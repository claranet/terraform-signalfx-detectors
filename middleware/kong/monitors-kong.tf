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
