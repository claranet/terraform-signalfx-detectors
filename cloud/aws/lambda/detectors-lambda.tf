resource "signalfx_detector" "pct_errors" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS Lambda errors rate"

  program_text = <<-EOF
    A = data('Errors', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'mean') and filter('Resource', '*') and ${module.filter-tags.filter_custom}, extrapolation='last_value', rollup='average')
    B = data('Invocations', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'mean') and filter('Resource', '*') and ${module.filter-tags.filter_custom}, extrapolation='last_value', rollup='average')
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.pct_errors_threshold_critical}), lasting='${var.pct_errors_lasting_duration_seconds}s')).publish('CRIT')
    detect((when(signal > threshold(${var.pct_errors_threshold_warning}), lasting='${var.pct_errors_lasting_duration_seconds}s') and when(signal <= ${var.pct_errors_threshold_critical}, lasting='${var.pct_errors_lasting_duration_seconds}s'))).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.pct_errors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.pct_errors_disabled_critical, var.pct_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.pct_errors_notifications_critical, var.pct_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.pct_errors_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.pct_errors_disabled_warning, var.pct_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.pct_errors_notifications_warning, var.pct_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "throttles" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS Lambda invocations throttled"

  program_text = <<-EOF
    signal = data('Throttles', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'mean') and filter('Resource', '*') and ${module.filter-tags.filter_custom}, extrapolation='last_value', rollup='average')${var.throttles_aggregation_function}.${var.throttles_transformation_function}(over='${var.throttles_transformation_window}').publish('signal')
    detect(when(signal > threshold(${var.throttles_threshold_critical}))).publish('CRIT')
    detect((when(signal > threshold(${var.throttles_threshold_warning})) and when(signal <= ${var.throttles_threshold_critical}))).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.throttles_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.throttles_disabled_critical, var.throttles_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.throttles_notifications_critical, var.throttles_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.throttles_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.throttles_disabled_warning, var.throttles_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.throttles_notifications_warning, var.throttles_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "invocations" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS Lambda invocations"

  program_text = <<-EOF
    signal = data('Invocations', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'mean') and filter('Resource', '*') and ${module.filter-tags.filter_custom}, extrapolation='last_value', rollup='average')${var.invocations_aggregation_function}.${var.invocations_transformation_function}(over='${var.invocations_transformation_window}').publish('signal')
    detect(when(signal < threshold(${var.invocations_threshold_warning}))).publish('WARN')
EOF

  rule {
    description           = "is too low < ${var.invocations_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.invocations_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.invocations_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}
