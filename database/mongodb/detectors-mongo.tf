resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] MongoDB heartbeat"

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('gauge.connections.current', filter=filter('plugin', 'mongo') and (not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}')) and (not filter('gcp_status', '{Code=3, Name=STOPPING}', '{Code=4, Name=TERMINATED}')) and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stoppped', 'PowerState/deallocating', 'PowerState/deallocated')) and ${module.filter-tags.filter_custom})
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

resource "signalfx_detector" "mongodb_primary" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] MongoDB more then one primary exists"

  program_text = <<-EOF
		signal = data('gauge.repl.is_primary_node', filter=filter('plugin', 'mongo') and ${module.filter-tags.filter_custom}).sum(by=['cluster'])${var.mongodb_primary_aggregation_function}.${var.mongodb_primary_transformation_function}(over='${var.mongodb_primary_transformation_window}').publish('signal')
		detect(when(signal >= 2)).publish('CRIT')
	EOF

  rule {
    description           = " = ${var.mongodb_primary_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.mongodb_primary_disabled_critical, var.mongodb_primary_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.mongodb_primary_notifications_critical, var.mongodb_primary_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "mongodb_secondary" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] MongoDB secondary is missing"

  program_text = <<-EOF
		A = data('gauge.repl.active_nodes', filter=filter('plugin', 'mongo') and ${module.filter-tags.filter_custom}).mean(by=['cluster'])${var.mongodb_secondary_aggregation_function}
		B = data('gauge.repl.is_primary_node', filter=filter('plugin', 'mongo') and ${module.filter-tags.filter_custom}).sum(by=['cluster'])${var.mongodb_secondary_aggregation_function}
		signal = (A-B).${var.mongodb_secondary_transformation_function}(over='${var.mongodb_secondary_transformation_window}').publish('signal')
		detect(when(signal <= ${var.mongodb_secondary_threshold_critical})).publish('CRIT')
		detect(when(signal < ${var.mongodb_secondary_threshold_warning}) and when(signal > ${var.mongodb_secondary_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = " <= ${var.mongodb_secondary_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.mongodb_secondary_disabled_critical, var.mongodb_secondary_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.mongodb_secondary_notifications_critical, var.mongodb_secondary_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = " < ${var.mongodb_secondary_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.mongodb_secondary_disabled_warning, var.mongodb_secondary_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.mongodb_secondary_notifications_warning, var.mongodb_secondary_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "mongodb_server_count" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] MongoDB server count is to high or wrong monitor config"

  program_text = <<-EOF
		signal = data('gauge.repl.active_nodes', filter=filter('plugin', 'mongo') and ${module.filter-tags.filter_custom}).mean(by=['cluster'])${var.mongodb_server_count_aggregation_function}.${var.mongodb_server_count_transformation_function}(over='${var.mongodb_server_count_transformation_window}').publish('signal')
		detect(when(signal > ${var.mongodb_server_count_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.mongodb_server_count_threshold_warning}) and when(signal <= ${var.mongodb_server_count_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = " > ${var.mongodb_server_count_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.mongodb_server_count_disabled_critical, var.mongodb_server_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.mongodb_server_count_notifications_critical, var.mongodb_server_count_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = " > ${var.mongodb_server_count_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.mongodb_server_count_disabled_warning, var.mongodb_server_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.mongodb_server_count_notifications_warning, var.mongodb_server_count_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}


resource "signalfx_detector" "mongodb_replication" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] MongoDB replication lag"

  program_text = <<-EOF
		signal = data('gauge.repl.max_lag', filter=filter('plugin', 'mongo') and ${module.filter-tags.filter_custom})${var.mongodb_replication_aggregation_function}.${var.mongodb_replication_transformation_function}(over='${var.mongodb_replication_transformation_window}').publish('signal')
		detect(when(signal > ${var.mongodb_replication_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.mongodb_replication_threshold_warning}) and when(signal <= ${var.mongodb_replication_threshold_critical})).publish('WARN')
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
