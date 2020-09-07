resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Functions heartbeat"

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'true') and filter('primary_aggregation_type', 'true')
        signal = data('AppConnections', filter=base_filter and ${module.filter-tags.filter_custom}).publish('signal')
        not_reporting.detector(stream=signal, resource_identifier=['azure_resource_name', 'azure_resource_group_name', 'azure_region'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "http_5xx_errors_rate" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Functions HTTP 5xx error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'true') and filter('primary_aggregation_type', 'true')
        A = data('Http5xx', extrapolation="zero", filter=base_filter and ${module.filter-tags.filter_custom})${var.http_5xx_errors_rate_aggregation_function}
        B = data('FunctionExecutionCount', extrapolation="zero", filter=base_filter and ${module.filter-tags.filter_custom})${var.http_5xx_errors_rate_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.http_5xx_errors_rate_threshold_critical}), lasting="${var.http_5xx_errors_rate_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.http_5xx_errors_rate_threshold_warning}), lasting="${var.http_5xx_errors_rate_timer}") and when(signal <= ${var.http_5xx_errors_rate_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.http_5xx_errors_rate_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_5xx_errors_rate_disabled_critical, var.http_5xx_errors_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_5xx_errors_rate_notifications_critical, var.http_5xx_errors_rate_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.http_5xx_errors_rate_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.http_5xx_errors_rate_disabled_warning, var.http_5xx_errors_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_5xx_errors_rate_notifications_warning, var.http_5xx_errors_rate_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "high_connections_count" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Functions connections count"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'true') and filter('primary_aggregation_type', 'true')
        signal = data('AppConnections', extrapolation="last_value", filter=base_filter and ${module.filter-tags.filter_custom})${var.high_connections_count_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.high_connections_count_threshold_critical}), lasting="${var.high_connections_count_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.high_connections_count_threshold_warning}), lasting="${var.high_connections_count_timer}") and when(signal <= ${var.high_connections_count_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.high_connections_count_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.high_connections_count_disabled_critical, var.high_connections_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.high_connections_count_notifications_critical, var.high_connections_count_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.high_connections_count_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.high_connections_count_disabled_warning, var.high_connections_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.high_connections_count_notifications_warning, var.high_connections_count_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "high_threads_count" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Functions thread count"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'true') and filter('primary_aggregation_type', 'true')
        signal = data('Threads', extrapolation='last_value', filter=base_filter and ${module.filter-tags.filter_custom})${var.high_threads_count_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.high_threads_count_threshold_critical}), lasting="${var.high_threads_count_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.high_threads_count_threshold_warning}), lasting="${var.high_threads_count_timer}") and when(signal <= ${var.high_threads_count_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.high_threads_count_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.high_threads_count_disabled_critical, var.high_threads_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.high_threads_count_notifications_critical, var.high_threads_count_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.high_threads_count_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.high_threads_count_disabled_warning, var.high_threads_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.high_threads_count_notifications_warning, var.high_threads_count_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
