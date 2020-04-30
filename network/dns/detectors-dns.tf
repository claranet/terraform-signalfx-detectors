resource "signalfx_detector" "dns_query_time" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] DNS query time"

	program_text = <<-EOF
		signal = data('dns.query_time_ms', filter=filter('plugin', 'telegraf/dns') and ${module.filter-tags.filter_custom})${var.dns_query_time_aggregation_function}.${var.dns_query_time_transformation_function}(over='${var.dns_query_time_transformation_window}').publish('signal')
		detect(when(signal > ${var.dns_query_time_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.dns_query_time_threshold_warning}) and when(signal <= ${var.dns_query_time_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.dns_query_time_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.dns_query_time_disabled_critical, var.dns_query_time_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.dns_query_time_notifications_critical, var.dns_query_time_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.dns_query_time_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.dns_query_time_disabled_warning, var.dns_query_time_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.dns_query_time_notifications_warning, var.dns_query_time_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "dns_error_code" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] DNS errors"

	program_text = <<-EOF
		signal = data('dns.rcode_value', filter=filter('plugin', 'telegraf/dns') and ${module.filter-tags.filter_custom})${var.dns_error_code_aggregation_function}.${var.dns_error_code_transformation_function}(over='${var.dns_error_code_transformation_window}').publish('signal')
		detect(when(signal > ${var.dns_error_code_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description           = " exists"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.dns_error_code_disabled_critical, var.dns_error_code_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.dns_error_code_notifications_critical, var.dns_error_code_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "dns_result_code" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] DNS result"

	program_text = <<-EOF
		signal = data('dns.result_code', filter=filter('plugin', 'telegraf/dns') and ${module.filter-tags.filter_custom})${var.dns_result_code_aggregation_function}.${var.dns_result_code_transformation_function}(over='${var.dns_result_code_transformation_window}').publish('signal')
		detect(when(signal > ${var.dns_result_code_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description           = " not success"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.dns_result_code_disabled_critical, var.dns_result_code_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.dns_result_code_notifications_critical, var.dns_result_code_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}
