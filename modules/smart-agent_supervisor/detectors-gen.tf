resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Supervisor heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('supervisor.state', filter=%{if var.heartbeat_exclude_not_running_vm}${local.not_running_vm_filters} and %{endif}${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "process_state" {
  name = format("%s %s", local.detector_name_prefix, "Jobs managed by supervisord")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('supervisor.state', filter=${module.filtering.signalflow})${var.process_state_aggregation_function}${var.process_state_transformation_function}.publish('signal')
    detect(when(signal > ${var.process_state_threshold_critical}%{if var.process_state_lasting_duration_critical != null}, lasting='${var.process_state_lasting_duration_critical}', at_least=${var.process_state_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal < ${var.process_state_threshold_major}%{if var.process_state_lasting_duration_major != null}, lasting='${var.process_state_lasting_duration_major}', at_least=${var.process_state_at_least_percentage_major}%{endif})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.process_state_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.process_state_disabled_critical, var.process_state_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.process_state_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.process_state_runbook_url, var.runbook_url), "")
    tip                   = var.process_state_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.process_state_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.process_state_disabled_major, var.process_state_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.process_state_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.process_state_runbook_url, var.runbook_url), "")
    tip                   = var.process_state_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.process_state_max_delay
}

