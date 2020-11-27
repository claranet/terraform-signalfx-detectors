resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway heartbeat")

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
        signal = data('Throughput', filter=base_filter and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "total_requests" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway has no request")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
        signal = data('TotalRequests', filter=base_filter and ${module.filter-tags.filter_custom})${var.total_requests_aggregation_function}.publish('signal')
        detect(when(signal < threshold(1), lasting="${var.total_requests_timer}")).publish('CRIT')
    EOF

  rule {
    description           = ""
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.total_requests_disabled_critical, var.total_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.total_requests_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

}

resource "signalfx_detector" "backend_connect_time" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway backend connect time")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
        signal = data('BackendConnectTime', filter=base_filter and ${module.filter-tags.filter_custom})${var.backend_connect_time_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.backend_connect_time_threshold_critical}), lasting="${var.backend_connect_time_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.backend_connect_time_threshold_major}), lasting="${var.backend_connect_time_timer}") and when(signal <= ${var.backend_connect_time_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.backend_connect_time_threshold_critical}ms"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_connect_time_disabled_critical, var.backend_connect_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_connect_time_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.backend_connect_time_threshold_major}ms"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.backend_connect_time_disabled_major, var.backend_connect_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_connect_time_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "failed_requests" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway failed request rate")

  program_text = <<-EOF
        from signalfx.detectors.aperiodic import conditions
        base_filter = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
        A = data('FailedRequests', extrapolation='zero', filter=base_filter and ${module.filter-tags.filter_custom})${var.failed_requests_aggregation_function}
        B = data('TotalRequests', extrapolation='zero', filter=base_filter and ${module.filter-tags.filter_custom})${var.failed_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.failed_requests_threshold_critical}), lasting="${var.failed_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.failed_requests_threshold_major}), lasting="${var.failed_requests_timer}") and when(signal <= ${var.failed_requests_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.failed_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.failed_requests_disabled_critical, var.failed_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.failed_requests_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.failed_requests_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.failed_requests_disabled_major, var.failed_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.failed_requests_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "unhealthy_host_ratio" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway backend unhealthy host ratio")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
        A = data('UnhealthyHostCount', filter=base_filter and ${module.filter-tags.filter_custom})${var.unhealthy_host_ratio_aggregation_function}
        B = data('HealthyHostCount', filter=base_filter and ${module.filter-tags.filter_custom})${var.unhealthy_host_ratio_aggregation_function}
        signal = (A/(A+B)).scale(100).publish('signal')
        detect(when(signal >= threshold(${var.unhealthy_host_ratio_threshold_critical}), lasting="${var.unhealthy_host_ratio_timer}")).publish('CRIT')
        detect(when(signal >= threshold(${var.unhealthy_host_ratio_threshold_major}), lasting="${var.unhealthy_host_ratio_timer}") and when(signal < ${var.unhealthy_host_ratio_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high >= ${var.unhealthy_host_ratio_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.unhealthy_host_ratio_disabled_critical, var.unhealthy_host_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.unhealthy_host_ratio_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high >= ${var.unhealthy_host_ratio_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.unhealthy_host_ratio_disabled_major, var.unhealthy_host_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.unhealthy_host_ratio_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "http_4xx_errors" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway 4xx error rate")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
        A = data('ResponseStatus', extrapolation='zero', filter=base_filter and filter('httpstatusgroup', '4xx') and ${module.filter-tags.filter_custom})${var.http_4xx_errors_aggregation_function}
        B = data('ResponseStatus', extrapolation='zero', filter=base_filter and ${module.filter-tags.filter_custom})${var.http_4xx_errors_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.http_4xx_errors_threshold_critical}), lasting="${var.http_4xx_errors_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.http_4xx_errors_threshold_major}), lasting="${var.http_4xx_errors_timer}") and when(signal <= ${var.http_4xx_errors_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.http_4xx_errors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_4xx_errors_disabled_critical, var.http_4xx_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_4xx_errors_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.http_4xx_errors_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_4xx_errors_disabled_major, var.http_4xx_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_4xx_errors_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "http_5xx_errors" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway 5xx error rate")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
        A = data('ResponseStatus', extrapolation='zero', filter=base_filter and filter('httpstatusgroup', '5xx') and ${module.filter-tags.filter_custom})${var.http_5xx_errors_aggregation_function}
        B = data('ResponseStatus', extrapolation='zero', filter=base_filter and ${module.filter-tags.filter_custom})${var.http_5xx_errors_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.http_5xx_errors_threshold_critical}), lasting="${var.http_5xx_errors_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.http_5xx_errors_threshold_major}), lasting="${var.http_5xx_errors_timer}") and when(signal <= ${var.http_5xx_errors_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.http_5xx_errors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_5xx_errors_disabled_critical, var.http_5xx_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_5xx_errors_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.http_5xx_errors_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_5xx_errors_disabled_major, var.http_5xx_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_5xx_errors_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "backend_http_4xx_errors" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway backend 4xx error rate")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
        A = data('BackendResponseStatus', extrapolation='zero', filter=base_filter and filter('httpstatusgroup', '4xx') and ${module.filter-tags.filter_custom})${var.backend_http_4xx_errors_aggregation_function}
        B = data('BackendResponseStatus', extrapolation='zero', filter=base_filter and ${module.filter-tags.filter_custom})${var.backend_http_4xx_errors_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.backend_http_4xx_errors_threshold_critical}), lasting="${var.backend_http_4xx_errors_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.backend_http_4xx_errors_threshold_major}), lasting="${var.backend_http_4xx_errors_timer}") and when(signal <= ${var.backend_http_4xx_errors_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.backend_http_4xx_errors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_http_4xx_errors_disabled_critical, var.backend_http_4xx_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_http_4xx_errors_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.backend_http_4xx_errors_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.backend_http_4xx_errors_disabled_major, var.backend_http_4xx_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_http_4xx_errors_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "backend_http_5xx_errors" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway backend 5xx error rate")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
        A = data('BackendResponseStatus', extrapolation='zero', filter=base_filter and filter('httpstatusgroup', '5xx') and ${module.filter-tags.filter_custom})${var.backend_http_5xx_errors_aggregation_function}
        B = data('BackendResponseStatus', extrapolation='zero', filter=base_filter and ${module.filter-tags.filter_custom})${var.backend_http_5xx_errors_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.backend_http_5xx_errors_threshold_critical}), lasting="${var.backend_http_5xx_errors_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.backend_http_5xx_errors_threshold_major}), lasting="${var.backend_http_5xx_errors_timer}") and when(signal <= ${var.backend_http_5xx_errors_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.backend_http_5xx_errors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_http_5xx_errors_disabled_critical, var.backend_http_5xx_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_http_5xx_errors_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.backend_http_5xx_errors_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.backend_http_5xx_errors_disabled_major, var.backend_http_5xx_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_http_5xx_errors_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}
