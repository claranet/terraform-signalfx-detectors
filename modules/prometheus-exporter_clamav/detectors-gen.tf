resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Clamav heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('clamav_up', filter=%{if var.heartbeat_exclude_not_running_vm}${local.not_running_vm_filters} and %{endif}${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "clamav_queue_length" {
  name = format("%s %s", local.detector_name_prefix, "Clamav queue length")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('clamav_queue_length', filter=${module.filtering.signalflow})${var.clamav_queue_length_aggregation_function}${var.clamav_queue_length_transformation_function}.publish('signal')
    detect(when(signal => ${var.clamav_queue_length_threshold_critical}%{if var.clamav_queue_length_lasting_duration_critical != null}, lasting='${var.clamav_queue_length_lasting_duration_critical}', at_least=${var.clamav_queue_length_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too high => ${var.clamav_queue_length_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.clamav_queue_length_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.clamav_queue_length_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.clamav_queue_length_runbook_url, var.runbook_url), "")
    tip                   = var.clamav_queue_length_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.clamav_queue_length_max_delay
}

