resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure VPN heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('fame.azure.virtual_network_gateway.total_flow_count', filter=${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "totalflowcount" {
  name = format("%s %s", local.detector_name_prefix, "Azure VPN total flow count")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('fame.azure.virtual_network_gateway.total_flow_count', filter=${module.filtering.signalflow})${var.totalflowcount_aggregation_function}${var.totalflowcount_transformation_function}.publish('signal')
    detect(when(signal == ${var.totalflowcount_threshold_critical}, lasting=%{if var.totalflowcount_lasting_duration_critical == null}None%{else}'${var.totalflowcount_lasting_duration_critical}'%{endif}, at_least=${var.totalflowcount_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is == ${var.totalflowcount_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.totalflowcount_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.totalflowcount_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.totalflowcount_runbook_url, var.runbook_url), "")
    tip                   = var.totalflowcount_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.totalflowcount_max_delay
}

resource "signalfx_detector" "tunnelstatus" {
  name = format("%s %s", local.detector_name_prefix, "Azure VPN ipsec tunnel status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('fame.azure.virtual_network_gateway.tunnel_status', filter=${module.filtering.signalflow})${var.tunnelstatus_aggregation_function}${var.tunnelstatus_transformation_function}.publish('signal')
    detect(when(signal == ${var.tunnelstatus_threshold_critical}, lasting=%{if var.tunnelstatus_lasting_duration_critical == null}None%{else}'${var.tunnelstatus_lasting_duration_critical}'%{endif}, at_least=${var.tunnelstatus_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is == ${var.tunnelstatus_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.tunnelstatus_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.tunnelstatus_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.tunnelstatus_runbook_url, var.runbook_url), "")
    tip                   = var.tunnelstatus_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.tunnelstatus_max_delay
}

