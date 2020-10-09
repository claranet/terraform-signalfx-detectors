resource "signalfx_detector" "velero_scheduled_backup_missing" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes velero successful backup"

  program_text = <<-EOF
    signal = data('velero_backup_success_total', filter=filter('schedule', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.velero_scheduled_backup_missing_aggregation_function}${var.velero_scheduled_backup_missing_transformation_function}.publish('signal')
    detect(when(signal < 1)).publish('MAJOR')
EOF

  rule {
    description           = "is missing"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.velero_scheduled_backup_missing_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.velero_scheduled_backup_missing_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }
}

resource "signalfx_detector" "velero_backup_failure" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes velero failed backup"

  program_text = <<-EOF
    signal = data('velero_backup_failure_total', filter=filter('schedule', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.velero_backup_failure_aggregation_function}${var.velero_backup_failure_transformation_function}.publish('signal')
    detect(when(signal > 0)).publish('MAJOR')
EOF

  rule {
    description           = "found"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.velero_backup_failure_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.velero_backup_failure_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }
}

resource "signalfx_detector" "velero_backup_partial_failure" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes velero failed partial backup"

  program_text = <<-EOF
    signal = data('velero_backup_partial_failure_total', filter=filter('schedule', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.velero_backup_partial_failure_aggregation_function}${var.velero_backup_partial_failure_transformation_function}.publish('signal')
    detect(when(signal > 0)).publish('MAJOR')
EOF

  rule {
    description           = "found"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.velero_backup_partial_failure_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.velero_backup_partial_failure_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }
}

resource "signalfx_detector" "velero_backup_deletion_failure" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes velero failed backup deletion"

  program_text = <<-EOF
    signal = data('velero_backup_deletion_failure_total', filter=filter('schedule', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.velero_backup_deletion_failure_aggregation_function}${var.velero_backup_deletion_failure_transformation_function}.publish('signal')
    detect(when(signal > 0)).publish('MAJOR')
EOF

  rule {
    description           = "found"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.velero_backup_deletion_failure_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.velero_backup_deletion_failure_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }
}

resource "signalfx_detector" "velero_volume_snapshot_failure" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes velero failed volume snapshot"

  program_text = <<-EOF
    signal = data('velero_volume_snapshot_failure_total', filter=filter('schedule', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.velero_volume_snapshot_failure_aggregation_function}${var.velero_volume_snapshot_failure_transformation_function}.publish('signal')
    detect(when(signal > 0)).publish('MAJOR')
EOF

  rule {
    description           = "found"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.velero_volume_snapshot_failure_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.velero_volume_snapshot_failure_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }
}

