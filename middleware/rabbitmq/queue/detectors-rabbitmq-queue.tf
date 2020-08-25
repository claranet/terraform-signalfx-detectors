resource "signalfx_detector" "messages_ready" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] RabbitMQ Queue messages ready"

  program_text = <<-EOF
    signal = data('gauge.queue.messages_ready', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.messages_ready_aggregation_function}${var.messages_ready_transformation_function}.publish('signal')
    detect(when(signal > ${var.messages_ready_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.messages_ready_threshold_warning}) and when(signal <= ${var.messages_ready_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.messages_ready_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.messages_ready_disabled_critical, var.messages_ready_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.messages_ready_notifications_critical, var.messages_ready_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.messages_ready_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.messages_ready_disabled_warning, var.messages_ready_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.messages_ready_notifications_warning, var.messages_ready_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "messages_unacknowledged" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] RabbitMQ Queue messages unacknowledged"

  program_text = <<-EOF
    signal = data('gauge.queue.messages_unacknowledged', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.messages_unacknowledged_aggregation_function}${var.messages_unacknowledged_transformation_function}.publish('signal')
    detect(when(signal > ${var.messages_unacknowledged_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.messages_unacknowledged_threshold_warning}) and when(signal <= ${var.messages_unacknowledged_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.messages_unacknowledged_disabled_critical, var.messages_unacknowledged_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.messages_unacknowledged_notifications_critical, var.messages_unacknowledged_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.messages_unacknowledged_disabled_warning, var.messages_unacknowledged_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.messages_unacknowledged_notifications_warning, var.messages_unacknowledged_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "messages_ack_rate" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] RabbitMQ Queue messages ack rate"

  program_text = <<-EOF
    signal = data('counter.queue.message_stats.ack', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.messages_ack_rate_aggregation_function}.publish('signal')
    msg = data('gauge.queue.messages', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.messages_ack_rate_aggregation_function}
    detect((when((signal >= 0) and (signal <= threshold(${var.messages_ack_rate_threshold_critical}) and (msg > 0)), lasting='${var.messages_ack_rate_lasting_duration_seconds}s', at_least=${var.messages_ack_rate_at_least_percentage}))).publish('CRIT')
    detect((when((signal >= ${var.messages_ack_rate_threshold_critical}) and (signal <= threshold(${var.messages_ack_rate_threshold_warning}) and (msg > 0)), lasting='${var.messages_ack_rate_lasting_duration_seconds}s', at_least=${var.messages_ack_rate_at_least_percentage}))).publish('WARN')
EOF

  rule {
    description           = format("is too low < %s and there are ready or unack messages", var.messages_ack_rate_threshold_critical)
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.messages_ack_rate_disabled_critical, var.messages_ack_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.messages_ack_rate_notifications_critical, var.messages_ack_rate_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = format("is too low < %s and there are ready or unack messages", var.messages_ack_rate_threshold_warning)
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.messages_ack_rate_disabled_warning, var.messages_ack_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.messages_ack_rate_notifications_warning, var.messages_ack_rate_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "consumer_use" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] RabbitMQ Queue consumer use"

  program_text = <<-EOF
    signal = data('gauge.queue.consumer_use', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.consumer_use_aggregation_function}.publish('util')
    msg = data('gauge.queue.messages', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.consumer_use_aggregation_function}
    detect((when((signal < threshold(${var.consumer_use_threshold_critical}) and (msg > 0)), lasting='${var.consumer_use_lasting_duration_seconds}s', at_least=${var.consumer_use_at_least_percentage}))).publish('CRIT')
    detect((when((signal < threshold(${var.consumer_use_threshold_warning}) and (msg > 0)), lasting='${var.consumer_use_lasting_duration_seconds}s', at_least=${var.consumer_use_at_least_percentage}))).publish('WARN')
EOF

  rule {
    description           = format("is too low < %s, consumers seems too slow", var.consumer_use_threshold_critical)
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.consumer_use_disabled_critical, var.consumer_use_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.consumer_use_notifications_critical, var.consumer_use_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = format("is too low < %s, consumers seems too slow", var.consumer_use_threshold_warning)
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.consumer_use_disabled_warning, var.consumer_use_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.consumer_use_notifications_warning, var.consumer_use_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

