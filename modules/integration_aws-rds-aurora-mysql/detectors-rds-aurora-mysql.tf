resource "signalfx_detector" "aurora_mysql_replica_lag" {
  name = format("%s %s", local.detector_name_prefix, "AWS RDS Aurora Mysql replica lag")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('AuroraReplicaLag', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*') and ${module.filtering.signalflow})${var.aurora_mysql_replica_lag_aggregation_function}${var.aurora_mysql_replica_lag_transformation_function}.publish('signal')
    detect(when(signal > ${var.aurora_mysql_replica_lag_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.aurora_mysql_replica_lag_threshold_major}) and when(signal <= ${var.aurora_mysql_replica_lag_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.aurora_mysql_replica_lag_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.aurora_mysql_replica_lag_disabled_critical, var.aurora_mysql_replica_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.aurora_mysql_replica_lag_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.aurora_mysql_replica_lag_runbook_url, var.runbook_url), "")
    tip                   = var.aurora_mysql_replica_lag_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.aurora_mysql_replica_lag_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.aurora_mysql_replica_lag_disabled_major, var.aurora_mysql_replica_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.aurora_mysql_replica_lag_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.aurora_mysql_replica_lag_runbook_url, var.runbook_url), "")
    tip                   = var.aurora_mysql_replica_lag_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

