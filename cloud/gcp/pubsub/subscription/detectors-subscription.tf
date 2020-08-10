resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] GCP Pub/Sub Subscription heartbeat"

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('subscription/pull_request_count', filter=${module.filter-tags.filter_custom}).publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "oldest_unacked_message" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] GCP Pub/Sub Subscription oldest unacknowledged message"

  program_text = <<-EOF
    signal = data('subscription/oldest_unacked_message_age', filter=filter('monitored_resource', 'pubsub_subscription') and ${module.filter-tags.filter_custom})${var.oldest_unacked_message_aggregation_function}${var.oldest_unacked_message_transformation_function}.publish('signal')
    detect(when(signal >= ${var.oldest_unacked_message_threshold_critical})).publish('CRIT')
    detect(when(signal >= ${var.oldest_unacked_message_threshold_warning}) and when(signal < ${var.oldest_unacked_message_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too old >= ${var.oldest_unacked_message_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.oldest_unacked_message_disabled_critical, var.oldest_unacked_message_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.oldest_unacked_message_notifications_critical, var.oldest_unacked_message_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too old >= ${var.oldest_unacked_message_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.oldest_unacked_message_disabled_warning, var.oldest_unacked_message_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.oldest_unacked_message_notifications_warning, var.oldest_unacked_message_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "push_latency" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] GCP Pub/Sub Subscription latency on push endpoint"

  program_text = <<-EOF
    signal = data('subscription/push_request_latencies', filter=filter('monitored_resource', 'pubsub_subscription') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='average')${var.push_latency_aggregation_function}${var.push_latency_transformation_function}.publish('signal')
    detect(when(signal >= ${var.push_latency_threshold_critical})).publish('CRIT')
    detect(when(signal >= ${var.push_latency_threshold_warning}) and when(signal < ${var.push_latency_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high >= ${var.push_latency_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.push_latency_disabled_critical, var.push_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.push_latency_notifications_critical, var.push_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high >= ${var.push_latency_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.push_latency_disabled_warning, var.push_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.push_latency_notifications_warning, var.push_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

