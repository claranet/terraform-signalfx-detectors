resource "signalfx_detector" "heartbeat" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] HTTP heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('http.status_code', ${module.filter-tags.filter_custom}).publish('signal')
		not_reporting.detector(stream=signal, resource_identifier=['url'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "http_code_matched" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] HTTP code matched"

	program_text = <<-EOF
		signal = data('http.code_matched', ${module.filter-tags.filter_custom}).count()${var.http_code_matched_aggregation_function}.${var.http_code_matched_transformation_function}(over='${var.http_code_matched_transformation_window}').publish('signal')
		detect(when(signal < ${var.http_code_matched_threshold_critical})).publish('CRIT')
		detect(when(signal < ${var.http_code_matched_threshold_warning}) and when(signal >= ${var.http_code_matched_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too low < ${var.http_code_matched_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.http_code_matched_disabled_critical, var.http_code_matched_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.http_code_matched_notifications_critical, var.http_code_matched_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too low < ${var.http_code_matched_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.http_code_matched_disabled_warning, var.http_code_matched_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.http_code_matched_notifications_warning, var.http_code_matched_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "http_status_code" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] HTTP status code"

	program_text = <<-EOF
		signal = data('http.status_code', ${module.filter-tags.filter_custom})${var.http_status_code_aggregation_function}.${var.http_status_code_transformation_function}(over='${var.http_status_code_transformation_window}').publish('signal')
		detect(when(signal > ${var.http_status_code_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description           = "is not success > ${var.http_status_code_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.http_status_code_disabled_critical, var.http_status_code_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.http_status_code_notifications_critical, var.http_status_code_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "http_regex_matched" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] HTTP regex matched"

	program_text = <<-EOF
		signal = data('http.regex_matched', ${module.filter-tags.filter_custom}).count()${var.http_regex_matched_aggregation_function}${var.http_regex_matched_transformation_function}(over='${var.http_regex_matched_transformation_window}').publish('signal')
		detect(when(signal < ${var.http_regex_matched_threshold_critical})).publish('CRIT')
		detect(when(signal < ${var.http_regex_matched_threshold_warning}) and when(signal >= ${var.http_regex_matched_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too low < ${var.http_regex_matched_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.http_regex_matched_disabled_critical, var.http_regex_matched_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.http_regex_matched_notifications_critical, var.http_regex_matched_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too low < ${var.http_regex_matched_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.http_regex_matched_disabled_warning, var.http_regex_matched_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.http_regex_matched_notifications_warning, var.http_regex_matched_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "http_response_time" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] HTTP response time"

	program_text = <<-EOF
		signal = data('http.response_time', ${module.filter-tags.filter_custom})${var.http_response_time_aggregation_function}.${var.http_response_time_transformation_function}(over='${var.http_response_time_transformation_window}').publish('signal')
		detect(when(signal > ${var.http_response_time_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.http_response_time_threshold_warning}) and when(signal <= ${var.http_response_time_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.http_response_time_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.http_response_time_disabled_critical, var.http_response_time_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.http_response_time_notifications_critical, var.http_response_time_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.http_response_time_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.http_response_time_disabled_warning, var.http_response_time_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.http_response_time_notifications_warning, var.http_response_time_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "http_content_length" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] HTTP content length"

	program_text = <<-EOF
		signal = data('http.content_length', ${module.filter-tags.filter_custom})${var.http_content_length_aggregation_function}.${var.http_content_length_transformation_function}(over='${var.http_content_length_transformation_window}').publish('signal')
		detect(when(signal < ${var.http_content_length_threshold_critical})).publish('CRIT')
		detect(when(signal < ${var.http_content_length_threshold_warning}) and when(signal >= ${var.http_content_length_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too low < ${var.http_content_length_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.http_content_length_disabled_critical, var.http_content_length_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.http_content_length_notifications_critical, var.http_content_length_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too low < ${var.http_content_length_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.http_content_length_disabled_warning, var.http_content_length_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.http_content_length_notifications_warning, var.http_content_length_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}
