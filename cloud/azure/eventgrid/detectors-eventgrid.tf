resource "signalfx_detector" "heartbeat" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure eventgrid heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('DeliverySuccessCount', filter=filter('resource_type', 'Microsoft.EventGrid/topics') and ${module.filter-tags.filter_custom}).publish('signal')
		not_reporting.detector(stream=signal, resource_identifier=['EventSubscriptionName'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "no_successful_message" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure eventgrid successful message"

	program_text = <<-EOF
		signal = data('PublishSuccessCount', filter=filter('resource_type', 'Microsoft.EventGrid/topics')and ${module.filter-tags.filter_custom})${var.no_successful_message_aggregation_function}.${var.no_successful_message_transformation_function}(over='${var.no_successful_message_transformation_window}').publish('signal')
		detect(when(signal < ${var.no_successful_message_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description           = "is too low < ${var.no_successful_message_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.no_successful_message_disabled_critical, var.no_successful_message_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.no_successful_message_notifications_critical, var.no_successful_message_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "failed_messages" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure eventgrid failed messages"

	program_text = <<-EOF
		from signalfx.detectors.aperiodic import aperiodic
		A = data('PublishFailCount', filter=filter('resource_type', 'Microsoft.EventGrid/topics') and ${module.filter-tags.filter_custom})${var.failed_messages_aggregation_function}
		B = data('PublishSuccessCount', filter=filter('resource_type', 'Microsoft.EventGrid/topics') and ${module.filter-tags.filter_custom})${var.failed_messages_aggregation_function}
		C = data('UnmatchedEventCount', filter=filter('resource_type', 'Microsoft.EventGrid/topics') and ${module.filter-tags.filter_custom})${var.failed_messages_aggregation_function}
		signal = ((A/(A+B+C))*100).${var.failed_messages_transformation_function}(over='${var.failed_messages_transformation_window}').publish('signal')
		aperiodic.above_or_below_detector(signal, ${var.failed_messages_threshold_critical}, 'above', lasting('${var.failed_messages_aperiodic_duration}', ${var.failed_messages_aperiodic_percentage})).publish('CRIT')
		aperiodic.above_or_below_detector(signal, ${var.failed_messages_threshold_warning}, 'above', lasting('${var.failed_messages_aperiodic_duration}', ${var.failed_messages_aperiodic_percentage})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.failed_messages_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.failed_messages_disabled_critical, var.failed_messages_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.failed_messages_notifications_critical, var.failed_messages_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.failed_messages_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.failed_messages_disabled_warning, var.failed_messages_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.failed_messages_notifications_warning, var.failed_messages_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "unmatched_events" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure eventgrid unmatched events"

	program_text = <<-EOF
		from signalfx.detectors.aperiodic import aperiodic
		A = data('UnmatchedEventCount', filter=filter('resource_type', 'Microsoft.EventGrid/topics') and ${module.filter-tags.filter_custom})${var.unmatched_events_aggregation_function}
		B = data('PublishSuccessCount', filter=filter('resource_type', 'Microsoft.EventGrid/topics') and ${module.filter-tags.filter_custom})${var.unmatched_events_aggregation_function}
		C = data('PublishFailCount', filter=filter('resource_type', 'Microsoft.EventGrid/topics') and ${module.filter-tags.filter_custom})${var.unmatched_events_aggregation_function}
		signal = ((A/(A+B+C))*100).${var.unmatched_events_transformation_function}(over='${var.unmatched_events_transformation_window}').publish('signal')
		aperiodic.above_or_below_detector(signal, ${var.unmatched_events_threshold_critical}, 'above', lasting('${var.unmatched_events_aperiodic_duration}', ${var.unmatched_events_aperiodic_percentage})).publish('CRIT')
		aperiodic.above_or_below_detector(signal, ${var.unmatched_events_threshold_warning}, 'above', lasting('${var.unmatched_events_aperiodic_duration}', ${var.unmatched_events_aperiodic_percentage})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.unmatched_events_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.unmatched_events_disabled_critical, var.unmatched_events_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.unmatched_events_notifications_critical, var.unmatched_events_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.unmatched_events_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.unmatched_events_disabled_warning, var.unmatched_events_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.unmatched_events_notifications_warning, var.unmatched_events_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{ruleName}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}
