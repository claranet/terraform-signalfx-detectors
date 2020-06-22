resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Event Hubs heartbeat"

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('IncomingRequests', filter=filter('resource_type', 'Microsoft.EventHub/namespace') and filter('primary_aggregation_type', 'true') and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stoppped', 'PowerState/deallocating', 'PowerState/deallocated')) and ${module.filter-tags.filter_custom}).publish('signal')
		not_reporting.detector(stream=signal, resource_identifier=['EntityName'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "eventhub_errors" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Event Hubs failed request rate"

  program_text = <<-EOF
		from signalfx.detectors.aperiodic import conditions
		A = data('IncomingRequests', filter=filter('resource_type', 'Microsoft.EventHub/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.eventhub_errors_aggregation_function}
		B = data('SuccessfulRequests', filter=filter('resource_type', 'Microsoft.EventHub/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.eventhub_errors_aggregation_function}
		signal = (((A-B)/A)*100).${var.eventhub_errors_transformation_function}(over='${var.eventhub_errors_transformation_window}').publish('signal')
		ON_Condition_CRIT = conditions.generic_condition(signal, ${var.eventhub_eventhub_errors_threshold_critical}, ${var.eventhub_eventhub_errors_threshold_critical}, 'above', lasting('${var.eventhub_eventhub_errors_aperiodic_duration}', ${var.eventhub_eventhub_errors_aperiodic_percentage}), 'observed')
		ON_Condition_WARN = conditions.generic_condition(signal, ${var.eventhub_eventhub_errors_threshold_warning}, ${var.eventhub_eventhub_errors_threshold_critical}, 'within_range', lasting('${var.eventhub_eventhub_errors_aperiodic_duration}', ${var.eventhub_eventhub_errors_aperiodic_percentage}), 'observed', strict_2=False)
		detect(ON_Condition_CRIT, off=when(signal is None, '${var.eventhub_eventhub_errors_clear_duration}')).publish('CRIT')
		detect(ON_Condition_WARN, off=when(signal is None, '${var.eventhub_eventhub_errors_clear_duration}')).publish('WARN')
  EOF

  rule {
    description           = "is too high > ${var.eventhub_errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.eventhub_errors_disabled_critical, var.eventhub_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.eventhub_errors_notifications_critical, var.eventhub_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.eventhub_errors_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.eventhub_errors_disabled_warning, var.eventhub_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.eventhub_errors_notifications_warning, var.eventhub_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "eventhub_errors" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Eventh Hubs error rate"

  program_text = <<-EOF
		from signalfx.detectors.aperiodic import conditions
		A = data('ServerErrors', filter=filter('resource_type', 'Microsoft.EventHub/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.eventhub_errors_aggregation_function}
		B = data('UserErrors', filter=filter('resource_type', 'Microsoft.EventHub/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.eventhub_errors_aggregation_function}
		C = data('QuotaExceededErrors', filter=filter('resource_type', 'Microsoft.EventHub/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.eventhub_errors_aggregation_function}
		D = data('IncomingRequests', filter=filter('resource_type', 'Microsoft.EventHub/namespaces') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.eventhub_errors_aggregation_function}
		signal = (((A+B+C)/D)*100).${var.eventhub_errors_transformation_function}(over='${var.eventhub_errors_transformation_window}').publish('signal')
		ON_Condition_CRIT = conditions.generic_condition(signal, ${var.eventhub_errors_threshold_critical}, ${var.eventhub_errors_threshold_critical}, 'above', lasting('${var.eventhub_errors_aperiodic_duration}', ${var.eventhub_errors_aperiodic_percentage}), 'observed')
		ON_Condition_WARN = conditions.generic_condition(signal, ${var.eventhub_errors_threshold_warning}, ${var.eventhub_errors_threshold_critical}, 'within_range', lasting('${var.eventhub_errors_aperiodic_duration}', ${var.eventhub_errors_aperiodic_percentage}), 'observed', strict_2=False)
		detect(ON_Condition_CRIT, off=when(signal is None, '${var.eventhub_errors_clear_duration}')).publish('CRIT')
		detect(ON_Condition_WARN, off=when(signal is None, '${var.eventhub_errors_clear_duration}')).publish('WARN')
  EOF

  rule {
    description           = "is too high > ${var.eventhub_errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.eventhub_errors_disabled_critical, var.eventhub_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.eventhub_errors_notifications_critical, var.eventhub_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.eventhub_errors_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.eventhub_errors_disabled_warning, var.eventhub_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.eventhub_errors_notifications_warning, var.eventhub_errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
