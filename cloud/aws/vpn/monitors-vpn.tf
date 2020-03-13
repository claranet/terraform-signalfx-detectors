resource "signalfx_detector" "heartbeat" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS VPN heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('TunnelDataIn', filter=filter('stat', 'count') and filter('namespace', 'AWS/VPN') and ${module.filter-tags.filter_custom})
		not_reporting.detector(stream=signal, resource_identifier=['host'], duration='${var.heartbeat_timeframe}').publish('CRIT')
	EOF

	rule {
		description           = "has not reported in ${var.heartbeat_timeframe}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.heartbeat_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "VPN_status" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] VPN tunnel state"

	program_text = <<-EOF
		signal = data('TunnelState', filter=filter('namespace', 'AWS/VPN') and filter('stat', 'count') and ${module.filter-tags.filter_custom})${var.vpn_status_aggregation_function}.${var.vpn_status_transformation_function}(over='${var.vpn_status_transformation_window}')
		detect(when(signal < ${var.vpn_status_threshold_critical})).publish('CRIT')
		detect(when(signal < ${var.vpn_status_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too low < ${var.vpn_status_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.vpn_status_disabled_critical, var.vpn_status_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.vpn_status_notifications_critical, var.vpn_status_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too low < ${var.vpn_status_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.vpn_status_disabled_warning, var.vpn_status_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.vpn_status_notifications_warning, var.vpn_status_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}
