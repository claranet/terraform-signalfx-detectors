resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kong heartbeat"

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('counter.kong.requests.count', filter=(not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}')) and (not filter('gcp_status', '{Code=3, Name=STOPPING}', '{Code=4, Name=TERMINATED}')) and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stoppped', 'PowerState/deallocating', 'PowerState/deallocated')) and ${module.filter-tags.filter_custom}).publish('signal')
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

resource "signalfx_detector" "treatment_limit" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kong treatment limit"

  program_text = <<-EOF
		A = data('counter.kong.connections.handled', filter=${module.filter-tags.filter_custom})${var.treatment_limit_aggregation_function}
		B = data('counter.kong.connections.accepted', filter=${module.filter-tags.filter_custom})${var.treatment_limit_aggregation_function}
		signal = ((A-B)/A).scale(100).${var.treatment_limit_transformation_function}(over='${var.treatment_limit_transformation_window}').publish('signal')
		detect(when(signal > ${var.treatment_limit_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.treatment_limit_threshold_warning}) and when(signal <= ${var.treatment_limit_threshold_critical})).publish('WARN')
  EOF

  rule {
    description           = "is too high > ${var.treatment_limit_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.treatment_limit_disabled_critical, var.treatment_limit_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.treatment_limit_notifications_critical, var.treatment_limit_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.treatment_limit_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.treatment_limit_disabled_warning, var.treatment_limit_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.treatment_limit_notifications_warning, var.treatment_limit_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

