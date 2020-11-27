resource "signalfx_detector" "heartbeat" {
  name      = format("%s %s", local.detector_name_prefix, "Haproxy heartbeat")
  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('haproxy_session_current', filter=${local.not_running_vm_filters} and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "server_status" {
  name = format("%s %s", local.detector_name_prefix, "Haproxy server status")

  program_text = <<-EOF
    signal = data('haproxy_status', filter=filter('type', '2') and ${module.filter-tags.filter_custom})${var.server_status_aggregation_function}${var.server_status_transformation_function}.publish('signal')
    detect(when(signal < 1)).publish('CRIT')
EOF

  rule {
    description           = "is down or in maintenance"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.server_status_disabled_critical, var.server_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.server_status_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "backend_status" {
  name = format("%s %s", local.detector_name_prefix, "Haproxy backend status")

  program_text = <<-EOF
    signal = data('haproxy_status', filter=filter('type', '1') and ${module.filter-tags.filter_custom})${var.backend_status_aggregation_function}${var.backend_status_transformation_function}.publish('signal')
    detect(when(signal < 1)).publish('CRIT')
EOF

  rule {
    description           = "is down (no available server left)"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_status_disabled_critical, var.backend_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_status_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "session_limit" {
  name = format("%s %s", local.detector_name_prefix, "Haproxy session")

  program_text = <<-EOF
    A = data('haproxy_session_current', filter=filter('type', '0', '2') and ${module.filter-tags.filter_custom})${var.session_limit_aggregation_function}${var.session_limit_transformation_function}
    B = data('haproxy_session_limit', filter=${module.filter-tags.filter_custom})${var.session_limit_aggregation_function}${var.session_limit_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.session_limit_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.session_limit_threshold_major}) and when(signal <= ${var.session_limit_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is approaching the limit > ${var.session_limit_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.session_limit_disabled_critical, var.session_limit_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.session_limit_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is approaching the limit > ${var.session_limit_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.session_limit_disabled_major, var.session_limit_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.session_limit_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "http_5xx_response" {
  name = format("%s %s", local.detector_name_prefix, "Haproxy 5xx response rate")

  program_text = <<-EOF
    A = data('haproxy_response_5xx', filter=${module.filter-tags.filter_custom}, rollup='delta')${var.http_5xx_response_aggregation_function}${var.http_5xx_response_transformation_function}
    B = data('haproxy_request_total', filter=${module.filter-tags.filter_custom}, rollup='delta')${var.http_5xx_response_aggregation_function}${var.http_5xx_response_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.http_5xx_response_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.http_5xx_response_threshold_major}) and when(signal <= ${var.http_5xx_response_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.http_5xx_response_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_5xx_response_disabled_critical, var.http_5xx_response_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_5xx_response_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.http_5xx_response_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_5xx_response_disabled_major, var.http_5xx_response_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_5xx_response_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "http_4xx_response" {
  name = format("%s %s", local.detector_name_prefix, "Haproxy 4xx response rate")

  program_text = <<-EOF
    A = data('haproxy_response_4xx', filter=${module.filter-tags.filter_custom}, rollup='delta')${var.http_4xx_response_aggregation_function}${var.http_4xx_response_transformation_function}
    B = data('haproxy_request_total', filter=${module.filter-tags.filter_custom}, rollup='delta')${var.http_4xx_response_aggregation_function}${var.http_4xx_response_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.http_4xx_response_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.http_4xx_response_threshold_major}) and when(signal <= ${var.http_4xx_response_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.http_4xx_response_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_4xx_response_disabled_critical, var.http_4xx_response_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_4xx_response_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.http_4xx_response_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_4xx_response_disabled_major, var.http_4xx_response_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_4xx_response_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

