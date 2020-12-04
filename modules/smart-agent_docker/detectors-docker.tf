resource "signalfx_detector" "heartbeat" {
  name      = format("%s %s", local.detector_name_prefix, "Docker host heartbeat")
  max_delay = 900

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('cpu.usage.system', filter=filter('plugin', 'docker') and ${local.not_running_vm_filters} and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "cpu" {
  name = format("%s %s", local.detector_name_prefix, "Docker container usage of cpu host")

  program_text = <<-EOF
		signal = data('cpu.percent', filter=filter('plugin', 'docker') and ${module.filter-tags.filter_custom})${var.cpu_aggregation_function}${var.cpu_transformation_function}.publish('signal')
		detect(when(signal > ${var.cpu_threshold_major})).publish('MAJOR')
		detect(when(signal > ${var.cpu_threshold_minor}) and when(signal <= ${var.cpu_threshold_major})).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_disabled_major, var.cpu_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.cpu_threshold_minor}%"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.cpu_disabled_minor, var.cpu_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "throttling" {
  name = format("%s %s", local.detector_name_prefix, "Docker container cpu throttling time")

  program_text = <<-EOF
		A = data('cpu.throttling_data.throttled_time', filter=filter('plugin', 'docker') and ${module.filter-tags.filter_custom}, rollup='delta')${var.throttling_aggregation_function}${var.throttling_transformation_function}
		B = data('cpu.throttling_data.throttled_time', filter=filter('plugin', 'docker') and ${module.filter-tags.filter_custom}, rollup='delta')${var.throttling_aggregation_function}${var.throttling_transformation_function}
		signal = (A/B).scale(100).publish('signal')
		detect(when(signal > ${var.throttling_threshold_major})).publish('MAJOR')
		detect(when(signal > ${var.throttling_threshold_minor}) and when(signal <= ${var.throttling_threshold_major})).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.throttling_threshold_major}ns"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.throttling_disabled_major, var.throttling_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.throttling_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.throttling_threshold_minor}ns"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.throttling_disabled_minor, var.throttling_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.throttling_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "memory" {
  name = format("%s %s", local.detector_name_prefix, "Docker memory usage")

  program_text = <<-EOF
		A = data('memory.usage.total', filter=filter('plugin', 'docker') and ${module.filter-tags.filter_custom})${var.memory_aggregation_function}${var.memory_transformation_function}
		B = data('memory.usage.limit', filter=filter('plugin', 'docker') and ${module.filter-tags.filter_custom})${var.memory_aggregation_function}${var.memory_transformation_function}
		signal = (A/B).scale(100).publish('signal')
		detect(when(signal > ${var.memory_threshold_major})).publish('MAJOR')
		detect(when(signal > ${var.memory_threshold_minor}) and when(signal <= ${var.memory_threshold_major})).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.memory_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_disabled_major, var.memory_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.memory_threshold_minor}%"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.memory_disabled_minor, var.memory_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

