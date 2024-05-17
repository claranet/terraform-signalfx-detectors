resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "MySQL heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('plugin', 'mysql')
    signal = data('mysql_octets.rx', filter=%{ if var.heartbeat_exclude_not_running_vm }${local.not_running_vm_filters} and %{ endif }base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "mysql_connections" {
  name = format("%s %s", local.detector_name_prefix, "MySQL number of connections over max capacity")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('mysql_threads_connected', filter=${module.filtering.signalflow}, rollup='average')${var.mysql_connections_aggregation_function}${var.mysql_connections_transformation_function}
    B = data('mysql_max_connections', filter=${module.filtering.signalflow}, rollup='average')${var.mysql_connections_aggregation_function}${var.mysql_connections_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.mysql_connections_threshold_critical}%{if var.mysql_connections_lasting_duration_critical != null}, lasting='${var.mysql_connections_lasting_duration_critical}', at_least=${var.mysql_connections_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.mysql_connections_threshold_major}%{if var.mysql_connections_lasting_duration_major != null}, lasting='${var.mysql_connections_lasting_duration_major}', at_least=${var.mysql_connections_at_least_percentage_major}%{endif}) and (not when(signal > ${var.mysql_connections_threshold_critical}%{if var.mysql_connections_lasting_duration_critical != null}, lasting='${var.mysql_connections_lasting_duration_critical}', at_least=${var.mysql_connections_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.mysql_connections_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.mysql_connections_disabled_critical, var.mysql_connections_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.mysql_connections_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.mysql_connections_runbook_url, var.runbook_url), "")
    tip                   = var.mysql_connections_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.mysql_connections_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.mysql_connections_disabled_major, var.mysql_connections_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.mysql_connections_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.mysql_connections_runbook_url, var.runbook_url), "")
    tip                   = var.mysql_connections_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.mysql_connections_max_delay
}

resource "signalfx_detector" "mysql_slow" {
  name = format("%s %s", local.detector_name_prefix, "MySQL slow queries percentage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = (not filter('plugin', 'mysql'))
    A = data('mysql_slow_queries', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta')${var.mysql_slow_aggregation_function}${var.mysql_slow_transformation_function}
    B = data('mysql_queries', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta')${var.mysql_slow_aggregation_function}${var.mysql_slow_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.mysql_slow_threshold_critical}%{if var.mysql_slow_lasting_duration_critical != null}, lasting='${var.mysql_slow_lasting_duration_critical}', at_least=${var.mysql_slow_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.mysql_slow_threshold_major}%{if var.mysql_slow_lasting_duration_major != null}, lasting='${var.mysql_slow_lasting_duration_major}', at_least=${var.mysql_slow_at_least_percentage_major}%{endif}) and (not when(signal > ${var.mysql_slow_threshold_critical}%{if var.mysql_slow_lasting_duration_critical != null}, lasting='${var.mysql_slow_lasting_duration_critical}', at_least=${var.mysql_slow_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.mysql_slow_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.mysql_slow_disabled_critical, var.mysql_slow_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.mysql_slow_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.mysql_slow_runbook_url, var.runbook_url), "")
    tip                   = var.mysql_slow_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.mysql_slow_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.mysql_slow_disabled_major, var.mysql_slow_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.mysql_slow_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.mysql_slow_runbook_url, var.runbook_url), "")
    tip                   = var.mysql_slow_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.mysql_slow_max_delay
}

resource "signalfx_detector" "mysql_pool_efficiency" {
  name = format("%s %s", local.detector_name_prefix, "MySQL innodb buffer pool efficiency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'mysql')
    A = data('mysql_bpool_counters.reads', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta')${var.mysql_pool_efficiency_aggregation_function}${var.mysql_pool_efficiency_transformation_function}
    B = data('mysql_bpool_counters.read_requests', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta')${var.mysql_pool_efficiency_aggregation_function}${var.mysql_pool_efficiency_transformation_function}
    signal = (A/B).fill(0).scale(100).publish('signal')
    detect(when(signal > ${var.mysql_pool_efficiency_threshold_minor}%{if var.mysql_pool_efficiency_lasting_duration_minor != null}, lasting='${var.mysql_pool_efficiency_lasting_duration_minor}', at_least=${var.mysql_pool_efficiency_at_least_percentage_minor}%{endif})).publish('MINOR')
    detect(when(signal > ${var.mysql_pool_efficiency_threshold_warning}%{if var.mysql_pool_efficiency_lasting_duration_warning != null}, lasting='${var.mysql_pool_efficiency_lasting_duration_warning}', at_least=${var.mysql_pool_efficiency_at_least_percentage_warning}%{endif}) and (not when(signal > ${var.mysql_pool_efficiency_threshold_minor}%{if var.mysql_pool_efficiency_lasting_duration_minor != null}, lasting='${var.mysql_pool_efficiency_lasting_duration_minor}', at_least=${var.mysql_pool_efficiency_at_least_percentage_minor}%{endif}))).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.mysql_pool_efficiency_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.mysql_pool_efficiency_disabled_minor, var.mysql_pool_efficiency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.mysql_pool_efficiency_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.mysql_pool_efficiency_runbook_url, var.runbook_url), "")
    tip                   = var.mysql_pool_efficiency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.mysql_pool_efficiency_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.mysql_pool_efficiency_disabled_warning, var.mysql_pool_efficiency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.mysql_pool_efficiency_notifications, "warning", []), var.notifications.warning), null)
    runbook_url           = try(coalesce(var.mysql_pool_efficiency_runbook_url, var.runbook_url), "")
    tip                   = var.mysql_pool_efficiency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.mysql_pool_efficiency_max_delay
}

