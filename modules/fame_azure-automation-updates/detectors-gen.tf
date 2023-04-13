resource "signalfx_detector" "failed_updates" {
  name = format("%s %s", local.detector_name_prefix, "Azure Automation Update failed updates")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('fame.azure.automation_update.updates_status', filter=filter('status', 'failed') and ${module.filtering.signalflow})${var.failed_updates_aggregation_function}${var.failed_updates_transformation_function}.publish('signal')
    detect(when(signal > ${var.failed_updates_threshold_critical}, lasting=%{if var.failed_updates_lasting_duration_critical == null}None%{else}'${var.failed_updates_lasting_duration_critical}'%{endif}, at_least=${var.failed_updates_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.failed_updates_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.failed_updates_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.failed_updates_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.failed_updates_runbook_url, var.runbook_url), "")
    tip                   = var.failed_updates_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.failed_updates_max_delay
}

