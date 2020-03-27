resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS Beanstalk heartbeat"

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('InstanceHealth', filter=filter('stat', 'mean') and filter('namespace', 'AWS/ElasticBeanstalk') and ${module.filter-tags.filter_custom})
		not_reporting.detector(stream=signal, resource_identifier=['InstanceId'], duration='${var.heartbeat_timeframe}').publish('CRIT')
	EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.heartbeat_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "health" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS Beanstalk environment health"

  program_text = <<-EOF
		signal = data('EnvironmentHealth', filter=filter('namespace', 'AWS/ElasticBeanstalk') and filter('stat', 'upper') and ${module.filter-tags.filter_custom})${var.health_aggregation_function}.${var.health_transformation_function}(over='${var.health_transformation_window}')
		detect(when(signal >= ${var.health_threshold_critical})).publish('CRIT')
		detect(when(signal >= ${var.health_threshold_warning})).publish('WARN')
	EOF

  rule {
    description           = "is too high >= ${var.health_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.health_disabled_critical, var.health_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.health_notifications_critical, var.health_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high >= ${var.health_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.health_disabled_warning, var.health_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.health_notifications_warning, var.health_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "latency_p90" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS Beanstalk application latency p90"

  program_text = <<-EOF
		signal = data('ApplicationLatencyP90', filter=filter('namespace', 'AWS/ElasticBeanstalk') and filter('stat', 'lower') and filter('InstanceId', '*') and ${module.filter-tags.filter_custom})${var.latency_p90_aggregation_function}.${var.latency_p90_transformation_function}(over='${var.latency_p90_transformation_window}')
		detect(when(signal >= ${var.latency_p90_threshold_critical})).publish('CRIT')
		detect(when(signal >= ${var.latency_p90_threshold_warning})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.latency_p90_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.latency_p90_disabled_critical, var.latency_p90_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.latency_p90_notifications_critical, var.latency_p90_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.latency_p90_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.latency_p90_disabled_warning, var.latency_p90_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.latency_p90_notifications_warning, var.latency_p90_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "app_5xx_error_rate" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS Beanstalk application 5xx error rate"

  program_text = <<-EOF
		A = data('ApplicationRequests5xx', filter=filter('namespace', 'AWS/ElasticBeanstalk') and filter('stat', 'sum') and filter('InstanceId', '*') and ${module.filter-tags.filter_custom})${var.app_5xx_error_rate_aggregation_function}
		B = data('ApplicationRequestsTotal', filter=filter('namespace', 'AWS/ElasticBeanstalk') and filter('stat', 'sum') and filter('InstanceId', '*') and ${module.filter-tags.filter_custom})${var.app_5xx_error_rate_aggregation_function}
		signal = (A/B).scale(100).${var.app_5xx_error_rate_transformation_function}(over='${var.app_5xx_error_rate_transformation_window}')
		detect(when(signal > ${var.app_5xx_error_rate_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.app_5xx_error_rate_threshold_warning})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.app_5xx_error_rate_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.app_5xx_error_rate_disabled_critical, var.app_5xx_error_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.app_5xx_error_rate_notifications_critical, var.app_5xx_error_rate_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.app_5xx_error_rate_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.app_5xx_error_rate_disabled_warning, var.app_5xx_error_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.app_5xx_error_rate_notifications_warning, var.app_5xx_error_rate_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "root_filesystem_usage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS Beanstalk instance root filesystem usage"

  program_text = <<-EOF
		signal = data('RootFilesystemUtil', filter=filter('namespace', 'AWS/ElasticBeanstalk') and filter('stat', 'lower') and filter('InstanceId', '*') and ${module.filter-tags.filter_custom})${var.root_filesystem_usage_aggregation_function}.${var.root_filesystem_usage_transformation_function}(over='${var.root_filesystem_usage_transformation_window}')
		detect(when(signal > ${var.root_filesystem_usage_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.root_filesystem_usage_threshold_warning})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.root_filesystem_usage_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.root_filesystem_usage_disabled_critical, var.root_filesystem_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.root_filesystem_usage_notifications_critical, var.root_filesystem_usage_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.root_filesystem_usage_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.root_filesystem_usage_disabled_warning, var.root_filesystem_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.root_filesystem_usage_notifications_warning, var.root_filesystem_usage_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}
