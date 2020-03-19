resource "signalfx_detector" "heartbeat" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure cosmosdb heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDB/databaseAccounts') and ${module.filter-tags.filter_custom})
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

resource "signalfx_detector" "4xx_requests" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure cosmodb 4xx requests rate"

	program_text = <<-EOF
		A = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '400') and ${module.filter-tags.filter_custom})${var.4xx_requests_aggregation_function}
		B = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '401') and ${module.filter-tags.filter_custom})${var.4xx_requests_aggregation_function}
		C = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '403') and ${module.filter-tags.filter_custom})${var.4xx_requests_aggregation_function}
		D = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '404') and ${module.filter-tags.filter_custom})${var.4xx_requests_aggregation_function}
		E = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '408') and ${module.filter-tags.filter_custom})${var.4xx_requests_aggregation_function}
		F = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '409') and ${module.filter-tags.filter_custom})${var.4xx_requests_aggregation_function}
		G = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '412') and ${module.filter-tags.filter_custom})${var.4xx_requests_aggregation_function}
		H = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '413') and ${module.filter-tags.filter_custom})${var.4xx_requests_aggregation_function}
		I = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '429') and ${module.filter-tags.filter_custom})${var.4xx_requests_aggregation_function}
		J = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '449') and ${module.filter-tags.filter_custom})${var.4xx_requests_aggregation_function}
		K = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and ${module.filter-tags.filter_custom})${var.4xx_requests_aggregation_function}
		signal = (((A+B+C+D+E+F+G+H+I+J)/K)*100).${var.4xx_requests_transformation_function}(over='${var.4xx_requests_transformation_window}')
		detect(when(signal > ${var.4xx_requests_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.4xx_requests_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.4xx_requests_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.4xx_requests_disabled_critical, var.4xx_requests_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.4xx_requests_notifications_critical, var.4xx_requests_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.4xx_requests_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.4xx_requests_disabled_warning, var.4xx_requests_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.4xx_requests_notifications_warning, var.4xx_requests_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "5xx_requests" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure cosmodb 5xx requests rate"

	program_text = <<-EOF
		A = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '500') and ${module.filter-tags.filter_custom})${var.5xx_requests_aggregation_function}
		B = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '503') and ${module.filter-tags.filter_custom})${var.5xx_requests_aggregation_function}
		C = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and ${module.filter-tags.filter_custom})${var.5xx_requests_aggregation_function}
		signal = (((A+B)/C)*100).${var.5xx_requests_transformation_function}(over='${var.5xx_requests_transformation_window}')
		detect(when(signal > ${var.5xx_requests_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.5xx_requests_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.5xx_requests_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.5xx_requests_disabled_critical, var.5xx_requests_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.5xx_requests_notifications_critical, var.5xx_requests_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.5xx_requests_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.5xx_requests_disabled_warning, var.5xx_requests_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.5xx_requests_notifications_warning, var.5xx_requests_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "scaling" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure cosmodb max scaling"

	program_text = <<-EOF
		A = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '429') and ${module.filter-tags.filter_custom})${var.scaling_aggregation_function}
		B = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and ${module.filter-tags.filter_custom})${var.scaling_aggregation_function}
		signal = ((A/B)*100).${var.scaling_transformation_function}(over='${var.scaling_transformation_window}')
		detect(when(signal > ${var.scaling_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.scaling_threshold_warning})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.scaling_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.scaling_disabled_critical, var.scaling_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.scaling_notifications_critical, var.scaling_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.scaling_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.scaling_disabled_warning, var.scaling_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.scaling_notifications_warning, var.scaling_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}
