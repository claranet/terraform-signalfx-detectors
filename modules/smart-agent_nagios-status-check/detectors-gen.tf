resource "signalfx_detector" "status_check" {
  name = format("%s %s", local.detector_name_prefix, "Nagios status check")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('nagios.state', filter=${module.filtering.signalflow})${var.status_check_aggregation_function}${var.status_check_transformation_function}.publish('signal')
    detect(when(signal == ${var.status_check_threshold_warning}, lasting=%{if var.status_check_lasting_duration_warning == null}None%{else}'${var.status_check_lasting_duration_warning}'%{endif}, at_least=${var.status_check_at_least_percentage_warning})).publish('WARN')
    detect(when(signal == ${var.status_check_threshold_critical}, lasting=%{if var.status_check_lasting_duration_critical == null}None%{else}'${var.status_check_lasting_duration_critical}'%{endif}, at_least=${var.status_check_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal == ${var.status_check_threshold_major}, lasting=%{if var.status_check_lasting_duration_major == null}None%{else}'${var.status_check_lasting_duration_major}'%{endif}, at_least=${var.status_check_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is Warning, check output from host script or related event == ${var.status_check_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.status_check_disabled_warning, var.status_check_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.status_check_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.status_check_runbook_url, var.runbook_url), "")
    tip                   = var.status_check_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is Critical, check output from host script or related event == ${var.status_check_threshold_critical}"
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
    description           = "is Unknown, check output from host script or related event == ${var.status_check_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.status_check_disabled_major, var.status_check_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.status_check_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.status_check_runbook_url, var.runbook_url), "")
    tip                   = var.status_check_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

