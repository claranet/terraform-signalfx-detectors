resource "signalfx_detector" "heartbeat" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure sql elasticpools heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('database_cpu_percent', filter=filter('resource_type', 'Microsoft.Sql/servers/elasticPools') and ${module.filter-tags.filter_custom}).publish('signal')
		not_reporting.detector(stream=signal, resource_identifier=['DatabaseResourceId'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "cpu" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure sql elasticpools CPU"

	program_text = <<-EOF
		signal = data('cpu_percent', filter=filter('resource_type', 'Microsoft.Sql/servers/elasticPools') and ${module.filter-tags.filter_custom})${var.cpu_aggregation_function}.${var.cpu_transformation_function}(over='${var.cpu_transformation_window}').publish('signal')
		detect(when(signal > ${var.cpu_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.cpu_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.cpu_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.cpu_disabled_critical, var.cpu_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.cpu_notifications_critical, var.cpu_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.cpu_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.cpu_disabled_warning, var.cpu_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.cpu_notifications_warning, var.cpu_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "free_space" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure sql elasticpools disk usage"

	program_text = <<-EOF
		signal = data('storage_percent', filter=filter('resource_type', 'Microsoft.Sql/servers/elasticPools') and ${module.filter-tags.filter_custom})${var.free_space_aggregation_function}.${var.free_space_transformation_function}(over='${var.free_space_transformation_window}').publish('signal')
		detect(when(signal > ${var.free_space_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.free_space_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.free_space_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.free_space_disabled_critical, var.free_space_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.free_space_notifications_critical, var.free_space_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.free_space_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.free_space_disabled_warning, var.free_space_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.free_space_notifications_warning, var.free_space_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "dtu_consumption" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure sql elasticpools DTU Consumption"

	program_text = <<-EOF
		signal = data('dtu_consumption_percent', filter=filter('resource_type', 'Microsoft.Sql/servers/elasticPools') and ${module.filter-tags.filter_custom})${var.dtu_consumption_aggregation_function}.${var.dtu_consumption_transformation_function}(over='${var.dtu_consumption_transformation_window}').publish('signal')
		detect(when(signal > ${var.dtu_consumption_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.dtu_consumption_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.dtu_consumption_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.dtu_consumption_disabled_critical, var.dtu_consumption_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.dtu_consumption_notifications_critical, var.dtu_consumption_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.dtu_consumption_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.dtu_consumption_disabled_warning, var.dtu_consumption_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.dtu_consumption_notifications_warning, var.dtu_consumption_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}
