resource "signalfx_detector" "heartbeat" {
    name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure API Management heartbeat"

    program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        signal = data('Duration', filter=filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true') and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stoppped', 'PowerState/deallocating', 'PowerState/deallocated')) and ${module.filter-tags.filter_custom}).publish('signal')
        not_reporting.detector(stream=signal, resource_identifier=['hostname'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "failed_requests" {
    name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure API Management failed request rate"

    program_text = <<-EOF
        from signalfx.detectors.aperiodic import conditions
        A = data('EventHubTotalFailedEvents', filter=filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.failed_requests_aggregation_function}
        B = data('EventHubTotalEvents', filter=filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.failed_requests_aggregation_function}
        signal = ((A/B)*100).${var.failed_requests_transformation_function}(over='${var.failed_requests_transformation_window}').publish('signal')
        ON_Condition_CRIT = conditions.generic_condition(signal, ${var.failed_requests_threshold_critical}, ${var.failed_requests_threshold_critical}, 'above', lasting('${var.failed_requests_aperiodic_duration}', ${var.failed_requests_aperiodic_percentage}), 'observed')
	ON_Condition_WARN = conditions.generic_condition(signal, ${var.failed_requests_threshold_warning}, ${var.failed_requests_threshold_critical}, 'within_range', lasting('${var.failed_requests_aperiodic_duration}', ${var.failed_requests_aperiodic_percentage}), 'observed', strict_2=False)
	detect(ON_Condition_CRIT, off=when(signal is None, '${var.failed_requests_clear_duration}')).publish('CRIT')
	detect(ON_Condition_WARN, off=when(signal is None, '${var.failed_requests_clear_duration}')).publish('WARN')
    EOF

    rule {
        description           = "is too high > ${var.failed_requests_threshold_critical}"
        severity              = "Critical"
        detect_label          = "CRIT"
        disabled              = coalesce(var.failed_requests_disabled_critical, var.failed_requests_disabled, var.detectors_disabled)
        notifications         = coalescelist(var.failed_requests_notifications_critical, var.failed_requests_notifications, var.notifications)
        parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    }

    rule {
        description           = "is too high > ${var.failed_requests_threshold_warning}"
        severity              = "Warning"
        detect_label          = "WARN"
        disabled              = coalesce(var.failed_requests_disabled_warning, var.failed_requests_disabled, var.detectors_disabled)
        notifications         = coalescelist(var.failed_requests_notifications_warning, var.failed_requests_notifications, var.notifications)
        parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    }
}

resource "signalfx_detector" "other_requests" {
    name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure API Management other non successful request rate"

    program_text = <<-EOF
        from signalfx.detectors.aperiodic import conditions
        A = data('EventHubThrottledEvents', filter=filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.other_requests_aggregation_function}
        B = data('EventHubTimedoutEvents', filter=filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.other_requests_aggregation_function}
        C = data('EventHubDroppedEvents', filter=filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.other_requests_aggregation_function}
        D = data('EventHubTotalEvents', filter=filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.other_requests_aggregation_function}
        signal = (((A+B+C)/D)*100).${var.other_requests_transformation_function}(over='${var.other_requests_transformation_window}').publish('signal')
        ON_Condition_CRIT = conditions.generic_condition(signal, ${var.other_requests_threshold_critical}, ${var.other_requests_threshold_critical}, 'above', lasting('${var.other_requests_aperiodic_duration}', ${var.other_requests_aperiodic_percentage}), 'observed')
	ON_Condition_WARN = conditions.generic_condition(signal, ${var.other_requests_threshold_warning}, ${var.other_requests_threshold_critical}, 'within_range', lasting('${var.other_requests_aperiodic_duration}', ${var.other_requests_aperiodic_percentage}), 'observed', strict_2=False)
	detect(ON_Condition_CRIT, off=when(signal is None, '${var.other_requests_clear_duration}')).publish('CRIT')
	detect(ON_Condition_WARN, off=when(signal is None, '${var.other_requests_clear_duration}')).publish('WARN')
    EOF

    rule {
        description           = "is too high > ${var.other_requests_threshold_critical}"
        severity              = "Critical"
        detect_label          = "CRIT"
        disabled              = coalesce(var.other_requests_disabled_critical, var.other_requests_disabled, var.detectors_disabled)
        notifications         = coalescelist(var.other_requests_notifications_critical, var.other_requests_notifications, var.notifications)
        parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    }

    rule {
        description           = "is too high > ${var.other_requests_threshold_warning}"
        severity              = "Warning"
        detect_label          = "WARN"
        disabled              = coalesce(var.other_requests_disabled_warning, var.other_requests_disabled, var.detectors_disabled)
        notifications         = coalescelist(var.other_requests_notifications_warning, var.other_requests_notifications, var.notifications)
        parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    }
}

resource "signalfx_detector" "unauthorized_requests" {
    name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure API Management unauthorized request rate"

    program_text = <<-EOF
        from signalfx.detectors.aperiodic import conditions
        A = data('EventHubRejectedEvents', filter=filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.unauthorized_requests_aggregation_function}
        B = data('EventHubTotalEvents', filter=filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.unauthorized_requests_aggregation_function}
        signal = ((A/B)*100).${var.unauthorized_requests_transformation_function}(over='${var.unauthorized_requests_transformation_window}').publish('signal')
        ON_Condition_CRIT = conditions.generic_condition(signal, ${var.unauthorized_requests_threshold_critical}, ${var.unauthorized_requests_threshold_critical}, 'above', lasting('${var.unauthorized_requests_aperiodic_duration}', ${var.unauthorized_requests_aperiodic_percentage}), 'observed')
	ON_Condition_WARN = conditions.generic_condition(signal, ${var.unauthorized_requests_threshold_warning}, ${var.unauthorized_requests_threshold_critical}, 'within_range', lasting('${var.unauthorized_requests_aperiodic_duration}', ${var.unauthorized_requests_aperiodic_percentage}), 'observed', strict_2=False)
	detect(ON_Condition_CRIT, off=when(signal is None, '${var.unauthorized_requests_clear_duration}')).publish('CRIT')
	detect(ON_Condition_WARN, off=when(signal is None, '${var.unauthorized_requests_clear_duration}')).publish('WARN')
    EOF

    rule {
        description           = "is too high > ${var.unauthorized_requests_threshold_critical}"
        severity              = "Critical"
        detect_label          = "CRIT"
        disabled              = coalesce(var.unauthorized_requests_disabled_critical, var.unauthorized_requests_disabled, var.detectors_disabled)
        notifications         = coalescelist(var.unauthorized_requests_notifications_critical, var.unauthorized_requests_notifications, var.notifications)
        parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    }

    rule {
        description           = "is too high > ${var.unauthorized_requests_threshold_warning}"
        severity              = "Warning"
        detect_label          = "WARN"
        disabled              = coalesce(var.unauthorized_requests_disabled_warning, var.unauthorized_requests_disabled, var.detectors_disabled)
        notifications         = coalescelist(var.unauthorized_requests_notifications_warning, var.unauthorized_requests_notifications, var.notifications)
        parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    }
}

resource "signalfx_detector" "successful_requests" {
    name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure API Management successful request rate"

    program_text = <<-EOF
        A = data('EventHubSuccessfulEvents', filter=filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.successful_requests_aggregation_function}
        B = data('EventHubTotalEvents', filter=filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.successful_requests_aggregation_function}
        signal = ((A/B)*100).fill(100).${var.successful_requests_transformation_function}(over='${var.successful_requests_transformation_window}').publish('signal')
        detect(when(signal < ${var.successful_requests_threshold_critical})).publish('CRIT')
        detect(when(signal < ${var.successful_requests_threshold_warning}) and when(signal >= ${var.successful_requests_threshold_critical})).publish('WARN')
    EOF

    rule {
        description           = "is too low < ${var.successful_requests_threshold_critical}"
        severity              = "Critical"
        detect_label          = "CRIT"
        disabled              = coalesce(var.successful_requests_disabled_critical, var.successful_requests_disabled, var.detectors_disabled)
        notifications         = coalescelist(var.successful_requests_notifications_critical, var.successful_requests_notifications, var.notifications)
        parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    }

    rule {
        description           = "is too low < ${var.successful_requests_threshold_warning}"
        severity              = "Warning"
        detect_label          = "WARN"
        disabled              = coalesce(var.successful_requests_disabled_warning, var.successful_requests_disabled, var.detectors_disabled)
        notifications         = coalescelist(var.successful_requests_notifications_warning, var.successful_requests_notifications, var.notifications)
        parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    }
}
