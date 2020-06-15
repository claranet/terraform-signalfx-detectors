resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes pod heartbeat"

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('kubernetes.container_ready', ${module.filter-tags.filter_custom}).publish('signal')
		not_reporting.detector(stream=signal, resource_identifier=['container_name'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "pod_phase_status" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes pod status phase: failed"

  program_text = <<-EOF
		from signalfx.detectors.aperiodic import aperiodic
		# Current phase of the pod (1 - Pending, 2 - Running, 3 - Succeeded, 4 - Failed, 5 - Unknown)
		signal = data('kubernetes.pod_phase', filter=${module.filter-tags.filter_custom})${var.pod_phase_status_aggregation_function}.${var.pod_phase_status_transformation_function}(over='${var.pod_phase_status_transformation_window}').publish('signal')
		aperiodic.range_detector(signal, 4, 5, 'within_range', lasting('${var.pod_phase_status_aperiodic_duration}', ${var.pod_phase_status_aperiodic_percentage}), upper_strict=False).publish('CRIT')
	EOF

  rule {
    description           = "is too high > ${var.pod_phase_status_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.pod_phase_status_disabled_critical, var.pod_phase_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.pod_phase_status_notifications_critical, var.pod_phase_status_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "error" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes pod waiting errors"

  program_text = <<-EOF
		signal = data('kubernetes.container_ready', filter=filter('container_status', 'waiting') and ${module.filter-tags.filter_custom})${var.error_aggregation_function}.${var.error_transformation_function}(over='${var.error_transformation_window}').publish('signal')
		detect(when(signal > ${var.error_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.error_threshold_warning}) and when(signal <= ${var.error_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.error_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.error_disabled_critical, var.error_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.error_notifications_critical, var.error_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.error_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.error_disabled_warning, var.error_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.error_notifications_warning, var.error_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "terminated" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes pod terminated abnormally"

  program_text = <<-EOF
		signal = data('kubernetes.container_ready', filter=filter('container_status', 'terminated') and not filter('container_status_reason', 'Completed') and ${module.filter-tags.filter_custom})${var.terminated_aggregation_function}.${var.terminated_transformation_function}(over='${var.terminated_transformation_window}').publish('signal')
		detect(when(signal > ${var.terminated_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.terminated_threshold_warning}) and when(signal <= ${var.terminated_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.terminated_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.terminated_disabled_critical, var.terminated_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.terminated_notifications_critical, var.terminated_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.terminated_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.terminated_disabled_warning, var.terminated_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.terminated_notifications_warning, var.terminated_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
