resource "signalfx_detector" "heartbeat" {
	name = "${upper(join("", formatlist("[%s]", var.prefixes_slug)))}[${upper(var.environment)}] System Heartbeat Check"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('dropped_connections_requests', filter=(not filter('aws_state', '*terminated}', '*stopped}')) and (not filter('gcp_status', '*TERMINATED}', '*STOPPING}')) and (not filter('azure_power_state', 'stop*', 'deallocat*')) and ${module.filter-tags.filter_custom})
		not_reporting.detector(stream=signal, resource_identifier=['host'], duration='${var.heartbeat_timeframe}').publish('CRIT')
	EOF

	rule {
		description = "System has not reported in ${var.heartbeat_timeframe}"
		severity = "Critical"
		detect_label = "CRIT"
		disabled = coalesce(var.heartbeat_disabled,var.disable_detectors)
        notifications = coalesce(split(";",var.heartbeat_notifications),split(";",var.notifications))
	}
}

resource "signalfx_detector" "dropped_connections_dropped_connections" {
	name = "${upper(join("", formatlist("[%s]", var.prefixes_slug)))}[${upper(var.environment)}] Nginx dropped connections"

	program_text = <<-EOF
		signal = data('connections.failed', filter=${module.filter-tags.filter_custom})${var.dropped_connections_aggregation_function}.${var.dropped_connections_transformation_function}(over='${var.dropped_connections_transformation_window}')
		detect(when(signal > ${var.dropped_connections_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.dropped_connections_threshold_warning})).publish('WARN')
	EOF

	rule {
		description = "${var.dropped_connections_transformation_function} nginx dropped connections over ${var.dropped_connections_transformation_window} > ${var.dropped_connections_threshold_critical}"
		severity = "Critical"
		detect_label = "CRIT"
		disabled = coalesce(var.dropped_connections_critical_disabled,var.dropped_connections_disabled,var.disable_detectors)
		notifications = coalesce(split(";",var.dropped_connections_critical_notifications),split(";",var.dropped_connections_notifications),split(";",var.notifications))
	}
        
		rule {
		description = "${var.dropped_connections_transformation_function} nginx dropped connections over ${var.dropped_connections_transformation_window} > ${var.dropped_connections_threshold_warning}"
		severity = "Warning"
		detect_label = "WARN"
		disabled = coalesce(var.dropped_connections_warning_disabled,var.dropped_connections_disabled,var.disable_detectors)
		notifications = coalesce(split(";",var.dropped_connections_warning_notifications),split(";",var.dropped_connections_notifications),split(";",var.notifications))
	}
}
