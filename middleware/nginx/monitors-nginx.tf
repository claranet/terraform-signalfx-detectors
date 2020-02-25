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

