resource "signalfx_detector" "sending_operations" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] GCP Pub/Sub Topic sending messages operations"

  program_text = <<-EOF
    reserved_topics = (not filter('topic_id', 'container-analysis-occurrences*', 'container-analysis-notes*', 'cloud-builds', 'gcr'))
    signal = data('topic/send_message_operation_count', filter=filter('monitored_resource', 'pubsub_topic') and reserved_topics and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.sending_operations_aggregation_function}${var.sending_operations_transformation_function}.publish('signal')
    detect(when(signal < ${var.sending_operations_threshold_warning})).publish('WARN')
EOF

  rule {
    description           = "are too low < ${var.sending_operations_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.sending_operations_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.sending_operations_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "unavailable_sending_operations" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] GCP Pub/Sub Topic sending unavailable messages"

  program_text = <<-EOF
    reserved_topics = (not filter('topic_id', 'container-analysis-occurrences*', 'container-analysis-notes*', 'cloud-builds', 'gcr'))
    signal = data('topic/send_message_operation_count', filter=filter('monitored_resource', 'pubsub_topic') and reserved_topics and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.unavailable_sending_operations_aggregation_function}${var.unavailable_sending_operations_transformation_function}.publish('signal')
    detect(when(signal > ${var.unavailable_sending_operations_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.unavailable_sending_operations_threshold_warning}) and when(signal <= ${var.unavailable_sending_operations_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "are too high > ${var.unavailable_sending_operations_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.unavailable_sending_operations_disabled_critical, var.unavailable_sending_operations_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.unavailable_sending_operations_notifications_critical, var.unavailable_sending_operations_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too high > ${var.unavailable_sending_operations_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.unavailable_sending_operations_disabled_warning, var.unavailable_sending_operations_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.unavailable_sending_operations_notifications_warning, var.unavailable_sending_operations_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "unavailable_sending_operations_ratio" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] GCP Pub/Sub Topic sending unavailable messages ratio"

  program_text = <<-EOF
    reserved_topics = (not filter('topic_id', 'container-analysis-occurrences*', 'container-analysis-notes*', 'cloud-builds', 'gcr'))
    A = data('topic/send_message_operation_count', filter=filter('monitored_resource', 'pubsub_topic') and filter('response_code', 'unavailable') and reserved_topics and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.unavailable_sending_operations_ratio_aggregation_function}${var.unavailable_sending_operations_ratio_transformation_function}
    B = data('topic/send_message_operation_count', filter=filter('monitored_resource', 'pubsub_topic') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.unavailable_sending_operations_ratio_aggregation_function}${var.unavailable_sending_operations_ratio_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > ${var.unavailable_sending_operations_ratio_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.unavailable_sending_operations_ratio_threshold_warning}) and when(signal <= ${var.unavailable_sending_operations_ratio_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high >= ${var.unavailable_sending_operations_ratio_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.unavailable_sending_operations_ratio_disabled_critical, var.unavailable_sending_operations_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.unavailable_sending_operations_ratio_notifications_critical, var.unavailable_sending_operations_ratio_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high >= ${var.unavailable_sending_operations_ratio_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.unavailable_sending_operations_ratio_disabled_warning, var.unavailable_sending_operations_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.unavailable_sending_operations_ratio_notifications_warning, var.unavailable_sending_operations_ratio_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

