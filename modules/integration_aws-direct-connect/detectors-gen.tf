resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Aws-direct-connect heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('ConnectionState', filter=%{if var.heartbeat_exclude_not_running_vm}${local.not_running_vm_filters} and %{endif}${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "connection_state" {
  name = format("%s %s", local.detector_name_prefix, "AWS Direct Connect connection state")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "state"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/DirectConnect')
    signal = data('ConnectionState', filter=base_filtering and filter('stat', 'maximum') and ${module.filtering.signalflow})${var.connection_state_aggregation_function}${var.connection_state_transformation_function}.publish('signal')
    detect(when(signal == ${var.connection_state_threshold_critical}%{if var.connection_state_lasting_duration_critical != null}, lasting='${var.connection_state_lasting_duration_critical}', at_least=${var.connection_state_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "Connection is down == ${var.connection_state_threshold_critical}state"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.connection_state_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.connection_state_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.connection_state_runbook_url, var.runbook_url), "")
    tip                   = var.connection_state_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.connection_state_max_delay
}

resource "signalfx_detector" "connection_traffic" {
  name = format("%s %s", local.detector_name_prefix, "AWS Direct Connect connection traffic")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "egress_bps"
    value_suffix = "bytes"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/DirectConnect')
    ingress_bps = data('ConnectionBpsIngress', filter=base_filtering and filter('stat', 'sum') and ${module.filtering.signalflow})${var.connection_traffic_aggregation_function}${var.connection_traffic_transformation_function}
    egress_bps = data('ConnectionBpsEgress', filter=base_filtering and filter('stat', 'sum') and ${module.filtering.signalflow})${var.connection_traffic_aggregation_function}${var.connection_traffic_transformation_function}.publish('egress_bps')
    detect(when(ingress_bps == ${var.connection_traffic_threshold_major}%{if var.connection_traffic_lasting_duration_major != null}, lasting='${var.connection_traffic_lasting_duration_major}', at_least=${var.connection_traffic_at_least_percentage_major}%{endif}) and when(egress_bps == 0)).publish('MAJOR')
EOF

  rule {
    description           = "No traffic detected == ${var.connection_traffic_threshold_major}bytes"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.connection_traffic_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.connection_traffic_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.connection_traffic_runbook_url, var.runbook_url), "")
    tip                   = var.connection_traffic_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.connection_traffic_max_delay
}

