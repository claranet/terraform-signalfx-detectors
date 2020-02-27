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
	name = "Kong exceeded its treatment limit"

	program_text = <<-EOF
		A = data('counter.kong.connections.handled', filter=filter('plugin', 'kong')).min(by=['host'])
		B = data('counter.kong.connections.accepted', filter=filter('plugin', 'kong')).min(by=['host'])
		signal = ((A-B)/A).scale(100).min(over='15m')
		detect(when(signal > ${var.treatment_limit_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description = "Min > ${var.treatment_limit_threshold_critical} for last 15m"
		severity = "Critical"
		detect_label = "CRIT"
	}
}
