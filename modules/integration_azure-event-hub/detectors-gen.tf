resource "signalfx_detector" "throttled_requests" {
  name = format("%s %s", local.detector_name_prefix, "Azure Event Hub throttled requests")

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.EventHub/clusters') and filter('primary_aggregation_type', 'true')
    A = data('ThrottledRequests', filter=base_filtering and ${module.filter-tags.filter_custom})${var.throttled_requests_aggregation_function}${var.throttled_requests_transformation_function}
    B = data('IncomingRequests', filter=base_filtering and ${module.filter-tags.filter_custom})${var.throttled_requests_aggregation_function}${var.throttled_requests_transformation_function}
    signal = (A/B).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.throttled_requests_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.throttled_requests_threshold_major}) and when(signal <= ${var.throttled_requests_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.throttled_requests_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.throttled_requests_disabled_critical, var.throttled_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.throttled_requests_notifications, "critical", []), var.notifications.critical)
    runbook_url           = var.throttled_requests_runbook_url
    tip                   = var.throttled_requests_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.throttled_requests_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.throttled_requests_disabled_major, var.throttled_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.throttled_requests_notifications, "major", []), var.notifications.major)
    runbook_url           = var.throttled_requests_runbook_url
    tip                   = var.throttled_requests_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

