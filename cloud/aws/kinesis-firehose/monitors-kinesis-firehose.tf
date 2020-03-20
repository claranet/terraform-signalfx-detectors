resource "signalfx_detector" "heartbeat" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS Kinesis heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('IncomingBytes', filter=filter('stat', 'count') and filter('namespace', 'AWS/Kinesis') and ${module.filter-tags.filter_custom})
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

resource "signalfx_detector" "incoming_records" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kinesis incoming records"

	program_text = <<-EOF
		signal = data('IncomingRecords', filter=filter('namespace', 'AWS/Kinesis') and filter('stat', 'count') and ${module.filter-tags.filter_custom})${var.incoming_records_aggregation_function}.${var.incoming_records_transformation_function}(over='${var.incoming_records_transformation_window}')
		detect(when(signal <= ${var.incoming_records_threshold_critical})).publish('CRIT')
		detect(when(signal <= ${var.incoming_records_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too low <= ${var.incoming_records_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.incoming_records_disabled_critical, var.incoming_records_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.incoming_records_notifications_critical, var.incoming_records_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too low <= ${var.incoming_records_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.incoming_records_disabled_warning, var.incoming_records_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.incoming_records_notifications_warning, var.incoming_records_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}
