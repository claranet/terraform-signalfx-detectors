resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] DNS heartbeat"

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('dns.result_code', filter=(not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}')) and (not filter('gcp_status', '{Code=3, Name=STOPPING}', '{Code=4, Name=TERMINATED}')) and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stoppped', 'PowerState/deallocating', 'PowerState/deallocated')) and ${module.filter-tags.filter_custom}).publish('signal')
		not_reporting.detector(stream=signal, resource_identifier=['host', 'server', 'domain', 'record_type'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "dns_result_code" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] DNS query result"

  program_text = <<-EOF
		signal = data('dns.result_code', filter=filter('plugin', 'telegraf/dns') and ${module.filter-tags.filter_custom})${var.dns_result_code_aggregation_function}.${var.dns_result_code_transformation_function}(over='${var.dns_result_code_transformation_window}').publish('signal')
		detect(when(signal > 0)).publish('CRIT')
	EOF

  rule {
    description           = "is not successful"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.dns_result_code_disabled_critical, var.dns_result_code_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.dns_result_code_notifications_critical, var.dns_result_code_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}
