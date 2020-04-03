resource "signalfx_detector" "heartbeat" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS NLB heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('ConsumedLCUs', filter=filter('stat', 'mean') and filter('namespace', 'AWS/NetworkELB') and ${module.filter-tags.filter_custom}).publish('signal')
		not_reporting.detector(stream=signal, resource_identifier=['LoadBalancer'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "no_healthy_instances" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS NLB healthy instances percentage"

	program_text = <<-EOF
		A = data('HealthyHostCount', filter=filter('namespace', 'AWS/NetworkELB') and filter('stat', 'lower') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom})${var.no_healthy_instances_aggregation_function}
		B = data('UnHealthyHostCount', filter=filter('namespace', 'AWS/NetworkELB') and filter('stat', 'upper') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom})${var.no_healthy_instances_aggregation_function}
		signal = (A / (A+B)).scale(100).${var.no_healthy_instances_transformation_function}(over='${var.no_healthy_instances_transformation_window}').publish('signal')
		detect(when(signal < ${var.no_healthy_instances_threshold_critical})).publish('CRIT')
		detect(when(signal < ${var.no_healthy_instances_threshold_warning}) and when(signal > ${var.no_healthy_instances_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "has fallen below critical capacity < ${var.no_healthy_instances_threshold_critical}%"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.no_healthy_instances_disabled_critical, var.no_healthy_instances_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.no_healthy_instances_notifications_critical, var.no_healthy_instances_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is below nominal capacity < ${var.no_healthy_instances_threshold_warning}%"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.no_healthy_instances_disabled_warning, var.no_healthy_instances_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.no_healthy_instances_notifications_warning, var.no_healthy_instances_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}
