resource "signalfx_detector" "status_check" {
  name = format("%s %s", local.detector_name_prefix, "Nagios check status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
        signal = data('nagios.state', filter=${module.filtering.signalflow})${var.status_check_aggregation_function}${var.status_check_transformation_function}.publish('signal')
        detect(when(signal == 1, lasting='${var.status_check_lasting_duration_seconds}s')).publish('WARN')
        detect(when(signal == 2, lasting='${var.status_check_lasting_duration_seconds}s')).publish('CRIT')
        detect(when(signal == 3, lasting='${var.status_check_lasting_duration_seconds}s')).publish('MAJOR')
  EOF

  rule {
    description           = "is UNKNOWN, please check the script output on the host"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.status_check_disabled_major, var.status_check_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.status_check_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.status_check_runbook_url, var.runbook_url), "")
    tip                   = var.status_check_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is CRITICAL, please check the script output on the host"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.status_check_disabled_critical, var.status_check_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.status_check_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.status_check_runbook_url, var.runbook_url), "")
    tip                   = var.status_check_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is WARNING, please check the script output on the host"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.status_check_disabled_warning, var.status_check_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.status_check_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.status_check_runbook_url, var.runbook_url), "")
    tip                   = var.status_check_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

