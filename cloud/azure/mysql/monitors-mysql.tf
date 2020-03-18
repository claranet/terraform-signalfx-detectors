resource "signalfx_detector" "heartbeat" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure mysql heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('active_connections', filter=filter('resource_type', 'Microsoft.DBforMySQL/servers') and ${module.filter-tags.filter_custom})
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

resource "signalfx_detector" "cpu_usage" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure mysql server CPU usage"

	program_text = <<-EOF
		signal = data('cpu_percent', filter=filter('resource_type', 'Microsoft.DBforMySQL/servers') and ${module.filter-tags.filter_custom})${var.cpu_usage_aggregation_function}.${var.cpu_usage_transformation_function}(over='${var.cpu_usage_transformation_window}')
		detect(when(signal > ${var.cpu_usage_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.cpu_usage_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.cpu_usage_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.cpu_usage_disabled_critical, var.cpu_usage_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.cpu_usage_notifications_critical, var.cpu_usage_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.cpu_usage_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.cpu_usage_disabled_warning, var.cpu_usage_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.cpu_usage_notifications_warning, var.cpu_usage_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "free_storage" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure mysql server storage"

	program_text = <<-EOF
		A = data('storage_percent', filter=filter('resource_type', 'Microsoft.DBforMySQL/servers) and ${module.filter-tags.filter_custom})${var.free_storage_aggregation_function}
		signal = (100-A).${var.free_storage_transformation_function}(over='${var.free_storage_transformation_window}')
		detect(when(signal < ${var.free_storage_threshold_critical})).publish('CRIT')
		detect(when(signal < ${var.free_storage_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too low < ${var.free_storage_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.free_storage_disabled_critical, var.free_storage_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.free_storage_notifications_critical, var.free_storage_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too low < ${var.free_storage_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.free_storage_disabled_warning, var.free_storage_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.free_storage_notifications_warning, var.free_storage_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "io_consumption" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure mysql server IO consumption"

	program_text = <<-EOF
		signal = data('io_consumption_percent', filter=filter('resource_type', 'Microsoft.DBforMySQL/servers) and ${module.filter-tags.filter_custom})${var.io_consumption_aggregation_function}.${var.io_consumption_transformation_function}(over='${var.io_consumption_transformation_window}')
		detect(when(signal > ${var.io_consumption_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.io_consumption_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.io_consumption_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.io_consumption_disabled_critical, var.io_consumption_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.io_consumption_notifications_critical, var.io_consumption_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.io_consumption_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.io_consumption_disabled_warning, var.io_consumption_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.io_consumption_notifications_warning, var.io_consumption_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "memory_usage" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure mysql server memory usage"

	program_text = <<-EOF
		signal = data('memory_percent', filter=filter('resource_type', 'Microsoft.DBforMySQL/servers) and ${module.filter-tags.filter_custom})${var.memory_usage_aggregation_function}.${var.memory_usage_transformation_function}(over='${var.memory_usage_transformation_window}')
		detect(when(signal > ${var.memory_usage_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.memory_usage_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.memory_usage_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.memory_usage_disabled_critical, var.memory_usage_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.memory_usage_notifications_critical, var.memory_usage_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.memory_usage_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.memory_usage_disabled_warning, var.memory_usage_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.memory_usage_notifications_warning, var.memory_usage_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}
