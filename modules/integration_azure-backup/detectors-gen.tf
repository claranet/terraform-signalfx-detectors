resource "signalfx_detector" "vm" {
  name = format("%s %s", local.detector_name_prefix, "Azure Backup vm")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.RecoveryServices/vaults') and filter('primary_aggregation_type', 'true') and filter('datasourcetype', 'Microsoft.Compute/virtualMachines') and filter('healthstatus', 'Healthy')
    signal = data('BackupHealthEvent', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.vm_aggregation_function}${var.vm_transformation_function}.publish('signal')
    detect(when(signal < ${var.vm_threshold_critical}, lasting=%{if var.vm_lasting_duration_critical == null}None%{else}'${var.vm_lasting_duration_critical}'%{endif}, at_least=${var.vm_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal < ${var.vm_threshold_major}, lasting=%{if var.vm_lasting_duration_major == null}None%{else}'${var.vm_lasting_duration_major}'%{endif}, at_least=${var.vm_at_least_percentage_major}) and (not when(signal < ${var.vm_threshold_critical}, lasting=%{if var.vm_lasting_duration_critical == null}None%{else}'${var.vm_lasting_duration_critical}'%{endif}, at_least=${var.vm_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.vm_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.vm_disabled_critical, var.vm_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.vm_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.vm_runbook_url, var.runbook_url), "")
    tip                   = var.vm_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.vm_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.vm_disabled_major, var.vm_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.vm_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.vm_runbook_url, var.runbook_url), "")
    tip                   = var.vm_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.vm_max_delay
}

resource "signalfx_detector" "file_share" {
  name = format("%s %s", local.detector_name_prefix, "Azure Backup file share")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.RecoveryServices/vaults') and filter('primary_aggregation_type', 'true') and filter('datasourcetype', 'Microsoft.Storage/storageAccounts/fileServices/shares') and filter('healthstatus', 'Healthy')
    signal = data('BackupHealthEvent', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.file_share_aggregation_function}${var.file_share_transformation_function}.publish('signal')
    detect(when(signal < ${var.file_share_threshold_critical}, lasting=%{if var.file_share_lasting_duration_critical == null}None%{else}'${var.file_share_lasting_duration_critical}'%{endif}, at_least=${var.file_share_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal < ${var.file_share_threshold_major}, lasting=%{if var.file_share_lasting_duration_major == null}None%{else}'${var.file_share_lasting_duration_major}'%{endif}, at_least=${var.file_share_at_least_percentage_major}) and (not when(signal < ${var.file_share_threshold_critical}, lasting=%{if var.file_share_lasting_duration_critical == null}None%{else}'${var.file_share_lasting_duration_critical}'%{endif}, at_least=${var.file_share_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.file_share_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.file_share_disabled_critical, var.file_share_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.file_share_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.file_share_runbook_url, var.runbook_url), "")
    tip                   = var.file_share_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.file_share_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.file_share_disabled_major, var.file_share_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.file_share_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.file_share_runbook_url, var.runbook_url), "")
    tip                   = var.file_share_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.file_share_max_delay
}

