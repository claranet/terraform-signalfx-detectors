resource "signalfx_detector" "pct_errors" {
  name = format("%s %s", local.detector_name_prefix, "AWS Lambda errors rate")

  program_text = <<-EOF
    A = data('Errors', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'mean') and filter('Resource', '*') and ${module.filter-tags.filter_custom}, extrapolation='last_value', rollup='average')${var.pct_errors_aggregation_function}${var.pct_errors_transformation_function}
    B = data('Invocations', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'mean') and filter('Resource', '*') and ${module.filter-tags.filter_custom}, extrapolation='last_value', rollup='average')${var.pct_errors_aggregation_function}${var.pct_errors_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.pct_errors_threshold_critical}), lasting='${var.pct_errors_lasting_duration_seconds}s')).publish('CRIT')
    detect((when(signal > threshold(${var.pct_errors_threshold_major}), lasting='${var.pct_errors_lasting_duration_seconds}s') and when(signal <= ${var.pct_errors_threshold_critical}, lasting='${var.pct_errors_lasting_duration_seconds}s'))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.pct_errors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.pct_errors_disabled_critical, var.pct_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.pct_errors_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.pct_errors_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.pct_errors_disabled_major, var.pct_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.pct_errors_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "throttles" {
  name = format("%s %s", local.detector_name_prefix, "AWS Lambda invocations throttled")

  program_text = <<-EOF
    signal = data('Throttles', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'mean') and filter('Resource', '*') and ${module.filter-tags.filter_custom}, extrapolation='last_value', rollup='average')${var.throttles_aggregation_function}${var.throttles_transformation_function}.publish('signal')
    detect(when(signal > threshold(${var.throttles_threshold_critical}))).publish('CRIT')
    detect((when(signal > threshold(${var.throttles_threshold_major})) and when(signal <= ${var.throttles_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.throttles_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.throttles_disabled_critical, var.throttles_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.throttles_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.throttles_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.throttles_disabled_major, var.throttles_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.throttles_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "invocations" {
  name = format("%s %s", local.detector_name_prefix, "AWS Lambda invocations")

  program_text = <<-EOF
    signal = data('Invocations', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'mean') and filter('Resource', '*') and ${module.filter-tags.filter_custom}, extrapolation='last_value', rollup='average')${var.invocations_aggregation_function}${var.invocations_transformation_function}.publish('signal')
    detect(when(signal < threshold(${var.invocations_threshold_major}))).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.invocations_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.invocations_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.invocations_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

