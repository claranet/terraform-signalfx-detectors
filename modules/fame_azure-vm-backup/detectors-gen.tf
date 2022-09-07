resource "signalfx_detector" "vm_backup" {
  name = format("%s %s", local.detector_name_prefix, "Azure VM backup success")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    backup = data('fame.azure.backup.vm', filter=${module.filtering.signalflow}, rollup='max')${var.vm_backup_aggregation_function}${var.vm_backup_transformation_function}
    signal = backup.max(over='1d').publish('signal')
    detect(when(signal < ${var.vm_backup_threshold_critical}, lasting=%{if var.vm_backup_lasting_duration_critical == null}None%{else}'${var.vm_backup_lasting_duration_critical}'%{endif}, at_least=${var.vm_backup_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.vm_backup_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.vm_backup_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.vm_backup_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.vm_backup_runbook_url, var.runbook_url), "")
    tip                   = var.vm_backup_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.vm_backup_max_delay
}

