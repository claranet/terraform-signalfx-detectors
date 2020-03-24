resource "signalfx_detector" "heartbeat" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes POD heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('nginx_requests', filter=(not filter('aws_state', '*terminated}', '*stopped}')) and (not filter('gcp_status', '*TERMINATED}', '*STOPPING}')) and (not filter('azure_power_state', 'stop*', 'deallocat*')) and ${module.filter-tags.filter_custom})
		not_reporting.detector(stream=signal, resource_identifier=['host'], duration='${var.nginx_heartbeat_timeframe}').publish('CRIT')
	EOF

	rule {
		description = "System has not reported in ${var.k8_pod_heartbeat_timeframe}"
		severity = "Critical"
		detect_label = "CRIT"
		disabled = coalesce(var.k8_pod_heartbeat_disabled_flag,var.disable_detectors)
			notifications = coalesce(split(";",var.k8_pod_heartbeat_notifications),split(";",var.notifications))
	}
}

resource "signalfx_detector" "pod_phase_status" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes POD phase failed status"

	program_text = <<-EOF
		signal = data('kube_pod_status_phase', filter=('phase', 'Failed') and ${module.filter-tags.filter_custom})${var.pod_phase_status_aggregation_function}.${var.pod_phase_status_transformation_function}(over='${var.pod_phase_status_transformation_window}')
		detect(when(signal > ${var.pod_phase_status_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.pod_phase_status_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.pod_phase_status_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.pod_phase_status_disabled_critical, var.pod_phase_status_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.pod_phase_status_notifications_critical, var.pod_phase_status_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.pod_phase_status_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.pod_phase_status_disabled_warning, var.pod_phase_status_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.pod_phase_status_notifications_warning, var.pod_phase_status_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "error" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes POD waiting errors"

	program_text = <<-EOF
		signal = data('kube_pod_container_status_waiting', filter=(not filter('reason', 'ContainerCreating')) and ${module.filter-tags.filter_custom})${var.error_aggregation_function}.${var.error_transformation_function}(over='${var.error_transformation_window}')
		detect(when(signal > ${var.error_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.error_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.error_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.error_disabled_critical, var.error_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.error_notifications_critical, var.error_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.error_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.error_disabled_warning, var.error_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.error_notifications_warning, var.error_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "terminated" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes POD terminated abnormally"

	program_text = <<-EOF
		signal = data('kube_pod_container_status_terminated', filter=(not filter('reason', 'ContainerCreating')) and ${module.filter-tags.filter_custom})${var.terminated_aggregation_function}.${var.terminated_transformation_function}(over='${var.terminated_transformation_window}')
		detect(when(signal > ${var.terminated_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.terminated_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.terminated_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.terminated_disabled_critical, var.terminated_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.terminated_notifications_critical, var.terminated_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.terminated_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.terminated_disabled_warning, var.terminated_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.terminated_notifications_warning, var.terminated_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}
