resource "signalfx_detector" "file_backup" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage File backup success")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    backup = data('fame.azure.backup.file_share', filter=${module.filtering.signalflow}, rollup='max')${var.file_backup_aggregation_function}${var.file_backup_transformation_function}
    signal = backup.max(over='1d').publish('signal')
    detect(when(signal < ${var.file_backup_threshold_critical}, lasting=%{if var.file_backup_lasting_duration_critical == null}None%{else}'${var.file_backup_lasting_duration_critical}'%{endif}, at_least=${var.file_backup_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.file_backup_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.file_backup_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.file_backup_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.file_backup_runbook_url, var.runbook_url), "")
    tip                   = var.file_backup_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.file_backup_max_delay
}

