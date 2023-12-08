resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "MongoDB heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('gauge.connections.available', filter=${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "page_faults" {
  name = format("%s %s", local.detector_name_prefix, "MongoDB page faults")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('counter.extra_info.page_faults', filter=${module.filtering.signalflow})${var.page_faults_aggregation_function}${var.page_faults_transformation_function}.publish('signal')
    detect(when(signal > ${var.page_faults_threshold_warning}%{if var.page_faults_lasting_duration_warning != null}, lasting='${var.page_faults_lasting_duration_warning}', at_least=${var.page_faults_at_least_percentage_warning}%{endif})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.page_faults_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.page_faults_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.page_faults_notifications, "warning", []), var.notifications.warning), null)
    runbook_url           = try(coalesce(var.page_faults_runbook_url, var.runbook_url), "")
    tip                   = var.page_faults_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.page_faults_max_delay
}

resource "signalfx_detector" "max_connections" {
  name = format("%s %s", local.detector_name_prefix, "MongoDB number of connections over max capacity")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('gauge.connections.current', filter=${module.filtering.signalflow})${var.max_connections_aggregation_function}${var.max_connections_transformation_function}
    B = data('gauge.connections.available', filter=${module.filtering.signalflow})${var.max_connections_aggregation_function}${var.max_connections_transformation_function}
    signal = (A/(A+B)).scale(100).publish('signal')
    detect(when(signal > ${var.max_connections_threshold_critical}%{if var.max_connections_lasting_duration_critical != null}, lasting='${var.max_connections_lasting_duration_critical}', at_least=${var.max_connections_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.max_connections_threshold_major}%{if var.max_connections_lasting_duration_major != null}, lasting='${var.max_connections_lasting_duration_major}', at_least=${var.max_connections_at_least_percentage_major}%{endif}) and (not when(signal > ${var.max_connections_threshold_critical}%{if var.max_connections_lasting_duration_critical != null}, lasting='${var.max_connections_lasting_duration_critical}', at_least=${var.max_connections_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.max_connections_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.max_connections_disabled_critical, var.max_connections_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.max_connections_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.max_connections_runbook_url, var.runbook_url), "")
    tip                   = var.max_connections_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.max_connections_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.max_connections_disabled_major, var.max_connections_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.max_connections_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.max_connections_runbook_url, var.runbook_url), "")
    tip                   = var.max_connections_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.max_connections_max_delay
}

resource "signalfx_detector" "asserts" {
  name = format("%s %s", local.detector_name_prefix, "MongoDB asserts (warning and regular) errors")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('counter.asserts.regular', filter=${module.filtering.signalflow})${var.asserts_aggregation_function}${var.asserts_transformation_function}
    B = data('counter.asserts.warning', filter=${module.filtering.signalflow})${var.asserts_aggregation_function}${var.asserts_transformation_function}
    signal = (A+B).publish('signal')
    detect(when(signal > ${var.asserts_threshold_minor}%{if var.asserts_lasting_duration_minor != null}, lasting='${var.asserts_lasting_duration_minor}', at_least=${var.asserts_at_least_percentage_minor}%{endif})).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.asserts_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.asserts_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.asserts_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.asserts_runbook_url, var.runbook_url), "")
    tip                   = var.asserts_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.asserts_max_delay
}

resource "signalfx_detector" "primary" {
  name = format("%s %s", local.detector_name_prefix, "MongoDB primary in replicaset")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('gauge.repl.is_primary_node', filter=${module.filtering.signalflow})${var.primary_aggregation_function}${var.primary_transformation_function}.publish('signal')
    detect(when(signal > ${var.primary_threshold_critical}%{if var.primary_lasting_duration_critical != null}, lasting='${var.primary_lasting_duration_critical}', at_least=${var.primary_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.primary_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.primary_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.primary_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.primary_runbook_url, var.runbook_url), "")
    tip                   = var.primary_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.primary_max_delay
}

resource "signalfx_detector" "secondary" {
  name = format("%s %s", local.detector_name_prefix, "MongoDB secondary members count in replicaset")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('gauge.repl.active_nodes', filter=${module.filtering.signalflow})${var.secondary_aggregation_function}${var.secondary_transformation_function}
    B = data('gauge.repl.is_primary_node', filter=${module.filtering.signalflow})${var.secondary_aggregation_function}${var.secondary_transformation_function}
    signal = (A-B).publish('signal')
    detect(when(signal < ${var.secondary_threshold_critical}%{if var.secondary_lasting_duration_critical != null}, lasting='${var.secondary_lasting_duration_critical}', at_least=${var.secondary_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.secondary_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.secondary_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.secondary_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.secondary_runbook_url, var.runbook_url), "")
    tip                   = var.secondary_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.secondary_max_delay
}

resource "signalfx_detector" "replication_lag" {
  name = format("%s %s", local.detector_name_prefix, "MongoDB replication lag")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('gauge.repl.max_lag', filter=${module.filtering.signalflow})${var.replication_lag_aggregation_function}${var.replication_lag_transformation_function}.publish('signal')
    detect(when(signal > ${var.replication_lag_threshold_critical}%{if var.replication_lag_lasting_duration_critical != null}, lasting='${var.replication_lag_lasting_duration_critical}', at_least=${var.replication_lag_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.replication_lag_threshold_major}%{if var.replication_lag_lasting_duration_major != null}, lasting='${var.replication_lag_lasting_duration_major}', at_least=${var.replication_lag_at_least_percentage_major}%{endif}) and (not when(signal > ${var.replication_lag_threshold_critical}%{if var.replication_lag_lasting_duration_critical != null}, lasting='${var.replication_lag_lasting_duration_critical}', at_least=${var.replication_lag_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.replication_lag_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.replication_lag_disabled_critical, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.replication_lag_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.replication_lag_runbook_url, var.runbook_url), "")
    tip                   = var.replication_lag_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.replication_lag_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.replication_lag_disabled_major, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.replication_lag_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.replication_lag_runbook_url, var.runbook_url), "")
    tip                   = var.replication_lag_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.replication_lag_max_delay
}

