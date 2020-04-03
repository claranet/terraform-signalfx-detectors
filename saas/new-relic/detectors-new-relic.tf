resource "signalfx_detector" "heartbeat" {
 	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ALB heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('Agent/MetricsReported/count/requests_per_minute/*' and ${module.filter-tags.filter_custom})
		not_reporting.detector(stream=signal, resource_identifier=['id'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "app_error_rate" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] New Relic error rate"

	program_text = <<-EOF
		signal = data('Errors/all/errors_per_minute/*' and ${module.filter-tags.filter_custom})${var.app_error_rate_aggregation_function}.${var.app_error_rate_transformation_function}(over='${var.app_error_rate_transformation_window}')
		detect(when(signal > ${var.app_error_rate_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.app_error_rate_threshold_warning}) and when(signal < ${var.app_error_rate_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.app_error_rate_threshold_critical}s"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.app_error_rate_disabled_critical, var.app_error_rate_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.app_error_rate_notifications_critical, var.app_error_rate_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.app_error_rate_threshold_warning}s"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.app_error_rate_disabled_warning, var.app_error_rate_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.app_error_rate_notifications_warning, var.app_error_rate_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "app_apdex_score" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] New Relic apdex score ratio"

	program_text = <<-EOF
		signal = data('Apdex/score/*' and ${module.filter-tags.filter_custom})${var.app_apdex_score_aggregation_function}.${var.app_apdex_score_transformation_function}(over='${var.app_apdex_score_transformation_window}')
		detect(when(signal < ${var.app_apdex_score_threshold_critical})).publish('CRIT')
		detect(when(signal < ${var.app_apdex_score_threshold_warning}) and when(signal > ${var.app_apdex_score_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "has fallen below critical capacity < ${var.app_apdex_score_threshold_critical}s"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.app_apdex_score_disabled_critical, var.app_apdex_score_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.app_apdex_score_notifications_critical, var.app_apdex_score_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is below nominal capacity < ${var.app_apdex_score_threshold_warning}s"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.app_apdex_score_disabled_warning, var.app_apdex_score_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.app_apdex_score_notifications_warning, var.app_apdex_score_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}
