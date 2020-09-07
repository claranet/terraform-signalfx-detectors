resource "signalfx_detector" "status_check" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Nagios check status"

  program_text = <<-EOF
        signal = data('nagios_state.state', filter=${module.filter-tags.filter_custom})${var.status_check_aggregation_function}${var.status_check_transformation_function}.publish('signal')
        detect(when(signal == 1, lasting='${var.status_check_lasting_duration_seconds}s')).publish('WARN')
        detect(when(signal == 2, lasting='${var.status_check_lasting_duration_seconds}s')).publish('CRIT')
        detect(when(signal == 3, lasting='${var.status_check_lasting_duration_seconds}s')).publish('UNKN')
  EOF

  rule {
    description           = "is UNKNOWN, please check the script output on the host"
    severity              = "Critical"
    detect_label          = "UNKN"
    disabled              = coalesce(var.status_check_disabled_unknown, var.status_check_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.status_check_notifications_unknown, var.status_check_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is CRITICAL, please check the script output on the host"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.status_check_disabled_critical, var.status_check_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.status_check_notifications_critical, var.status_check_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is WARNING, please check the script output on the host"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.status_check_disabled_warning, var.status_check_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.status_check_notifications_warning, var.status_check_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
