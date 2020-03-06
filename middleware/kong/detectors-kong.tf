resource "signalfx_detector" "heartbeat" {
	name = "${upper(join("", formatlist("[%s]", var.prefixes_slug)))}[${upper(var.environment)}] Kong heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('counter.kong.requests.count', filter= filter('aws_state', 'running') and filter('gcp_status', '*RUNNING}') and filter('azure_power_state', 'PowerState/running') and ${module.filter-tags.filter_custom})
		not_reporting.detector(stream=signal, resource_identifier=['host'], duration='${var.heartbeat_timeframe}').publish('CRIT')
	EOF

	rule {
		description           = "has not reported in ${var.heartbeat_timeframe}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
		notifications         = split(";", coalesce(var.heartbeat_notifications, var.notifications))
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "treatment_limit" {
	name = "${upper(join("", formatlist("[%s]", var.prefixes_slug)))}[${upper(var.environment)}] Kong treatment limit"

	program_text = <<-EOF
		A = data('counter.kong.connections.handled', filter=${module.filter-tags.filter_custom})${var.treatment_limit_aggregation_function}
		B = data('counter.kong.connections.accepted', filter=${module.filter-tags.filter_custom})${var.treatment_limit_aggregation_function}
		signal = ((A-B)/A).scale(100).${var.treatment_limit_transformation_function}(over='${var.treatment_limit_transformation_window}')
		detect(when(signal > ${var.treatment_limit_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.treatment_limit_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.treatment_limit_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.treatment_limit_disabled_critical, var.treatment_limit_disabled, var.detectors_disabled)
		notifications         = split(";", coalesce(var.treatment_limit_notifications_critical, var.treatment_limit_notifications, var.notifications))
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.treatment_limit_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.treatment_limit_disabled_warning, var.treatment_limit_disabled, var.detectors_disabled)
		notifications         = split(";", coalesce(var.treatment_limit_notifications_warning, var.treatment_limit_notifications, var.notifications))
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

