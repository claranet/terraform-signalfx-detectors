resource "signalfx_detector" "pending" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud Functions pending")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('function/execution_times', filter=not filter('status', 'ok') and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.pending_aggregation_function}.publish('signal')
    detect(when(signal > ${var.pending_threshold_minor}%{if var.pending_lasting_duration_minor != null}, lasting='${var.pending_lasting_duration_minor}', at_least=${var.pending_at_least_percentage_minor}%{endif})).publish('MINOR')
    detect(when(signal > ${var.pending_threshold_warning}%{if var.pending_lasting_duration_warning != null}, lasting='${var.pending_lasting_duration_warning}', at_least=${var.pending_at_least_percentage_warning}%{endif})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.pending_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.pending_disabled_minor, var.pending_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.pending_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.pending_runbook_url, var.runbook_url), "")
    tip                   = var.pending_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.pending_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.pending_disabled_warning, var.pending_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.pending_notifications, "warning", []), var.notifications.warning), null)
    runbook_url           = try(coalesce(var.pending_runbook_url, var.runbook_url), "")
    tip                   = var.pending_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.pending_max_delay
}

