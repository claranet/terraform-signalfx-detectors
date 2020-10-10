resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS SQS heartbeat"

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('NumberOfMessagesReceived', filter=filter('stat', 'mean') and filter('namespace', 'AWS/SQS') and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.subject_novalue
    parameterized_body    = local.body
  }
}

resource "signalfx_detector" "visible_messages" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS SQS Visible messages"

  program_text = <<-EOF
    signal = data('ApproximateNumberOfMessagesVisible', filter=filter('namespace', 'AWS/SQS') and filter('stat', 'upper') and ${module.filter-tags.filter_custom})${var.visible_messages_aggregation_function}${var.visible_messages_transformation_function}.publish('signal')
    detect(when(signal > ${var.visible_messages_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.visible_messages_threshold_major}) and when(signal <= ${var.visible_messages_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "are too high > ${var.visible_messages_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.visible_messages_disabled_critical, var.visible_messages_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.visible_messages_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.subject
    parameterized_body    = local.body
  }

  rule {
    description           = "are too high > ${var.visible_messages_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.visible_messages_disabled_major, var.visible_messages_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.visible_messages_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.subject
    parameterized_body    = local.body
  }
}

resource "signalfx_detector" "age_of_oldest_message" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS SQS Age of the oldest message"

  program_text = <<-EOF
    signal = data('ApproximateAgeOfOldestMessage', filter=filter('namespace', 'AWS/SQS') and filter('stat', 'upper') and ${module.filter-tags.filter_custom})${var.age_of_oldest_message_aggregation_function}${var.age_of_oldest_message_transformation_function}.publish('signal')
    detect(when(signal > ${var.age_of_oldest_message_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.age_of_oldest_message_threshold_major}) and when(signal <= ${var.age_of_oldest_message_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too old > ${var.age_of_oldest_message_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.age_of_oldest_message_disabled_critical, var.age_of_oldest_message_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.age_of_oldest_message_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.subject
    parameterized_body    = local.body
  }

  rule {
    description           = "is too old > ${var.age_of_oldest_message_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.age_of_oldest_message_disabled_major, var.age_of_oldest_message_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.age_of_oldest_message_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.subject
    parameterized_body    = local.body
  }
}

