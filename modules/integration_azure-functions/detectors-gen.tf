resource "signalfx_detector" "errors" {
  name = format("%s %s", local.detector_name_prefix, "Azure Functions wrapper errors")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    base_filtering = filter('is_Azure_Function', 'true')
    errors = data('azure.function.errors', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='last_value')${var.errors_aggregation_function}${var.errors_transformation_function}
    invocations = data('azure.function.invocations', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='last_value')${var.errors_aggregation_function}${var.errors_transformation_function}
    signal = (errors / invocations).fill(value=0).scale(100).publish('signal')
    detect(when(signal > ${var.errors_threshold_critical}, lasting='${var.errors_lasting_duration_critical}')).publish('CRIT')
    detect(when(signal > ${var.errors_threshold_major}, lasting='${var.errors_lasting_duration_major}') and when(signal <= ${var.errors_threshold_critical}, lasting='${var.errors_lasting_duration_major}')).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.errors_disabled_critical, var.errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.errors_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.errors_runbook_url, var.runbook_url), "")
    tip                   = var.errors_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }

  rule {
    description           = "is too high > ${var.errors_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.errors_disabled_major, var.errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.errors_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.errors_runbook_url, var.runbook_url), "")
    tip                   = var.errors_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }
}

