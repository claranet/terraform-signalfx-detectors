resource "signalfx_detector" "volume_space" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes node volume space usage")

  program_text = <<-EOF
    A = data('kubernetes.volume_available_bytes', filter=${module.filter-tags.filter_custom} and not filter('volume_type', 'configMap', 'secret'))${var.volume_space_aggregation_function}${var.volume_space_transformation_function}
    B = data('kubernetes.volume_capacity_bytes', filter=${module.filter-tags.filter_custom} and not filter('volume_type', 'configMap', 'secret'))${var.volume_space_aggregation_function}${var.volume_space_transformation_function}
    signal = ((B-A)/B).scale(100).publish('signal')
    detect(when(signal > ${var.volume_space_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.volume_space_threshold_major}) and when(signal < ${var.volume_space_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.volume_space_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.volume_space_disabled_critical, var.volume_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.volume_space_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.volume_space_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.volume_space_disabled_major, var.volume_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.volume_space_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "volume_inodes" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes node volume inodes usage")

  program_text = <<-EOF
    A = data('kubernetes.volume_inodes_free', filter=${module.filter-tags.filter_custom} and not filter('volume_type', 'configMap', 'secret'))${var.volume_inodes_aggregation_function}${var.volume_inodes_transformation_function}
    B = data('kubernetes.volume_inodes', filter=${module.filter-tags.filter_custom} and not filter('volume_type', 'configMap', 'secret'))${var.volume_inodes_aggregation_function}${var.volume_inodes_transformation_function}
    signal = ((B-A)/B).scale(100).publish('signal')
    detect(when(signal > ${var.volume_inodes_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.volume_inodes_threshold_major}) and when(signal < ${var.volume_inodes_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.volume_inodes_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.volume_inodes_disabled_critical, var.volume_inodes_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.volume_inodes_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.volume_inodes_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.volume_inodes_disabled_major, var.volume_inodes_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.volume_inodes_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

