resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Event Grid heartbeat"

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('DeliverySuccessCount', filter=filter('resource_type', 'Microsoft.EventGrid/topics') and filter('primary_aggregation_type', 'true') and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stoppped', 'PowerState/deallocating', 'PowerState/deallocated')) and ${module.filter-tags.filter_custom}).publish('signal')
		not_reporting.detector(stream=signal, resource_identifier=['EventSubscriptionName'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "no_successful_message" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Event Grid no successful message"

  program_text = <<-EOF
		signal = data('PublishSuccessCount', filter=filter('resource_type', 'Microsoft.EventGrid/topics')and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.no_successful_message_aggregation_function}.${var.no_successful_message_transformation_function}(over='${var.no_successful_message_transformation_window}').publish('signal')
		detect(when(signal < ${var.no_successful_message_threshold_critical})).publish('CRIT')
  EOF

  rule {
    description           = "is too low < ${var.no_successful_message_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.no_successful_message_disabled_critical, var.no_successful_message_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.no_successful_message_notifications_critical, var.no_successful_message_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "failed_messages" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Event Grid failed message rate"

  program_text = <<-EOF
		from signalfx.detectors.aperiodic import conditions
		A = data('PublishFailCount', filter=filter('resource_type', 'Microsoft.EventGrid/topics') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.failed_messages_aggregation_function}
		B = data('PublishSuccessCount', filter=filter('resource_type', 'Microsoft.EventGrid/topics') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.failed_messages_aggregation_function}
		C = data('UnmatchedEventCount', filter=filter('resource_type', 'Microsoft.EventGrid/topics') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.failed_messages_aggregation_function}
		signal = ((A/(A+B+C))*100).${var.failed_messages_transformation_function}(over='${var.failed_messages_transformation_window}').publish('signal')
		ON_Condition_CRIT = conditions.generic_condition(signal, ${var.failed_messages_threshold_critical}, ${var.failed_messages_threshold_critical}, 'above', lasting('${var.failed_messages_aperiodic_duration}', ${var.failed_messages_aperiodic_percentage}), 'observed')
		ON_Condition_WARN = conditions.generic_condition(signal, ${var.failed_messages_threshold_warning}, ${var.failed_messages_threshold_critical}, 'within_range', lasting('${var.failed_messages_aperiodic_duration}', ${var.failed_messages_aperiodic_percentage}), 'observed', strict_2=False)
		detect(ON_Condition_CRIT, off=when(signal is None, '${var.failed_messages_clear_duration}') or not ON_Condition_CRIT, mode='split').publish('CRIT')
		detect(ON_Condition_WARN, off=when(signal is None, '${var.failed_messages_clear_duration}') or not ON_Condition_WARN, mode='split').publish('WARN')
  EOF

  rule {
    description           = "is too high > ${var.failed_messages_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.failed_messages_disabled_critical, var.failed_messages_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.failed_messages_notifications_critical, var.failed_messages_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.failed_messages_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.failed_messages_disabled_warning, var.failed_messages_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.failed_messages_notifications_warning, var.failed_messages_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "unmatched_events" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Event Grid unmatched event rate"

  program_text = <<-EOF
		from signalfx.detectors.aperiodic import conditions
		A = data('UnmatchedEventCount', filter=filter('resource_type', 'Microsoft.EventGrid/topics') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.unmatched_events_aggregation_function}
		B = data('PublishSuccessCount', filter=filter('resource_type', 'Microsoft.EventGrid/topics') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.unmatched_events_aggregation_function}
		C = data('PublishFailCount', filter=filter('resource_type', 'Microsoft.EventGrid/topics') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.unmatched_events_aggregation_function}
		signal = ((A/(A+B+C))*100).${var.unmatched_events_transformation_function}(over='${var.unmatched_events_transformation_window}').publish('signal')
		ON_Condition_CRIT = conditions.generic_condition(signal, ${var.unmatched_events_threshold_critical}, ${var.unmatched_events_threshold_critical}, 'above', lasting('${var.unmatched_events_aperiodic_duration}', ${var.unmatched_events_aperiodic_percentage}), 'observed')
		ON_Condition_WARN = conditions.generic_condition(signal, ${var.unmatched_events_threshold_warning}, ${var.unmatched_events_threshold_critical}, 'within_range', lasting('${var.unmatched_events_aperiodic_duration}', ${var.unmatched_events_aperiodic_percentage}), 'observed', strict_2=False)
		detect(ON_Condition_CRIT, off=when(signal is None, '${var.unmatched_events_clear_duration}') or not ON_Condition_CRIT, mode='split').publish('CRIT')
		detect(ON_Condition_WARN, off=when(signal is None, '${var.unmatched_events_clear_duration}') or not ON_Condition_WARN, mode='split').publish('WARN')
  EOF

  rule {
    description           = "is too high > ${var.unmatched_events_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.unmatched_events_disabled_critical, var.unmatched_events_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.unmatched_events_notifications_critical, var.unmatched_events_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.unmatched_events_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.unmatched_events_disabled_warning, var.unmatched_events_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.unmatched_events_notifications_warning, var.unmatched_events_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
