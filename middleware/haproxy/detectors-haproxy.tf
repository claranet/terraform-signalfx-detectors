resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Haproxy heartbeat"

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('haproxy_session_current', filter=(not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}')) and (not filter('gcp_status', '{Code=3, Name=STOPPING}', '{Code=4, Name=TERMINATED}')) and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stopped', 'PowerState/deallocating', 'PowerState/deallocated')) and ${module.filter-tags.filter_custom}).publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=['host'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "server_status" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Haproxy server status"

  program_text = <<-EOF
    signal = data('haproxy_status', filter=filter('type', '2') and ${module.filter-tags.filter_custom})${var.server_status_aggregation_function}.${var.server_status_transformation_function}(over='${var.server_status_transformation_window}').publish('signal')
    detect(when(signal < 1)).publish('CRIT')
EOF

  rule {
    description           = "is down or in maintenance"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.server_status_disabled_critical, var.server_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.server_status_notifications_critical, var.server_status_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "backend_status" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Haproxy backend status"

  program_text = <<-EOF
    signal = data('haproxy_status', filter=filter('type', '1') and ${module.filter-tags.filter_custom})${var.backend_status_aggregation_function}.${var.backend_status_transformation_function}(over='${var.backend_status_transformation_window}').publish('signal')
    detect(when(signal < 1)).publish('CRIT')
EOF

  rule {
    description           = "is down (no available server left)"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_status_disabled_critical, var.backend_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.backend_status_notifications_critical, var.backend_status_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "session_limit" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Haproxy session"

  program_text = <<-EOF
        A = data('haproxy_session_current', filter=${module.filter-tags.filter_custom})${var.session_limit_aggregation_function}
        B = data('haproxy_session_limit', filter=${module.filter-tags.filter_custom})${var.session_limit_aggregation_function}
        signal = (A/B).scale(100).${var.session_limit_transformation_function}(over='${var.session_limit_transformation_window}').publish('signal')
        detect(when(signal > ${var.session_limit_threshold_critical})).publish('CRIT')
        detect(when(signal > ${var.session_limit_threshold_warning}) and when(signal <= ${var.session_limit_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is approaching the limit > ${var.session_limit_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.session_limit_disabled_critical, var.session_limit_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.session_limit_notifications_critical, var.session_limit_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is approaching the limit > ${var.session_limit_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.session_limit_disabled_warning, var.session_limit_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.session_limit_notifications_warning, var.session_limit_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "http_5xx_response" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Haproxy 5xx response rate"

  program_text = <<-EOF
        A = data('haproxy_response_5xx', filter=${module.filter-tags.filter_custom})${var.http_5xx_response_aggregation_function}
        B = data('haproxy_request_total', filter=${module.filter-tags.filter_custom})${var.http_5xx_response_aggregation_function}
        signal = (A/B).scale(100).${var.http_5xx_response_transformation_function}(over='${var.http_5xx_response_transformation_window}').publish('signal')
        detect(when(signal > ${var.http_5xx_response_threshold_critical})).publish('CRIT')
        detect(when(signal > ${var.http_5xx_response_threshold_warning}) and when(signal <= ${var.http_5xx_response_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.http_5xx_response_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_5xx_response_disabled_critical, var.http_5xx_response_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_5xx_response_notifications_critical, var.http_5xx_response_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.http_5xx_response_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.http_5xx_response_disabled_warning, var.http_5xx_response_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_5xx_response_notifications_warning, var.http_5xx_response_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "http_4xx_response" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Haproxy 4xx response rate"

  program_text = <<-EOF
        A = data('haproxy_response_4xx', filter=${module.filter-tags.filter_custom})${var.http_4xx_response_aggregation_function}
        B = data('haproxy_request_total', filter=${module.filter-tags.filter_custom})${var.http_4xx_response_aggregation_function}
        signal = (A/B).scale(100).${var.http_4xx_response_transformation_function}(over='${var.http_4xx_response_transformation_window}').publish('signal')
        detect(when(signal > ${var.http_4xx_response_threshold_critical})).publish('CRIT')
        detect(when(signal > ${var.http_4xx_response_threshold_warning}) and when(signal <= ${var.http_4xx_response_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.http_4xx_response_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_4xx_response_disabled_critical, var.http_4xx_response_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_4xx_response_notifications_critical, var.http_4xx_response_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.http_4xx_response_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.http_4xx_response_disabled_warning, var.http_4xx_response_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_4xx_response_notifications_warning, var.http_4xx_response_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
