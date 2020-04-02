resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ALB heartbeat"

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('RequestCount', filter=filter('stat', 'sum') and filter('namespace', 'AWS/ApplicationELB') and ${module.filter-tags.filter_custom}).publish('signal')
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
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ALB healthy instances percentage"

  program_text = <<-EOF
		A = data('HealthyHostCount', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'lower') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom})${var.no_healthy_instances_aggregation_function}
		B = data('UnHealthyHostCount', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'upper') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom})${var.no_healthy_instances_aggregation_function}
		signal = (A/(A+B)).scale(100).${var.no_healthy_instances_transformation_function}(over='${var.no_healthy_instances_transformation_window}').publish('signal')
		detect(when(signal < ${var.no_healthy_instances_threshold_critical})).publish('CRIT')
		detect(when(signal < ${var.no_healthy_instances_threshold_warning})).publish('WARN')
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

resource "signalfx_detector" "latency" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ALB latency"

  program_text = <<-EOF
		from signalfx.detectors.aperiodic import aperiodic
		signal = data('TargetResponseTime', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'mean') and filter('TargetGroup', '*') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom})${var.latency_aggregation_function}.${var.latency_transformation_function}(over='${var.latency_transformation_window}').publish('signal')
		aperiodic.above_or_below_detector(signal, ${var.latency_threshold_critical}, 'above', lasting('${var.latency_aperiodic_duration}', ${var.latency_aperiodic_percentage})).publish('CRIT')
		aperiodic.above_or_below_detector(signal, ${var.latency_threshold_warning}, 'above', lasting('${var.latency_aperiodic_duration}', ${var.latency_aperiodic_percentage})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.latency_threshold_critical}s"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.latency_disabled_critical, var.latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.latency_notifications_critical, var.latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.latency_threshold_warning}s"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.latency_disabled_warning, var.latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.latency_notifications_warning, var.latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "httpcode_5xx" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ALB 5xx error rate"

  program_text = <<-EOF
		A = data('HTTPCode_ELB_5XX_Count', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.httpcode_5xx_aggregation_function}
		B = data('RequestCount', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.httpcode_5xx_aggregation_function}
		signal = (A/B).scale(100).${var.httpcode_5xx_transformation_function}(over='${var.httpcode_5xx_transformation_window}').publish('signal')
		detect(when(signal > ${var.httpcode_5xx_threshold_critical}) and when(B > ${var.httpcode_5xx_threshold_number_requests})).publish('CRIT')
		detect(when(signal > ${var.httpcode_5xx_threshold_warning}) and when(B > ${var.httpcode_5xx_threshold_number_requests})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.httpcode_5xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.httpcode_5xx_disabled_critical, var.httpcode_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.httpcode_5xx_notifications_critical, var.httpcode_5xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.httpcode_5xx_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.httpcode_5xx_disabled_warning, var.httpcode_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.httpcode_5xx_notifications_warning, var.httpcode_5xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "httpcode_4xx" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ALB 4xx error rate"

  program_text = <<-EOF
		A = data('HTTPCode_ELB_4XX_Count', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.httpcode_4xx_aggregation_function}
		B = data('RequestCount', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.httpcode_4xx_aggregation_function}
		signal = (A/B).scale(100).${var.httpcode_4xx_transformation_function}(over='${var.httpcode_4xx_transformation_window}').publish('signal')
		detect(when(signal > ${var.httpcode_4xx_threshold_critical}) and when(B > ${var.httpcode_4xx_threshold_number_requests})).publish('CRIT')
		detect(when(signal > ${var.httpcode_4xx_threshold_warning}) and when(B > ${var.httpcode_4xx_threshold_number_requests})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.httpcode_4xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.httpcode_4xx_disabled_critical, var.httpcode_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.httpcode_4xx_notifications_critical, var.httpcode_4xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.httpcode_4xx_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.httpcode_4xx_disabled_warning, var.httpcode_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.httpcode_4xx_notifications_warning, var.httpcode_4xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "httpcode_target_5xx" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ALB target 5xx error rate"

  program_text = <<-EOF
		A = data('HTTPCode_Target_5XX_Count', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.httpcode_target_5xx_aggregation_function}
		B = data('RequestCount', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and filter('TargetGroup', '*') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.httpcode_target_5xx_aggregation_function}
		signal = (A/B).scale(100).${var.httpcode_target_5xx_transformation_function}(over='${var.httpcode_target_5xx_transformation_window}').publish('signal')
		detect(when(signal > ${var.httpcode_target_5xx_threshold_critical}) and when(B > ${var.httpcode_target_5xx_threshold_number_requests})).publish('CRIT')
		detect(when(signal > ${var.httpcode_target_5xx_threshold_warning}) and when(B > ${var.httpcode_target_5xx_threshold_number_requests})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.httpcode_target_5xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.httpcode_target_5xx_disabled_critical, var.httpcode_target_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.httpcode_target_5xx_notifications_critical, var.httpcode_target_5xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.httpcode_target_5xx_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.httpcode_target_5xx_disabled_warning, var.httpcode_target_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.httpcode_target_5xx_notifications_warning, var.httpcode_target_5xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "httpcode_target_4xx" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ALB target 4xx error rate"

  program_text = <<-EOF
		A = data('HTTPCode_Target_4XX_Count', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and filter('TargetGroup', '*') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.httpcode_target_4xx_aggregation_function}
		B = data('RequestCount', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.httpcode_target_4xx_aggregation_function}
		signal = (A/B).scale(100).${var.httpcode_target_4xx_transformation_function}(over='${var.httpcode_target_4xx_transformation_window}').publish('signal')
		detect(when(signal > ${var.httpcode_target_4xx_threshold_critical}) and when(B > ${var.httpcode_target_4xx_threshold_number_requests})).publish('CRIT')
		detect(when(signal > ${var.httpcode_target_4xx_threshold_warning}) and when(B > ${var.httpcode_target_4xx_threshold_number_requests})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.httpcode_target_4xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.httpcode_target_4xx_disabled_critical, var.httpcode_target_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.httpcode_target_4xx_notifications_critical, var.httpcode_target_4xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.httpcode_target_4xx_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.httpcode_target_4xx_disabled_warning, var.httpcode_target_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.httpcode_target_4xx_notifications_warning, var.httpcode_target_4xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}
