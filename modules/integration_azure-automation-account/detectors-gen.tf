resource "signalfx_detector" "failed_jobs" {
  name = format("%s %s", local.detector_name_prefix, "Azure Automation Account failed jobs")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Automation/automationAccounts') and filter('primary_aggregation_type', 'true')
    success = data('TotalJob', filter=base_filtering and filter('status', 'Completed') and ${module.filtering.signalflow})${var.failed_jobs_aggregation_function}${var.failed_jobs_transformation_function}
    failed = data('TotalJob', filter=base_filtering and filter('status', 'Failed') and ${module.filtering.signalflow})${var.failed_jobs_aggregation_function}${var.failed_jobs_transformation_function}
    signal = (failed - success.scale(10)).min(over='1h').publish('signal')
    detect(when(signal > ${var.failed_jobs_threshold_critical}, lasting=%{if var.failed_jobs_lasting_duration_critical == null}None%{else}'${var.failed_jobs_lasting_duration_critical}'%{endif}, at_least=${var.failed_jobs_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.failed_jobs_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.failed_jobs_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.failed_jobs_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.failed_jobs_runbook_url, var.runbook_url), "")
    tip                   = var.failed_jobs_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.failed_jobs_max_delay
}

