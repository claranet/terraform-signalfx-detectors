resource "signalfx_detector" "kong_service_heartbeat" {
	name = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] Kong Service Heartbeat Check"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('counter.kong.requests.count', filter=(not filter('aws_state', '*terminated}', '*stopped}')) and (not filter('gcp_status', '*TERMINATED}', '*STOPPING}')) and (not filter('azure_power_state', 'stop*', 'deallocat*')) and ${module.filter-tags.filter_custom})
		not_reporting.detector(stream=signal, resource_identifier=['host'], duration='${var.kong_service_heartbeat_timeframe}').publish('CRIT')
	EOF

	rule {
		description = "Kong Server has not reported in ${var.kong_service_heartbeat_timeframe}"
		severity = "Critical"
		detect_label = "CRIT"
		disabled = coalesce(var.kong_heartbeat_disabled_flag,var.disable_detectors)
            notifications = coalesce(split(";",var.kong_heartbeat_notifications),split(";",var.notifications))
	}
}

resource "signalfx_detector" "treatment_limit" {
	name = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] Kong exceeded its treatment limit"

	program_text = <<-EOF
		A = data('counter.kong.connections.handled', filter=${module.filter-tags.filter_custom})${var.treatment_limit_aggregation_function}
		B = data('counter.kong.connections.accepted', filter=${module.filter-tags.filter_custom})${var.treatment_limit_aggregation_function}
		signal = ((A-B)/A).scale(100).${var.treatment_limit_transformation_function}(over='${var.treatment_limit_transformation_window}')
		detect(when(signal > ${var.treatment_limit_threshold_critical})).publish('CRIT')
		detect(when(signal < ${var.treatment_limit_threshold_warning})).publish('WARN')
	EOF

	rule {
		description = "${var.treatment_limit_transformation_function} treatment limit over ${var.treatment_limit_transformation_window} > ${var.treatment_limit_threshold_critical}"
		severity = "Critical"
		detect_label = "CRIT"
		disabled = coalesce(var.treatment_limit_critical_disabled_flag,var.disable_kong_detector,var.disable_detectors)
		notifications = coalesce(split(";",var.treatment_limit_critical_notifications),split(";",var.treatment_limit_notifications),split(";",var.notifications))
	}

	rule {
		description = "${var.treatment_limit_transformation_function} treatment limit over ${var.treatment_limit_transformation_window} > ${var.treatment_limit_threshold_warning}"
		severity = "Warning"
		detect_label = "WARN"
		disabled = coalesce(var.treatment_limit_warning_disabled_flag,var.disable_kong_detector,var.disable_detectors)
		notifications = coalesce(split(";",var.treatment_limit_warning_notifications),split(";",var.treatment_limit_notifications),split(";",var.notifications))
	}
}
