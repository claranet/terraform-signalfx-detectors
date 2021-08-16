resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS SQS heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('NumberOfMessagesReceived', filter=filter('stat', 'mean') and filter('namespace', 'AWS/SQS') and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}', auto_resolve_after='${local.heartbeat_auto_resolve_after}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.heartbeat_runbook_url, var.runbook_url), "")
    tip                   = var.heartbeat_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject_novalue : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "visible_messages" {
  name = format("%s %s", local.detector_name_prefix, "AWS SQS Visible messages")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('ApproximateNumberOfMessagesVisible', filter=filter('namespace', 'AWS/SQS') and filter('stat', 'upper') and ${module.filtering.signalflow})${var.visible_messages_aggregation_function}${var.visible_messages_transformation_function}.publish('signal')
    detect(when(signal > ${var.visible_messages_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.visible_messages_threshold_major}) and (not when(signal > ${var.visible_messages_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "are too high > ${var.visible_messages_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.visible_messages_disabled_critical, var.visible_messages_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.visible_messages_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.visible_messages_runbook_url, var.runbook_url), "")
    tip                   = var.visible_messages_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "are too high > ${var.visible_messages_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.visible_messages_disabled_major, var.visible_messages_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.visible_messages_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.visible_messages_runbook_url, var.runbook_url), "")
    tip                   = var.visible_messages_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "age_of_oldest_message" {
  name = format("%s %s", local.detector_name_prefix, "AWS SQS Age of the oldest message")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('ApproximateAgeOfOldestMessage', filter=filter('namespace', 'AWS/SQS') and filter('stat', 'upper') and ${module.filtering.signalflow})${var.age_of_oldest_message_aggregation_function}${var.age_of_oldest_message_transformation_function}.publish('signal')
    detect(when(signal > ${var.age_of_oldest_message_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.age_of_oldest_message_threshold_major}) and (not when(signal > ${var.age_of_oldest_message_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too old > ${var.age_of_oldest_message_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.age_of_oldest_message_disabled_critical, var.age_of_oldest_message_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.age_of_oldest_message_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.age_of_oldest_message_runbook_url, var.runbook_url), "")
    tip                   = var.age_of_oldest_message_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too old > ${var.age_of_oldest_message_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.age_of_oldest_message_disabled_major, var.age_of_oldest_message_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.age_of_oldest_message_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.age_of_oldest_message_runbook_url, var.runbook_url), "")
    tip                   = var.age_of_oldest_message_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

