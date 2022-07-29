resource "signalfx_detector" "backup" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage File backup success")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('fame.azure.backup.file_share', filter=${module.filtering.signalflow}, extrapolation='zero')${var.backup_aggregation_function}${var.backup_transformation_function}.publish('signal')
    detect(when(signal < ${var.backup_threshold_critical}, lasting=%{if var.backup_lasting_duration_critical == null}None%{else}'${var.backup_lasting_duration_critical}'%{endif}, at_least=${var.backup_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.backup_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backup_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backup_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.backup_runbook_url, var.runbook_url), "")
    tip                   = var.backup_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.backup_max_delay
}

