resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS RDS Common heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('namespace', 'AWS/RDS')
    signal = data('CPUUtilization', filter=base_filtering and filter('stat', 'mean') and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "cpu_usage" {
  name = format("%s %s", local.detector_name_prefix, "AWS RDS Common instance cpu")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/RDS')
    signal = data('CPUUtilization', filter=base_filtering and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*') and ${module.filtering.signalflow})${var.cpu_usage_aggregation_function}${var.cpu_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_usage_threshold_critical}, lasting=%{if var.cpu_usage_lasting_duration_critical == null}None%{else}'${var.cpu_usage_lasting_duration_critical}'%{endif}, at_least=${var.cpu_usage_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_usage_threshold_major}, lasting=%{if var.cpu_usage_lasting_duration_major == null}None%{else}'${var.cpu_usage_lasting_duration_major}'%{endif}, at_least=${var.cpu_usage_at_least_percentage_major}) and (not when(signal > ${var.cpu_usage_threshold_critical}, lasting=%{if var.cpu_usage_lasting_duration_critical == null}None%{else}'${var.cpu_usage_lasting_duration_critical}'%{endif}, at_least=${var.cpu_usage_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_usage_disabled_critical, var.cpu_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_usage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cpu_usage_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cpu_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_usage_disabled_major, var.cpu_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_usage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cpu_usage_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cpu_usage_max_delay
}

resource "signalfx_detector" "free_space_low" {
  name = format("%s %s", local.detector_name_prefix, "AWS RDS Common instance free space")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Gibibyte"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/RDS')
    signal = data('FreeStorageSpace', filter=base_filtering and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*') and ${module.filtering.signalflow})${var.free_space_low_aggregation_function}${var.free_space_low_transformation_function}.publish('signal')
    detect(when(signal < ${var.free_space_low_threshold_major}, lasting=%{if var.free_space_low_lasting_duration_major == null}None%{else}'${var.free_space_low_lasting_duration_major}'%{endif}, at_least=${var.free_space_low_at_least_percentage_major}) and (not when(signal < ${var.free_space_low_threshold_critical}, lasting=%{if var.free_space_low_lasting_duration_critical == null}None%{else}'${var.free_space_low_lasting_duration_critical}'%{endif}, at_least=${var.free_space_low_at_least_percentage_critical}))).publish('MAJOR')
    detect(when(signal < ${var.free_space_low_threshold_critical}, lasting=%{if var.free_space_low_lasting_duration_critical == null}None%{else}'${var.free_space_low_lasting_duration_critical}'%{endif}, at_least=${var.free_space_low_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.free_space_low_threshold_major}Gibibyte"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.free_space_low_disabled_major, var.free_space_low_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.free_space_low_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.free_space_low_runbook_url, var.runbook_url), "")
    tip                   = var.free_space_low_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.free_space_low_threshold_critical}Gibibyte"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.free_space_low_disabled_critical, var.free_space_low_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.free_space_low_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.free_space_low_runbook_url, var.runbook_url), "")
    tip                   = var.free_space_low_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.free_space_low_max_delay
}

resource "signalfx_detector" "replica_lag" {
  name = format("%s %s", local.detector_name_prefix, "AWS RDS Common replica lag")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/RDS')
    signal = data('ReplicaLag', filter=base_filtering and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*') and ${module.filtering.signalflow})${var.replica_lag_aggregation_function}${var.replica_lag_transformation_function}.publish('signal')
    detect(when(signal > ${var.replica_lag_threshold_critical}, lasting=%{if var.replica_lag_lasting_duration_critical == null}None%{else}'${var.replica_lag_lasting_duration_critical}'%{endif}, at_least=${var.replica_lag_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.replica_lag_threshold_major}, lasting=%{if var.replica_lag_lasting_duration_major == null}None%{else}'${var.replica_lag_lasting_duration_major}'%{endif}, at_least=${var.replica_lag_at_least_percentage_major}) and (not when(signal > ${var.replica_lag_threshold_critical}, lasting=%{if var.replica_lag_lasting_duration_critical == null}None%{else}'${var.replica_lag_lasting_duration_critical}'%{endif}, at_least=${var.replica_lag_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.replica_lag_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.replica_lag_disabled_critical, var.replica_lag_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.replica_lag_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.replica_lag_runbook_url, var.runbook_url), "")
    tip                   = var.replica_lag_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.replica_lag_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.replica_lag_disabled_major, var.replica_lag_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.replica_lag_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.replica_lag_runbook_url, var.runbook_url), "")
    tip                   = var.replica_lag_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.replica_lag_max_delay
}

resource "signalfx_detector" "dbload" {
  name = format("%s %s", local.detector_name_prefix, "AWS RDS Common db load")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/RDS') and filter('stat', 'mean')
    signal = data('DBLoad', filter=base_filtering and ${module.filtering.signalflow})${var.dbload_aggregation_function}${var.dbload_transformation_function}.publish('signal')
    detect(when(signal > ${var.dbload_threshold_critical}, lasting=%{if var.dbload_lasting_duration_critical == null}None%{else}'${var.dbload_lasting_duration_critical}'%{endif}, at_least=${var.dbload_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.dbload_threshold_major}, lasting=%{if var.dbload_lasting_duration_major == null}None%{else}'${var.dbload_lasting_duration_major}'%{endif}, at_least=${var.dbload_at_least_percentage_major}) and (not when(signal > ${var.dbload_threshold_critical}, lasting=%{if var.dbload_lasting_duration_critical == null}None%{else}'${var.dbload_lasting_duration_critical}'%{endif}, at_least=${var.dbload_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.dbload_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.dbload_disabled_critical, var.dbload_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.dbload_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.dbload_runbook_url, var.runbook_url), "")
    tip                   = var.dbload_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.dbload_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.dbload_disabled_major, var.dbload_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.dbload_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.dbload_runbook_url, var.runbook_url), "")
    tip                   = var.dbload_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.dbload_max_delay
}

