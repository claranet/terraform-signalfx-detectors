resource "signalfx_detector" "volume_space" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes node volume space usage"

  program_text = <<-EOF
    A = data('kubernetes.volume_available_bytes', ${module.filter-tags.filter_custom} and not filter('volume_type', 'configMap', 'secret'))${var.volume_space_aggregation_function}${var.volume_space_transformation_function}
    B = data('kubernetes.volume_capacity_bytes', ${module.filter-tags.filter_custom} and not filter('volume_type', 'configMap', 'secret'))${var.volume_space_aggregation_function}${var.volume_space_transformation_function}
    signal = ((B-A)/B).scale(100).publish('signal')
    detect(when(signal > ${var.volume_space_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.volume_space_threshold_warning}) and when(signal < ${var.volume_space_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.volume_space_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.volume_space_disabled_critical, var.volume_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.volume_space_notifications_critical, var.volume_space_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.volume_space_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.volume_space_disabled_warning, var.volume_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.volume_space_notifications_warning, var.volume_space_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "volume_inodes" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes node volume inodes usage"

  program_text = <<-EOF
    A = data('kubernetes.volume_inodes_free', ${module.filter-tags.filter_custom} and not filter('volume_type', 'configMap', 'secret'))${var.volume_inodes_aggregation_function}${var.volume_inodes_transformation_function}
    B = data('kubernetes.volume_inodes', ${module.filter-tags.filter_custom} and not filter('volume_type', 'configMap', 'secret'))${var.volume_inodes_aggregation_function}${var.volume_inodes_transformation_function}
    signal = ((B-A)/B).scale(100).publish('signal')
    detect(when(signal > ${var.volume_inodes_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.volume_inodes_threshold_warning}) and when(signal < ${var.volume_inodes_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.volume_inodes_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.volume_inodes_disabled_critical, var.volume_inodes_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.volume_inodes_notifications_critical, var.volume_inodes_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.volume_inodes_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.volume_inodes_disabled_warning, var.volume_inodes_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.volume_inodes_notifications_warning, var.volume_inodes_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

