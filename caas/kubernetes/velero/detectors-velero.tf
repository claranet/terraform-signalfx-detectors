resource "signalfx_detector" "velero_scheduled_backup_missing" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes velero scheduled backup missing"

  program_text = <<-EOF
		signal = data('velero_backup_success_total', ${module.filter-tags.filter_custom})${var.velero_scheduled_backup_missing_aggregation_function}.${var.velero_scheduled_backup_missing_transformation_function}(over='${var.velero_scheduled_backup_missing_transformation_window}').publish('signal')
		detect(when(signal < ${var.velero_scheduled_backup_missing_threshold_critical})).publish('CRIT')
		detect(when(signal < ${var.velero_scheduled_backup_missing_threshold_warning}) and when(signal >= ${var.velero_scheduled_backup_missing_threshold_critical})).publish('WARN')

EOF

  rule {
    description           = "are too low < ${var.velero_scheduled_backup_missing_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.velero_scheduled_backup_missing_disabled_critical, var.velero_scheduled_backup_missing_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.velero_scheduled_backup_missing_notifications_critical, var.velero_scheduled_backup_missing_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too low < ${var.velero_scheduled_backup_missing_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.velero_scheduled_backup_missing_disabled_warning, var.velero_scheduled_backup_missing_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.velero_scheduled_backup_missing_notifications_warning, var.velero_scheduled_backup_missing_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "velero_backup_failure" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes velero backup failure"

  program_text = <<-EOF
		signal = data('velero_backup_failure_total', ${module.filter-tags.filter_custom})${var.velero_backup_failure_aggregation_function}.${var.velero_backup_failure_transformation_function}(over='${var.velero_backup_failure_transformation_window}').publish('signal')
		detect(when(signal > ${var.velero_backup_failure_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.velero_backup_failure_threshold_warning}) and when(signal <= ${var.velero_backup_failure_threshold_critical})).publish('WARN')

EOF

  rule {
    description           = "are too high > ${var.velero_backup_failure_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.velero_backup_failure_disabled_critical, var.velero_backup_failure_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.velero_backup_failure_notifications_critical, var.velero_backup_failure_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too high > ${var.velero_backup_failure_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.velero_backup_failure_disabled_warning, var.velero_backup_failure_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.velero_backup_failure_notifications_warning, var.velero_backup_failure_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "velero_backup_partial_failure" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes velero backup partial failure"

  program_text = <<-EOF
		signal = data('velero_backup_partial_failure_total', ${module.filter-tags.filter_custom})${var.velero_backup_partial_failure_aggregation_function}.${var.velero_backup_partial_failure_transformation_function}(over='${var.velero_backup_partial_failure_transformation_window}').publish('signal')
		detect(when(signal > ${var.velero_backup_partial_failure_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.velero_backup_partial_failure_threshold_warning}) and when(signal <= ${var.velero_backup_partial_failure_threshold_critical})).publish('WARN')

EOF

  rule {
    description           = "are too high > ${var.velero_backup_partial_failure_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.velero_backup_partial_failure_disabled_critical, var.velero_backup_partial_failure_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.velero_backup_partial_failure_notifications_critical, var.velero_backup_partial_failure_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too high > ${var.velero_backup_partial_failure_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.velero_backup_partial_failure_disabled_warning, var.velero_backup_partial_failure_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.velero_backup_partial_failure_notifications_warning, var.velero_backup_partial_failure_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "velero_backup_deletion_failure" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes velero backup deletion failure"

  program_text = <<-EOF
		signal = data('velero_backup_deletion_failure_total', ${module.filter-tags.filter_custom})${var.velero_backup_deletion_failure_aggregation_function}.${var.velero_backup_deletion_failure_transformation_function}(over='${var.velero_backup_deletion_failure_transformation_window}').publish('signal')
		detect(when(signal > ${var.velero_backup_deletion_failure_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.velero_backup_deletion_failure_threshold_warning}) and when(signal <= ${var.velero_backup_deletion_failure_threshold_critical})).publish('WARN')

EOF

  rule {
    description           = "are too high > ${var.velero_backup_deletion_failure_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.velero_backup_deletion_failure_disabled_critical, var.velero_backup_deletion_failure_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.velero_backup_deletion_failure_notifications_critical, var.velero_backup_deletion_failure_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too high > ${var.velero_backup_deletion_failure_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.velero_backup_deletion_failure_disabled_warning, var.velero_backup_deletion_failure_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.velero_backup_deletion_failure_notifications_warning, var.velero_backup_deletion_failure_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "velero_volume_snapshot_failure" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes velero volume snapshot failure"

  program_text = <<-EOF
		signal = data('velero_volume_snapshot_failure_total', ${module.filter-tags.filter_custom})${var.velero_volume_snapshot_failure_aggregation_function}.${var.velero_volume_snapshot_failure_transformation_function}(over='${var.velero_volume_snapshot_failure_transformation_window}').publish('signal')
		detect(when(signal > ${var.velero_volume_snapshot_failure_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.velero_volume_snapshot_failure_threshold_warning}) and when(signal <= ${var.velero_volume_snapshot_failure_threshold_critical})).publish('WARN')

EOF

  rule {
    description           = "are too high > ${var.velero_volume_snapshot_failure_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.velero_volume_snapshot_failure_disabled_critical, var.velero_volume_snapshot_failure_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.velero_volume_snapshot_failure_notifications_critical, var.velero_volume_snapshot_failure_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too high > ${var.velero_volume_snapshot_failure_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.velero_volume_snapshot_failure_disabled_warning, var.velero_volume_snapshot_failure_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.velero_volume_snapshot_failure_notifications_warning, var.velero_volume_snapshot_failure_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}
