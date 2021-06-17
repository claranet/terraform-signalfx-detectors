resource "signalfx_detector" "processes" {
  name = format("%s %s", local.detector_name_prefix, "Processes aliveness")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
        signal = data('ps_count.processes', filter=${module.filtering.signalflow})${var.processes_aggregation_function}${var.processes_transformation_function}.publish('signal')
        detect(when(signal < 1)).publish('CRIT')
        detect(when(signal < ${var.processes_threshold_major}) and when (signal >= 1)).publish('MAJOR')
EOF

  rule {
    description           = "count is too low < 1"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.processes_disabled_critical, var.processes_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.processes_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.processes_runbook_url, var.runbook_url), "")
    tip                   = var.processes_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "count is too low < ${var.processes_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.processes_disabled_major, var.processes_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.processes_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.processes_runbook_url, var.runbook_url), "")
    tip                   = var.processes_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

