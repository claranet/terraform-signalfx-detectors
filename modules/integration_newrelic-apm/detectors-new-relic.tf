resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "New Relic heartbeat")

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('Apdex/score/*', ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('MAJOR')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "error_rate" {
  name = format("%s %s", local.detector_name_prefix, "New Relic error rate")

  program_text = <<-EOF
    signal = data('Errors/all/errors_per_minute/*', ${module.filter-tags.filter_custom})${var.error_rate_aggregation_function}${var.error_rate_transformation_function}.publish('signal')
    detect(when(signal > ${var.error_rate_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.error_rate_threshold_major}) and when(signal <= ${var.error_rate_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.error_rate_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.error_rate_disabled_critical, var.error_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.error_rate_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.error_rate_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.error_rate_disabled_major, var.error_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.error_rate_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

}

resource "signalfx_detector" "apdex" {
  name = format("%s %s", local.detector_name_prefix, "New Relic apdex score ratio")

  program_text = <<-EOF
    signal = data('Apdex/score/*', ${module.filter-tags.filter_custom})${var.apdex_aggregation_function}${var.apdex_transformation_function}.publish('signal')
    detect(when(signal < ${var.apdex_threshold_critical})).publish('CRIT')
    detect(when(signal < ${var.apdex_threshold_major}) and when(signal >= ${var.apdex_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "has fallen below critical capacity < ${var.apdex_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.apdex_disabled_critical, var.apdex_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.apdex_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is below nominal capacity < ${var.apdex_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.apdex_disabled_major, var.apdex_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.apdex_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

