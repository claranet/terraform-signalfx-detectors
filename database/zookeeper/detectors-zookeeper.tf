resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Zookeeper heartbeat"

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('gauge.zk_max_file_descriptor_count', filter=filter('plugin', 'zookeeper') and (not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}')) and (not filter('gcp_status', '{Code=3, Name=STOPPING}', '{Code=4, Name=TERMINATED}')) and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stoppped', 'PowerState/deallocating', 'PowerState/deallocated')) and ${module.filter-tags.filter_custom})
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

resource "signalfx_detector" "zookeeper_latency" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Zookeeper latency"

  program_text = <<-EOF
		signal = data('gauge.zk_avg_latency', filter=filter('plugin', 'zookeeper') and ${module.filter-tags.filter_custom})${var.zookeeper_latency_aggregation_function}.${var.zookeeper_latency_transformation_function}(over='${var.zookeeper_latency_transformation_window}').publish('signal')
		detect(when(signal > ${var.zookeeper_latency_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.zookeeper_latency_threshold_warning}) and when(signal <= ${var.zookeeper_latency_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.zookeeper_latency_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.zookeeper_latency_disabled_critical, var.zookeeper_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.zookeeper_latency_notifications_critical, var.zookeeper_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.zookeeper_latency_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.zookeeper_latency_disabled_warning, var.zookeeper_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.zookeeper_latency_notifications_warning, var.zookeeper_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
