resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS Beanstalk heartbeat"

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('EnvironmentHealth', filter=filter('stat', 'mean') and filter('namespace', 'AWS/ElasticBeanstalk') and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }
}

resource "signalfx_detector" "health" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS Beanstalk environment health"

  program_text = <<-EOF
    signal = data('EnvironmentHealth', filter=filter('namespace', 'AWS/ElasticBeanstalk') and filter('stat', 'upper') and ${module.filter-tags.filter_custom})${var.health_aggregation_function}${var.health_transformation_function}.publish('signal')
    detect(when(signal >= ${var.health_threshold_critical})).publish('CRIT')
    detect(when(signal >= ${var.health_threshold_major}) and when(signal < ${var.health_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.health_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.health_disabled_critical, var.health_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.health_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }

  rule {
    description           = "is too high >= ${var.health_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.health_disabled_major, var.health_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.health_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }
}

resource "signalfx_detector" "latency_p90" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS Beanstalk application latency p90"

  program_text = <<-EOF
    signal = data('ApplicationLatencyP90', filter=filter('namespace', 'AWS/ElasticBeanstalk') and filter('stat', 'lower') and (not filter('InstanceId', '*')) and ${module.filter-tags.filter_custom})${var.latency_p90_aggregation_function}${var.latency_p90_transformation_function}.publish('signal')
    detect(when(signal >= ${var.latency_p90_threshold_critical})).publish('CRIT')
    detect(when(signal >= ${var.latency_p90_threshold_major}) and when(signal < ${var.latency_p90_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.latency_p90_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.latency_p90_disabled_critical, var.latency_p90_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.latency_p90_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }

  rule {
    description           = "is too high > ${var.latency_p90_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.latency_p90_disabled_major, var.latency_p90_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.latency_p90_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }
}

resource "signalfx_detector" "app_5xx_error_rate" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS Beanstalk application 5xx error rate"

  program_text = <<-EOF
    A = data('ApplicationRequests5xx', filter=filter('namespace', 'AWS/ElasticBeanstalk') and filter('stat', 'sum') and (not filter('InstanceId', '*')) and ${module.filter-tags.filter_custom})${var.app_5xx_error_rate_aggregation_function}${var.app_5xx_error_rate_transformation_function}
    B = data('ApplicationRequestsTotal', filter=filter('namespace', 'AWS/ElasticBeanstalk') and filter('stat', 'sum') and (not filter('InstanceId', '*')) and ${module.filter-tags.filter_custom})${var.app_5xx_error_rate_aggregation_function}${var.app_5xx_error_rate_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.app_5xx_error_rate_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.app_5xx_error_rate_threshold_major}) and when(signal <= ${var.app_5xx_error_rate_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.app_5xx_error_rate_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.app_5xx_error_rate_disabled_critical, var.app_5xx_error_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.app_5xx_error_rate_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }

  rule {
    description           = "is too high > ${var.app_5xx_error_rate_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.app_5xx_error_rate_disabled_major, var.app_5xx_error_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.app_5xx_error_rate_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }

}

resource "signalfx_detector" "root_filesystem_usage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS Beanstalk instance root filesystem usage"

  program_text = <<-EOF
    signal = data('RootFilesystemUtil', filter=filter('namespace', 'AWS/ElasticBeanstalk') and filter('stat', 'lower') and (not filter('InstanceId', '*')) and ${module.filter-tags.filter_custom})${var.root_filesystem_usage_aggregation_function}${var.root_filesystem_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.root_filesystem_usage_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.root_filesystem_usage_threshold_major}) and when(signal <= ${var.root_filesystem_usage_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.root_filesystem_usage_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.root_filesystem_usage_disabled_critical, var.root_filesystem_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.root_filesystem_usage_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }

  rule {
    description           = "is too high > ${var.root_filesystem_usage_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.root_filesystem_usage_disabled_major, var.root_filesystem_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.root_filesystem_usage_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }
}

