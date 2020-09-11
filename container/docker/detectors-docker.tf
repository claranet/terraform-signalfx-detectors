resource "signalfx_detector" "heartbeat" {
  name      = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Docker host heartbeat"
  max_delay = 900

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('cpu.usage.system', filter=filter('plugin', 'docker') and (not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}')) and (not filter('gcp_status', '{Code=3, Name=STOPPING}', '{Code=4, Name=TERMINATED}')) and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stoppped', 'PowerState/deallocating', 'PowerState/deallocated')) and ${module.filter-tags.filter_custom}).mean(by='host').publish('signal')
		not_reporting.detector(stream=signal, resource_identifier=['host'], duration='${var.heartbeat_timeframe}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.heartbeat_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "cpu" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Docker container usage of cpu host"

  program_text = <<-EOF
		signal = data('cpu.percent', filter=filter('plugin', 'docker') and ${module.filter-tags.filter_custom})${var.cpu_aggregation_function}${var.cpu_transformation_function}.publish('signal')
		detect(when(signal > ${var.cpu_threshold_warning})).publish('WARN')
		detect(when(signal > ${var.cpu_threshold_major}) and when(signal <= ${var.cpu_threshold_warning})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.cpu_disabled_warning, var.cpu_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.cpu_notifications_warning, var.cpu_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.cpu_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_disabled_major, var.cpu_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.cpu_notifications_major, var.cpu_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "throttling" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Docker container cpu throttling time"

  program_text = <<-EOF
		A = data('cpu.throttling_data.throttled_time', filter=filter('plugin', 'docker') and ${module.filter-tags.filter_custom}, rollup='delta')${var.throttling_aggregation_function}${var.throttling_transformation_function}
		B = data('cpu.throttling_data.throttled_time', filter=filter('plugin', 'docker') and ${module.filter-tags.filter_custom}, rollup='delta')${var.throttling_aggregation_function}${var.throttling_transformation_function}
		signal = (A/B).scale(100).publish('signal')
		detect(when(signal > ${var.throttling_threshold_warning})).publish('WARN')
		detect(when(signal > ${var.throttling_threshold_major}) and when(signal <= ${var.throttling_threshold_warning})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.throttling_threshold_warning}ns"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.throttling_disabled_warning, var.throttling_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.throttling_notifications_warning, var.throttling_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.throttling_threshold_major}ns"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.throttling_disabled_major, var.throttling_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.throttling_notifications_major, var.throttling_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "memory" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Docker memory usage"

  program_text = <<-EOF
		A = data('memory.usage.total', filter=filter('plugin', 'docker') and ${module.filter-tags.filter_custom})${var.memory_aggregation_function}${var.memory_transformation_function}
		B = data('memory.usage.limit', filter=filter('plugin', 'docker') and ${module.filter-tags.filter_custom})${var.memory_aggregation_function}${var.memory_transformation_function}
		signal = (A/B).scale(100).publish('signal')
		detect(when(signal > ${var.memory_threshold_warning})).publish('WARN')
		detect(when(signal > ${var.memory_threshold_major}) and when(signal <= ${var.memory_threshold_warning})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memory_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.memory_disabled_warning, var.memory_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.memory_notifications_warning, var.memory_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.memory_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_disabled_major, var.memory_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.memory_notifications_major, var.memory_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

