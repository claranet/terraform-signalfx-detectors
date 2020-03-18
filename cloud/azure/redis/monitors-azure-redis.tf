resource "signalfx_detector" "heartbeat" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure redis heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('connectedclients', filter=filter('resource_type', 'Microsoft.Cache/redis') and ${module.filter-tags.filter_custom})
		not_reporting.detector(stream=signal, resource_identifier=['host'], duration='${var.heartbeat_timeframe}').publish('CRIT')
	EOF

	rule {
		description           = "has not reported in ${var.heartbeat_timeframe}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.heartbeat_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "evictedkeys" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure redis evictedkeys"

	program_text = <<-EOF
		signal = data('evictedkeys', filter=filter('resource_type', 'Microsoft.Cache/redis') and ${module.filter-tags.filter_custom})${var.evictedkeys_aggregation_function}.${var.evictedkeys_transformation_function}(over='${var.evictedkeys_transformation_window}')
		detect(when(signal > ${var.evictedkeys_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.evictedkeys_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.evictedkeys_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.evictedkeys_disabled_critical, var.evictedkeys_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.evictedkeys_notifications_critical, var.evictedkeys_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.evictedkeys_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.evictedkeys_disabled_warning, var.evictedkeys_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.evictedkeys_notifications_warning, var.evictedkeys_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "percent_processor_time" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure redis processor time too high"

	program_text = <<-EOF
		signal = data('percentProcessorTime', filter=filter('resource_type', 'Microsoft.Cache/redis') and ${module.filter-tags.filter_custom})${var.percent_processor_time_aggregation_function}.${var.percent_processor_time_transformation_function}(over='${var.percent_processor_time_transformation_window}')
		detect(when(signal > ${var.percent_processor_time_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.percent_processor_time_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.percent_processor_time_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.percent_processor_time_disabled_critical, var.percent_processor_time_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.percent_processor_time_notifications_critical, var.percent_processor_time_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.percent_processor_time_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.percent_processor_time_disabled_warning, var.percent_processor_time_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.percent_processor_time_notifications_warning, var.percent_processor_time_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "load" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure redis load too"

	program_text = <<-EOF
		signal = data('serverLoad', filter=filter('resource_type', 'Microsoft.Cache/redis') and ${module.filter-tags.filter_custom})${var.load_aggregation_function}.${var.load_transformation_function}(over='${var.load_transformation_window}')
		detect(when(signal > ${var.load_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.load_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.load_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.load_disabled_critical, var.load_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.load_notifications_critical, var.load_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.load_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.load_disabled_warning, var.load_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.load_notifications_warning, var.load_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}
