resource "signalfx_detector" "node_status" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra nodetool node status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('cassandra.status', filter=${module.filtering.signalflow})${var.node_status_aggregation_function}${var.node_status_transformation_function}.publish('signal')
    detect(when(signal == ${var.node_status_threshold_critical}, lasting=%{if var.node_status_lasting_duration_critical == null}None%{else}'${var.node_status_lasting_duration_critical}'%{endif}, at_least=${var.node_status_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal < ${var.node_status_threshold_minor}, lasting=%{if var.node_status_lasting_duration_minor == null}None%{else}'${var.node_status_lasting_duration_minor}'%{endif}, at_least=${var.node_status_at_least_percentage_minor})).publish('MINOR')
EOF

  rule {
    description           = "is dead == ${var.node_status_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.node_status_disabled_critical, var.node_status_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.node_status_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.node_status_runbook_url, var.runbook_url), "")
    tip                   = var.node_status_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is unknown < ${var.node_status_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.node_status_disabled_minor, var.node_status_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.node_status_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.node_status_runbook_url, var.runbook_url), "")
    tip                   = var.node_status_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.node_status_max_delay
}

resource "signalfx_detector" "node_state" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra nodetool node state")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('cassandra.state', filter=${module.filtering.signalflow})${var.node_state_aggregation_function}${var.node_state_transformation_function}.publish('signal')
    detect(when(signal > ${var.node_state_threshold_critical}, lasting=%{if var.node_state_lasting_duration_critical == null}None%{else}'${var.node_state_lasting_duration_critical}'%{endif}, at_least=${var.node_state_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is not normal > ${var.node_state_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.node_state_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.node_state_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.node_state_runbook_url, var.runbook_url), "")
    tip                   = var.node_state_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.node_state_max_delay
}

