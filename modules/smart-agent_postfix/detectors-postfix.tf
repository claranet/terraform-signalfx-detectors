resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Postfix heartbeat")

  authorized_writer_teams = var.authorized_writer_teams

  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('gauge.queue.size', filter=${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "postfix_queue_size" {
  name = format("%s %s", local.detector_name_prefix, "Postfix queue size")

  authorized_writer_teams = var.authorized_writer_teams

  program_text = <<-EOF
    signal = data('gauge.queue.size', filter=${module.filter-tags.filter_custom})${var.postfix_queue_size_aggregation_function}${var.postfix_queue_size_transformation_function}.publish('signal')
    detect(when(signal >= ${var.postfix_queue_size_threshold_critical})).publish('CRIT')
    detect(when(signal >= ${var.postfix_queue_size_threshold_major}) and when(signal < ${var.postfix_queue_size_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.postfix_queue_size_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.postfix_queue_size_disabled_critical, var.postfix_queue_size_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.postfix_queue_size_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high >= ${var.postfix_queue_size_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.postfix_queue_size_disabled_major, var.postfix_queue_size_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.postfix_queue_size_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}
