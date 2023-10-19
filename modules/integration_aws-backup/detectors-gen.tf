resource "signalfx_detector" "backup_failed" {
  name = format("%s %s", local.detector_name_prefix, "AWS Backup failed")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/Backup') and filter('stat', 'sum') and filter('BackupVaultName', '*', match_missing=False) and filter('ResourceType', '*', match_missing=False)
    signal = data('NumberOfBackupJobsFailed', filter=base_filtering and ${module.filtering.signalflow})${var.backup_failed_aggregation_function}${var.backup_failed_transformation_function}.publish('signal')
    detect(when(signal > ${var.backup_failed_threshold_critical}, lasting=%{if var.backup_failed_lasting_duration_critical == null}None%{else}'${var.backup_failed_lasting_duration_critical}'%{endif}, at_least=${var.backup_failed_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.backup_failed_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backup_failed_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backup_failed_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.backup_failed_runbook_url, var.runbook_url), "")
    tip                   = var.backup_failed_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.backup_failed_max_delay
}

resource "signalfx_detector" "backup_job_expired" {
  name = format("%s %s", local.detector_name_prefix, "AWS Backup job expired")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/Backup') and filter('stat', 'sum') and filter('BackupVaultName', '*', match_missing=False) and filter('ResourceType', '*', match_missing=False)
    signal = data('NumberOfBackupJobsExpired', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.backup_job_expired_aggregation_function}${var.backup_job_expired_transformation_function}.publish('signal')
    detect(when(signal > ${var.backup_job_expired_threshold_critical}, lasting=%{if var.backup_job_expired_lasting_duration_critical == null}None%{else}'${var.backup_job_expired_lasting_duration_critical}'%{endif}, at_least=${var.backup_job_expired_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.backup_job_expired_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backup_job_expired_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backup_job_expired_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.backup_job_expired_runbook_url, var.runbook_url), "")
    tip                   = var.backup_job_expired_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.backup_job_expired_max_delay
}

resource "signalfx_detector" "backup_copy_jobs_failed" {
  name = format("%s %s", local.detector_name_prefix, "AWS Backup copy jobs failed")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/Backup') and filter('stat', 'sum')
    signal = data('NumberOfCopyJobsFailed', filter=base_filtering and ${module.filtering.signalflow})${var.backup_copy_jobs_failed_aggregation_function}${var.backup_copy_jobs_failed_transformation_function}.publish('signal')
    detect(when(signal > ${var.backup_copy_jobs_failed_threshold_critical}, lasting=%{if var.backup_copy_jobs_failed_lasting_duration_critical == null}None%{else}'${var.backup_copy_jobs_failed_lasting_duration_critical}'%{endif}, at_least=${var.backup_copy_jobs_failed_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.backup_copy_jobs_failed_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backup_copy_jobs_failed_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backup_copy_jobs_failed_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.backup_copy_jobs_failed_runbook_url, var.runbook_url), "")
    tip                   = var.backup_copy_jobs_failed_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.backup_copy_jobs_failed_max_delay
}

resource "signalfx_detector" "backup_successful" {
  name = format("%s %s", local.detector_name_prefix, "AWS Backup check jobs completed successfully")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/Backup') and filter('stat', 'sum') and filter('BackupVaultName', '*', match_missing=False) and filter('ResourceType', '*', match_missing=False)
    created = data('NumberOfBackupJobsCreated', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.backup_successful_aggregation_function}${var.backup_successful_transformation_function}
    completed = data('NumberOfBackupJobsCompleted', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.backup_successful_aggregation_function}${var.backup_successful_transformation_function}
    signal = (created-completed).publish('signal')
    detect(when(signal > ${var.backup_successful_threshold_critical}, lasting=%{if var.backup_successful_lasting_duration_critical == null}None%{else}'${var.backup_successful_lasting_duration_critical}'%{endif}, at_least=${var.backup_successful_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.backup_successful_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backup_successful_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backup_successful_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.backup_successful_runbook_url, var.runbook_url), "")
    tip                   = var.backup_successful_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.backup_successful_max_delay
}

resource "signalfx_detector" "backup_rp_partial" {
  name = format("%s %s", local.detector_name_prefix, "AWS Backup recovery point partial")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/Backup') and filter('stat', 'sum') and filter('BackupVaultName', '*', match_missing=False) and filter('ResourceType', '*', match_missing=False)
    signal = data('NumberOfRecoveryPointsPartial', filter=base_filtering and ${module.filtering.signalflow})${var.backup_rp_partial_aggregation_function}${var.backup_rp_partial_transformation_function}.publish('signal')
    detect(when(signal > ${var.backup_rp_partial_threshold_minor}, lasting=%{if var.backup_rp_partial_lasting_duration_minor == null}None%{else}'${var.backup_rp_partial_lasting_duration_minor}'%{endif}, at_least=${var.backup_rp_partial_at_least_percentage_minor})).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.backup_rp_partial_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.backup_rp_partial_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backup_rp_partial_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.backup_rp_partial_runbook_url, var.runbook_url), "")
    tip                   = var.backup_rp_partial_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.backup_rp_partial_max_delay
}

resource "signalfx_detector" "backup_rp_expired" {
  name = format("%s %s", local.detector_name_prefix, "AWS Backup recovery point expired")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/Backup') and filter('stat', 'sum') and filter('BackupVaultName', '*', match_missing=False) and filter('ResourceType', '*', match_missing=False)
    signal = data('NumberOfRecoveryPointsExpired', filter=base_filtering and ${module.filtering.signalflow})${var.backup_rp_expired_aggregation_function}${var.backup_rp_expired_transformation_function}.publish('signal')
    detect(when(signal > ${var.backup_rp_expired_threshold_major}, lasting=%{if var.backup_rp_expired_lasting_duration_major == null}None%{else}'${var.backup_rp_expired_lasting_duration_major}'%{endif}, at_least=${var.backup_rp_expired_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.backup_rp_expired_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.backup_rp_expired_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backup_rp_expired_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.backup_rp_expired_runbook_url, var.runbook_url), "")
    tip                   = var.backup_rp_expired_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.backup_rp_expired_max_delay
}

