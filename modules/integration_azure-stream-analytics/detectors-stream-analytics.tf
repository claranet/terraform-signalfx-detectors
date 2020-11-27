resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure Stream Analytics heartbeat")

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.StreamAnalytics/streamingjobs') and filter('primary_aggregation_type', 'true')
        signal = data('ResourceUtilization', filter=base_filter and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
        not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
    EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "su_utilization" {
  name = format("%s %s", local.detector_name_prefix, "Azure Stream Analytics resource utilization")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.StreamAnalytics/streamingjobs') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        signal = data('ResourceUtilization', filter=base_filter)${var.su_utilization_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.su_utilization_threshold_critical}), lasting="${var.su_utilization_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.su_utilization_threshold_major}), lasting="${var.su_utilization_timer}") and when(signal <= ${var.su_utilization_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.su_utilization_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.su_utilization_disabled_critical, var.su_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.su_utilization_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.su_utilization_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.su_utilization_disabled_major, var.su_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.su_utilization_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "failed_function_requests" {
  name = format("%s %s", local.detector_name_prefix, "Azure Stream Analytics failed function requests rate")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.StreamAnalytics/streamingjobs') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('AMLCalloutFailedRequests', extrapolation='zero', filter=base_filter)${var.failed_function_requests_aggregation_function}
        B = data('AMLCalloutRequests', extrapolation='zero', filter=base_filter)${var.failed_function_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.failed_function_requests_threshold_critical}), lasting="${var.failed_function_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.failed_function_requests_threshold_major}), lasting="${var.failed_function_requests_timer}") and when(signal <= ${var.failed_function_requests_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.failed_function_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.failed_function_requests_disabled_critical, var.failed_function_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.failed_function_requests_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.failed_function_requests_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.failed_function_requests_disabled_major, var.failed_function_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.failed_function_requests_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "conversion_errors" {
  name = format("%s %s", local.detector_name_prefix, "Azure Stream Analytics conversion errors rate")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.StreamAnalytics/streamingjobs') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        signal = data('ConversionErrors', filter=base_filter)${var.conversion_errors_aggregation_function}. publish('signal')
        detect(when(signal > threshold(${var.conversion_errors_threshold_critical}), lasting="${var.conversion_errors_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.conversion_errors_threshold_major}), lasting="${var.conversion_errors_timer}") and when(signal <= ${var.conversion_errors_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.conversion_errors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.conversion_errors_disabled_critical, var.conversion_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.conversion_errors_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.conversion_errors_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.conversion_errors_disabled_major, var.conversion_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.conversion_errors_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "runtime_errors" {
  name = format("%s %s", local.detector_name_prefix, "Azure Stream Analytics runtime errors rate")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.StreamAnalytics/streamingjobs') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        signal = data('Errors', filter=base_filter)${var.runtime_errors_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.runtime_errors_threshold_critical}), lasting="${var.runtime_errors_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.runtime_errors_threshold_major}), lasting="${var.runtime_errors_timer}") and when(signal <= ${var.runtime_errors_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.runtime_errors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.runtime_errors_disabled_critical, var.runtime_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.runtime_errors_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.runtime_errors_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.runtime_errors_disabled_major, var.runtime_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.runtime_errors_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}
