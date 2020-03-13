resource "signalfx_detector" "heartbeat" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ElasticSearch heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('gauge.cluster.active-shards', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom})
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

resource "signalfx_detector" "cluster_status" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ElasticSearch cluster status"

	program_text = <<-EOF
		signal = data('gauge.cluster.status', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom})${var.cluster_status_aggregation_function}.${var.cluster_status_transformation_function}(over='${var.cluster_status_transformation_window}')
		detect(when(signal >= ${var.cluster_status_threshold_critical})).publish('CRIT')
		detect(when(signal >= ${var.cluster_status_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.cluster_status_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.cluster_status_disabled_critical, var.cluster_status_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.cluster_status_notifications_critical, var.cluster_status_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.cluster_status_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.cluster_status_disabled_warning, var.cluster_status_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.cluster_status_notifications_warning, var.cluster_status_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "cpu_90_15min" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ElasticSearch cluster CPU"

	program_text = <<-EOF
		signal = data('gauge.process.cpu.percent', filter=filter('plugin', 'elasticsearch')and ${module.filter-tags.filter_custom})${var.cpu_90_15min_aggregation_function}.${var.cpu_90_15min_transformation_function}(over='${var.cpu_90_15min_transformation_window}')
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
