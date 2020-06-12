resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Stream Analytics heartbeat"

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        signal = data('ResourceUtilization', filter=filter('resource_type', 'Microsoft.StreamAnalytics/streamingjobs') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}).publish('signal')
        not_reporting.detector(stream=signal, resource_identifier=['logicalname'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "su_utilization" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Stream Analytics resource utilization"

  program_text = <<-EOF
        signal = data('ResourceUtilization', filter=filter('resource_type', 'Microsoft.StreamAnalytics/streamingjobs') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.su_utilization_aggregation_function}.${var.su_utilization_transformation_function}(over='${var.su_utilization_transformation_window}').publish('signal')
        detect(when(signal > ${var.su_utilization_threshold_critical})).publish('CRIT')
        detect(when(signal > ${var.su_utilization_threshold_warning}) and when(signal <= ${var.su_utilization_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.su_utilization_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.su_utilization_disabled_critical, var.su_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.su_utilization_notifications_critical, var.su_utilization_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.su_utilization_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.su_utilization_disabled_warning, var.su_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.su_utilization_notifications_warning, var.su_utilization_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "failed_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Stream Analytics failed request rate"

  program_text = <<-EOF
        from signalfx.detectors.aperiodic import aperiodic
        A = data('AMLCalloutFailedRequests', filter=filter('resource_type', 'Microsoft.StreamAnalytics/streamingjobs') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.failed_requests_aggregation_function}
        B = data('AMLCalloutRequests', filter=filter('resource_type', 'Microsoft.StreamAnalytics/streamingjobs') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.failed_requests_aggregation_function}
        signal = ((A/B)*100).${var.failed_requests_transformation_function}(over='${var.failed_requests_transformation_window}').publish('signal')
        aperiodic.above_or_below_detector(signal, ${var.failed_requests_threshold_critical}, 'above', lasting('${var.failed_requests_aperiodic_duration}', ${var.failed_requests_aperiodic_percentage})).publish('CRIT')
        aperiodic.range_detector(signal, ${var.failed_requests_threshold_warning}, ${var.failed_requests_threshold_critical}, 'within_range', lasting('${var.failed_requests_aperiodic_duration}', ${var.failed_requests_aperiodic_percentage}), upper_strict=False).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.failed_requests_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.failed_requests_disabled_critical, var.failed_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.failed_requests_notifications_critical, var.failed_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.failed_requests_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.failed_requests_disabled_warning, var.failed_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.failed_requests_notifications_warning, var.failed_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "conversion_errors" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Stream Analytics conversion errors"

  program_text = <<-EOF
        signal = data('ConversionErrors', filter=filter('resource_type', 'Microsoft.StreamAnalytics/streamingjobs') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.conversion_errors_aggregation_function}.${var.conversion_errors_transformation_function}(over='${var.conversion_errors_transformation_window}').publish('signal')
        detect(when(signal > ${var.conversion_errors_threshold_critical})).publish('CRIT')
        detect(when(signal > ${var.conversion_errors_threshold_warning}) and when(signal <= ${var.conversion_errors_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "are too high > ${var.conversion_errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.conversion_errors_disabled_critical, var.conversion_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.conversion_errors_notifications_critical, var.conversion_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too high > ${var.conversion_errors_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.conversion_errors_disabled_warning, var.conversion_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.conversion_errors_notifications_warning, var.conversion_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "runtime_errors" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Stream Analytics runtime errors"

  program_text = <<-EOF
        signal = data('Errors', filter=filter('resource_type', 'Microsoft.StreamAnalytics/streamingjobs') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.runtime_errors_aggregation_function}.${var.runtime_errors_transformation_function}(over='${var.runtime_errors_transformation_window}').publish('signal')
        detect(when(signal > ${var.runtime_errors_threshold_critical})).publish('CRIT')
        detect(when(signal > ${var.runtime_errors_threshold_warning}) and when(signal <= ${var.runtime_errors_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "are too high > ${var.runtime_errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.runtime_errors_disabled_critical, var.runtime_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.runtime_errors_notifications_critical, var.runtime_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too high > ${var.runtime_errors_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.runtime_errors_disabled_warning, var.runtime_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.runtime_errors_notifications_warning, var.runtime_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
