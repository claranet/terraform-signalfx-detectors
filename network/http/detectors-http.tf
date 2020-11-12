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
  name = format("%s %s", local.detector_name_prefix, "HTTP code")

  program_text = <<-EOF
    signal = data('http.code_matched', filter=${module.filter-tags.filter_custom}, rollup='max')${var.http_code_matched_aggregation_function}${var.http_code_matched_transformation_function}.publish('signal')
    detect(when(signal < 1, lasting='${var.http_code_matched_lasting_duration_seconds}s', at_least=${var.http_code_matched_at_least_percentage})).publish('CRIT')
EOF

  rule {
    description           = "does not match expected result"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_code_matched_disabled_critical, var.http_code_matched_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_code_matched_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

}

resource "signalfx_detector" "http_regex_matched" {
  name = format("%s %s", local.detector_name_prefix, "HTTP regex expression")

  program_text = <<-EOF
    signal = data('http.regex_matched', filter=${module.filter-tags.filter_custom}, rollup='min')${var.http_regex_matched_aggregation_function}${var.http_regex_matched_transformation_function}.publish('signal')
    detect(when(signal < 1, lasting='${var.http_regex_matched_lasting_duration_seconds}s', at_least=${var.http_regex_matched_at_least_percentage})).publish('CRIT')
EOF

  rule {
    description           = "does not match in body response"
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
    signal = data('http.response_time', filter=${module.filter-tags.filter_custom}, rollup='max')${var.http_response_time_aggregation_function}${var.http_response_time_transformation_function}.publish('signal')
    detect(when(signal > ${var.http_response_time_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.http_response_time_threshold_major}) and when(signal <= ${var.http_response_time_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.http_response_time_threshold_critical} seconds"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_response_time_disabled_critical, var.http_response_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_response_time_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.http_response_time_threshold_major} seconds"
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
    signal = data('http.content_length', filter=${module.filter-tags.filter_custom}, rollup='min')${var.http_content_length_aggregation_function}${var.http_content_length_transformation_function}.publish('signal')
    detect(when(signal < ${var.http_content_length_threshold_warning})).publish('WARN')
EOF

  rule {
    description           = "is too low < ${var.http_content_length_threshold_warning} bytes"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.http_content_length_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_content_length_notifications, "warning", []), var.notifications.warning)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "certificate_expiration_date" {
  name = format("%s %s", local.detector_name_prefix, "TLS certificate expiry date")

  program_text = <<-EOF
    A = data('http.cert_expiry', filter=${module.filter-tags.filter_custom}, rollup='min')${var.certificate_expiration_date_aggregation_function}${var.certificate_expiration_date_transformation_function}
    signal = (A/86400).publish('signal')
    detect(when(signal < ${var.certificate_expiration_date_threshold_major})).publish('MAJOR')
    detect(when(signal < ${var.certificate_expiration_date_threshold_minor}) and when(signal >= ${var.certificate_expiration_date_threshold_major})).publish('MINOR')
EOF

  rule {
    description           = "is too soon < ${var.certificate_expiration_date_threshold_major} days"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.certificate_expiration_date_disabled_major, var.certificate_expiration_date_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.certificate_expiration_date_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too soon < ${var.certificate_expiration_date_threshold_minor} days"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.certificate_expiration_date_disabled_minor, var.certificate_expiration_date_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.certificate_expiration_date_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "invalid_tls_certificate" {
  name = format("%s %s", local.detector_name_prefix, "TLS certificate")

  program_text = <<-EOF
    signal = data('http.cert_valid', filter=${module.filter-tags.filter_custom}, rollup='min')${var.invalid_tls_certificate_aggregation_function}${var.invalid_tls_certificate_transformation_function}.publish('signal')
    detect(when(signal < 1)).publish('CRIT')
EOF

  rule {
    description           = "is invalid"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.invalid_tls_certificate_disabled_critical, var.invalid_tls_certificate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.invalid_tls_certificate_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}
