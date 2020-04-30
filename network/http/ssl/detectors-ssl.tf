resource "signalfx_detector" "invalid_ssl_certificate" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] SSL invalid certificate count"

	program_text = <<-EOF
		signal = data('http.certificate_valid' and ${module.filter-tags.filter_custom})${var.invalid_ssl_certificate_aggregation_function}.${var.invalid_ssl_certificate_transformation_function}(over='${var.invalid_ssl_certificate_transformation_window}').publish('signal')
		detect(when(signal > ${var.invalid_ssl_certificate_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.invalid_ssl_certificate_threshold_warning}) and when(signal <= ${var.invalid_ssl_certificate_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.invalid_ssl_certificate_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.invalid_ssl_certificate_disabled_critical, var.invalid_ssl_certificate_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.invalid_ssl_certificate_notifications_critical, var.invalid_ssl_certificate_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.invalid_ssl_certificate_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.invalid_ssl_certificate_disabled_warning, var.invalid_ssl_certificate_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.invalid_ssl_certificate_notifications_warning, var.invalid_ssl_certificate_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "certificate_expiration_date" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] SSL certificate expiring in days"

	program_text = <<-EOF
		A = data(' http.certificate_expiration' and ${module.filter-tags.filter_custom})${var.certificate_expiration_date_aggregation_function}
		signal = (A/86400).${var.certificate_expiration_date_transformation_function}(over='${var.certificate_expiration_date_transformation_window}').publish('signal')
		detect(when(signal < ${var.certificate_expiration_date_threshold_critical})).publish('CRIT')
		detect(when(signal < ${var.certificate_expiration_date_threshold_warning}) and when(signal >= ${var.certificate_expiration_date_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too low < ${var.certificate_expiration_date_threshold_critical} days"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.certificate_expiration_date_disabled_critical, var.certificate_expiration_date_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.certificate_expiration_date_notifications_critical, var.certificate_expiration_date_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too low < ${var.certificate_expiration_date_threshold_warning} days"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.certificate_expiration_date_disabled_warning, var.certificate_expiration_date_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.certificate_expiration_date_notifications_warning, var.certificate_expiration_date_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}
