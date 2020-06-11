resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS SQS heartbeat"

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('NumberOfMessagesReceived', filter=filter('stat', 'mean') and filter('namespace', 'AWS/SQS') and ${module.filter-tags.filter_custom}).publish('signal')
		not_reporting.detector(stream=signal, resource_identifier=['QueueName'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "visible_messages" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS SQS Visible messages"

  program_text = <<-EOF
		signal = data('ApproximateNumberOfMessagesVisible', filter=filter('namespace', 'AWS/SQS')and filter('stat', 'upper') and ${module.filter-tags.filter_custom})${var.visible_messages_aggregation_function}.${var.visible_messages_transformation_function}(over='${var.visible_messages_transformation_window}').publish('signal')
		detect(when(signal > ${var.visible_messages_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.visible_messages_threshold_warning}) and when(signal <= ${var.visible_messages_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = "are too high > ${var.visible_messages_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.visible_messages_disabled_critical, var.visible_messages_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.visible_messages_notifications_critical, var.visible_messages_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too high > ${var.visible_messages_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.visible_messages_disabled_warning, var.visible_messages_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.visible_messages_notifications_warning, var.visible_messages_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "age_of_oldest_message" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS SQS Age of the oldest message"

  program_text = <<-EOF
		signal = data('ApproximateAgeOfOldestMessage', filter=filter('namespace', 'AWS/SQS') and filter('stat', 'upper') and ${module.filter-tags.filter_custom})${var.age_of_oldest_message_aggregation_function}.${var.age_of_oldest_message_transformation_function}(over='${var.age_of_oldest_message_transformation_window}').publish('signal')
		detect(when(signal > ${var.age_of_oldest_message_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.age_of_oldest_message_threshold_warning}) and when(signal <= ${var.age_of_oldest_message_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = "is too old > ${var.age_of_oldest_message_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.age_of_oldest_message_disabled_critical, var.age_of_oldest_message_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.age_of_oldest_message_notifications_critical, var.age_of_oldest_message_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too old > ${var.age_of_oldest_message_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.age_of_oldest_message_disabled_warning, var.age_of_oldest_message_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.age_of_oldest_message_notifications_warning, var.age_of_oldest_message_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}
