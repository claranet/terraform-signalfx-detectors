resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure App Gateway heartbeat"

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('Throughput', filter=filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}).publish('signal')
		not_reporting.detector(stream=signal, resource_identifier=['subscription_id'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "total_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure App Gateway requests"

  program_text = <<-EOF
		signal = data('TotalRequests', filter=filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}, rollup='sum')${var.total_requests_aggregation_function}.${var.total_requests_transformation_function}(over='${var.total_requests_transformation_window}').publish('signal')
		detect(when(signal < ${var.total_requests_threshold_critical})).publish('CRIT')
	EOF

  rule {
    description           = "have fallen below critical capacity < ${var.total_requests_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.total_requests_disabled_critical, var.total_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.total_requests_notifications_critical, var.total_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "backend_connect_time" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure App Gateway backend connect time"

  program_text = <<-EOF
		signal = data('BackendConnectTime', filter=filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.backend_connect_time_aggregation_function}.${var.backend_connect_time_transformation_function}(over='${var.backend_connect_time_transformation_window}').publish('signal')
		detect(when(signal > ${var.backend_connect_time_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.backend_connect_time_threshold_warning}) and when(signal <= ${var.backend_connect_time_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.backend_connect_time_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_connect_time_disabled_critical, var.backend_connect_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.backend_connect_time_notifications_critical, var.backend_connect_time_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.backend_connect_time_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.backend_connect_time_disabled_warning, var.backend_connect_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.backend_connect_time_notifications_warning, var.backend_connect_time_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "failed_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure App Gateway failed request rate"

  program_text = <<-EOF
		from signalfx.detectors.aperiodic import conditions
		A = data('FailedRequests', filter=filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.failed_requests_aggregation_function}
		B = data('TotalRequests', filter=filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.failed_requests_aggregation_function}
		signal = ((A/B)*100).${var.failed_requests_transformation_function}(over='${var.failed_requests_transformation_window}').publish('signal')
		ON_Condition_CRIT = conditions.generic_condition(signal, ${var.failed_requests_threshold_critical}, ${var.failed_requests_threshold_critical}, 'above', lasting('${var.failed_requests_aperiodic_duration}', ${var.failed_requests_aperiodic_percentage}), 'observed')
		ON_Condition_WARN = conditions.generic_condition(signal, ${var.failed_requests_threshold_warning}, ${var.failed_requests_threshold_critical}, 'within_range', lasting('${var.failed_requests_aperiodic_duration}', ${var.failed_requests_aperiodic_percentage}), 'observed', strict_2=False)
		detect(ON_Condition_CRIT, off=when(signal is None, '${var.failed_requests_clear_duration}')).publish('CRIT')
		detect(ON_Condition_WARN, off=when(signal is None, '${var.failed_requests_clear_duration}')).publish('WARN')	
	EOF

  rule {
    description           = "is too high > ${var.failed_requests_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.failed_requests_disabled_critical, var.failed_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.failed_requests_notifications_critical, var.failed_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.failed_requests_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.failed_requests_disabled_warning, var.failed_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.failed_requests_notifications_warning, var.failed_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "unhealthy_host_ratio" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure App Gateway backend unhealthy host ratio"

  program_text = <<-EOF
		A = data('UnhealthyHostCount', filter=filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.unhealthy_host_ratio_aggregation_function}
		B = data('HealthyHostCount', filter=filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.unhealthy_host_ratio_aggregation_function}
		signal = ((A/(A+B))*100).${var.unhealthy_host_ratio_transformation_function}(over='${var.unhealthy_host_ratio_transformation_window}').publish('signal')
		detect(when(signal >= ${var.unhealthy_host_ratio_threshold_critical})).publish('CRIT')
		detect(when(signal >= ${var.unhealthy_host_ratio_threshold_warning}) and when(signal < ${var.unhealthy_host_ratio_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = "is too high >= ${var.unhealthy_host_ratio_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.unhealthy_host_ratio_disabled_critical, var.unhealthy_host_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.unhealthy_host_ratio_notifications_critical, var.unhealthy_host_ratio_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high >= ${var.unhealthy_host_ratio_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.unhealthy_host_ratio_disabled_warning, var.unhealthy_host_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.unhealthy_host_ratio_notifications_warning, var.unhealthy_host_ratio_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "http_4xx_errors" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure App Gateway 4xx error rate"

  program_text = <<-EOF
		from signalfx.detectors.aperiodic import conditions
		A = data('ResponseStatus', filter=filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('httpstatusgroup', '4xx') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.http_4xx_errors_aggregation_function}
		B = data('ResponseStatus', filter=filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.http_4xx_errors_aggregation_function}
		signal = ((A/B)*100).${var.http_4xx_errors_transformation_function}(over='${var.http_4xx_errors_transformation_window}').publish('signal')
		ON_Condition_CRIT = conditions.generic_condition(signal, ${var.http_4xx_errors_threshold_critical}, ${var.http_4xx_errors_threshold_critical}, 'above', lasting('${var.http_4xx_errors_aperiodic_duration}', ${var.http_4xx_errors_aperiodic_percentage}), 'observed')
		ON_Condition_WARN = conditions.generic_condition(signal, ${var.http_4xx_errors_threshold_warning}, ${var.http_4xx_errors_threshold_critical}, 'within_range', lasting('${var.http_4xx_errors_aperiodic_duration}', ${var.http_4xx_errors_aperiodic_percentage}), 'observed', strict_2=False)
		detect(ON_Condition_CRIT, off=when(signal is None, '${var.http_4xx_errors_clear_duration}')).publish('CRIT')
		detect(ON_Condition_WARN, off=when(signal is None, '${var.http_4xx_errors_clear_duration}')).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.http_4xx_errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_4xx_errors_disabled_critical, var.http_4xx_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_4xx_errors_notifications_critical, var.http_4xx_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.http_4xx_errors_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.http_4xx_errors_disabled_warning, var.http_4xx_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_4xx_errors_notifications_warning, var.http_4xx_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "http_5xx_errors" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure App Gateway 5xx error rate"

  program_text = <<-EOF
		from signalfx.detectors.aperiodic import conditions
		A = data('ResponseStatus', filter=filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('httpstatusgroup', '5xx') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.http_5xx_errors_aggregation_function}
		B = data('ResponseStatus', filter=filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.http_5xx_errors_aggregation_function}
		signal = ((A/B)*100).${var.http_5xx_errors_transformation_function}(over='${var.http_5xx_errors_transformation_window}').publish('signal')
		ON_Condition_CRIT = conditions.generic_condition(signal, ${var.http_5xx_errors_threshold_critical}, ${var.http_5xx_errors_threshold_critical}, 'above', lasting('${var.http_5xx_errors_aperiodic_duration}', ${var.http_5xx_errors_aperiodic_percentage}), 'observed')
		ON_Condition_WARN = conditions.generic_condition(signal, ${var.http_5xx_errors_threshold_warning}, ${var.http_5xx_errors_threshold_critical}, 'within_range', lasting('${var.http_5xx_errors_aperiodic_duration}', ${var.http_5xx_errors_aperiodic_percentage}), 'observed', strict_2=False)
		detect(ON_Condition_CRIT, off=when(signal is None, '${var.http_5xx_errors_clear_duration}')).publish('CRIT')
		detect(ON_Condition_WARN, off=when(signal is None, '${var.http_5xx_errors_clear_duration}')).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.http_5xx_errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_5xx_errors_disabled_critical, var.http_5xx_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_5xx_errors_notifications_critical, var.http_5xx_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.http_5xx_errors_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.http_5xx_errors_disabled_warning, var.http_5xx_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_5xx_errors_notifications_warning, var.http_5xx_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "backend_http_4xx_errors" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure App Gateway backend 4xx error rate"

  program_text = <<-EOF
		from signalfx.detectors.aperiodic import conditions
		A = data('BackendResponseStatus', filter=filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('httpstatusgroup', '4xx') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.backend_http_4xx_errors_aggregation_function}
		B = data('BackendResponseStatus', filter=filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.backend_http_4xx_errors_aggregation_function}
		signal = ((A/B)*100).${var.backend_http_4xx_errors_transformation_function}(over='${var.backend_http_4xx_errors_transformation_window}').publish('signal')
		ON_Condition_CRIT = conditions.generic_condition(signal, ${var.backend_http_4xx_errors_threshold_critical}, ${var.backend_http_4xx_errors_threshold_critical}, 'above', lasting('${var.backend_http_4xx_errors_aperiodic_duration}', ${var.backend_http_4xx_errors_aperiodic_percentage}), 'observed')
		ON_Condition_WARN = conditions.generic_condition(signal, ${var.backend_http_4xx_errors_threshold_warning}, ${var.backend_http_4xx_errors_threshold_critical}, 'within_range', lasting('${var.backend_http_4xx_errors_aperiodic_duration}', ${var.backend_http_4xx_errors_aperiodic_percentage}), 'observed', strict_2=False)
		detect(ON_Condition_CRIT, off=when(signal is None, '${var.backend_http_4xx_errors_clear_duration}')).publish('CRIT')
		detect(ON_Condition_WARN, off=when(signal is None, '${var.backend_http_4xx_errors_clear_duration}')).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.backend_http_4xx_errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_http_4xx_errors_disabled_critical, var.backend_http_4xx_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.backend_http_4xx_errors_notifications_critical, var.backend_http_4xx_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.backend_http_4xx_errors_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.backend_http_4xx_errors_disabled_warning, var.backend_http_4xx_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.backend_http_4xx_errors_notifications_warning, var.backend_http_4xx_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "backend_http_5xx_errors" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure App Gateway backend 5xx error rate"

  program_text = <<-EOF
		from signalfx.detectors.aperiodic import conditions
		A = data('BackendResponseStatus', filter=filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('httpstatusgroup', '5xx') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.backend_http_5xx_errors_aggregation_function}
		B = data('BackendResponseStatus', filter=filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.backend_http_5xx_errors_aggregation_function}
		signal = ((A/B)*100).${var.backend_http_5xx_errors_transformation_function}(over='${var.backend_http_5xx_errors_transformation_window}').publish('signal')
		ON_Condition_CRIT = conditions.generic_condition(signal, ${var.backend_http_5xx_errors_threshold_critical}, ${var.backend_http_5xx_errors_threshold_critical}, 'above', lasting('${var.backend_http_5xx_errors_aperiodic_duration}', ${var.backend_http_5xx_errors_aperiodic_percentage}), 'observed')
		ON_Condition_WARN = conditions.generic_condition(signal, ${var.backend_http_5xx_errors_threshold_warning}, ${var.backend_http_5xx_errors_threshold_critical}, 'within_range', lasting('${var.backend_http_5xx_errors_aperiodic_duration}', ${var.backend_http_5xx_errors_aperiodic_percentage}), 'observed', strict_2=False)
		detect(ON_Condition_CRIT, off=when(signal is None, '${var.backend_http_5xx_errors_clear_duration}')).publish('CRIT')
		detect(ON_Condition_WARN, off=when(signal is None, '${var.backend_http_5xx_errors_clear_duration}')).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.backend_http_5xx_errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_http_5xx_errors_disabled_critical, var.backend_http_5xx_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.backend_http_5xx_errors_notifications_critical, var.backend_http_5xx_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.backend_http_5xx_errors_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.backend_http_5xx_errors_disabled_warning, var.backend_http_5xx_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.backend_http_5xx_errors_notifications_warning, var.backend_http_5xx_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
