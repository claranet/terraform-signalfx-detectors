resource "signalfx_detector" "backup_failed" {
  name = format("%s %s", local.detector_name_prefix, "AWS Backup failed")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "count"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/Backup')
    failed = data('NumberOfBackupJobsFailed', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.backup_failed_aggregation_function}${var.backup_failed_transformation_function}
    signal = failed.publish('signal')
    detect(when(signal > ${var.backup_failed_threshold_critical}, lasting=%{if var.backup_failed_lasting_duration_critical == null}None%{else}'${var.backup_failed_lasting_duration_critical}'%{endif}, at_least=${var.backup_failed_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.backup_failed_threshold_critical}count"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backup_failed_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backup_failed_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.backup_failed_runbook_url, var.runbook_url), "")
    tip                   = var.backup_failed_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "backup_job_expired" {
  name = format("%s %s", local.detector_name_prefix, "AWS Backup job expired")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "count"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/Backup')
    failed = data('NumberOfBackupJobsExpired', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.backup_job_expired_aggregation_function}${var.backup_job_expired_transformation_function}
    signal = failed.publish('signal')
    detect(when(signal > ${var.backup_job_expired_threshold_critical}, lasting=%{if var.backup_job_expired_lasting_duration_critical == null}None%{else}'${var.backup_job_expired_lasting_duration_critical}'%{endif}, at_least=${var.backup_job_expired_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.backup_job_expired_threshold_critical}count"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backup_job_expired_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backup_job_expired_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.backup_job_expired_runbook_url, var.runbook_url), "")
    tip                   = var.backup_job_expired_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "backup_copy_jobs_failed" {
  name = format("%s %s", local.detector_name_prefix, "AWS Backup copy jobs failed")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "count"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/Backup')
    failed = data('NumberOfCopyJobsFailed', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.backup_copy_jobs_failed_aggregation_function}${var.backup_copy_jobs_failed_transformation_function}
    signal = failed.publish('signal')
    detect(when(signal > ${var.backup_copy_jobs_failed_threshold_critical}, lasting=%{if var.backup_copy_jobs_failed_lasting_duration_critical == null}None%{else}'${var.backup_copy_jobs_failed_lasting_duration_critical}'%{endif}, at_least=${var.backup_copy_jobs_failed_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.backup_copy_jobs_failed_threshold_critical}count"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backup_copy_jobs_failed_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backup_copy_jobs_failed_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.backup_copy_jobs_failed_runbook_url, var.runbook_url), "")
    tip                   = var.backup_copy_jobs_failed_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

