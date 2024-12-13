resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS SQS heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('stat', 'mean') and filter('namespace', 'AWS/SQS')
    signal = data('NumberOfMessagesReceived', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}', auto_resolve_after='${local.heartbeat_auto_resolve_after}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.heartbeat_runbook_url, var.runbook_url), "")
    tip                   = var.heartbeat_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject_novalue : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.heartbeat_max_delay
}

resource "signalfx_detector" "visible_messages" {
  name = format("%s %s", local.detector_name_prefix, "AWS SQS visible messages")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/SQS') and filter('stat', 'upper')
    signal = data('ApproximateNumberOfMessagesVisible', filter=base_filtering and ${module.filtering.signalflow})${var.visible_messages_aggregation_function}${var.visible_messages_transformation_function}.publish('signal')
    detect(when(signal > ${var.visible_messages_threshold_critical}%{if var.visible_messages_lasting_duration_critical != null}, lasting='${var.visible_messages_lasting_duration_critical}', at_least=${var.visible_messages_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.visible_messages_threshold_major}%{if var.visible_messages_lasting_duration_major != null}, lasting='${var.visible_messages_lasting_duration_major}', at_least=${var.visible_messages_at_least_percentage_major}%{endif}) and (not when(signal > ${var.visible_messages_threshold_critical}%{if var.visible_messages_lasting_duration_critical != null}, lasting='${var.visible_messages_lasting_duration_critical}', at_least=${var.visible_messages_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.visible_messages_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.visible_messages_disabled_critical, var.visible_messages_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.visible_messages_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.visible_messages_runbook_url, var.runbook_url), "")
    tip                   = var.visible_messages_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.visible_messages_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.visible_messages_disabled_major, var.visible_messages_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.visible_messages_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.visible_messages_runbook_url, var.runbook_url), "")
    tip                   = var.visible_messages_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.visible_messages_max_delay
}

resource "signalfx_detector" "age_of_oldest_message" {
  name = format("%s %s", local.detector_name_prefix, "AWS SQS age of the oldest message")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/SQS') and filter('stat', 'upper')
    signal = data('ApproximateAgeOfOldestMessage', filter=base_filtering and ${module.filtering.signalflow})${var.age_of_oldest_message_aggregation_function}${var.age_of_oldest_message_transformation_function}.publish('signal')
    detect(when(signal > ${var.age_of_oldest_message_threshold_critical}%{if var.age_of_oldest_message_lasting_duration_critical != null}, lasting='${var.age_of_oldest_message_lasting_duration_critical}', at_least=${var.age_of_oldest_message_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.age_of_oldest_message_threshold_major}%{if var.age_of_oldest_message_lasting_duration_major != null}, lasting='${var.age_of_oldest_message_lasting_duration_major}', at_least=${var.age_of_oldest_message_at_least_percentage_major}%{endif}) and (not when(signal > ${var.age_of_oldest_message_threshold_critical}%{if var.age_of_oldest_message_lasting_duration_critical != null}, lasting='${var.age_of_oldest_message_lasting_duration_critical}', at_least=${var.age_of_oldest_message_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.age_of_oldest_message_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.age_of_oldest_message_disabled_critical, var.age_of_oldest_message_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.age_of_oldest_message_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.age_of_oldest_message_runbook_url, var.runbook_url), "")
    tip                   = var.age_of_oldest_message_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.age_of_oldest_message_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.age_of_oldest_message_disabled_major, var.age_of_oldest_message_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.age_of_oldest_message_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.age_of_oldest_message_runbook_url, var.runbook_url), "")
    tip                   = var.age_of_oldest_message_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.age_of_oldest_message_max_delay
}

