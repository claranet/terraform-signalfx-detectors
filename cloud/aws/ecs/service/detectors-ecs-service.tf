resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS ECS heartbeat")

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('CPUUtilization', filter=filter('namespace', 'AWS/ECS') and filter('stat', 'mean') and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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

# Monitors related to services
resource "signalfx_detector" "cpu_utilization" {
  name = format("%s %s", local.detector_name_prefix, "AWS ECS service CPU utilization")

  program_text = <<-EOF
    signal = data('CPUUtilization', filter=filter('namespace', 'AWS/ECS') and filter('stat', 'mean') and filter('ServiceName', '*') and ${module.filter-tags.filter_custom}).mean(by=['ServiceName'])${var.cpu_utilization_aggregation_function}${var.cpu_utilization_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_utilization_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_utilization_threshold_major}) and when(signal <= ${var.cpu_utilization_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_utilization_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_utilization_disabled_critical, var.cpu_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_utilization_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.cpu_utilization_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_utilization_disabled_major, var.cpu_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_utilization_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "memory_utilization" {
  name = format("%s %s", local.detector_name_prefix, "AWS ECS service memory utilization")

  program_text = <<-EOF
    signal = data('Memoryutilization', filter=filter('namespace', 'AWS/ECS') and filter('stat', 'mean') and filter('ServiceName', '*') and ${module.filter-tags.filter_custom}).mean(by=['ServiceName'])${var.memory_utilization_aggregation_function}${var.memory_utilization_transformation_function}.publish('signal')
    detect(when(signal > ${var.memory_utilization_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.memory_utilization_threshold_major}) and when(signal <= ${var.memory_utilization_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memory_utilization_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_utilization_disabled_critical, var.memory_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_utilization_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.memory_utilization_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_utilization_disabled_major, var.memory_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_utilization_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

