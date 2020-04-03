resource "signalfx_detector" "heartbeat" {
 	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] MongoDB heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('gauge.connections.current', filter=filter('plugin', 'mongo') and ${module.filter-tags.filter_custom})
		not_reporting.detector(stream=signal, resource_identifier=['cluster'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "mongodb_replication" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] MongoDB replication lag"

	program_text = <<-EOF
		signal = data('gauge.repl.max_lag', filter=filter('plugin', 'mongo') and ${module.filter-tags.filter_custom})${var.mongodb_replication_aggregation_function}.${var.mongodb_replication_transformation_function}(over='${var.mongodb_replication_transformation_window}').publish('signal')
		detect(when(signal > ${var.mongodb_replication_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.mongodb_replication_threshold_warning}) and when(signal < ${var.mongodb_replication_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.mongodb_replication_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.mongodb_replication_disabled_critical, var.mongodb_replication_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.mongodb_replication_notifications_critical, var.mongodb_replication_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.mongodb_replication_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.mongodb_replication_disabled_warning, var.mongodb_replication_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.mongodb_replication_notifications_warning, var.mongodb_replication_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}
