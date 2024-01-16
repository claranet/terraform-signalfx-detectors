resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "GCP Pub/Sub Subscription heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('subscription/pull_request_count', filter=${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "oldest_unacked_message" {
  name = format("%s %s", local.detector_name_prefix, "GCP Pub/Sub Subscription oldest unacknowledged message")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('monitored_resource', 'pubsub_subscription')
    signal = data('subscription/oldest_unacked_message_age', filter=base_filtering and ${module.filtering.signalflow})${var.oldest_unacked_message_aggregation_function}${var.oldest_unacked_message_transformation_function}.publish('signal')
    detect(when(signal >= ${var.oldest_unacked_message_threshold_critical}%{if var.oldest_unacked_message_lasting_duration_critical != null}, lasting='${var.oldest_unacked_message_lasting_duration_critical}', at_least=${var.oldest_unacked_message_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal >= ${var.oldest_unacked_message_threshold_major}%{if var.oldest_unacked_message_lasting_duration_major != null}, lasting='${var.oldest_unacked_message_lasting_duration_major}', at_least=${var.oldest_unacked_message_at_least_percentage_major}%{endif}) and (not when(signal >= ${var.oldest_unacked_message_threshold_critical}%{if var.oldest_unacked_message_lasting_duration_critical != null}, lasting='${var.oldest_unacked_message_lasting_duration_critical}', at_least=${var.oldest_unacked_message_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.oldest_unacked_message_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.oldest_unacked_message_disabled_critical, var.oldest_unacked_message_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.oldest_unacked_message_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.oldest_unacked_message_runbook_url, var.runbook_url), "")
    tip                   = var.oldest_unacked_message_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high >= ${var.oldest_unacked_message_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.oldest_unacked_message_disabled_major, var.oldest_unacked_message_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.oldest_unacked_message_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.oldest_unacked_message_runbook_url, var.runbook_url), "")
    tip                   = var.oldest_unacked_message_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.oldest_unacked_message_max_delay
}

resource "signalfx_detector" "push_latency" {
  name = format("%s %s", local.detector_name_prefix, "GCP Pub/Sub Subscription latency on push endpoint")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('monitored_resource', 'pubsub_subscription')
    signal = data('subscription/push_request_latencies', filter=base_filtering and ${module.filtering.signalflow}, rollup='average', extrapolation='zero')${var.push_latency_aggregation_function}${var.push_latency_transformation_function}.publish('signal')
    detect(when(signal >= ${var.push_latency_threshold_critical}%{if var.push_latency_lasting_duration_critical != null}, lasting='${var.push_latency_lasting_duration_critical}', at_least=${var.push_latency_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal >= ${var.push_latency_threshold_major}%{if var.push_latency_lasting_duration_major != null}, lasting='${var.push_latency_lasting_duration_major}', at_least=${var.push_latency_at_least_percentage_major}%{endif}) and (not when(signal >= ${var.push_latency_threshold_critical}%{if var.push_latency_lasting_duration_critical != null}, lasting='${var.push_latency_lasting_duration_critical}', at_least=${var.push_latency_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.push_latency_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.push_latency_disabled_critical, var.push_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.push_latency_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.push_latency_runbook_url, var.runbook_url), "")
    tip                   = var.push_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high >= ${var.push_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.push_latency_disabled_major, var.push_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.push_latency_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.push_latency_runbook_url, var.runbook_url), "")
    tip                   = var.push_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.push_latency_max_delay
}

