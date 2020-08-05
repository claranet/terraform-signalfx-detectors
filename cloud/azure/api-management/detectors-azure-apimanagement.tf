resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure API Management heartbeat"

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        signal = data('Capacity', filter=base_filter).publish('signal')
        not_reporting.detector(stream=signal, resource_identifier=['azure_resource_name', 'azure_resourceègroup_name'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "failed_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure API Management failed requests rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('FailedRequests', extrapolation='zero', filter=base_filter)${var.failed_requests_aggregation_function}
        B = data('TotalRequests', extrapolation='zero', filter=base_filter)${var.failed_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.failed_requests_threshold_critical}), lasting="${var.failed_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.failed_requests_threshold_warning}), lasting="${var.failed_requests_timer}") and when(signal <= ${var.failed_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.failed_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.failed_requests_disabled_critical, var.failed_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.failed_requests_notifications_critical, var.failed_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.failed_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.failed_requests_disabled_warning, var.failed_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.failed_requests_notifications_warning, var.failed_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "unauthorized_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure API Management unauthorized requests rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('UnauthorizedRequests', extrapolation='zero', filter=base_filter)${var.unauthorized_requests_aggregation_function}
        B = data('TotalRequests', extrapolation='zero', filter=base_filter)${var.unauthorized_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.unauthorized_requests_threshold_critical}), lasting="${var.unauthorized_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.unauthorized_requests_threshold_warning}), lasting="${var.unauthorized_requests_timer}") and when(signal <= ${var.unauthorized_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.unauthorized_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.unauthorized_requests_disabled_critical, var.unauthorized_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.unauthorized_requests_notifications_critical, var.unauthorized_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.unauthorized_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.unauthorized_requests_disabled_warning, var.unauthorized_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.unauthorized_requests_notifications_warning, var.unauthorized_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "successful_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure API Management successful requests rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('SuccessfulRequests', extrapolation='zero', filter=base_filter)${var.successful_requests_aggregation_function}
        B = data('TotalRequests', extrapolation='zero', filter=base_filter)${var.successful_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal < threshold(${var.successful_requests_threshold_critical}), lasting="${var.successful_requests_timer}")).publish('CRIT')
        detect(when(signal < threshold(${var.successful_requests_threshold_warning}), lasting="${var.successful_requests_timer}") and when(signal >= ${var.successful_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too low < ${var.successful_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.successful_requests_disabled_critical, var.successful_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.successful_requests_notifications_critical, var.successful_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too low < ${var.successful_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.successful_requests_disabled_warning, var.successful_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.successful_requests_notifications_warning, var.successful_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
