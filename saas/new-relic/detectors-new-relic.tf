resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] New Relic heartbeat"

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('Apdex/score/*', ${module.filter-tags.filter_custom}).publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('WARN')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.heartbeat_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "error_rate" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] New Relic error rate"

  program_text = <<-EOF
    signal = data('Errors/all/errors_per_minute/*', ${module.filter-tags.filter_custom})${var.error_rate_aggregation_function}${var.error_rate_transformation_function}.publish('signal')
    detect(when(signal > ${var.error_rate_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.error_rate_threshold_warning}) and when(signal <= ${var.error_rate_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.error_rate_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.error_rate_disabled_critical, var.error_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.error_rate_notifications_critical, var.error_rate_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.error_rate_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.error_rate_disabled_warning, var.error_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.error_rate_notifications_warning, var.error_rate_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "apdex" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] New Relic apdex score ratio"

  program_text = <<-EOF
    signal = data('Apdex/score/*', ${module.filter-tags.filter_custom})${var.apdex_aggregation_function}${var.apdex_transformation_function}.publish('signal')
    detect(when(signal < ${var.apdex_threshold_critical})).publish('CRIT')
    detect(when(signal < ${var.apdex_threshold_warning}) and when(signal >= ${var.apdex_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "has fallen below critical capacity < ${var.apdex_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.apdex_disabled_critical, var.apdex_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.apdex_notifications_critical, var.apdex_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is below nominal capacity < ${var.apdex_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.apdex_disabled_warning, var.apdex_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.apdex_notifications_warning, var.apdex_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

