resource "signalfx_detector" "aurora_mysql_replica_lag" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS RDS Aurora Mysql replica lag"

  program_text = <<-EOF
    signal = data('AuroraReplicaLag', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*') and ${module.filter-tags.filter_custom})${var.aurora_mysql_replica_lag_aggregation_function}${var.aurora_mysql_replica_lag_transformation_function}.publish('signal')
    detect(when(signal > ${var.aurora_mysql_replica_lag_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.aurora_mysql_replica_lag_threshold_warning}) and when(signal <= ${var.aurora_mysql_replica_lag_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.aurora_mysql_replica_lag_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.aurora_mysql_replica_lag_disabled_critical, var.aurora_mysql_replica_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.aurora_mysql_replica_lag_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.aurora_mysql_replica_lag_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.aurora_mysql_replica_lag_disabled_warning, var.aurora_mysql_replica_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.aurora_mysql_replica_lag_notifications, "warning", []), var.notifications.warning)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

