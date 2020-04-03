resource "signalfx_detector" "heartbeat" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS Alb heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('https/total_latencies' and ${module.filter-tags.filter_custom}).publish('signal')
		not_reporting.detector(stream=signal, resource_identifier=['backend_name'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "error_rate_4xx" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] GCP LB 4xx errors"

	program_text = <<-EOF
		A = data('https/request_count', filter=filter('service', 'loadbalancing') and filter('response_code_class', '400') and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.error_rate_4xx_aggregation_function}
		B = data('https/request_count', filter=filter('service', 'loadbalancing') and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.error_rate_4xx_aggregation_function}
		signal = ((A/B)*100).${var.error_rate_4xx_transformation_function}(over='${var.error_rate_4xx_transformation_window}').publish('signal')
		detect(when(signal > ${var.error_rate_4xx_threshold_critical}) and when(B > ${var.error_rate_4xx_threshold_number_requests})).publish('CRIT')
		detect(when(signal > ${var.error_rate_4xx_threshold_warning}) and when(B > ${var.error_rate_4xx_threshold_number_requests}) and when(signal < ${var.error_rate_4xx_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.error_rate_4xx_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.error_rate_4xx_disabled_critical, var.error_rate_4xx_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.error_rate_4xx_notifications_critical, var.error_rate_4xx_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.error_rate_4xx_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.error_rate_4xx_disabled_warning, var.error_rate_4xx_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.error_rate_4xx_notifications_warning, var.error_rate_4xx_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "error_rate_5xx" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] GCP LB 5xx errors"

	program_text = <<-EOF
		A = data('https/request_count', filter=filter('service', 'loadbalancing') and filter('response_code_class', '500') and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.error_rate_5xx_aggregation_function}
		B = data('https/request_count', filter=filter('service', 'loadbalancing') and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.error_rate_5xx_aggregation_function}
		signal = ((A/(B+5))*100).${var.error_rate_5xx_transformation_function}(over='${var.error_rate_5xx_transformation_window}').publish('signal')
		detect(when(signal > ${var.error_rate_5xx_threshold_critical}) and when(B > ${var.error_rate_5xx_threshold_number_requests})).publish('CRIT')
		detect(when(signal > ${var.error_rate_5xx_threshold_warning}) and when(B > ${var.error_rate_5xx_threshold_number_requests}) and when(signal < ${var.error_rate_5xx_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.error_rate_5xx_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.error_rate_5xx_disabled_critical, var.error_rate_5xx_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.error_rate_5xx_notifications_critical, var.error_rate_5xx_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.error_rate_5xx_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.error_rate_5xx_disabled_warning, var.error_rate_5xx_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.error_rate_5xx_notifications_warning, var.error_rate_5xx_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "backend_latency" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] GCP LB backend latency"

	program_text = <<-EOF
		from signalfx.detectors.aperiodic import aperiodic
		signal = data('https/backend_latencies ', filter=filter('service', 'loadbalancing') and filter('backend_target_type', 'BACKEND_SERVICE') and ${module.filter-tags.filter_custom})${var.backend_latency_aggregation_function}.${var.backend_latency_transformation_function}(over='${var.backend_latency_transformation_window}').publish('signal')
		aperiodic.above_or_below_detector(signal, ${var.backend_latency_threshold_critical}, 'above', lasting('${var.backend_latency_aperiodic_duration}', ${var.backend_latency_aperiodic_percentage})).publish('CRIT')
		aperiodic.above_or_below_detector(signal, ${var.backend_latency_threshold_warning}, 'above', lasting('${var.backend_latency_aperiodic_duration}', ${var.backend_latency_aperiodic_percentage})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.backend_latency_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.backend_latency_disabled_critical, var.backend_latency_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.backend_latency_notifications_critical, var.backend_latency_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.backend_latency_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.backend_latency_disabled_warning, var.backend_latency_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.backend_latency_notifications_warning, var.backend_latency_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "backend_latency_bucket" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] GCP LB backend latency bucket"

	program_text = <<-EOF
		from signalfx.detectors.aperiodic import aperiodic
		signal = data('https/backend_latencies ', filter=filter('service', 'loadbalancing') and filter('backend_target_type', 'BACKEND_BUCKET') and ${module.filter-tags.filter_custom})${var.backend_latency_bucket_aggregation_function}.${var.backend_latency_bucket_transformation_function}(over='${var.backend_latency_bucket_transformation_window}').publish('signal')
		aperiodic.above_or_below_detector(signal, ${var.backend_latency_bucket_threshold_critical}, 'above', lasting('${var.backend_latency_bucket_aperiodic_duration}', ${var.backend_latency_bucket_aperiodic_percentage})).publish('CRIT')
		aperiodic.above_or_below_detector(signal, ${var.backend_latency_bucket_threshold_warning}, 'above', lasting('${var.backend_latency_bucket_aperiodic_duration}', ${var.backend_latency_bucket_aperiodic_percentage})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.backend_latency_bucket_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.backend_latency_bucket_disabled_critical, var.backend_latency_bucket_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.backend_latency_bucket_notifications_critical, var.backend_latency_bucket_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.backend_latency_bucket_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.backend_latency_bucket_disabled_warning, var.backend_latency_bucket_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.backend_latency_bucket_notifications_warning, var.backend_latency_bucket_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "request_count" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] GCP LB request count"

	program_text = <<-EOF
		from signalfx.detectors.aperiodic import aperiodic
		signal = data('https/request_count', filter=filter('service', 'loadbalancing') and ${module.filter-tags.filter_custom})${var.request_count_aggregation_function}).rateofchange().${var.request_count_transformation_function}(over='${var.request_count_transformation_window}').publish('signal')
		aperiodic.above_or_below_detector(signal, ${var.request_count_threshold_critical}, 'above', lasting('${var.request_count_aperiodic_duration}', ${var.request_count_aperiodic_percentage})).publish('CRIT')
		aperiodic.above_or_below_detector(signal, ${var.request_count_threshold_warning}, 'above', lasting('${var.request_count_aperiodic_duration}', ${var.request_count_aperiodic_percentage})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.request_count_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.request_count_disabled_critical, var.request_count_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.request_count_notifications_critical, var.request_count_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.request_count_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.request_count_disabled_warning, var.request_count_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.request_count_notifications_warning, var.request_count_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}