resource "signalfx_detector" "mysql_pool_utilization" {
  name = format("%s %s", local.detector_name_prefix, "MySQL innodb buffer pool utilization")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'mysql')
    A = data('mysql_bpool_pages.free', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.mysql_pool_utilization_aggregation_function}${var.mysql_pool_utilization_transformation_function}
    B = data('mysql_bpool_pages.total', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.mysql_pool_utilization_aggregation_function}${var.mysql_pool_utilization_transformation_function}
    signal = ((B-A)/B).scale(100).publish('signal')
    detect(when(signal > ${var.mysql_pool_utilization_threshold_minor}%{if var.mysql_pool_utilization_lasting_duration_minor != null}, lasting='${var.mysql_pool_utilization_lasting_duration_minor}', at_least=${var.mysql_pool_utilization_at_least_percentage_minor}%{endif})).publish('MINOR')
    detect(when(signal > ${var.mysql_pool_utilization_threshold_warning}%{if var.mysql_pool_utilization_lasting_duration_warning != null}, lasting='${var.mysql_pool_utilization_lasting_duration_warning}', at_least=${var.mysql_pool_utilization_at_least_percentage_warning}%{endif}) and (not when(signal > ${var.mysql_pool_utilization_threshold_minor}%{if var.mysql_pool_utilization_lasting_duration_minor != null}, lasting='${var.mysql_pool_utilization_lasting_duration_minor}', at_least=${var.mysql_pool_utilization_at_least_percentage_minor}%{endif}))).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.mysql_pool_utilization_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.mysql_pool_utilization_disabled_minor, var.mysql_pool_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.mysql_pool_utilization_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.mysql_pool_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.mysql_pool_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.mysql_pool_utilization_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.mysql_pool_utilization_disabled_warning, var.mysql_pool_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.mysql_pool_utilization_notifications, "warning", []), var.notifications.warning), null)
    runbook_url           = try(coalesce(var.mysql_pool_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.mysql_pool_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.mysql_pool_utilization_max_delay
}

resource "signalfx_detector" "mysql_replication_lag" {
  name = format("%s %s", local.detector_name_prefix, "MySQL replication lag")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('mysql_seconds_behind_master', filter=${module.filtering.signalflow}, rollup='average')${var.mysql_replication_lag_aggregation_function}${var.mysql_replication_lag_transformation_function}.publish('signal')
    detect(when(signal > ${var.mysql_replication_lag_threshold_critical}%{if var.mysql_replication_lag_lasting_duration_critical != null}, lasting='${var.mysql_replication_lag_lasting_duration_critical}', at_least=${var.mysql_replication_lag_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.mysql_replication_lag_threshold_major}%{if var.mysql_replication_lag_lasting_duration_major != null}, lasting='${var.mysql_replication_lag_lasting_duration_major}', at_least=${var.mysql_replication_lag_at_least_percentage_major}%{endif}) and (not when(signal > ${var.mysql_replication_lag_threshold_critical}%{if var.mysql_replication_lag_lasting_duration_critical != null}, lasting='${var.mysql_replication_lag_lasting_duration_critical}', at_least=${var.mysql_replication_lag_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.mysql_replication_lag_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.mysql_replication_lag_disabled_critical, var.mysql_replication_lag_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.mysql_replication_lag_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.mysql_replication_lag_runbook_url, var.runbook_url), "")
    tip                   = var.mysql_replication_lag_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.mysql_replication_lag_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.mysql_replication_lag_disabled_major, var.mysql_replication_lag_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.mysql_replication_lag_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.mysql_replication_lag_runbook_url, var.runbook_url), "")
    tip                   = var.mysql_replication_lag_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.mysql_replication_lag_max_delay
}

resource "signalfx_detector" "mysql_slave_sql_status" {
  name = format("%s %s", local.detector_name_prefix, "MySQL slave sql status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('mysql_slave_sql_running', filter=${module.filtering.signalflow}, rollup='average')${var.mysql_slave_sql_status_aggregation_function}${var.mysql_slave_sql_status_transformation_function}.publish('signal')
    detect(when(signal < ${var.mysql_slave_sql_status_threshold_critical}%{if var.mysql_slave_sql_status_lasting_duration_critical != null}, lasting='${var.mysql_slave_sql_status_lasting_duration_critical}', at_least=${var.mysql_slave_sql_status_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.mysql_slave_sql_status_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.mysql_slave_sql_status_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.mysql_slave_sql_status_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.mysql_slave_sql_status_runbook_url, var.runbook_url), "")
    tip                   = var.mysql_slave_sql_status_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.mysql_slave_sql_status_max_delay
}

resource "signalfx_detector" "mysql_slave_io_status" {
  name = format("%s %s", local.detector_name_prefix, "MySQL slave io status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('mysql_slave_io_running', filter=${module.filtering.signalflow}, rollup='average')${var.mysql_slave_io_status_aggregation_function}${var.mysql_slave_io_status_transformation_function}.publish('signal')
    detect(when(signal < ${var.mysql_slave_io_status_threshold_critical}%{if var.mysql_slave_io_status_lasting_duration_critical != null}, lasting='${var.mysql_slave_io_status_lasting_duration_critical}', at_least=${var.mysql_slave_io_status_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.mysql_slave_io_status_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.mysql_slave_io_status_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.mysql_slave_io_status_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.mysql_slave_io_status_runbook_url, var.runbook_url), "")
    tip                   = var.mysql_slave_io_status_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.mysql_slave_io_status_max_delay
}

