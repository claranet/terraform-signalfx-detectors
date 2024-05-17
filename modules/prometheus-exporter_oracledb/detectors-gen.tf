resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Oracle heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('oracledb_up', filter=%{ if var.heartbeat_exclude_not_running_vm }${local.not_running_vm_filters} and %{ endif }${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "dbisdown" {
  name = format("%s %s", local.detector_name_prefix, "Oracle database status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('oracledb_up', filter=${module.filtering.signalflow})${var.dbisdown_aggregation_function}${var.dbisdown_transformation_function}.publish('signal')
    detect(when(signal < ${var.dbisdown_threshold_critical}%{if var.dbisdown_lasting_duration_critical != null}, lasting='${var.dbisdown_lasting_duration_critical}', at_least=${var.dbisdown_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is down < ${var.dbisdown_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.dbisdown_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.dbisdown_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.dbisdown_runbook_url, var.runbook_url), "")
    tip                   = var.dbisdown_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.dbisdown_max_delay
}

