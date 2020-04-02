resource "signalfx_detector" "heartbeat" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure search heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('SearchQueriesPerSecond', filter=filter('resource_type', 'Microsoft.Search/searchServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}).publish('signal')
		not_reporting.detector(stream=signal, resource_identifier=['azure_resource_id'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "search_latency" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure search latency"

	program_text = <<-EOF
		signal = data('SearchLatency', filter=filter('resource_type', 'Microsoft.Search/searchServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.search_latency_aggregation_function}.${var.search_latency_transformation_function}(over='${var.search_latency_transformation_window}').publish('signal')
		detect(when(signal > ${var.search_latency_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.search_latency_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.search_latency_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.search_latency_disabled_critical, var.search_latency_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.search_latency_notifications_critical, var.search_latency_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.search_latency_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.search_latency_disabled_warning, var.search_latency_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.search_latency_notifications_warning, var.search_latency_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "search_throttled_queries_rate" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Search throttled queries rate"

	program_text = <<-EOF
		signal = data('ThrottledSearchQueriesPercentage', filter=filter('resource_type', 'Microsoft.Search/searchServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.search_throttled_queries_rate_aggregation_function}.${var.search_throttled_queries_rate_transformation_function}(over='${var.search_throttled_queries_rate_transformation_window}').publish('signal')
		detect(when(signal > ${var.search_throttled_queries_rate_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.search_throttled_queries_rate_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.search_throttled_queries_rate_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.search_throttled_queries_rate_disabled_critical, var.search_throttled_queries_rate_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.search_throttled_queries_rate_notifications_critical, var.search_throttled_queries_rate_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.search_throttled_queries_rate_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.search_throttled_queries_rate_disabled_warning, var.search_throttled_queries_rate_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.search_throttled_queries_rate_notifications_warning, var.search_throttled_queries_rate_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}
