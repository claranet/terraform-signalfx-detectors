resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS VPN heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('stat', 'mean') and filter('namespace', 'AWS/VPN')
    signal = data('TunnelState', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}', auto_resolve_after='${local.heartbeat_auto_resolve_after}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.heartbeat_runbook_url, var.runbook_url), "")
    tip                   = var.heartbeat_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject_novalue : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.heartbeat_max_delay
}

resource "signalfx_detector" "vpn_status" {
  name = format("%s %s", local.detector_name_prefix, "AWS VPN tunnel state")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/VPN') and filter('stat', 'mean') and filter('VpnId', '*')
    signal = data('TunnelState', filter=base_filtering and ${module.filtering.signalflow})${var.vpn_status_aggregation_function}${var.vpn_status_transformation_function}.publish('signal')
    detect(when(signal < ${var.vpn_status_threshold_critical}%{if var.vpn_status_lasting_duration_critical != null}, lasting='${var.vpn_status_lasting_duration_critical}', at_least=${var.vpn_status_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.vpn_status_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.vpn_status_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.vpn_status_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.vpn_status_runbook_url, var.runbook_url), "")
    tip                   = var.vpn_status_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.vpn_status_max_delay
}

