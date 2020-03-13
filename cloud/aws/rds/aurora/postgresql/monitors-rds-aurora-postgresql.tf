resource "signalfx_detector" "aurora_postgresql_replica_lag" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] RDS Aurora PostgreSQL replica lag"

	program_text = <<-EOF
		signal = data('RDSToAuroraPostgreSQLReplicaLag', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and ${module.filter-tags.filter_custom})${var.aurora_postgresql_replica_lag_aggregation_function}.${var.aurora_postgresql_replica_lag_transformation_function}(over='${var.aurora_postgresql_replica_lag_transformation_window}')
		detect(when(signal > ${var.aurora_postgresql_replica_lag_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.aurora_postgresql_replica_lag_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.aurora_postgresql_replica_lag_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.aurora_postgresql_replica_lag_disabled_critical, var.aurora_postgresql_replica_lag_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.aurora_postgresql_replica_lag_notifications_critical, var.aurora_postgresql_replica_lag_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.aurora_postgresql_replica_lag_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.aurora_postgresql_replica_lag_disabled_warning, var.aurora_postgresql_replica_lag_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.aurora_postgresql_replica_lag_notifications_warning, var.aurora_postgresql_replica_lag_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}
