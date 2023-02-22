resource "signalfx_detector" "node" {
  name = format("%s %s", local.detector_name_prefix, "Galera node")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('mysql_wsrep_ready', filter=${module.filtering.signalflow})${var.node_aggregation_function}${var.node_transformation_function}.publish('signal')
    detect(when(signal < ${var.node_threshold_critical}, lasting=%{if var.node_lasting_duration_critical == null}None%{else}'${var.node_lasting_duration_critical}'%{endif}, at_least=${var.node_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is not ready < ${var.node_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.node_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.node_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.node_runbook_url, var.runbook_url), "")
    tip                   = var.node_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.node_max_delay
}

resource "signalfx_detector" "node_state" {
  name = format("%s %s", local.detector_name_prefix, "Galera node state")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('mysql_wsrep_local_state', filter=${module.filtering.signalflow})${var.node_state_aggregation_function}${var.node_state_transformation_function}.publish('signal')
    detect(when(signal != ${var.node_state_threshold_critical}, lasting=%{if var.node_state_lasting_duration_critical == null}None%{else}'${var.node_state_lasting_duration_critical}'%{endif}, at_least=${var.node_state_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is not Synced != ${var.node_state_threshold_critical}"
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

resource "signalfx_detector" "replication_paused_ratio" {
  name = format("%s %s", local.detector_name_prefix, "Galera replication paused ratio")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('mysql_wsrep_flow_control_paused', filter=${module.filtering.signalflow})${var.replication_paused_ratio_aggregation_function}${var.replication_paused_ratio_transformation_function}.publish('signal')
    detect(when(signal > ${var.replication_paused_ratio_threshold_major}, lasting=%{if var.replication_paused_ratio_lasting_duration_major == null}None%{else}'${var.replication_paused_ratio_lasting_duration_major}'%{endif}, at_least=${var.replication_paused_ratio_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.replication_paused_ratio_threshold_minor}, lasting=%{if var.replication_paused_ratio_lasting_duration_minor == null}None%{else}'${var.replication_paused_ratio_lasting_duration_minor}'%{endif}, at_least=${var.replication_paused_ratio_at_least_percentage_minor}) and (not when(signal > ${var.replication_paused_ratio_threshold_major}, lasting=%{if var.replication_paused_ratio_lasting_duration_major == null}None%{else}'${var.replication_paused_ratio_lasting_duration_major}'%{endif}, at_least=${var.replication_paused_ratio_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.replication_paused_ratio_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.replication_paused_ratio_disabled_major, var.replication_paused_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.replication_paused_ratio_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.replication_paused_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.replication_paused_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.replication_paused_ratio_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.replication_paused_ratio_disabled_minor, var.replication_paused_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.replication_paused_ratio_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.replication_paused_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.replication_paused_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.replication_paused_ratio_max_delay
}

resource "signalfx_detector" "recv_queue_length" {
  name = format("%s %s", local.detector_name_prefix, "Galera recv queue length")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('mysql_wsrep_local_recv_queue_avg', filter=${module.filtering.signalflow})${var.recv_queue_length_aggregation_function}${var.recv_queue_length_transformation_function}.publish('signal')
    detect(when(signal > ${var.recv_queue_length_threshold_major}, lasting=%{if var.recv_queue_length_lasting_duration_major == null}None%{else}'${var.recv_queue_length_lasting_duration_major}'%{endif}, at_least=${var.recv_queue_length_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.recv_queue_length_threshold_minor}, lasting=%{if var.recv_queue_length_lasting_duration_minor == null}None%{else}'${var.recv_queue_length_lasting_duration_minor}'%{endif}, at_least=${var.recv_queue_length_at_least_percentage_minor}) and (not when(signal > ${var.recv_queue_length_threshold_major}, lasting=%{if var.recv_queue_length_lasting_duration_major == null}None%{else}'${var.recv_queue_length_lasting_duration_major}'%{endif}, at_least=${var.recv_queue_length_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.recv_queue_length_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.recv_queue_length_disabled_major, var.recv_queue_length_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.recv_queue_length_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.recv_queue_length_runbook_url, var.runbook_url), "")
    tip                   = var.recv_queue_length_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.recv_queue_length_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.recv_queue_length_disabled_minor, var.recv_queue_length_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.recv_queue_length_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.recv_queue_length_runbook_url, var.runbook_url), "")
    tip                   = var.recv_queue_length_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.recv_queue_length_max_delay
}

