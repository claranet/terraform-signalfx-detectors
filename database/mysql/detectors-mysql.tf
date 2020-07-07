resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] MySQL heartbeat"

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('mysql_octets.rx', filter=filter('plugin', 'mysql') and (not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}')) and (not filter('gcp_status', '{Code=3, Name=STOPPING}', '{Code=4, Name=TERMINATED}')) and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stoppped', 'PowerState/deallocating', 'PowerState/deallocated')) and ${module.filter-tags.filter_custom})
		not_reporting.detector(stream=signal, resource_identifier=['host'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

#resource "signalfx_detector" "mysql_connections" {
#  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] MySQL connections used to max ratio "
#
#  program_text = <<-EOF
#		A = data('threads.connected', filter=filter('plugin', 'mysql') and ${module.filter-tags.filter_custom})${var.mysql_connections_aggregation_function}
#		B = data('total_threads.created', filter=filter('plugin', 'mysql') and ${module.filter-tags.filter_custom})${var.mysql_connections_aggregation_function}
#		signal = (A/B).scale(100).${var.mysql_connections_transformation_function}(over='${var.mysql_connections_transformation_window}')
#		detect(when(signal > ${var.mysql_connections_threshold_critical})).publish('CRIT')
#		detect(when(signal > ${var.mysql_connections_threshold_warning}) and when(signal <= ${var.mysql_connections_threshold_critical})).publish('WARN')
#	EOF
#
#  rule {
#    description           = "is too high > ${var.mysql_connections_threshold_critical}"
#    severity              = "Critical"
#    detect_label          = "CRIT"
#    disabled              = coalesce(var.mysql_connections_disabled_critical, var.mysql_connections_disabled, var.detectors_disabled)
#    notifications         = coalescelist(var.mysql_connections_notifications_critical, var.mysql_connections_notifications, var.notifications)
#    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
#  }
#
#  rule {
#    description           = "is too high > ${var.mysql_connections_threshold_warning}"
#    severity              = "Warning"
#    detect_label          = "WARN"
#    disabled              = coalesce(var.mysql_connections_disabled_warning, var.mysql_connections_disabled, var.detectors_disabled)
#    notifications         = coalescelist(var.mysql_connections_notifications_warning, var.mysql_connections_notifications, var.notifications)
#    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
#  }
#}

resource "signalfx_detector" "mysql_slow" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] MySQL slow queries rate"

  program_text = <<-EOF
		A = data('mysql_slow_queries', filter=filter('plugin', 'mysql') and ${module.filter-tags.filter_custom})${var.mysql_slow_aggregation_function}
		B = data('threads.running', filter=filter('plugin', 'mysql') and ${module.filter-tags.filter_custom})${var.mysql_slow_aggregation_function}
		signal = (A/B).scale(100).${var.mysql_slow_transformation_function}(over='${var.mysql_slow_transformation_window}')
		detect(when(signal > ${var.mysql_slow_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.mysql_slow_threshold_warning}) and when(signal <= ${var.mysql_slow_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.mysql_slow_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.mysql_slow_disabled_critical, var.mysql_slow_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.mysql_slow_notifications_critical, var.mysql_slow_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.mysql_slow_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.mysql_slow_disabled_warning, var.mysql_slow_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.mysql_slow_notifications_warning, var.mysql_slow_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "mysql_pool_efficiency" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] MySQL Innodb buffer pool efficiency"

  program_text = <<-EOF
		A = data('mysql_bpool_counters.reads', filter=filter('plugin', 'mysql') and ${module.filter-tags.filter_custom})${var.mysql_pool_efficiency_aggregation_function}
		B = data('mysql_bpool_counters.read_requests', filter=filter('plugin', 'mysql') and ${module.filter-tags.filter_custom})${var.mysql_pool_efficiency_aggregation_function}
		signal = (A/B).scale(100).${var.mysql_pool_efficiency_transformation_function}(over='${var.mysql_pool_efficiency_transformation_window}')
		detect(when(signal > ${var.mysql_pool_efficiency_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.mysql_pool_efficiency_threshold_warning}) and when(signal <= ${var.mysql_pool_efficiency_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.mysql_pool_efficiency_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.mysql_pool_efficiency_disabled_critical, var.mysql_pool_efficiency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.mysql_pool_efficiency_notifications_critical, var.mysql_pool_efficiency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.mysql_pool_efficiency_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.mysql_pool_efficiency_disabled_warning, var.mysql_pool_efficiency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.mysql_pool_efficiency_notifications_warning, var.mysql_pool_efficiency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "mysql_pool_utilization" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] MySQL Innodb buffer pool utilization"

  program_text = <<-EOF
		A = data('mysql_bpool_pages.free', filter=filter('plugin', 'mysql') and ${module.filter-tags.filter_custom})${var.mysql_pool_utilization_aggregation_function}
		B = data('mysql_bpool_pages.total', filter=filter('plugin', 'mysql') and ${module.filter-tags.filter_custom})${var.mysql_pool_utilization_aggregation_function}
		signal = ((B-A)/B*100).${var.mysql_pool_utilization_transformation_function}(over='${var.mysql_pool_utilization_transformation_window}')
		detect(when(signal > ${var.mysql_pool_utilization_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.mysql_pool_utilization_threshold_warning}) and when(signal <= ${var.mysql_pool_utilization_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.mysql_pool_utilization_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.mysql_pool_utilization_disabled_critical, var.mysql_pool_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.mysql_pool_utilization_notifications_critical, var.mysql_pool_utilization_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.mysql_pool_utilization_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.mysql_pool_utilization_disabled_warning, var.mysql_pool_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.mysql_pool_utilization_notifications_warning, var.mysql_pool_utilization_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "mysql_threads_anomaly" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] MySQL threads changed abnormally"

  program_text = <<-EOF
		from signalfx.detectors.against_periods import against_periods
		signal = data('threads.running', filter=filter('plugin', 'mysql') and ${module.filter-tags.filter_custom})${var.mysql_threads_anomaly_aggregation_function}.${var.mysql_threads_anomaly_transformation_function}(over='${var.mysql_threads_anomaly_transformation_window}').publish('signal')
		against_periods.detector_growth_rate(signal, window_to_compare=duration('${var.mysql_threads_anomaly_window_to_compare}'), space_between_windows=duration('${var.mysql_threads_anomaly_space_between_windows}'), num_windows=${var.mysql_threads_anomaly_num_windows}, fire_growth_rate_threshold=${var.mysql_threads_anomaly_fire_growth_rate_threshold}, clear_growth_rate_threshold=${var.mysql_threads_anomaly_clear_growth_rate_threshold}, discard_historical_outliers=True, orientation='${var.mysql_threads_anomaly_orientation}').publish('CRIT')
	EOF

  rule {
    description           = " rate > ${var.mysql_threads_anomaly_fire_growth_rate_threshold}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.mysql_threads_anomaly_disabled_critical, var.mysql_threads_anomaly_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.mysql_threads_anomaly_notifications_critical, var.mysql_threads_anomaly_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "mysql_questions_anomaly" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] MySQL queries changed abnomally"

  program_text = <<-EOF
		from signalfx.detectors.against_periods import against_periods
		signal = data('mysql_commands.*', filter=filter('plugin', 'mysql') and ${module.filter-tags.filter_custom}).sum(by=['host'])${var.mysql_questions_anomaly_aggregation_function}.${var.mysql_questions_anomaly_transformation_function}(over='${var.mysql_questions_anomaly_transformation_window}').publish('signal')
		against_periods.detector_growth_rate(signal, window_to_compare=duration('${var.mysql_questions_anomaly_window_to_compare}'), space_between_windows=duration('${var.mysql_questions_anomaly_space_between_windows}'), num_windows=${var.mysql_questions_anomaly_num_windows}, fire_growth_rate_threshold=${var.mysql_questions_anomaly_fire_growth_rate_threshold}, clear_growth_rate_threshold=${var.mysql_questions_anomaly_clear_growth_rate_threshold}, discard_historical_outliers=True, orientation='${var.mysql_questions_anomaly_orientation}').publish('CRIT')
	EOF

  rule {
    description           = " rate > ${var.mysql_questions_anomaly_fire_growth_rate_threshold}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.mysql_questions_anomaly_disabled_critical, var.mysql_questions_anomaly_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.mysql_questions_anomaly_notifications_critical, var.mysql_questions_anomaly_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

#resource "signalfx_detector" "mysql_replication_lag" {
#  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] MySQL Innodb replication lag"
#
#  program_text = <<-EOF
#		signal = data('gauge.slave_lag', filter=filter('plugin', 'mysql') and ${module.filter-tags.filter_custom})${var.mysql_replication_lag_aggregation_function}.${var.mysql_replication_lag_transformation_function}(over='${var.mysql_replication_lag_transformation_window}').publish('signal')
#		detect(when(signal > ${var.mysql_replication_lag_threshold_critical})).publish('CRIT')
#		detect(when(signal > ${var.mysql_replication_lag_threshold_warning}) and when(signal <= ${var.mysql_replication_lag_threshold_critical})).publish('WARN')
#	EOF
#
#  rule {
#    description           = "is too high > ${var.mysql_replication_lag_threshold_critical}"
#    severity              = "Critical"
#    detect_label          = "CRIT"
#    disabled              = coalesce(var.mysql_replication_lag_disabled_critical, var.mysql_replication_lag_disabled, var.detectors_disabled)
#    notifications         = coalescelist(var.mysql_replication_lag_notifications_critical, var.mysql_replication_lag_notifications, var.notifications)
#    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
#  }
#
#  rule {
#    description           = "is too high > ${var.mysql_replication_lag_threshold_warning}"
#    severity              = "Warning"
#    detect_label          = "WARN"
#    disabled              = coalesce(var.mysql_replication_lag_disabled_warning, var.mysql_replication_lag_disabled, var.detectors_disabled)
#    notifications         = coalescelist(var.mysql_replication_lag_notifications_warning, var.mysql_replication_lag_notifications, var.notifications)
#    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
#  }
#}

resource "signalfx_detector" "mysql_replication_status" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] MySQL Replication Status"

  program_text = <<-EOF
		A = data('replication_sql_status', filter=${module.filter-tags.filter_custom})${var.mysql_replication_status_aggregation_function}
		B = data('replication_io_status', filter=${module.filter-tags.filter_custom})${var.mysql_replication_status_aggregation_function}
		signal = (A+B).${var.mysql_replication_status_transformation_function}(over='${var.mysql_replication_status_transformation_window}')
		detect(when(signal > 0) and when(signal < 2)).publish('WARN')
		detect(when(signal < 1)).publish('CRIT')
	EOF

  rule {
    description           = " is fully stopped"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.mysql_replication_status_disabled_critical, var.mysql_replication_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.mysql_replication_status_notifications_critical, var.mysql_replication_status_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = " is partially stopped"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.mysql_replication_status_disabled_critical, var.mysql_replication_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.mysql_replication_status_notifications_critical, var.mysql_replication_status_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
