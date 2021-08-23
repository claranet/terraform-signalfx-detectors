resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS Kinesis heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('ResourceCount', filter=filter('stat', 'mean') and filter('namespace', 'AWS/Kinesis') and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "incoming_records" {
  name = format("%s %s", local.detector_name_prefix, "AWS Kinesis incoming records")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('IncomingRecords', filter=filter('namespace', 'AWS/Kinesis') and filter('stat', 'lower') and (not filter('ShardId', '*')) and ${module.filtering.signalflow})${var.incoming_records_aggregation_function}${var.incoming_records_transformation_function}.publish('signal')
    detect(when(signal <= ${var.incoming_records_threshold_critical})).publish('CRIT')
    detect(when(signal <= ${var.incoming_records_threshold_major}) and (not when(signal <= ${var.incoming_records_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "are too low <= ${var.incoming_records_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.incoming_records_disabled_critical, var.incoming_records_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.incoming_records_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.incoming_records_runbook_url, var.runbook_url), "")
    tip                   = var.incoming_records_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "are too low <= ${var.incoming_records_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.incoming_records_disabled_major, var.incoming_records_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.incoming_records_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.incoming_records_runbook_url, var.runbook_url), "")
    tip                   = var.incoming_records_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

