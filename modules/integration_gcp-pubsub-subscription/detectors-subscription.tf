resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "GCP Pub/Sub Subscription heartbeat")

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('subscription/pull_request_count', filter=${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "oldest_unacked_message" {
  name = format("%s %s", local.detector_name_prefix, "GCP Pub/Sub Subscription oldest unacknowledged message")

  program_text = <<-EOF
    signal = data('subscription/oldest_unacked_message_age', filter=filter('monitored_resource', 'pubsub_subscription') and ${module.filter-tags.filter_custom})${var.oldest_unacked_message_aggregation_function}${var.oldest_unacked_message_transformation_function}.publish('signal')
    detect(when(signal >= ${var.oldest_unacked_message_threshold_critical})).publish('CRIT')
    detect(when(signal >= ${var.oldest_unacked_message_threshold_major}) and when(signal < ${var.oldest_unacked_message_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too old >= ${var.oldest_unacked_message_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.oldest_unacked_message_disabled_critical, var.oldest_unacked_message_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.oldest_unacked_message_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too old >= ${var.oldest_unacked_message_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.oldest_unacked_message_disabled_major, var.oldest_unacked_message_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.oldest_unacked_message_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "push_latency" {
  name = format("%s %s", local.detector_name_prefix, "GCP Pub/Sub Subscription latency on push endpoint")

  program_text = <<-EOF
    signal = data('subscription/push_request_latencies', filter=filter('monitored_resource', 'pubsub_subscription') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='average')${var.push_latency_aggregation_function}${var.push_latency_transformation_function}.publish('signal')
    detect(when(signal >= ${var.push_latency_threshold_critical})).publish('CRIT')
    detect(when(signal >= ${var.push_latency_threshold_major}) and when(signal < ${var.push_latency_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.push_latency_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.push_latency_disabled_critical, var.push_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.push_latency_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high >= ${var.push_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.push_latency_disabled_major, var.push_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.push_latency_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

