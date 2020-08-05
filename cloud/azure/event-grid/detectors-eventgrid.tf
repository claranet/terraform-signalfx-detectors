resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Event Grid heartbeat"

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.EventGrid/topics') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        signal = data('DeliverySuccessCount', filter=base_filter).publish('signal')
        not_reporting.detector(stream=signal, resource_identifier=['azure_resource_name', 'azure_resource_group_name'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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
        base_filter = filter('resource_type', 'Microsoft.EventGrid/topics') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        signal = data('PublishSuccessCount', filter=base_filter)${var.no_successful_message_aggregation_function}.publish('signal')
        detect(when(signal < threshold(${var.no_successful_message_threshold_critical}), lasting="${var.no_successful_message_timer}")).publish('CRIT')
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
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Event Grid failed messages rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.EventGrid/topics') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('PublishFailCount', extrapolation='zero', filter=base_filter)${var.failed_messages_aggregation_function}
        B = data('PublishSuccessCount', extrapolation='zero', filter=base_filter)${var.failed_messages_aggregation_function}
        C = data('UnmatchedEventCount', extrapolation='zero', filter=base_filter)${var.failed_messages_aggregation_function}
        signal = (A/(A+B+C)).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.failed_messages_threshold_critical}), lasting="${var.failed_messages_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.failed_messages_threshold_warning}), lasting="${var.failed_messages_timer}") and when(signal <= ${var.failed_messages_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.failed_messages_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.failed_messages_disabled_critical, var.failed_messages_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.failed_messages_notifications_critical, var.failed_messages_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.failed_messages_threshold_warning}%"
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
        base_filter = filter('resource_type', 'Microsoft.EventGrid/topics') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('PublishFailCount', extrapolation='zero', filter=base_filter)${var.unmatched_events_aggregation_function}
        B = data('PublishSuccessCount', extrapolation='zero', filter=base_filter)${var.unmatched_events_aggregation_function}
        C = data('UnmatchedEventCount', extrapolation='zero', filter=base_filter)${var.unmatched_events_aggregation_function}
        signal = (C/(A+B+C)).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.unmatched_events_threshold_critical}), lasting="${var.unmatched_events_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.unmatched_events_threshold_warning}), lasting="${var.unmatched_events_timer}") and when(signal <= ${var.unmatched_events_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.unmatched_events_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.unmatched_events_disabled_critical, var.unmatched_events_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.unmatched_events_notifications_critical, var.unmatched_events_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.unmatched_events_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.unmatched_events_disabled_warning, var.unmatched_events_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.unmatched_events_notifications_warning, var.unmatched_events_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
