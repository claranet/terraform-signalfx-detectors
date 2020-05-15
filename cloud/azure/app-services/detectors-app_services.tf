resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure App Services heartbeat"

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('Requests', filter=filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}).publish('signal')
		not_reporting.detector(stream=signal, resource_identifier=['azure_resource_name', 'azure_resource_group_name', 'azure_region'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "response_time" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure App Service response time"

  program_text = <<-EOF
		from signalfx.detectors.aperiodic import aperiodic
		signal = data('AverageResponseTime', filter=filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.response_time_aggregation_function}.${var.response_time_transformation_function}(over='${var.response_time_transformation_window}').publish('signal')
		aperiodic.above_or_below_detector(signal, ${var.response_time_threshold_critical}, 'above', lasting('${var.response_time_aperiodic_duration}', ${var.response_time_aperiodic_percentage})).publish('CRIT')
		aperiodic.range_detector(signal, ${var.response_time_threshold_warning}, ${var.response_time_threshold_critical}, 'within_range', lasting('${var.response_time_aperiodic_duration}', ${var.response_time_aperiodic_percentage}), upper_strict=False).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.response_time_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.response_time_disabled_critical, var.response_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.response_time_notifications_critical, var.response_time_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.response_time_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.response_time_disabled_warning, var.response_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.response_time_notifications_warning, var.response_time_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "memory_usage_count" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure App Service memory usage"

  program_text = <<-EOF
		signal = data('MemoryWorkingSet', filter=filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.memory_usage_count_aggregation_function}.${var.memory_usage_count_transformation_function}(over='${var.memory_usage_count_transformation_window}').publish('signal')
		detect(when(signal > ${var.memory_usage_count_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.memory_usage_count_threshold_warning}) and when(signal <= ${var.memory_usage_count_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.memory_usage_count_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_usage_count_disabled_critical, var.memory_usage_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.memory_usage_count_notifications_critical, var.memory_usage_count_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.memory_usage_count_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.memory_usage_count_disabled_warning, var.memory_usage_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.memory_usage_count_notifications_warning, var.memory_usage_count_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "http_5xx_errors_count" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure App Service 5xx error rate"

  program_text = <<-EOF
		from signalfx.detectors.aperiodic import aperiodic
		A = data('Http5xx', filter=filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.http_5xx_errors_count_aggregation_function}
		B = data('Requests', filter=filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.http_5xx_errors_count_aggregation_function}
		signal = ((A/B)*100).${var.http_5xx_errors_count_transformation_function}(over='${var.http_5xx_errors_count_transformation_window}').publish('signal')
		aperiodic.above_or_below_detector(signal, ${var.http_5xx_errors_count_threshold_critical}, 'above', lasting('${var.http_5xx_errors_count_aperiodic_duration}', ${var.http_5xx_errors_count_aperiodic_percentage})).publish('CRIT')
		aperiodic.range_detector(signal, ${var.http_5xx_errors_count_threshold_warning}, ${var.http_5xx_errors_count_threshold_critical}, 'within_range', lasting('${var.http_5xx_errors_count_aperiodic_duration}', ${var.http_5xx_errors_count_aperiodic_percentage}), upper_strict=False).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.http_5xx_errors_count_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_5xx_errors_count_disabled_critical, var.http_5xx_errors_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_5xx_errors_count_notifications_critical, var.http_5xx_errors_count_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.http_5xx_errors_count_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.http_5xx_errors_count_disabled_warning, var.http_5xx_errors_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_5xx_errors_count_notifications_warning, var.http_5xx_errors_count_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "http_4xx_errors_count" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure App Service 4xx error rate"

  program_text = <<-EOF
		from signalfx.detectors.aperiodic import aperiodic
		A = data('Http4xx', filter=filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.http_4xx_errors_count_aggregation_function}
		B = data('Requests', filter=filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.http_4xx_errors_count_aggregation_function}
		signal = ((A/B)*100).${var.http_4xx_errors_count_transformation_function}(over='${var.http_4xx_errors_count_transformation_window}').publish('signal')
		aperiodic.above_or_below_detector(signal, ${var.http_4xx_errors_count_threshold_critical}, 'above', lasting('${var.http_4xx_errors_count_aperiodic_duration}', ${var.http_4xx_errors_count_aperiodic_percentage})).publish('CRIT')
		aperiodic.range_detector(signal, ${var.http_4xx_errors_count_threshold_warning}, ${var.http_4xx_errors_count_threshold_critical}, 'within_range', lasting('${var.http_4xx_errors_count_aperiodic_duration}', ${var.http_4xx_errors_count_aperiodic_percentage}), upper_strict=False).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.http_4xx_errors_count_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_4xx_errors_count_disabled_critical, var.http_4xx_errors_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_4xx_errors_count_notifications_critical, var.http_4xx_errors_count_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.http_4xx_errors_count_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.http_4xx_errors_count_disabled_warning, var.http_4xx_errors_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_4xx_errors_count_notifications_warning, var.http_4xx_errors_count_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "http_success_status_rate" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure App Service successful response rate"

  program_text = <<-EOF
		from signalfx.detectors.aperiodic import aperiodic
		A = data('Http2xx', filter=filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.http_success_status_rate_aggregation_function}
		B = data('Http3xx', filter=filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.http_success_status_rate_aggregation_function}
		C = data('Requests', filter=filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and ${module.filter-tags.filter_custom})${var.http_success_status_rate_aggregation_function}
		signal = (((A+B)/C)*100).${var.http_success_status_rate_transformation_function}(over='${var.http_success_status_rate_transformation_window}').publish('signal')
		aperiodic.above_or_below_detector(signal, ${var.http_success_status_rate_threshold_critical}, 'below', lasting('${var.http_success_status_rate_aperiodic_duration}', ${var.http_success_status_rate_aperiodic_percentage})).publish('CRIT')
		aperiodic.range_detector(signal, ${var.http_success_status_rate_threshold_critical}, ${var.http_success_status_rate_threshold_warning}, 'within_range', lasting('${var.http_success_status_rate_aperiodic_duration}', ${var.http_success_status_rate_aperiodic_percentage}), lower_strict=False).publish('WARN')
	EOF

  rule {
    description           = "is too low < ${var.http_success_status_rate_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_success_status_rate_disabled_critical, var.http_success_status_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_success_status_rate_notifications_critical, var.http_success_status_rate_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too low < ${var.http_success_status_rate_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.http_success_status_rate_disabled_warning, var.http_success_status_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_success_status_rate_notifications_warning, var.http_success_status_rate_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "status" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure App Service"

  program_text = <<-EOF
		signal = data('HealthCheckStatus', filter=filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.status_aggregation_function}.${var.status_transformation_function}(over='${var.status_transformation_window}').publish('signal')
		detect(when(signal < ${var.status_threshold_critical})).publish('CRIT')
	EOF

  rule {
    description           = "is not reporting up"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.status_disabled_critical, var.status_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.status_notifications_critical, var.status_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}
