resource "signalfx_detector" "velero_scheduled_backup_missing" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes velero successful backup")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('schedule', '*')
    signal = data('velero_backup_success_total', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.velero_scheduled_backup_missing_aggregation_function}${var.velero_scheduled_backup_missing_transformation_function}.publish('signal')
    detect(when(signal < ${var.velero_scheduled_backup_missing_threshold_major}%{if var.velero_scheduled_backup_missing_lasting_duration_major != null}, lasting='${var.velero_scheduled_backup_missing_lasting_duration_major}', at_least=${var.velero_scheduled_backup_missing_at_least_percentage_major}%{endif})).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.velero_scheduled_backup_missing_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.velero_scheduled_backup_missing_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.velero_scheduled_backup_missing_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.velero_scheduled_backup_missing_runbook_url, var.runbook_url), "")
    tip                   = var.velero_scheduled_backup_missing_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.velero_scheduled_backup_missing_max_delay
}

resource "signalfx_detector" "velero_backup_failure" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes velero failed backup")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('schedule', '*')
    signal = data('velero_backup_failure_total', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.velero_backup_failure_aggregation_function}${var.velero_backup_failure_transformation_function}.publish('signal')
    detect(when(signal > ${var.velero_backup_failure_threshold_major}%{if var.velero_backup_failure_lasting_duration_major != null}, lasting='${var.velero_backup_failure_lasting_duration_major}', at_least=${var.velero_backup_failure_at_least_percentage_major}%{endif})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.velero_backup_failure_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.velero_backup_failure_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.velero_backup_failure_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.velero_backup_failure_runbook_url, var.runbook_url), "")
    tip                   = var.velero_backup_failure_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.velero_backup_failure_max_delay
}

resource "signalfx_detector" "velero_backup_partial_failure" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes velero failed partial backup")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('schedule', '*')
    signal = data('velero_backup_partial_failure_total', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.velero_backup_partial_failure_aggregation_function}${var.velero_backup_partial_failure_transformation_function}.publish('signal')
    detect(when(signal > ${var.velero_backup_partial_failure_threshold_major}%{if var.velero_backup_partial_failure_lasting_duration_major != null}, lasting='${var.velero_backup_partial_failure_lasting_duration_major}', at_least=${var.velero_backup_partial_failure_at_least_percentage_major}%{endif})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.velero_backup_partial_failure_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.velero_backup_partial_failure_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.velero_backup_partial_failure_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.velero_backup_partial_failure_runbook_url, var.runbook_url), "")
    tip                   = var.velero_backup_partial_failure_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.velero_backup_partial_failure_max_delay
}

resource "signalfx_detector" "velero_backup_deletion_failure" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes velero failed backup deletion")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('schedule', '*')
    signal = data('velero_backup_deletion_failure_total', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.velero_backup_deletion_failure_aggregation_function}${var.velero_backup_deletion_failure_transformation_function}.publish('signal')
    detect(when(signal > ${var.velero_backup_deletion_failure_threshold_major}%{if var.velero_backup_deletion_failure_lasting_duration_major != null}, lasting='${var.velero_backup_deletion_failure_lasting_duration_major}', at_least=${var.velero_backup_deletion_failure_at_least_percentage_major}%{endif})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.velero_backup_deletion_failure_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.velero_backup_deletion_failure_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.velero_backup_deletion_failure_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.velero_backup_deletion_failure_runbook_url, var.runbook_url), "")
    tip                   = var.velero_backup_deletion_failure_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.velero_backup_deletion_failure_max_delay
}

resource "signalfx_detector" "velero_volume_snapshot_failure" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes velero failed volume snapshot")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('schedule', '*')
    signal = data('velero_volume_snapshot_failure_total', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.velero_volume_snapshot_failure_aggregation_function}${var.velero_volume_snapshot_failure_transformation_function}.publish('signal')
    detect(when(signal > ${var.velero_volume_snapshot_failure_threshold_major}%{if var.velero_volume_snapshot_failure_lasting_duration_major != null}, lasting='${var.velero_volume_snapshot_failure_lasting_duration_major}', at_least=${var.velero_volume_snapshot_failure_at_least_percentage_major}%{endif})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.velero_volume_snapshot_failure_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.velero_volume_snapshot_failure_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.velero_volume_snapshot_failure_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.velero_volume_snapshot_failure_runbook_url, var.runbook_url), "")
    tip                   = var.velero_volume_snapshot_failure_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.velero_volume_snapshot_failure_max_delay
}

