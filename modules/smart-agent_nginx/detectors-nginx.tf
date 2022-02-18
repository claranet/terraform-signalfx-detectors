resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Nginx heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('nginx_connections.reading', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

  max_delay = var.heartbeat_max_delay
}

resource "signalfx_detector" "dropped_connections" {
  name = format("%s %s", local.detector_name_prefix, "Nginx dropped connections")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('connections.failed', filter=${module.filtering.signalflow})${var.dropped_connections_aggregation_function}${var.dropped_connections_transformation_function}.publish('signal')
    detect(when(signal > ${var.dropped_connections_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.dropped_connections_threshold_major}) and (not when(signal > ${var.dropped_connections_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.dropped_connections_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.dropped_connections_disabled_critical, var.dropped_connections_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.dropped_connections_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.dropped_connections_runbook_url, var.runbook_url), "")
    tip                   = var.dropped_connections_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.dropped_connections_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.dropped_connections_disabled_major, var.dropped_connections_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.dropped_connections_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.dropped_connections_runbook_url, var.runbook_url), "")
    tip                   = var.dropped_connections_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.dropped_connections_max_delay
}

