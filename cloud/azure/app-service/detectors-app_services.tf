resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure App Service heartbeat")

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true')
        signal = data('CpuTime', base_filter and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "response_time" {
  name = format("%s %s", local.detector_name_prefix, "Azure App Service response time")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true')
        signal = data('HttpResponseTime', extrapolation="last_value", filter=base_filter and ${module.filter-tags.filter_custom})${var.response_time_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.response_time_threshold_critical}), lasting="${var.response_time_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.response_time_threshold_major}), lasting="${var.response_time_timer}") and when(signal <= ${var.response_time_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.response_time_threshold_critical}s"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.response_time_disabled_critical, var.response_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.response_time_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.response_time_threshold_major}s"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.response_time_disabled_major, var.response_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.response_time_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

}

resource "signalfx_detector" "memory_usage_count" {
  name = format("%s %s", local.detector_name_prefix, "Azure App Service memory usage")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true')
        signal = data('MemoryWorkingSet', filter=base_filter and ${module.filter-tags.filter_custom})${var.memory_usage_count_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.memory_usage_count_threshold_critical}), lasting="${var.memory_usage_count_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.memory_usage_count_threshold_major}), lasting="${var.memory_usage_count_timer}") and when(signal <= ${var.memory_usage_count_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${ceil(var.memory_usage_count_threshold_critical / 1024 / 1024)}Mb"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_usage_count_disabled_critical, var.memory_usage_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_usage_count_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${ceil(var.memory_usage_count_threshold_major / 1024 / 1024)}Mb"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_usage_count_disabled_major, var.memory_usage_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_usage_count_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

}

resource "signalfx_detector" "http_5xx_errors_count" {
  name = format("%s %s", local.detector_name_prefix, "Azure App Service 5xx error rate")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true')
        A = data('Http5xx', extrapolation="zero", filter=base_filter and ${module.filter-tags.filter_custom})${var.http_5xx_errors_count_aggregation_function}
        B = data('Requests', extrapolation="zero", filter=base_filter and ${module.filter-tags.filter_custom})${var.http_5xx_errors_count_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.http_5xx_errors_count_threshold_critical}), lasting="${var.http_5xx_errors_count_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.http_5xx_errors_count_threshold_major}), lasting="${var.http_5xx_errors_count_timer}") and when(signal <= ${var.http_5xx_errors_count_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.http_5xx_errors_count_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_5xx_errors_count_disabled_critical, var.http_5xx_errors_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_5xx_errors_count_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.http_5xx_errors_count_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_5xx_errors_count_disabled_major, var.http_5xx_errors_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_5xx_errors_count_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

}

resource "signalfx_detector" "http_4xx_errors_count" {
  name = format("%s %s", local.detector_name_prefix, "Azure App Service 4xx error rate")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true')
        A = data('Http4xx', extrapolation="zero", filter=base_filter and ${module.filter-tags.filter_custom})${var.http_4xx_errors_count_aggregation_function}
        B = data('Requests', extrapolation="zero", filter=base_filter and ${module.filter-tags.filter_custom})${var.http_4xx_errors_count_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.http_4xx_errors_count_threshold_critical}), lasting="${var.http_4xx_errors_count_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.http_4xx_errors_count_threshold_major}), lasting="${var.http_4xx_errors_count_timer}") and when(signal <= ${var.http_4xx_errors_count_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.http_4xx_errors_count_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_4xx_errors_count_disabled_critical, var.http_4xx_errors_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_4xx_errors_count_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.http_4xx_errors_count_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_4xx_errors_count_disabled_major, var.http_4xx_errors_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_4xx_errors_count_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "http_success_status_rate" {
  name = format("%s %s", local.detector_name_prefix, "Azure App Service successful response rate")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true')
        A = data('Http2xx', extrapolation="zero", filter=base_filter and ${module.filter-tags.filter_custom})${var.http_success_status_rate_aggregation_function}
        B = data('Http3xx', extrapolation="zero", filter=base_filter and ${module.filter-tags.filter_custom})${var.http_success_status_rate_aggregation_function}
        C = data('Requests', extrapolation="zero", filter=base_filter and ${module.filter-tags.filter_custom})${var.http_success_status_rate_aggregation_function}
        signal = ((A+B)/C).scale(100).fill(100).publish('signal')
        detect(when(signal < threshold(${var.http_success_status_rate_threshold_critical}), lasting="${var.http_success_status_rate_timer}")).publish('CRIT')
        detect(when(signal < threshold(${var.http_success_status_rate_threshold_major}), lasting="${var.http_success_status_rate_timer}") and when(signal >= ${var.http_success_status_rate_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too low < ${var.http_success_status_rate_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_success_status_rate_disabled_critical, var.http_success_status_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_success_status_rate_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too low < ${var.http_success_status_rate_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_success_status_rate_disabled_major, var.http_success_status_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_success_status_rate_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}
