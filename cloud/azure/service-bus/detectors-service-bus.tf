resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure Service Bus heartbeat")

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true')
        signal = data('Size', filter=base_filter and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "active_connections" {
  name = format("%s %s", local.detector_name_prefix, "Azure Service Bus no active connections")

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
    notifications         = coalescelist(lookup(var.active_connections_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

}

resource "signalfx_detector" "user_errors" {
  name = format("%s %s", local.detector_name_prefix, "Azure Service Bus user error rate")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('UserErrors', extrapolation='zero', filter=base_filter)${var.user_errors_aggregation_function}
        B = data('IncomingRequests', extrapolation='zero', filter=base_filter)${var.user_errors_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.user_errors_threshold_critical}), lasting="${var.user_errors_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.user_errors_threshold_major}), lasting="${var.user_errors_timer}") and when(signal <= ${var.user_errors_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.user_errors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.user_errors_disabled_critical, var.user_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.user_errors_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.user_errors_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.user_errors_disabled_major, var.user_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.user_errors_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "server_errors" {
  name = format("%s %s", local.detector_name_prefix, "Azure Service Bus server error rate")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('ServerErrors', extrapolation='zero', filter=base_filter)${var.server_errors_aggregation_function}
        B = data('IncomingRequests', extrapolation='zero', filter=base_filter)${var.server_errors_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.server_errors_threshold_critical}), lasting="${var.server_errors_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.server_errors_threshold_major}), lasting="${var.server_errors_timer}") and when(signal <= ${var.server_errors_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.server_errors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.server_errors_disabled_critical, var.server_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.server_errors_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.server_errors_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.server_errors_disabled_major, var.server_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.server_errors_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "throttled_requests" {
  name = format("%s %s", local.detector_name_prefix, "Azure Service Bus throttled requests rate")

  program_text = <<-EOF
    base_filter = filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
    A = data('ThrottledRequests', filter=base_filter and ${module.filter-tags.filter_custom})${var.throttled_requests_aggregation_function}${var.throttled_requests_transformation_function}
    B = data('IncomingRequests', filter=base_filter and ${module.filter-tags.filter_custom})${var.throttled_requests_aggregation_function}${var.throttled_requests_transformation_function}
    signal = (A/B).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.throttled_requests_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.throttled_requests_threshold_major}) and when(signal <= ${var.throttled_requests_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.throttled_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.throttled_requests_disabled_critical, var.throttled_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.throttled_requests_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.throttled_requests_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.throttled_requests_disabled_major, var.throttled_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.throttled_requests_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}
