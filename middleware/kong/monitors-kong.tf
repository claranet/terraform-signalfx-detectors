resource "signalfx_detector" "kong_service_heartbeat" {
	name = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] Kong Service Heartbeat Check"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('counter.kong.requests.count', filter=(not filter('aws_state', '*terminated}', '*stopped}')) and (not filter('gcp_status', '*TERMINATED}', '*STOPPING}')) and (not filter('azure_power_state', 'stop*', 'deallocat*')))
		not_reporting.detector(stream=signal, resource_identifier=['host'], duration='${var.kong_service_heartbeat_timeframe}').publish('CRIT')
	EOF

	rule {
		description = "Kong Server has not reported in ${var.kong_service_heartbeat_timeframe}"
		severity = "Critical"
		detect_label = "CRIT"
		disabled = "${var.kong_service_heartbeat_disabled_flag}"
	}
}

resource "signalfx_detector" "treatment_limit" {
	name = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] Kong exceeded its treatment limit"

	program_text = <<-EOF
		A = data('counter.kong.connections.handled'"${var.treatment_limit_filter == "" ? "" : "${var.treatment_limit_filter}"}")${var.treatment_limit_aggregation_function}
		B = data('counter.kong.connections.accepted'"${var.treatment_limit_filter == "" ? "" : "${var.treatment_limit_filter}"}")${var.treatment_limit_aggregation_function}
		signal = ((A-B)/A).scale(100).${var.treatment_limit_transformation_function}(over='${var.treatment_limit_transformation_window}')
		detect(when(signal > ${var.treatment_limit_threshold_critical})).publish('CRIT')
		detect(when(signal < ${var.treatment_limit_threshold_warning})).publish('WARN')
	EOF

	rule {
		description = "${var.treatment_limit_transformation_function} treatment limit over ${var.treatment_limit_transformation_window} > ${var.treatment_limit_threshold_critical}"
		severity = "Critical"
		detect_label = "CRIT"
		disabled = var.treatment_limit_critical_disabled_flag
	}

	rule {
		description = "${var.treatment_limit_transformation_function} treatment limit over ${var.treatment_limit_transformation_window} > ${var.treatment_limit_threshold_warning}"
		severity = "Warning"
		detect_label = "WARN"
		disabled = var.treatment_limit_warning_disabled_flag
	}
}
