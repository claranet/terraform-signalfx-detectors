resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElasticSearch heartbeat")

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('Nodes', filter=filter('namespace', 'AWS/ES') and filter('stat', 'mean') and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "cluster_status" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElasticSearch cluster status")

  program_text = <<-EOF
    A = data('ClusterStatus.red', filter=filter('namespace', 'AWS/ES') and filter('stat', 'upper') and ${module.filter-tags.filter_custom})${var.cluster_status_aggregation_function}${var.cluster_status_transformation_function}.publish('A')
    B = data('ClusterStatus.yellow', filter=filter('namespace', 'AWS/ES') and filter('stat', 'upper') and ${module.filter-tags.filter_custom})${var.cluster_status_aggregation_function}${var.cluster_status_transformation_function}.publish('B')
    detect(when(A >= 1)).publish('CRIT')
    detect(when(B >= 1)).publish('MAJOR')
EOF

  rule {
    description           = "is red"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cluster_status_disabled_critical, var.cluster_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cluster_status_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is yellow"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cluster_status_disabled_major, var.cluster_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cluster_status_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "free_space" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElasticSearch cluster free storage space")

  program_text = <<-EOF
    signal = data('FreeStorageSpace', filter=filter('namespace', 'AWS/ES') and filter('stat', 'lower') and filter('NodeId', '*') and ${module.filter-tags.filter_custom})${var.free_space_aggregation_function}${var.free_space_transformation_function}.publish('signal')
    detect(when(signal < ${var.free_space_threshold_critical})).publish('CRIT')
    detect(when(signal < ${var.free_space_threshold_major}) and when(signal >= ${var.free_space_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.free_space_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.free_space_disabled_critical, var.free_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.free_space_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too low < ${var.free_space_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.free_space_disabled_major, var.free_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.free_space_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "cpu_90_15min" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElasticSearch cluster CPU")

  program_text = <<-EOF
    signal = data('CPUUtilization', filter=filter('namespace', 'AWS/ES') and filter('stat', 'upper') and filter('NodeId', '*') and ${module.filter-tags.filter_custom})${var.cpu_90_15min_aggregation_function}${var.cpu_90_15min_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_90_15min_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_90_15min_threshold_major}) and when(signal <= ${var.cpu_90_15min_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_90_15min_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_90_15min_disabled_critical, var.cpu_90_15min_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_90_15min_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.cpu_90_15min_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_90_15min_disabled_major, var.cpu_90_15min_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_90_15min_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

