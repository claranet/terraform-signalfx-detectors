resource "signalfx_detector" "heartbeat" {
  name = "${upper(join("", formatlist("[%s]", var.prefixes_slug)))}[${upper(var.environment)}] Nginx heartbeat"

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('dropped_connections_requests', filter=(not filter('aws_state', '*terminated}', '*stopped}')) and (not filter('gcp_status', '*TERMINATED}', '*STOPPING}')) and (not filter('azure_power_state', 'stop*', 'deallocat*')) and ${module.filter-tags.filter_custom})
		not_reporting.detector(stream=signal, resource_identifier=['host'], duration='${var.heartbeat_timeframe}').publish('CRIT')
	EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = split(";", coalesce(var.heartbeat_notifications, var.notifications))
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "dropped_connections" {
  name = "${upper(join("", formatlist("[%s]", var.prefixes_slug)))}[${upper(var.environment)}] Nginx dropped connections"

  program_text = <<-EOF
		signal = data('connections.failed', filter=${module.filter-tags.filter_custom})${var.dropped_connections_aggregation_function}.${var.dropped_connections_transformation_function}(over='${var.dropped_connections_transformation_window}')
		detect(when(signal > ${var.dropped_connections_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.dropped_connections_threshold_warning})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.dropped_connections_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.dropped_connections_disabled_critical, var.dropped_connections_disabled, var.detectors_disabled)
    notifications         = split(";", coalesce(var.dropped_connections_notifications_critical, var.dropped_connections_notifications, var.notifications))
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.dropped_connections_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.dropped_connections_disabled_warning, var.dropped_connections_disabled, var.detectors_disabled)
    notifications         = split(";", coalesce(var.dropped_connections_notifications_warning, var.dropped_connections_notifications, var.notifications))
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
