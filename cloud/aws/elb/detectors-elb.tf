resource "signalfx_detector" "heartbeat" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ELB heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('RequestCount', filter=filter('stat', 'sum') and filter('namespace', 'AWS/ELB')and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}).publish('signal')
		not_reporting.detector(stream=signal, resource_identifier=['LoadBalancerName'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ELB healthy instances percentage"

	program_text = <<-EOF
		A = data('HealthyHostCount', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'lower') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom})${var.no_healthy_instances_aggregation_function}
		B = data('UnHealthyHostCount', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'upper') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom})${var.no_healthy_instances_aggregation_function}
		signal = (A/ (A + B)).scale(100).${var.no_healthy_instances_transformation_function}(over='${var.no_healthy_instances_transformation_window}').publish('signal')
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

resource "signalfx_detector" "too_much_4xx" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ELB 4xx error rate"

	program_text = <<-EOF
		A = data('HTTPCode_ELB_4XX', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.too_much_4xx_aggregation_function}
		B = data('RequestCount', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.too_much_4xx_aggregation_function}
		signal = (A/B).scale(100).${var.too_much_4xx_transformation_function}(over='${var.too_much_4xx_transformation_window}').publish('signal')
		detect(when(signal > ${var.too_much_4xx_threshold_critical}) and when(B > ${var.too_much_4xx_threshold_number_requests})).publish('CRIT')
		detect(when(signal > ${var.too_much_4xx_threshold_warning}) and when(B > ${var.too_much_4xx_threshold_number_requests}) and when(signal < ${var.too_much_4xx_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.too_much_4xx_threshold_critical}%"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.too_much_4xx_disabled_critical, var.too_much_4xx_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.too_much_4xx_notifications_critical, var.too_much_4xx_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.too_much_4xx_threshold_warning}%"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.too_much_4xx_disabled_warning, var.too_much_4xx_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.too_much_4xx_notifications_warning, var.too_much_4xx_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "too_much_5xx" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ELB 5xx error rate"

	program_text = <<-EOF
		A = data('HTTPCode_ELB_5XX', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.too_much_5xx_aggregation_function}
		B = data('RequestCount', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.too_much_5xx_aggregation_function}
		signal = (A/B).scale(100).${var.too_much_5xx_transformation_function}(over='${var.too_much_5xx_transformation_window}').publish('signal')
		detect(when(signal > ${var.too_much_5xx_threshold_critical}) and when(B > ${var.too_much_5xx_threshold_number_requests})).publish('CRIT')
		detect(when(signal > ${var.too_much_5xx_threshold_warning}) and when(B > ${var.too_much_5xx_threshold_number_requests}) and when(signal < ${var.too_much_5xx_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.too_much_5xx_threshold_critical}%"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.too_much_5xx_disabled_critical, var.too_much_5xx_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.too_much_5xx_notifications_critical, var.too_much_5xx_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.too_much_5xx_threshold_warning}%"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.too_much_5xx_disabled_warning, var.too_much_5xx_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.too_much_5xx_notifications_warning, var.too_much_5xx_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "too_much_4xx_backend" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ELB backend 4xx error rate"

	program_text = <<-EOF
		A = data('HTTPCode_Backend_4XX', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.too_much_4xx_backend_aggregation_function}
		B = data('RequestCount', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.too_much_4xx_backend_aggregation_function}
		signal = (A/B).scale(100).${var.too_much_4xx_backend_transformation_function}(over='${var.too_much_4xx_backend_transformation_window}').publish('signal')
		detect(when(signal > ${var.too_much_4xx_backend_threshold_critical}) and when(B > ${var.too_much_4xx_backend_threshold_number_requests})).publish('CRIT')
		detect(when(signal > ${var.too_much_4xx_backend_threshold_warning}) and when(B > ${var.too_much_4xx_backend_threshold_number_requests}) and when(signal < ${var.too_much_4xx_backend_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.too_much_4xx_backend_threshold_critical}%"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.too_much_4xx_backend_disabled_critical, var.too_much_4xx_backend_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.too_much_4xx_backend_notifications_critical, var.too_much_4xx_backend_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.too_much_4xx_backend_threshold_warning}%"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.too_much_4xx_backend_disabled_warning, var.too_much_4xx_backend_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.too_much_4xx_backend_notifications_warning, var.too_much_4xx_backend_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "too_much_5xx_backend" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ELB backend 5xx error rate"

	program_text = <<-EOF
		A = data('HTTPCode_Backend_5XX', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.too_much_5xx_backend_aggregation_function}
		B = data('RequestCount', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.too_much_5xx_backend_aggregation_function}
		signal = (A/B).scale(100).${var.too_much_5xx_backend_transformation_function}(over='${var.too_much_5xx_backend_transformation_window}').publish('signal')
		detect(when(signal > ${var.too_much_5xx_backend_threshold_critical}) and when(B > ${var.too_much_5xx_backend_threshold_number_requests})).publish('CRIT')
		detect(when(signal > ${var.too_much_5xx_backend_threshold_warning}) and when(B > ${var.too_much_5xx_backend_threshold_number_requests}) and when(signal < ${var.too_much_5xx_backend_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.too_much_5xx_backend_threshold_critical}%"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.too_much_5xx_backend_disabled_critical, var.too_much_5xx_backend_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.too_much_5xx_backend_notifications_critical, var.too_much_5xx_backend_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.too_much_5xx_backend_threshold_warning}%"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.too_much_5xx_backend_disabled_warning, var.too_much_5xx_backend_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.too_much_5xx_backend_notifications_warning, var.too_much_5xx_backend_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "backend_latency" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ELB backend latency"

	program_text = <<-EOF
		from signalfx.detectors.aperiodic import aperiodic
		signal = data('Latency', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'mean') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom})${var.backend_latency_aggregation_function}.${var.backend_latency_transformation_function}(over='${var.backend_latency_transformation_window}').publish('signal')
		aperiodic.above_or_below_detector(signal, ${var.backend_latency_threshold_critical}, 'above', lasting('${var.backend_latency_aperiodic_duration}', ${var.backend_latency_aperiodic_percentage})).publish('CRIT')
		aperiodic.range_detector(signal, ${var.backend_latency_threshold_warning}, ${var.backend_latency_threshold_critical}, 'within_range', lasting('${var.backend_latency_aperiodic_duration}', ${var.backend_latency_aperiodic_percentage})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.backend_latency_threshold_critical}s"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.backend_latency_disabled_critical, var.backend_latency_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.backend_latency_notifications_critical, var.backend_latency_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.backend_latency_threshold_warning}s"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.backend_latency_disabled_warning, var.backend_latency_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.backend_latency_notifications_warning, var.backend_latency_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}
