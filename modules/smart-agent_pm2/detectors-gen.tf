resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Pm2 heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = (not filter('name', 'pm2-metrics'))
    signal = data('pm2_up', filter=${local.not_running_vm_filters} and base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "up" {
  name = format("%s %s", local.detector_name_prefix, "Pm2 up application")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = (not filter('name', 'pm2-metrics'))
    signal = data('pm2_up', filter=${local.not_running_vm_filters} and base_filtering and ${module.filtering.signalflow})${var.up_aggregation_function}${var.up_transformation_function}.publish('signal')
    detect(when(signal > ${var.up_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.up_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.up_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.up_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.up_runbook_url, var.runbook_url), "")
    tip                   = var.up_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "restarts" {
  name = format("%s %s", local.detector_name_prefix, "Pm2 restarts counter")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = (not filter('name', 'pm2-metrics'))
    signal = data('pm2_restarts', filter=${local.not_running_vm_filters} and base_filtering and ${module.filtering.signalflow})${var.restarts_aggregation_function}${var.restarts_transformation_function}.publish('signal')
    detect(when(signal > ${var.restarts_threshold_critical})).publish('CRIT')
    detect(when(signal >= ${var.restarts_threshold_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.restarts_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.restarts_disabled_critical, var.restarts_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.restarts_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.restarts_runbook_url, var.runbook_url), "")
    tip                   = var.restarts_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high >= ${var.restarts_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.restarts_disabled_major, var.restarts_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.restarts_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.restarts_runbook_url, var.runbook_url), "")
    tip                   = var.restarts_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

