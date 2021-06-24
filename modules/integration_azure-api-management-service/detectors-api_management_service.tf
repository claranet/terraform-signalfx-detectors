resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure API Management Service Heartbeat")

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true')
        signal = data('NetworkConnectivity', filter=base_filter and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
        not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}', auto_resolve_after='${local.heartbeat_auto_resolve_after}').publish('CRIT')
    EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.heartbeat_runbook_url, var.runbook_url), "")
    tip                   = var.heartbeat_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject_novalue : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "capacity" {
  name = format("%s %s", local.detector_name_prefix, "Azure API Management Service Capacity")

  program_text = <<-EOF
    base_filter = filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true')
    signal = data('Capacity', filter=base_filter and ${module.filtering.signalflow})${var.capacity_aggregation_function}${var.capacity_transformation_function}.publish('signal')
    detect(when(signal > ${var.capacity_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.capacity_threshold_major}) and when(signal <= ${var.capacity_threshold_critical})).publish('MAJOR')
  EOF

  rule {
    description           = "is too high > ${var.capacity_threshold_critical} %"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.capacity_disabled_critical, var.capacity_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.capacity_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.capacity_runbook_url, var.runbook_url), "")
    tip                   = var.capacity_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.capacity_threshold_major} %"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.capacity_disabled_major, var.capacity_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.capacity_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.capacity_runbook_url, var.runbook_url), "")
    tip                   = var.capacity_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "gateway_requests_duration" {
  name = format("%s %s", local.detector_name_prefix, "Azure API Management Service Duration of gateway request")

  program_text = <<-EOF
    base_filter = filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true')
    signal = data('Duration', filter=base_filter and ${module.filtering.signalflow})${var.gateway_requests_duration_aggregation_function}${var.gateway_requests_duration_transformation_function}.scale(0.001).publish('signal')
    detect(when(signal > ${var.gateway_requests_duration_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.gateway_requests_duration_threshold_major}) and when(signal <= ${var.gateway_requests_duration_threshold_critical})).publish('MAJOR')
  EOF

  rule {
    description           = "is too high > ${var.gateway_requests_duration_threshold_critical} s"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.gateway_requests_duration_disabled_critical, var.gateway_requests_duration_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.gateway_requests_duration_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.gateway_requests_duration_runbook_url, var.runbook_url), "")
    tip                   = var.gateway_requests_duration_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.gateway_requests_duration_threshold_major} s"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.gateway_requests_duration_disabled_major, var.gateway_requests_duration_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.gateway_requests_duration_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.gateway_requests_duration_runbook_url, var.runbook_url), "")
    tip                   = var.gateway_requests_duration_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "backend_requests_duration" {
  name = format("%s %s", local.detector_name_prefix, "Azure API Management Service Duration of backend request")

  program_text = <<-EOF
    base_filter = filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true')
    signal = data('BackendDuration', filter=base_filter and ${module.filtering.signalflow})${var.backend_requests_duration_aggregation_function}${var.backend_requests_duration_transformation_function}.scale(0.001).publish('signal')
    detect(when(signal > ${var.backend_requests_duration_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.backend_requests_duration_threshold_major}) and when(signal <= ${var.backend_requests_duration_threshold_critical})).publish('MAJOR')
  EOF

  rule {
    description           = "is too high > ${var.backend_requests_duration_threshold_critical} s"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_requests_duration_disabled_critical, var.backend_requests_duration_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_requests_duration_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.backend_requests_duration_runbook_url, var.runbook_url), "")
    tip                   = var.backend_requests_duration_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.backend_requests_duration_threshold_major} s"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.backend_requests_duration_disabled_major, var.backend_requests_duration_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_requests_duration_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.backend_requests_duration_runbook_url, var.runbook_url), "")
    tip                   = var.backend_requests_duration_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}
