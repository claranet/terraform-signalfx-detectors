resource "signalfx_detector" "heartbeat" {
  name      = format("%s %s", local.detector_name_prefix, "HTTP heartbeat")
  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('http.status_code', filter=${local.not_running_vm_filters} and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "http_code_matched" {
  name = format("%s %s", local.detector_name_prefix, "HTTP code ")

  program_text = <<-EOF
    signal = data('http.code_matched', ${module.filter-tags.filter_custom})${var.http_code_matched_aggregation_function}${var.http_code_matched_transformation_function}.publish('signal')
    detect(when(signal < 1, lasting('${var.http_code_matched_lasting_duration}'))).publish('CRIT')
EOF

  rule {
    description           = "does not match"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_code_matched_disabled_critical, var.http_code_matched_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_code_matched_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

}

resource "signalfx_detector" "http_regex_matched" {
  name = format("%s %s", local.detector_name_prefix, "HTTP regex ")

  program_text = <<-EOF
    signal = data('http.regex_matched', ${module.filter-tags.filter_custom})${var.http_regex_matched_aggregation_function}${var.http_regex_matched_transformation_function}.publish('signal')
    detect(when(signal < 1, lasting('${var.http_regex_matched_lasting_duration}'))).publish('CRIT')
EOF

  rule {
    description           = "does not match"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_regex_matched_disabled_critical, var.http_regex_matched_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_regex_matched_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

}

resource "signalfx_detector" "http_response_time" {
  name = format("%s %s", local.detector_name_prefix, "HTTP response time")

  program_text = <<-EOF
    signal = data('http.response_time', ${module.filter-tags.filter_custom})${var.http_response_time_aggregation_function}${var.http_response_time_transformation_function}.publish('signal')
    detect(when(signal > ${var.http_response_time_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.http_response_time_threshold_major}) and when(signal <= ${var.http_response_time_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.http_response_time_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_response_time_disabled_critical, var.http_response_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_response_time_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.http_response_time_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_response_time_disabled_major, var.http_response_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_response_time_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "http_content_length" {
  name = format("%s %s", local.detector_name_prefix, "HTTP content length")

  program_text = <<-EOF
    signal = data('http.content_length', ${module.filter-tags.filter_custom})${var.http_content_length_aggregation_function}${var.http_content_length_transformation_function}.publish('signal')
    detect(when(signal < ${var.http_content_length_threshold_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.http_content_length_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_content_length_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_content_length_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "certificate_expiration_date" {
  name = format("%s %s", local.detector_name_prefix, "TLS certificate expiring in ")

  program_text = <<-EOF
    A = data('http.cert_expiry', ${module.filter-tags.filter_custom})${var.certificate_expiration_date_aggregation_function}${var.certificate_expiration_date_transformation_function}
    signal = (A/86400).publish('signal')
    detect(when(signal < ${var.certificate_expiration_date_threshold_critical})).publish('CRIT')
    detect(when(signal < ${var.certificate_expiration_date_threshold_major}) and when(signal >= ${var.certificate_expiration_date_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = " < ${var.certificate_expiration_date_threshold_critical} days"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.certificate_expiration_date_disabled_critical, var.certificate_expiration_date_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.certificate_expiration_date_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = " < ${var.certificate_expiration_date_threshold_major} days"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.certificate_expiration_date_disabled_major, var.certificate_expiration_date_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.certificate_expiration_date_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "invalid_tls_certificate" {
  name = format("%s %s", local.detector_name_prefix, "TLS certificate")

  program_text = <<-EOF
    signal = data('http.cert_valid', ${module.filter-tags.filter_custom})${var.invalid_tls_certificate_aggregation_function}${var.invalid_tls_certificate_transformation_function}.publish('signal')
    detect(when(signal < 1)).publish('CRIT')
EOF

  rule {
    description           = " is not valid"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.invalid_tls_certificate_disabled_critical, var.invalid_tls_certificate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.invalid_tls_certificate_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

}
