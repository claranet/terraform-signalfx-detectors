resource "signalfx_detector" "nginx_heartbeat" {
	name = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] System Heartbeat Check"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('nginx_requests', filter=(not filter('aws_state', '*terminated}', '*stopped}')) and (not filter('gcp_status', '*TERMINATED}', '*STOPPING}')) and (not filter('azure_power_state', 'stop*', 'deallocat*')))
		not_reporting.detector(stream=signal, resource_identifier=['host'], duration='${var.nginx_heartbeat_timeframe}').publish('CRIT')
	EOF

	rule {
		description = "System has not reported in ${var.nginx_heartbeat_timeframe}"
		severity = "Critical"
		detect_label = "CRIT"
		disabled = "${var.nginx_heartbeat_disabled_flag}"
	}
}

resource "signalfx_detector" "nginx_dropped_connections" {
	name = "Nginx dropped connections"

	program_text = <<-EOF
		signal = data('connections.failed', filter=filter('plugin', 'nginx')).mean(by=['host']).min(over='5m')
		detect(when(signal > ${var.nginx_dropped_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description = "Min > ${var.nginx_dropped_threshold_critical} for last 5m"
		severity = "Critical"
		detect_label = "CRIT"
	}
}

