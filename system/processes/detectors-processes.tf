resource "signalfx_detector" "processes" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Processes aliveness"

  program_text = <<-EOF
		signal = data('ps_count.processes', filter=${module.filter-tags.filter_custom})${var.processes_aggregation_function}.${var.processes_transformation_function}(over='${var.processes_transformation_window}').publish('signal')
		detect(when(signal < ${var.processes_threshold_critical})).publish('CRIT')
        detect(when(signal < ${var.processes_threshold_warning}) and when(signal > ${var.processes_threshold_critical})).publish('WARN')
  EOF

  rule {
    description           = "is too low < ${var.processes_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.processes_disabled_critical, var.processes_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.processes_notifications_critical, var.processes_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too low < ${var.processes_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.processes_disabled_warning, var.processes_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.processes_notifications_warning, var.processes_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}



