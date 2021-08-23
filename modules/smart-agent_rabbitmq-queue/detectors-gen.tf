resource "signalfx_detector" "messages_ready" {
  name = format("%s %s", local.detector_name_prefix, "RabbitMQ Queue messages ready")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'rabbitmq')
    signal = data('gauge.queue.messages_ready', filter=base_filtering and ${module.filtering.signalflow})${var.messages_ready_aggregation_function}${var.messages_ready_transformation_function}.publish('signal')
    detect(when(signal > ${var.messages_ready_threshold_critical}, lasting=%{if var.messages_ready_lasting_duration_critical == null}None%{else}'${var.messages_ready_lasting_duration_critical}'%{endif}, at_least=${var.messages_ready_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.messages_ready_threshold_major}, lasting=%{if var.messages_ready_lasting_duration_major == null}None%{else}'${var.messages_ready_lasting_duration_major}'%{endif}, at_least=${var.messages_ready_at_least_percentage_major}) and (not when(signal > ${var.messages_ready_threshold_critical}, lasting=%{if var.messages_ready_lasting_duration_critical == null}None%{else}'${var.messages_ready_lasting_duration_critical}'%{endif}, at_least=${var.messages_ready_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.messages_ready_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.messages_ready_disabled_critical, var.messages_ready_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.messages_ready_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.messages_ready_runbook_url, var.runbook_url), "")
    tip                   = var.messages_ready_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.messages_ready_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.messages_ready_disabled_major, var.messages_ready_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.messages_ready_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.messages_ready_runbook_url, var.runbook_url), "")
    tip                   = var.messages_ready_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "messages_unacknowledged" {
  name = format("%s %s", local.detector_name_prefix, "RabbitMQ Queue messages unacknowledged")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'rabbitmq')
    signal = data('gauge.queue.messages_unacknowledged', filter=base_filtering and ${module.filtering.signalflow})${var.messages_unacknowledged_aggregation_function}${var.messages_unacknowledged_transformation_function}.publish('signal')
    detect(when(signal > ${var.messages_unacknowledged_threshold_critical}, lasting=%{if var.messages_unacknowledged_lasting_duration_critical == null}None%{else}'${var.messages_unacknowledged_lasting_duration_critical}'%{endif}, at_least=${var.messages_unacknowledged_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.messages_unacknowledged_threshold_major}, lasting=%{if var.messages_unacknowledged_lasting_duration_major == null}None%{else}'${var.messages_unacknowledged_lasting_duration_major}'%{endif}, at_least=${var.messages_unacknowledged_at_least_percentage_major}) and (not when(signal > ${var.messages_unacknowledged_threshold_critical}, lasting=%{if var.messages_unacknowledged_lasting_duration_critical == null}None%{else}'${var.messages_unacknowledged_lasting_duration_critical}'%{endif}, at_least=${var.messages_unacknowledged_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.messages_unacknowledged_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.messages_unacknowledged_disabled_critical, var.messages_unacknowledged_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.messages_unacknowledged_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.messages_unacknowledged_runbook_url, var.runbook_url), "")
    tip                   = var.messages_unacknowledged_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.messages_unacknowledged_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.messages_unacknowledged_disabled_major, var.messages_unacknowledged_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.messages_unacknowledged_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.messages_unacknowledged_runbook_url, var.runbook_url), "")
    tip                   = var.messages_unacknowledged_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "messages_ack_rate" {
  name = format("%s %s", local.detector_name_prefix, "RabbitMQ Queue messages ack rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'rabbitmq')
    msg = data('gauge.queue.messages', filter=base_filtering and ${module.filtering.signalflow})${var.messages_ack_rate_aggregation_function}${var.messages_ack_rate_transformation_function}
    signal = data('counter.queue.message_stats.ack', filter=base_filtering and ${module.filtering.signalflow})${var.messages_ack_rate_aggregation_function}${var.messages_ack_rate_transformation_function}.publish('signal')
    detect(when(signal <= ${var.messages_ack_rate_threshold_critical}, lasting=%{if var.messages_ack_rate_lasting_duration_critical == null}None%{else}'${var.messages_ack_rate_lasting_duration_critical}'%{endif}, at_least=${var.messages_ack_rate_at_least_percentage_critical}) and when(signal >= 0) and when(msg > 0)).publish('CRIT')
    detect(when(signal <= ${var.messages_ack_rate_threshold_major}, lasting=%{if var.messages_ack_rate_lasting_duration_major == null}None%{else}'${var.messages_ack_rate_lasting_duration_major}'%{endif}, at_least=${var.messages_ack_rate_at_least_percentage_major}) and when(signal >= 0) and when(msg > 0) and (not when(signal <= ${var.messages_ack_rate_threshold_critical}, lasting=%{if var.messages_ack_rate_lasting_duration_critical == null}None%{else}'${var.messages_ack_rate_lasting_duration_critical}'%{endif}, at_least=${var.messages_ack_rate_at_least_percentage_critical}) and when(signal >= 0) and when(msg > 0))).publish('MAJOR')
EOF

  rule {
    description           = "is to low and there are ready or unack messages <= ${var.messages_ack_rate_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.messages_ack_rate_disabled_critical, var.messages_ack_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.messages_ack_rate_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.messages_ack_rate_runbook_url, var.runbook_url), "")
    tip                   = var.messages_ack_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is to low and there are ready or unack messages <= ${var.messages_ack_rate_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.messages_ack_rate_disabled_major, var.messages_ack_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.messages_ack_rate_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.messages_ack_rate_runbook_url, var.runbook_url), "")
    tip                   = var.messages_ack_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "consumer_use" {
  name = format("%s %s", local.detector_name_prefix, "RabbitMQ Queue consumer use")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'rabbitmq')
    msg = data('gauge.queue.messages', filter=base_filtering and ${module.filtering.signalflow})${var.consumer_use_aggregation_function}${var.consumer_use_transformation_function}
    signal = data('gauge.queue.consumer_use', filter=base_filtering and ${module.filtering.signalflow})${var.consumer_use_aggregation_function}${var.consumer_use_transformation_function}.publish('signal')
    detect(when(signal < ${var.consumer_use_threshold_critical}, lasting=%{if var.consumer_use_lasting_duration_critical == null}None%{else}'${var.consumer_use_lasting_duration_critical}'%{endif}, at_least=${var.consumer_use_at_least_percentage_critical}) and when(msg > 0)).publish('CRIT')
    detect(when(signal < ${var.consumer_use_threshold_major}, lasting=%{if var.consumer_use_lasting_duration_major == null}None%{else}'${var.consumer_use_lasting_duration_major}'%{endif}, at_least=${var.consumer_use_at_least_percentage_major}) and when(msg > 0) and (not when(signal < ${var.consumer_use_threshold_critical}, lasting=%{if var.consumer_use_lasting_duration_critical == null}None%{else}'${var.consumer_use_lasting_duration_critical}'%{endif}, at_least=${var.consumer_use_at_least_percentage_critical}) and when(msg > 0))).publish('MAJOR')
EOF

  rule {
    description           = "is too low and consumers seems too slow < ${var.consumer_use_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.consumer_use_disabled_critical, var.consumer_use_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.consumer_use_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.consumer_use_runbook_url, var.runbook_url), "")
    tip                   = var.consumer_use_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low and consumers seems too slow < ${var.consumer_use_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.consumer_use_disabled_major, var.consumer_use_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.consumer_use_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.consumer_use_runbook_url, var.runbook_url), "")
    tip                   = var.consumer_use_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

