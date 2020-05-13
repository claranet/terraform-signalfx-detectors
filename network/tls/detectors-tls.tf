resource "signalfx_detector" "heartbeat" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] TLS heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('http.status_code', ${module.filter-tags.filter_custom}).publish('signal')
		not_reporting.detector(stream=signal, resource_identifier=['url'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "invalid_tls_certificate" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] TLS invalid certificate count"

	program_text = <<-EOF
		signal = data('http.certificate_expiry', filter=filter('isValid', 'false') and ${module.filter-tags.filter_custom}).count(by=['serverName', 'url'])${var.invalid_tls_certificate_aggregation_function}.${var.invalid_tls_certificate_transformation_function}(over='${var.invalid_tls_certificate_transformation_window}').publish('signal')
		detect(when(signal < ${var.invalid_tls_certificate_threshold_critical})).publish('CRIT')
		detect(when(signal < ${var.invalid_tls_certificate_threshold_warning}) and when(signal <= ${var.invalid_tls_certificate_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.invalid_tls_certificate_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.invalid_tls_certificate_disabled_critical, var.invalid_tls_certificate_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.invalid_tls_certificate_notifications_critical, var.invalid_tls_certificate_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high < ${var.invalid_tls_certificate_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.invalid_tls_certificate_disabled_warning, var.invalid_tls_certificate_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.invalid_tls_certificate_notifications_warning, var.invalid_tls_certificate_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "tls_certificate_expiration" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] TLS certificate expiring count"

	program_text = <<-EOF
		signal = data('http.certificate_expiry', ${module.filter-tags.filter_custom}).below(${var.tls_certificate_expiration_timeframe}, inclusive=True).count(by=['serverName', 'url'])${var.tls_certificate_expiration_aggregation_function}.${var.tls_certificate_expiration_transformation_function}(over='${var.tls_certificate_expiration_transformation_window}').publish('signal')
		detect(when(signal > ${var.tls_certificate_expiration_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.tls_certificate_expiration_threshold_warning}) and when(signal <= ${var.tls_certificate_expiration_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.tls_certificate_expiration_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.tls_certificate_expiration_disabled_critical, var.tls_certificate_expiration_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.tls_certificate_expiration_notifications_critical, var.tls_certificate_expiration_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.tls_certificate_expiration_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.tls_certificate_expiration_disabled_warning, var.tls_certificate_expiration_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.tls_certificate_expiration_notifications_warning, var.tls_certificate_expiration_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "certificate_expiration_date" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] TLS certificate expiring in "

	program_text = <<-EOF
		A = data('http.certificate_expiry', ${module.filter-tags.filter_custom})${var.certificate_expiration_date_aggregation_function}
		signal = (A/86400).${var.tls_certificate_expiration_transformation_function}(over='${var.certificate_expiration_date_transformation_window}').publish('signal')
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
