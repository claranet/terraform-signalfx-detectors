resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Docker heartbeat"

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('cpu.usage.system', filter=filter('plugin', 'docker') and ${module.filter-tags.filter_custom}).publish('signal')
		not_reporting.detector(stream=signal, resource_identifier=['container_name'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "memory_used" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Docker memory used instances"

  program_text = <<-EOF
		A = data('memory.usage.limit', filter=filter('plugin', 'docker') and ${module.filter-tags.filter_custom})${var.memory_used_aggregation_function}
		B = data('memory.usage.total', filter=filter('plugin', 'docker') and ${module.filter-tags.filter_custom})${var.memory_used_aggregation_function}
		signal = ((B*100)/A).${var.memory_used_transformation_function}(over='${var.memory_used_transformation_window}').publish('signal')
		detect(when(signal > ${var.memory_used_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.memory_used_threshold_warning}) and when(signal <= ${var.memory_used_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = "are too high > ${var.memory_used_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_used_disabled_critical, var.memory_used_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.memory_used_notifications_critical, var.memory_used_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too high > ${var.memory_used_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.memory_used_disabled_warning, var.memory_used_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.memory_used_notifications_warning, var.memory_used_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}
