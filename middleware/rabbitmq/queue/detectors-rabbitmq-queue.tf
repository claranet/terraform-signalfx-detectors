resource "signalfx_detector" "messages_ready" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] RabbitMQ Queue messages ready"

  program_text = <<-EOF
        signal = data('gauge.queue.messages_ready', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.messages_ready_aggregation_function}.${var.messages_ready_transformation_function}(over='${var.messages_ready_transformation_window}').publish('signal')
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
        signal = data('gauge.queue.messages_unacknowledged', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.messages_unacknowledged_aggregation_function}.${var.messages_unacknowledged_transformation_function}(over='${var.messages_unacknowledged_transformation_window}').publish('signal')
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
        rate = data('counter.queue.message_stats.ack', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.messages_ack_rate_aggregation_function}.publish('rate')
        msg = data('gauge.queue.messages', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.messages_ack_rate_aggregation_function}.publish('msg', enable=False)
        detect((when((rate >= 0) and (rate <= threshold(${var.messages_ack_rate_threshold_critical}) and (msg > 0)), lasting='${var.messages_ack_rate_duration}'))).publish('CRIT')
        detect((when((rate >= ${var.messages_ack_rate_threshold_critical}) and (rate <= threshold(${var.messages_ack_rate_threshold_warning}) and (msg > 0)), lasting='${var.messages_ack_rate_duration}'))).publish('WARN')
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

resource "signalfx_detector" "consumer_utilisation" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] RabbitMQ Queue consumer utilisation"

  program_text = <<-EOF
        util = data('gauge.queue.consumer_utilisation', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.consumer_utilisation_aggregation_function}.publish('util')
        msg = data('gauge.queue.messages', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.consumer_utilisation_aggregation_function}.publish('msg')
        detect((when((util < threshold(${var.consumer_utilisation_threshold_critical}) and (msg > 0)), lasting='${var.consumer_utilisation_duration}'))).publish('CRIT')
        detect((when((util < threshold(${var.consumer_utilisation_threshold_warning}) and (msg > 0)), lasting='${var.consumer_utilisation_duration}'))).publish('WARN')
  EOF

  rule {
    description           = format("is too low < %s, consumers seems too slow", var.consumer_utilisation_threshold_critical)
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.consumer_utilisation_disabled_critical, var.consumer_utilisation_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.consumer_utilisation_notifications_critical, var.consumer_utilisation_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = format("is too low < %s, consumers seems too slow", var.consumer_utilisation_threshold_warning)
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.consumer_utilisation_disabled_warning, var.consumer_utilisation_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.consumer_utilisation_notifications_warning, var.consumer_utilisation_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
