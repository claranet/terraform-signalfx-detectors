resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Service Bus heartbeat"

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        signal = data('SuccessfulRequests', filter=filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}).publish('signal')
        not_reporting.detector(stream=signal, resource_identifier=['entityname'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "active_connections" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Service Bus no active connections"

  program_text = <<-EOF
        signal = data('ActiveConnections', filter=filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.active_connections_aggregation_function}.${var.active_connections_transformation_function}(over='${var.active_connections_transformation_window}').publish('signal')
        detect(when(signal > ${var.active_connections_threshold_critical})).publish('CRIT')
    EOF

  rule {
    description           = " < ${var.active_connections_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.active_connections_disabled_critical, var.active_connections_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.active_connections_notifications_critical, var.active_connections_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "user_errors" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Service Bus user error rate"

  program_text = <<-EOF
        from signalfx.detectors.aperiodic import aperiodic
        A = data('UserErrors', filter=filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.user_errors_aggregation_function}
        B = data('IncomingRequests', filter=filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.user_errors_aggregation_function}
        signal = ((A/B)*100).${var.user_errors_transformation_function}(over='${var.user_errors_transformation_window}').publish('signal')
        aperiodic.above_or_below_detector(signal, ${var.user_errors_threshold_critical}, 'above', lasting('${var.user_errors_aperiodic_duration}', ${var.user_errors_aperiodic_percentage})).publish('CRIT')
        aperiodic.range_detector(signal, ${var.user_errors_threshold_warning}, ${var.user_errors_threshold_critical}, 'within_range', lasting('${var.user_errors_aperiodic_duration}', ${var.user_errors_aperiodic_percentage}), upper_strict=False).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.user_errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.user_errors_disabled_critical, var.user_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.user_errors_notifications_critical, var.user_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.user_errors_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.user_errors_disabled_warning, var.user_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.user_errors_notifications_warning, var.user_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "server_errors" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Service Bus server error rate"

  program_text = <<-EOF
        from signalfx.detectors.aperiodic import aperiodic
        A = data('ServerErrors', filter=filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.server_errors_aggregation_function}
        B = data('IncomingRequests', filter=filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.server_errors_aggregation_function}
        signal = ((A/B)*100).${var.server_errors_transformation_function}(over='${var.server_errors_transformation_window}').publish('signal')
        aperiodic.above_or_below_detector(signal, ${var.server_errors_threshold_critical}, 'above', lasting('${var.server_errors_aperiodic_duration}', ${var.server_errors_aperiodic_percentage})).publish('CRIT')
        aperiodic.range_detector(signal, ${var.server_errors_threshold_warning}, ${var.server_errors_threshold_critical}, 'within_range', lasting('${var.server_errors_aperiodic_duration}', ${var.server_errors_aperiodic_percentage}), upper_strict=False).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.server_errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.server_errors_disabled_critical, var.server_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.server_errors_notifications_critical, var.server_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.server_errors_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.server_errors_disabled_warning, var.server_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.server_errors_notifications_warning, var.server_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
