resource "signalfx_detector" "messages_ready" {
  name = format("%s %s", local.detector_name_prefix, "RabbitMQ Queue messages ready")

  program_text = <<-EOF
    signal = data('gauge.queue.messages_ready', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.messages_ready_aggregation_function}${var.messages_ready_transformation_function}.publish('signal')
    detect(when(signal > ${var.messages_ready_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.messages_ready_threshold_major}) and when(signal <= ${var.messages_ready_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.messages_ready_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.messages_ready_disabled_critical, var.messages_ready_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.messages_ready_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.messages_ready_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.messages_ready_disabled_major, var.messages_ready_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.messages_ready_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "messages_unacknowledged" {
  name = format("%s %s", local.detector_name_prefix, "RabbitMQ Queue messages unacknowledged")

  program_text = <<-EOF
    signal = data('gauge.queue.messages_unacknowledged', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.messages_unacknowledged_aggregation_function}${var.messages_unacknowledged_transformation_function}.publish('signal')
    detect(when(signal > ${var.messages_unacknowledged_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.messages_unacknowledged_threshold_major}) and when(signal <= ${var.messages_unacknowledged_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.messages_unacknowledged_disabled_critical, var.messages_unacknowledged_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.messages_unacknowledged_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.messages_unacknowledged_disabled_major, var.messages_unacknowledged_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.messages_unacknowledged_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "messages_ack_rate" {
  name = format("%s %s", local.detector_name_prefix, "RabbitMQ Queue messages ack rate")

  program_text = <<-EOF
    signal = data('counter.queue.message_stats.ack', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.messages_ack_rate_aggregation_function}.publish('signal')
    msg = data('gauge.queue.messages', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.messages_ack_rate_aggregation_function}
    detect((when((signal >= 0) and (signal <= threshold(${var.messages_ack_rate_threshold_critical}) and (msg > 0)), lasting='${var.messages_ack_rate_lasting_duration_seconds}s', at_least=${var.messages_ack_rate_at_least_percentage}))).publish('CRIT')
    detect((when((signal >= ${var.messages_ack_rate_threshold_critical}) and (signal <= threshold(${var.messages_ack_rate_threshold_major}) and (msg > 0)), lasting='${var.messages_ack_rate_lasting_duration_seconds}s', at_least=${var.messages_ack_rate_at_least_percentage}))).publish('MAJOR')
EOF

  rule {
    description           = format("is too low < %s and there are ready or unack messages", var.messages_ack_rate_threshold_critical)
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.messages_ack_rate_disabled_critical, var.messages_ack_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.messages_ack_rate_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = format("is too low < %s and there are ready or unack messages", var.messages_ack_rate_threshold_major)
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.messages_ack_rate_disabled_major, var.messages_ack_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.messages_ack_rate_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "consumer_use" {
  name = format("%s %s", local.detector_name_prefix, "RabbitMQ Queue consumer use")

  program_text = <<-EOF
    signal = data('gauge.queue.consumer_use', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.consumer_use_aggregation_function}.publish('util')
    msg = data('gauge.queue.messages', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.consumer_use_aggregation_function}
    detect((when((signal < threshold(${var.consumer_use_threshold_critical}) and (msg > 0)), lasting='${var.consumer_use_lasting_duration_seconds}s', at_least=${var.consumer_use_at_least_percentage}))).publish('CRIT')
    detect((when((signal < threshold(${var.consumer_use_threshold_major}) and (msg > 0)), lasting='${var.consumer_use_lasting_duration_seconds}s', at_least=${var.consumer_use_at_least_percentage}))).publish('MAJOR')
EOF

  rule {
    description           = format("is too low < %s, consumers seems too slow", var.consumer_use_threshold_critical)
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.consumer_use_disabled_critical, var.consumer_use_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.consumer_use_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = format("is too low < %s, consumers seems too slow", var.consumer_use_threshold_major)
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.consumer_use_disabled_major, var.consumer_use_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.consumer_use_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

