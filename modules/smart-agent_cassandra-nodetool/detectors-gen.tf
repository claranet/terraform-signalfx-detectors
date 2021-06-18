resource "signalfx_detector" "node_status" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra nodetool node status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    signal = data('cassandra.status', filter=${module.filtering.signalflow})${var.node_status_aggregation_function}${var.node_status_transformation_function}.publish('signal')
    detect(when(signal == ${var.node_status_threshold_critical})).publish('CRIT')
    detect(when(signal < ${var.node_status_threshold_minor})).publish('MINOR')
EOF

  rule {
    description           = "is dead == ${var.node_status_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.node_status_disabled_critical, var.node_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.node_status_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.node_status_runbook_url, var.runbook_url), "")
    tip                   = var.node_status_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }

  rule {
    description           = "is unknown < ${var.node_status_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.node_status_disabled_minor, var.node_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.node_status_notifications, "minor", []), var.notifications.minor)
    runbook_url           = try(coalesce(var.node_status_runbook_url, var.runbook_url), "")
    tip                   = var.node_status_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }
}

resource "signalfx_detector" "node_state" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra nodetool node state")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    signal = data('cassandra.state', filter=${module.filtering.signalflow})${var.node_state_aggregation_function}${var.node_state_transformation_function}.publish('signal')
    detect(when(signal > ${var.node_state_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "is not normal > ${var.node_state_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.node_state_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.node_state_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.node_state_runbook_url, var.runbook_url), "")
    tip                   = var.node_state_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }
}

