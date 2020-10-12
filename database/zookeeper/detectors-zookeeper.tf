resource "signalfx_detector" "heartbeat" {
  name      = format("%s %s", local.detector_name_prefix, "Zookeeper heartbeat")
  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('gauge.zk_max_file_descriptor_count', filter=filter('plugin', 'zookeeper') and ${local.not_running_vm_filters} and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "zookeeper_health" {
  name = format("%s %s", local.detector_name_prefix, "Zookeeper service health")

  program_text = <<-EOF
    signal = data('gauge.zk_service_health', filter=filter('plugin', 'zookeeper') and ${module.filter-tags.filter_custom})${var.zookeeper_health_aggregation_function}${var.zookeeper_health_transformation_function}.publish('signal')
    detect(when(signal != 1)).publish('CRIT')
EOF

  rule {
    description           = "is not running"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.zookeeper_health_disabled_critical, var.zookeeper_health_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.zookeeper_health_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "zookeeper_latency" {
  name = format("%s %s", local.detector_name_prefix, "Zookeeper latency")

  program_text = <<-EOF
    signal = data('gauge.zk_avg_latency', filter=filter('plugin', 'zookeeper') and ${module.filter-tags.filter_custom})${var.zookeeper_latency_aggregation_function}${var.zookeeper_latency_transformation_function}.publish('signal')
    detect(when(signal > ${var.zookeeper_latency_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.zookeeper_latency_threshold_major}) and when(signal <= ${var.zookeeper_latency_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.zookeeper_latency_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.zookeeper_latency_disabled_critical, var.zookeeper_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.zookeeper_latency_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.zookeeper_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.zookeeper_latency_disabled_major, var.zookeeper_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.zookeeper_latency_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "file_descriptors" {
  name = format("%s %s", local.detector_name_prefix, "Zookeeper file descriptors usage")

  program_text = <<-EOF
    A = data('gauge.zk_open_file_descriptor_count', filter=filter('plugin', 'zookeeper') and ${module.filter-tags.filter_custom}, rollup='average')${var.file_descriptors_aggregation_function}${var.file_descriptors_transformation_function}
    B = data('gauge.zk_max_file_descriptor_count', filter=filter('plugin', 'zookeeper') and ${module.filter-tags.filter_custom}, rollup='average')${var.file_descriptors_aggregation_function}${var.file_descriptors_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.file_descriptors_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.file_descriptors_threshold_major}) and when(signal <= ${var.file_descriptors_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.file_descriptors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.file_descriptors_disabled_critical, var.file_descriptors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.file_descriptors_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.file_descriptors_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.file_descriptors_disabled_major, var.file_descriptors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.file_descriptors_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

