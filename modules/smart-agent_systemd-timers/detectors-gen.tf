resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Systemd-timers heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('gauge.substate.failed', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}', auto_resolve_after='${local.heartbeat_auto_resolve_after}').publish('MINOR')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.heartbeat_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.heartbeat_runbook_url, var.runbook_url), "")
    tip                   = var.heartbeat_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject_novalue : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.heartbeat_max_delay
}

resource "signalfx_detector" "execution_delay" {
  name = format("%s %s", local.detector_name_prefix, "Systemd-timers execution delay")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('gauge.active_state.active', filter=${module.filtering.signalflow})${var.execution_delay_aggregation_function}${var.execution_delay_transformation_function}
    B = data('gauge.active_state.activating', filter=${module.filtering.signalflow})${var.execution_delay_aggregation_function}${var.execution_delay_transformation_function}
    signal = (A+B).publish('signal')
    detect(when(signal < ${var.execution_delay_threshold_major}%{if var.execution_delay_lasting_duration_major != null}, lasting='${var.execution_delay_lasting_duration_major}', at_least=${var.execution_delay_at_least_percentage_major}%{endif})).publish('MAJOR')
EOF

  rule {
    description           = "is too long < ${var.execution_delay_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.execution_delay_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.execution_delay_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.execution_delay_runbook_url, var.runbook_url), "")
    tip                   = var.execution_delay_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.execution_delay_max_delay
}

resource "signalfx_detector" "last_execution_state" {
  name = format("%s %s", local.detector_name_prefix, "Systemd-timers last execution state")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('gauge.substate.failed', filter=${module.filtering.signalflow})${var.last_execution_state_aggregation_function}${var.last_execution_state_transformation_function}.publish('signal')
    detect(when(signal > ${var.last_execution_state_threshold_major}%{if var.last_execution_state_lasting_duration_major != null}, lasting='${var.last_execution_state_lasting_duration_major}', at_least=${var.last_execution_state_at_least_percentage_major}%{endif})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.last_execution_state_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.last_execution_state_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.last_execution_state_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.last_execution_state_runbook_url, var.runbook_url), "")
    tip                   = var.last_execution_state_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.last_execution_state_max_delay
}

