resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Service Bus heartbeat"

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        signal = data('Size', filter=base_filter).publish('signal')
        not_reporting.detector(stream=signal, resource_identifier=['entityname', 'azure_resource_name', 'azure_resource_group_name'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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
        base_filter = filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        signal = data('ActiveConnections', filter=base_filter)${var.active_connections_aggregation_function}.publish('signal')
        detect(when(signal < threshold(${var.active_connections_threshold_critical}), lasting="${var.active_connections_timer}")).publish('CRIT')
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
        base_filter = filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('UserErrors', extrapolation='zero', filter=base_filter)${var.user_errors_aggregation_function}
        B = data('IncomingRequests', extrapolation='zero', filter=base_filter)${var.user_errors_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.user_errors_threshold_critical}), lasting="${var.user_errors_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.user_errors_threshold_warning}), lasting="${var.user_errors_timer}") and when(signal <= ${var.user_errors_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.user_errors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.user_errors_disabled_critical, var.user_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.user_errors_notifications_critical, var.user_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.user_errors_threshold_warning}%"
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
        base_filter = filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('ServerErrors', extrapolation='zero', filter=base_filter)${var.server_errors_aggregation_function}
        B = data('IncomingRequests', extrapolation='zero', filter=base_filter)${var.server_errors_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.server_errors_threshold_critical}), lasting="${var.server_errors_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.server_errors_threshold_warning}), lasting="${var.server_errors_timer}") and when(signal <= ${var.server_errors_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.server_errors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.server_errors_disabled_critical, var.server_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.server_errors_notifications_critical, var.server_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.server_errors_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.server_errors_disabled_warning, var.server_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.server_errors_notifications_warning, var.server_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
