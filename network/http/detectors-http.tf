resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] HTTP heartbeat"

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('http.status_code', filter=(not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}')) and (not filter('gcp_status', '{Code=3, Name=STOPPING}', '{Code=4, Name=TERMINATED}')) and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stoppped', 'PowerState/deallocating', 'PowerState/deallocated')) and ${module.filter-tags.filter_custom}).publish('signal')
		not_reporting.detector(stream=signal, resource_identifier=['host', 'url', 'method'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "http_code_matched" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] HTTP code "

  program_text = <<-EOF
		signal = data('http.code_matched', ${module.filter-tags.filter_custom})${var.http_code_matched_aggregation_function}.${var.http_code_matched_transformation_function}(over='${var.http_code_matched_transformation_window}').publish('signal')
		detect(when(signal < 1)).publish('CRIT')
	EOF

  rule {
    description           = "does not match"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_code_matched_disabled_critical, var.http_code_matched_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_code_matched_notifications_critical, var.http_code_matched_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "http_regex_matched" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] HTTP regex "

  program_text = <<-EOF
		signal = data('http.regex_matched', ${module.filter-tags.filter_custom})${var.http_regex_matched_aggregation_function}.${var.http_regex_matched_transformation_function}(over='${var.http_regex_matched_transformation_window}').publish('signal')
		detect(when(signal < 1)).publish('CRIT')
	EOF

  rule {
    description           = "does not match"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_regex_matched_disabled_critical, var.http_regex_matched_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_regex_matched_notifications_critical, var.http_regex_matched_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "http_response_time" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] HTTP response time"

  program_text = <<-EOF
		signal = data('http.response_time', ${module.filter-tags.filter_custom})${var.http_response_time_aggregation_function}.${var.http_response_time_transformation_function}(over='${var.http_response_time_transformation_window}').publish('signal')
		detect(when(signal > ${var.http_response_time_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.http_response_time_threshold_warning}) and when(signal <= ${var.http_response_time_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.http_response_time_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_response_time_disabled_critical, var.http_response_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_response_time_notifications_critical, var.http_response_time_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.http_response_time_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.http_response_time_disabled_warning, var.http_response_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_response_time_notifications_warning, var.http_response_time_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "http_content_length" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] HTTP content length"

  program_text = <<-EOF
		signal = data('http.content_length', ${module.filter-tags.filter_custom})${var.http_content_length_aggregation_function}.${var.http_content_length_transformation_function}(over='${var.http_content_length_transformation_window}').publish('signal')
		detect(when(signal < ${var.http_content_length_threshold_critical})).publish('CRIT')
		detect(when(signal < ${var.http_content_length_threshold_warning}) and when(signal >= ${var.http_content_length_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = "is too low < ${var.http_content_length_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_content_length_disabled_critical, var.http_content_length_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_content_length_notifications_critical, var.http_content_length_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too low < ${var.http_content_length_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.http_content_length_disabled_warning, var.http_content_length_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.http_content_length_notifications_warning, var.http_content_length_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "certificate_expiration_date" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] TLS certificate expiring in "

  program_text = <<-EOF
		A = data('http.cert_expiry', ${module.filter-tags.filter_custom})${var.certificate_expiration_date_aggregation_function}
		signal = (A/86400).${var.certificate_expiration_date_transformation_function}(over='${var.certificate_expiration_date_transformation_window}').publish('signal')
		detect(when(signal < ${var.certificate_expiration_date_threshold_critical})).publish('CRIT')
		detect(when(signal < ${var.certificate_expiration_date_threshold_warning}) and when(signal >= ${var.certificate_expiration_date_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = " < ${var.certificate_expiration_date_threshold_critical} days"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.certificate_expiration_date_disabled_critical, var.certificate_expiration_date_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.certificate_expiration_date_notifications_critical, var.certificate_expiration_date_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = " < ${var.certificate_expiration_date_threshold_warning} days"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.certificate_expiration_date_disabled_warning, var.certificate_expiration_date_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.certificate_expiration_date_notifications_warning, var.certificate_expiration_date_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "invalid_tls_certificate" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] TLS certificate"

  program_text = <<-EOF
		signal = data('http.cert_valid', ${module.filter-tags.filter_custom})${var.invalid_tls_certificate_aggregation_function}.${var.invalid_tls_certificate_transformation_function}(over='${var.invalid_tls_certificate_transformation_window}').publish('signal')
		detect(when(signal < 1)).publish('CRIT')
	EOF

  rule {
    description           = " is not valid"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.invalid_tls_certificate_disabled_critical, var.invalid_tls_certificate_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.invalid_tls_certificate_notifications_critical, var.invalid_tls_certificate_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}
