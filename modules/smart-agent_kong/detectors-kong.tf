resource "signalfx_detector" "heartbeat" {
  name      = format("%s %s", local.detector_name_prefix, "Kong heartbeat")
  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('counter.kong.requests.count', filter=${local.not_running_vm_filters} and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "treatment_limit" {
  name = format("%s %s", local.detector_name_prefix, "Kong treatment limit")

  program_text = <<-EOF
    A = data('kong_nginx_http_current_connections', filter=filter('state', 'handled') and ${module.filter-tags.filter_custom})${var.treatment_limit_aggregation_function}${var.treatment_limit_transformation_function}
    B = data('kong_nginx_http_current_connections', filter=filter('state', 'accepted') and ${module.filter-tags.filter_custom})${var.treatment_limit_aggregation_function}${var.treatment_limit_transformation_function}
    signal = ((A-B)/A).scale(100).publish('signal')
    detect(when(signal > ${var.treatment_limit_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.treatment_limit_threshold_major}) and when(signal <= ${var.treatment_limit_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.treatment_limit_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.treatment_limit_disabled_critical, var.treatment_limit_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.treatment_limit_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.treatment_limit_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.treatment_limit_disabled_major, var.treatment_limit_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.treatment_limit_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

