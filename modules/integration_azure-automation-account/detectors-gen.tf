resource "signalfx_detector" "jobs" {
  name = format("%s %s", local.detector_name_prefix, "Azure Automation Account jobs")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Automation/automationAccounts') and filter('primary_aggregation_type', 'true') and filter('status', 'Failed')
    totaljob = data('TotalJob', filter=base_filtering and ${module.filtering.signalflow})${var.jobs_aggregation_function}${var.jobs_transformation_function}
    signal = totaljob.fill().count(by=['runbook']).publish('signal')
    detect(when(signal >= ${var.jobs_threshold_critical}, lasting=%{if var.jobs_lasting_duration_critical == null}None%{else}'${var.jobs_lasting_duration_critical}'%{endif}, at_least=${var.jobs_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high >= ${var.jobs_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.jobs_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.jobs_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.jobs_runbook_url, var.runbook_url), "")
    tip                   = var.jobs_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.jobs_max_delay
}

