resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "MongoDB heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('gauge.connections.available', filter=${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.heartbeat_runbook_url, var.runbook_url), "")
    tip                   = var.heartbeat_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "page_faults" {
  name = format("%s %s", local.detector_name_prefix, "MongoDB page faults")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    signal = data('counter.extra_info.page_faults', filter=${module.filtering.signalflow})${var.page_faults_aggregation_function}${var.page_faults_transformation_function}.publish('signal')
    detect(when(signal > ${var.page_faults_threshold_warning})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.page_faults_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.page_faults_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.page_faults_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.page_faults_runbook_url, var.runbook_url), "")
    tip                   = var.page_faults_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "max_connections" {
  name = format("%s %s", local.detector_name_prefix, "MongoDB number of connections over max capacity")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    A = data('gauge.connections.current', filter=${module.filtering.signalflow})${var.max_connections_aggregation_function}${var.max_connections_transformation_function}
    B = data('gauge.connections.available', filter=${module.filtering.signalflow})${var.max_connections_aggregation_function}${var.max_connections_transformation_function}
    signal = (A/(A+B)).scale(100).publish('signal')
    detect(when(signal > ${var.max_connections_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.max_connections_threshold_major}) and when(signal <= ${var.max_connections_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.max_connections_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.max_connections_disabled_critical, var.max_connections_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.max_connections_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.max_connections_runbook_url, var.runbook_url), "")
    tip                   = var.max_connections_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.max_connections_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.max_connections_disabled_major, var.max_connections_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.max_connections_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.max_connections_runbook_url, var.runbook_url), "")
    tip                   = var.max_connections_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "asserts" {
  name = format("%s %s", local.detector_name_prefix, "MongoDB asserts (warning and regular) errors")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    A = data('counter.asserts.regular', filter=${module.filtering.signalflow})${var.asserts_aggregation_function}${var.asserts_transformation_function}
    B = data('counter.asserts.warning', filter=${module.filtering.signalflow})${var.asserts_aggregation_function}${var.asserts_transformation_function}
    signal = (A+B).publish('signal')
    detect(when(signal > ${var.asserts_threshold_minor})).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.asserts_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.asserts_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.asserts_notifications, "minor", []), var.notifications.minor)
    runbook_url           = try(coalesce(var.asserts_runbook_url, var.runbook_url), "")
    tip                   = var.asserts_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "primary" {
  name = format("%s %s", local.detector_name_prefix, "MongoDB primary in replicaset")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    signal = data('gauge.repl.is_primary_node', filter=${module.filtering.signalflow})${var.primary_aggregation_function}${var.primary_transformation_function}.publish('signal')
    detect(when(signal > ${var.primary_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "is missing"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.primary_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.primary_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.primary_runbook_url, var.runbook_url), "")
    tip                   = var.primary_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "secondary" {
  name = format("%s %s", local.detector_name_prefix, "MongoDB secondary members count in replicaset")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    A = data('gauge.repl.active_nodes', filter=${module.filtering.signalflow})${var.secondary_aggregation_function}${var.secondary_transformation_function}
    B = data('gauge.repl.is_primary_node', filter=${module.filtering.signalflow})${var.secondary_aggregation_function}${var.secondary_transformation_function}
    signal = (A-B).publish('signal')
    detect(when(signal < ${var.secondary_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.secondary_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.secondary_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.secondary_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.secondary_runbook_url, var.runbook_url), "")
    tip                   = var.secondary_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "replication_lag" {
  name = format("%s %s", local.detector_name_prefix, "MongoDB replication lag")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    signal = data('gauge.repl.max_lag', filter=${module.filtering.signalflow})${var.replication_lag_aggregation_function}${var.replication_lag_transformation_function}.publish('signal')
    detect(when(signal > ${var.replication_lag_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.replication_lag_threshold_major}) and when(signal <= ${var.replication_lag_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.replication_lag_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.replication_lag_disabled_critical, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.replication_lag_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.replication_lag_runbook_url, var.runbook_url), "")
    tip                   = var.replication_lag_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.replication_lag_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.replication_lag_disabled_major, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.replication_lag_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.replication_lag_runbook_url, var.runbook_url), "")
    tip                   = var.replication_lag_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

