resource "signalfx_detector" "heartbeat" {
  name      = format("%s %s", local.detector_name_prefix, "MySQL heartbeat")
  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('mysql_octets.rx', filter=filter('plugin', 'mysql') and ${local.not_running_vm_filters} and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "mysql_connections" {
  name = format("%s %s", local.detector_name_prefix, "MySQL number of connections over max capacity")

  program_text = <<-EOF
    A = data('mysql_threads_connected', filter=${module.filter-tags.filter_custom}, rollup='average')${var.connections_aggregation_function}${var.connections_transformation_function}
    B = data('mysql_max_connections', filter=${module.filter-tags.filter_custom}, rollup='average')${var.connections_aggregation_function}${var.connections_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.connections_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.connections_threshold_major}) and when(signal <= ${var.connections_threshold_critical})).publish('MAJOR')
  EOF

  rule {
    description           = "is too high > ${var.connections_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.connections_disabled_critical, var.connections_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.connections_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.connections_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.connections_disabled_major, var.connections_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.connections_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "mysql_slow" {
  name = format("%s %s", local.detector_name_prefix, "MySQL slow queries percentage")

  program_text = <<-EOF
    A = data('mysql_slow_queries', filter=(not filter('plugin', 'mysql')) and ${module.filter-tags.filter_custom}, rollup='delta')${var.slow_aggregation_function}${var.slow_transformation_function}
    B = data('mysql_queries', filter=(not filter('plugin', 'mysql')) and ${module.filter-tags.filter_custom}, rollup='delta')${var.slow_aggregation_function}${var.slow_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.slow_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.slow_threshold_major}) and when(signal <= ${var.slow_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.slow_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.slow_disabled_critical, var.slow_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.slow_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.slow_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.slow_disabled_major, var.slow_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.slow_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "mysql_pool_efficiency" {
  name = format("%s %s", local.detector_name_prefix, "MySQL Innodb buffer pool efficiency")

  program_text = <<-EOF
    A = data('mysql_bpool_counters.reads', filter=filter('plugin', 'mysql') and ${module.filter-tags.filter_custom}, rollup='delta')${var.pool_efficiency_aggregation_function}${var.pool_efficiency_transformation_function}
    B = data('mysql_bpool_counters.read_requests', filter=filter('plugin', 'mysql') and ${module.filter-tags.filter_custom}, rollup='delta')${var.pool_efficiency_aggregation_function}${var.pool_efficiency_transformation_function}
    signal = (A/B).fill(0).scale(100).publish('signal')
    detect(when(signal > ${var.pool_efficiency_threshold_minor})).publish('MINOR')
    detect(when(signal > ${var.pool_efficiency_threshold_warning}) and when(signal <= ${var.pool_efficiency_threshold_minor})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.pool_efficiency_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.pool_efficiency_disabled_minor, var.pool_efficiency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.pool_efficiency_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.pool_efficiency_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.pool_efficiency_disabled_warning, var.pool_efficiency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.pool_efficiency_notifications, "warning", []), var.notifications.warning)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "mysql_pool_utilization" {
  name = format("%s %s", local.detector_name_prefix, "MySQL Innodb buffer pool utilization")

  program_text = <<-EOF
    A = data('mysql_bpool_pages.free', filter=filter('plugin', 'mysql') and ${module.filter-tags.filter_custom}, rollup='average')${var.pool_utilization_aggregation_function}${var.pool_utilization_transformation_function}
    B = data('mysql_bpool_pages.total', filter=filter('plugin', 'mysql') and ${module.filter-tags.filter_custom}, rollup='average')${var.pool_utilization_aggregation_function}${var.pool_utilization_transformation_function}
    signal = ((B-A)/B).scale(100).publish('signal')
    detect(when(signal > ${var.pool_utilization_threshold_minor})).publish('MINOR')
    detect(when(signal > ${var.pool_utilization_threshold_warning}) and when(signal <= ${var.pool_utilization_threshold_minor})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.pool_utilization_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.pool_utilization_disabled_minor, var.pool_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.pool_utilization_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.pool_utilization_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.pool_utilization_disabled_warning, var.pool_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.pool_utilization_notifications, "warning", []), var.notifications.warning)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "mysql_threads_anomaly" {
  name = format("%s %s", local.detector_name_prefix, "MySQL running threads changed abruptly")

  program_text = <<-EOF
    from signalfx.detectors.against_periods import against_periods
    signal = data('threads.running', filter=filter('plugin', 'mysql') and ${module.filter-tags.filter_custom}, rollup='average')${var.threads_anomaly_aggregation_function}${var.threads_anomaly_transformation_function}.publish('signal')
    against_periods.detector_growth_rate(signal, window_to_compare=duration('${var.threads_anomaly_window_to_compare}'), space_between_windows=duration('${var.threads_anomaly_space_between_windows}'), num_windows=${var.threads_anomaly_num_windows}, fire_growth_rate_threshold=${var.threads_anomaly_fire_growth_rate_threshold}, clear_growth_rate_threshold=${var.threads_anomaly_clear_growth_rate_threshold}, discard_historical_outliers=True, orientation='${var.threads_anomaly_orientation}').publish('CRIT')
EOF

  rule {
    description           = "with rate > ${var.threads_anomaly_fire_growth_rate_threshold}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.threads_anomaly_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.threads_anomaly_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "mysql_questions_anomaly" {
  name = format("%s %s", local.detector_name_prefix, "MySQL running queries changed abruptly")

  program_text = <<-EOF
    from signalfx.detectors.against_periods import against_periods
    signal = data('mysql_commands.*', filter=filter('plugin', 'mysql') and ${module.filter-tags.filter_custom}, rollup='delta')${var.questions_anomaly_aggregation_function}${var.questions_anomaly_transformation_function}.publish('signal')
    against_periods.detector_growth_rate(signal, window_to_compare=duration('${var.questions_anomaly_window_to_compare}'), space_between_windows=duration('${var.questions_anomaly_space_between_windows}'), num_windows=${var.questions_anomaly_num_windows}, fire_growth_rate_threshold=${var.questions_anomaly_fire_growth_rate_threshold}, clear_growth_rate_threshold=${var.questions_anomaly_clear_growth_rate_threshold}, discard_historical_outliers=True, orientation='${var.questions_anomaly_orientation}').publish('CRIT')
EOF

  rule {
    description           = "with rate > ${var.questions_anomaly_fire_growth_rate_threshold}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.questions_anomaly_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.questions_anomaly_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "mysql_replication_lag" {
  name = format("%s %s", local.detector_name_prefix, "MySQL replication lag")

  program_text = <<-EOF
    signal = data('mysql_seconds_behind_master', filter=${module.filter-tags.filter_custom}, rollup='average')${var.replication_lag_aggregation_function}${var.replication_lag_transformation_function}.publish('signal')
    detect(when(signal > ${var.replication_lag_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.replication_lag_threshold_major}) and when(signal <= ${var.replication_lag_threshold_critical})).publish('MAJOR')
  EOF

  rule {
    description           = "is too high > ${var.replication_lag_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.replication_lag_disabled_critical, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.replication_lag_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.replication_lag_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.replication_lag_disabled_major, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.replication_lag_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "mysql_slave_sql_status" {
  name = format("%s %s", local.detector_name_prefix, "MySQL slave sql status")

  program_text = <<-EOF
    signal = data('mysql_slave_sql_running', filter=${module.filter-tags.filter_custom}, rollup='average')${var.slave_sql_status_aggregation_function}${var.slave_sql_status_transformation_function}.publish('signal')
    detect(when(signal < 1)).publish('CRIT')
EOF

  rule {
    description           = "is not running"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.slave_sql_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.slave_sql_status_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "mysql_slave_io_status" {
  name = format("%s %s", local.detector_name_prefix, "MySQL slave sql status")

  program_text = <<-EOF
    signal = data('mysql_slave_io_running', filter=${module.filter-tags.filter_custom}, rollup='average')${var.slave_io_status_aggregation_function}${var.slave_io_status_transformation_function}.publish('signal')
    detect(when(signal < 1)).publish('CRIT')
EOF

  rule {
    description           = "is not running"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.slave_io_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.slave_io_status_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

