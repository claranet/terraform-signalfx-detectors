resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Event Hub heartbeat"

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.EventHub/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        signal = data('Size', filter=base_filter).publish('signal')
        not_reporting.detector(stream=signal, resource_identifier=['Role', 'azure_resource_name', 'azure_resource_group_name'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "eventhub_failed_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Event Hub failed requests rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.EventHub/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('IncomingRequests', extrapolation='zero', filter=base_filter)${var.eventhub_failed_requests_aggregation_function}
        B = data('SuccessfulRequests', extrapolation='zero', filter=base_filter)${var.eventhub_failed_requests_aggregation_function}
        signal = ((A-B)/A).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.eventhub_failed_requests_threshold_critical}), lasting="${var.eventhub_failed_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.eventhub_failed_requests_threshold_warning}), lasting="${var.eventhub_failed_requests_timer}") and when(signal <= ${var.eventhub_failed_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.eventhub_failed_requests_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.eventhub_failed_requests_disabled_critical, var.eventhub_failed_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.eventhub_failed_requests_notifications_critical, var.eventhub_failed_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.eventhub_failed_requests_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.eventhub_failed_requests_disabled_warning, var.eventhub_failed_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.eventhub_failed_requests_notifications_warning, var.eventhub_failed_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "eventhub_errors" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Event Hub errors rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.EventHub/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('ServerErrors', extrapolation='zero', filter=base_filter)${var.eventhub_errors_aggregation_function}
        B = data('UserErrors', extrapolation='zero', filter=base_filter)${var.eventhub_errors_aggregation_function}
        C = data('QuotaExceededErrors', extrapolation='zero', filter=base_filter)${var.eventhub_errors_aggregation_function}
        D = data('IncomingRequests', extrapolation='zero', filter=base_filter)${var.eventhub_errors_aggregation_function}
        signal = ((A+B+C)/D).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.eventhub_failed_requests_threshold_critical}), lasting="${var.eventhub_errors_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.eventhub_failed_requests_threshold_warning}), lasting="${var.eventhub_errors_timer}") and when(signal <= ${var.eventhub_failed_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.eventhub_errors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.eventhub_errors_disabled_critical, var.eventhub_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.eventhub_errors_notifications_critical, var.eventhub_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.eventhub_errors_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.eventhub_errors_disabled_warning, var.eventhub_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.eventhub_errors_notifications_warning, var.eventhub_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}
