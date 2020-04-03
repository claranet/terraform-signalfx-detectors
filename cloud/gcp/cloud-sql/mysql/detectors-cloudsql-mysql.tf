resource "signalfx_detector" "replication_lag" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Cloud SQL MySQL replication lag"

	program_text = <<-EOF
		signal = data('database/mysql/replication/seconds_behind_master' and ${module.filter-tags.filter_custom})${var.replication_lag_aggregation_function}.${var.replication_lag_transformation_function}(over='${var.replication_lag_transformation_window}').publish('signal')
		detect(when(signal > ${var.replication_lag_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.replication_lag_threshold_warning}) and when(signal < ${var.replication_lag_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.replication_lag_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.replication_lag_disabled_critical, var.replication_lag_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.replication_lag_notifications_critical, var.replication_lag_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.replication_lag_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.replication_lag_disabled_warning, var.replication_lag_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.replication_lag_notifications_warning, var.replication_lag_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}
