resource "signalfx_detector" "aurora_mysql_replica_lag" {
  name = format("%s %s", local.detector_name_prefix, "AWS RDS Aurora Mysql replica lag")

  program_text = <<-EOF
    signal = data('AuroraReplicaLag', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*') and ${module.filter-tags.filter_custom})${var.aurora_mysql_replica_lag_aggregation_function}${var.aurora_mysql_replica_lag_transformation_function}.publish('signal')
    detect(when(signal > ${var.aurora_mysql_replica_lag_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.aurora_mysql_replica_lag_threshold_major}) and when(signal <= ${var.aurora_mysql_replica_lag_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.aurora_mysql_replica_lag_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.aurora_mysql_replica_lag_disabled_critical, var.aurora_mysql_replica_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.aurora_mysql_replica_lag_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.aurora_mysql_replica_lag_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.aurora_mysql_replica_lag_disabled_major, var.aurora_mysql_replica_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.aurora_mysql_replica_lag_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

