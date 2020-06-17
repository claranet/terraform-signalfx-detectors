resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] NTP heartbeat"

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('ntp.offset_seconds', filter=filter('aws_state', 'running') and filter('gcp_status', '*RUNNING}') and filter('azure_power_state', 'PowerState/running') and ${module.filter-tags.filter_custom}).publish('signal')
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

resource "signalfx_detector" "ntp" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] NTP offset"

  program_text = <<-EOF
        signal = data('ntp.offset_seconds', filter=${module.filter-tags.filter_custom})${var.ntp_aggregation_function}.${var.ntp_transformation_function}(over='${var.ntp_transformation_window}').publish('signal')
        detect(when(signal > ${var.ntp_threshold_warning})).publish('WARN')
  EOF

  rule {
    description           = "is too high > ${var.ntp_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.ntp_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.ntp_notifications_warning, var.ntp_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
