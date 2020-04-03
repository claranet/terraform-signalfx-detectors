resource "signalfx_detector" "heartbeat" {
 	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] MySQL heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('mysql_octets.rx', filter=filter('plugin', 'mysql') and ${module.filter-tags.filter_custom})
		not_reporting.detector(stream=signal, resource_identifier=['host'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "mysql_slow" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Mysql slow queries"

	program_text = <<-EOF
		A = data('mysql_slow_queries', filter=filter('plugin', 'mysql') and ${module.filter-tags.filter_custom})${var.mysql_slow_aggregation_function}
		B = data('cache_size.qcache', filter=filter('plugin', 'mysql') and ${module.filter-tags.filter_custom})${var.mysql_slow_aggregation_function}
		signal = (A/B).scale(100).${var.mysql_slow_transformation_function}(over='${var.mysql_slow_transformation_window}')
		detect(when(signal > ${var.mysql_slow_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.mysql_slow_threshold_warning}) and when(signal < ${var.mysql_slow_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.mysql_slow_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.mysql_slow_disabled_critical, var.mysql_slow_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.mysql_slow_notifications_critical, var.mysql_slow_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.mysql_slow_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.mysql_slow_disabled_warning, var.mysql_slow_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.mysql_slow_notifications_warning, var.mysql_slow_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}
