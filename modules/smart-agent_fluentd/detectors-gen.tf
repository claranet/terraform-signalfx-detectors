resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Fluentd heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  max_delay = 900

  program_text = <<-EOF
    fluentd_signal = data('fluentd_output_status_buffer_queue_length', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}
    cpu_signal = data('cpu.utilization', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}
    no_fluentd_data = (count(fluentd_signal) == 0 and count(cpu_signal) > 0).publish("no_fluentd_data")
    detect(when(no_fluentd_data, lasting="300s"), auto_resolve_after="60s").publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.heartbeat_timeframe}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.heartbeat_runbook_url, var.runbook_url), "")
    tip                   = var.heartbeat_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject_novalue : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "buffer" {
  name = format("%s %s", local.detector_name_prefix, "Fluentd Buffer length")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('fluentd_output_status_buffer_queue_length', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.buffer_aggregation_function}${var.buffer_transformation_function}.publish('signal')
    detect(when(signal > ${var.buffer_threshold}, lasting="${var.buffer_lasting_seconds}s"), auto_resolve_after="${var.buffer_auto_resolve_seconds}s").publish('MAJOR')
EOF
  rule {
    description           = "is too high > ${var.buffer_threshold}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.buffer_disabled, var.buffer_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.buffer_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.buffer_runbook_url, var.runbook_url), "")
    tip                   = var.buffer_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}
