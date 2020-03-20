resource "signalfx_detector" "heartbeat" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ElasticSearch heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('Nodes', filter=filter('namespace', 'AWS/ES') and filter('stat', 'mean') and ${module.filter-tags.filter_custom})
		not_reporting.detector(stream=signal, resource_identifier=['DomainName'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "cluster_status" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ElasticSearch cluster status"

	program_text = <<-EOF
		A = data('ClusterStatus.red', filter=filter('namespace', 'AWS/ES') and filter('stat', 'upper') and ${module.filter-tags.filter_custom})${var.cluster_status_aggregation_function}.${var.cluster_status_transformation_function}(over='${var.cluster_status_transformation_window}')
		B = data('ClusterStatus.yellow', filter=filter('namespace', 'AWS/ES') and filter('stat', 'upper') and ${module.filter-tags.filter_custom})${var.cluster_status_aggregation_function}.${var.cluster_status_transformation_function}(over='${var.cluster_status_transformation_window}')
		detect(when(A >= ${var.cluster_status_threshold_critical})).publish('CRIT')
		detect(when(B >= ${var.cluster_status_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is red > ${var.cluster_status_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.cluster_status_disabled_critical, var.cluster_status_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.cluster_status_notifications_critical, var.cluster_status_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is yellow > ${var.cluster_status_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.cluster_status_disabled_warning, var.cluster_status_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.cluster_status_notifications_warning, var.cluster_status_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "free_space" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ElasticSearch cluster free storage space"

	program_text = <<-EOF
		signal = data('FreeStorageSpace', filter=filter('namespace', 'AWS/ES') and filter('stat', 'lower') and (not filter('NodeId', '*')) and ${module.filter-tags.filter_custom}).sum(by=['Nodes'])${var.free_space_aggregation_function}.${var.free_space_transformation_function}(over='${var.free_space_transformation_window}')
		detect(when(signal < ${var.free_space_threshold_critical})).publish('CRIT')
		detect(when(signal < ${var.free_space_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too low < ${var.free_space_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.free_space_disabled_critical, var.free_space_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.free_space_notifications_critical, var.free_space_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too low < ${var.free_space_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.free_space_disabled_warning, var.free_space_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.free_space_notifications_warning, var.free_space_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "cpu_90_15min" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ElasticSearch cluster CPU"

	program_text = <<-EOF
		signal = data('CPUUtilization', filter=filter('namespace', 'AWS/ES') and filter('stat', 'upper') and filter('NodeId', '*') and ${module.filter-tags.filter_custom}).sum(by=['Nodes'])${var.cpu_90_15min_aggregation_function}.${var.cpu_90_15min_transformation_function}(over='${var.cpu_90_15min_transformation_window}')
		detect(when(signal > ${var.cpu_90_15min_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.cpu_90_15min_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.cpu_90_15min_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.cpu_90_15min_disabled_critical, var.cpu_90_15min_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.cpu_90_15min_notifications_critical, var.cpu_90_15min_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.cpu_90_15min_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.cpu_90_15min_disabled_warning, var.cpu_90_15min_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.cpu_90_15min_notifications_warning, var.cpu_90_15min_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}
