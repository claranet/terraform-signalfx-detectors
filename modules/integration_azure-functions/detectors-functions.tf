resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure Functions heartbeat")

  authorized_writer_teams = var.authorized_writer_teams


  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'true') and filter('primary_aggregation_type', 'true')
        signal = data('AppConnections', filter=base_filter and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
        not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
    EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.heartbeat_runbook_url, var.runbook_url), "")
    tip                   = var.heartbeat_tip
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "http_5xx_errors_rate" {
  name = format("%s %s", local.detector_name_prefix, "Azure Functions HTTP 5xx error rate")

  authorized_writer_teams = var.authorized_writer_teams


  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'true') and filter('primary_aggregation_type', 'true')
        A = data('Http5xx', extrapolation="zero", filter=base_filter and ${module.filter-tags.filter_custom})${var.http_5xx_errors_rate_aggregation_function}
        B = data('FunctionExecutionCount', extrapolation="zero", filter=base_filter and ${module.filter-tags.filter_custom})${var.http_5xx_errors_rate_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.http_5xx_errors_rate_threshold_critical}), lasting="${var.http_5xx_errors_rate_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.http_5xx_errors_rate_threshold_major}), lasting="${var.http_5xx_errors_rate_timer}") and when(signal <= ${var.http_5xx_errors_rate_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.http_5xx_errors_rate_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_5xx_errors_rate_disabled_critical, var.http_5xx_errors_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_5xx_errors_rate_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.http_5xx_errors_rate_runbook_url, var.runbook_url), "")
    tip                   = var.http_5xx_errors_rate_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.http_5xx_errors_rate_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_5xx_errors_rate_disabled_major, var.http_5xx_errors_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_5xx_errors_rate_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.http_5xx_errors_rate_runbook_url, var.runbook_url), "")
    tip                   = var.http_5xx_errors_rate_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "high_connections_count" {
  name = format("%s %s", local.detector_name_prefix, "Azure Functions connections count")

  authorized_writer_teams = var.authorized_writer_teams


  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'true') and filter('primary_aggregation_type', 'true')
        signal = data('AppConnections', extrapolation="last_value", filter=base_filter and ${module.filter-tags.filter_custom})${var.high_connections_count_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.high_connections_count_threshold_critical}), lasting="${var.high_connections_count_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.high_connections_count_threshold_major}), lasting="${var.high_connections_count_timer}") and when(signal <= ${var.high_connections_count_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.high_connections_count_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.high_connections_count_disabled_critical, var.high_connections_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.high_connections_count_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.high_connections_count_runbook_url, var.runbook_url), "")
    tip                   = var.high_connections_count_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.high_connections_count_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.high_connections_count_disabled_major, var.high_connections_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.high_connections_count_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.high_connections_count_runbook_url, var.runbook_url), "")
    tip                   = var.high_connections_count_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "high_threads_count" {
  name = format("%s %s", local.detector_name_prefix, "Azure Functions thread count")

  authorized_writer_teams = var.authorized_writer_teams


  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'true') and filter('primary_aggregation_type', 'true')
        signal = data('Threads', extrapolation='last_value', filter=base_filter and ${module.filter-tags.filter_custom})${var.high_threads_count_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.high_threads_count_threshold_critical}), lasting="${var.high_threads_count_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.high_threads_count_threshold_major}), lasting="${var.high_threads_count_timer}") and when(signal <= ${var.high_threads_count_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.high_threads_count_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.high_threads_count_disabled_critical, var.high_threads_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.high_threads_count_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.high_threads_count_runbook_url, var.runbook_url), "")
    tip                   = var.high_threads_count_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.high_threads_count_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.high_threads_count_disabled_major, var.high_threads_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.high_threads_count_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.high_threads_count_runbook_url, var.runbook_url), "")
    tip                   = var.high_threads_count_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}
