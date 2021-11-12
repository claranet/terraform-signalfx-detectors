resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Oracle heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('oracledb_Process_limits_value', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "listener" {
  name = format("%s %s", local.detector_name_prefix, "Oracle process listener")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('tnslsnr', filter=${module.filtering.signalflow})${var.listener_aggregation_function}${var.listener_transformation_function}.publish('signal')
    detect(when(signal < ${var.listener_threshold_critical}, lasting=%{if var.listener_lasting_duration_critical == null}None%{else}'${var.listener_lasting_duration_critical}'%{endif}, at_least=${var.listener_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is not started < ${var.listener_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.listener_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.listener_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.listener_runbook_url, var.runbook_url), "")
    tip                   = var.listener_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "dbisdown" {
  name = format("%s %s", local.detector_name_prefix, "Oracle database status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('oracledb_up', filter=${module.filtering.signalflow}, rollup='latest')${var.dbisdown_aggregation_function}${var.dbisdown_transformation_function}.publish('signal')
    detect(when(signal < ${var.dbisdown_threshold_critical}, lasting=%{if var.dbisdown_lasting_duration_critical == null}None%{else}'${var.dbisdown_lasting_duration_critical}'%{endif}, at_least=${var.dbisdown_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is down < ${var.dbisdown_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.dbisdown_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.dbisdown_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.dbisdown_runbook_url, var.runbook_url), "")
    tip                   = var.dbisdown_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "pdbisdown" {
  name = format("%s %s", local.detector_name_prefix, "Oracle pluggable database")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('oracledb_Pdb_is_up_count', filter=${module.filtering.signalflow}, rollup='latest')${var.pdbisdown_aggregation_function}${var.pdbisdown_transformation_function}.publish('signal')
    detect(when(signal > ${var.pdbisdown_threshold_critical}, lasting=%{if var.pdbisdown_lasting_duration_critical == null}None%{else}'${var.pdbisdown_lasting_duration_critical}'%{endif}, at_least=${var.pdbisdown_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is down > ${var.pdbisdown_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.pdbisdown_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.pdbisdown_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.pdbisdown_runbook_url, var.runbook_url), "")
    tip                   = var.pdbisdown_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "blocking_sessions" {
  name = format("%s %s", local.detector_name_prefix, "Oracle blocking session(s)")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('oracledb_blocking_sessions_count', filter=${module.filtering.signalflow}, rollup='latest')${var.blocking_sessions_aggregation_function}${var.blocking_sessions_transformation_function}.publish('signal')
    detect(when(signal > ${var.blocking_sessions_threshold_critical}, lasting=%{if var.blocking_sessions_lasting_duration_critical == null}None%{else}'${var.blocking_sessions_lasting_duration_critical}'%{endif}, at_least=${var.blocking_sessions_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.blocking_sessions_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.blocking_sessions_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.blocking_sessions_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.blocking_sessions_runbook_url, var.runbook_url), "")
    tip                   = var.blocking_sessions_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "alertlogerror" {
  name = format("%s %s", local.detector_name_prefix, "Oracle alert.log errors count")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('oracledb_AlertLogError_count', filter=${module.filtering.signalflow}, rollup='latest')${var.alertlogerror_aggregation_function}${var.alertlogerror_transformation_function}.publish('signal')
    detect(when(signal > ${var.alertlogerror_threshold_critical}, lasting=%{if var.alertlogerror_lasting_duration_critical == null}None%{else}'${var.alertlogerror_lasting_duration_critical}'%{endif}, at_least=${var.alertlogerror_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "error(s) detected > ${var.alertlogerror_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.alertlogerror_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.alertlogerror_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.alertlogerror_runbook_url, var.runbook_url), "")
    tip                   = var.alertlogerror_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "fra_usage" {
  name = format("%s %s", local.detector_name_prefix, "Oracle fast recovery area usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('oracledb_FRA_Usage_value', filter=${module.filtering.signalflow}, rollup='latest')${var.fra_usage_aggregation_function}${var.fra_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.fra_usage_threshold_critical}, lasting=%{if var.fra_usage_lasting_duration_critical == null}None%{else}'${var.fra_usage_lasting_duration_critical}'%{endif}, at_least=${var.fra_usage_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.fra_usage_threshold_major}, lasting=%{if var.fra_usage_lasting_duration_major == null}None%{else}'${var.fra_usage_lasting_duration_major}'%{endif}, at_least=${var.fra_usage_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.fra_usage_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.fra_usage_disabled_critical, var.fra_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.fra_usage_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.fra_usage_runbook_url, var.runbook_url), "")
    tip                   = var.fra_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.fra_usage_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.fra_usage_disabled_major, var.fra_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.fra_usage_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.fra_usage_runbook_url, var.runbook_url), "")
    tip                   = var.fra_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "sessions_limits" {
  name = format("%s %s", local.detector_name_prefix, "Oracle number of sessions compared to limit")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('oracledb_Sessions_limits_value', filter=${module.filtering.signalflow}, rollup='latest')${var.sessions_limits_aggregation_function}${var.sessions_limits_transformation_function}.publish('signal')
    detect(when(signal > ${var.sessions_limits_threshold_critical}, lasting=%{if var.sessions_limits_lasting_duration_critical == null}None%{else}'${var.sessions_limits_lasting_duration_critical}'%{endif}, at_least=${var.sessions_limits_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.sessions_limits_threshold_major}, lasting=%{if var.sessions_limits_lasting_duration_major == null}None%{else}'${var.sessions_limits_lasting_duration_major}'%{endif}, at_least=${var.sessions_limits_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.sessions_limits_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.sessions_limits_disabled_critical, var.sessions_limits_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.sessions_limits_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.sessions_limits_runbook_url, var.runbook_url), "")
    tip                   = var.sessions_limits_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.sessions_limits_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.sessions_limits_disabled_major, var.sessions_limits_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.sessions_limits_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.sessions_limits_runbook_url, var.runbook_url), "")
    tip                   = var.sessions_limits_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "process_limits" {
  name = format("%s %s", local.detector_name_prefix, "Oracle number of processes compared to limit")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('oracledb_Process_limits_value', filter=${module.filtering.signalflow}, rollup='latest')${var.process_limits_aggregation_function}${var.process_limits_transformation_function}.publish('signal')
    detect(when(signal > ${var.process_limits_threshold_critical}, lasting=%{if var.process_limits_lasting_duration_critical == null}None%{else}'${var.process_limits_lasting_duration_critical}'%{endif}, at_least=${var.process_limits_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.process_limits_threshold_major}, lasting=%{if var.process_limits_lasting_duration_major == null}None%{else}'${var.process_limits_lasting_duration_major}'%{endif}, at_least=${var.process_limits_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.process_limits_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.process_limits_disabled_critical, var.process_limits_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.process_limits_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.process_limits_runbook_url, var.runbook_url), "")
    tip                   = var.process_limits_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.process_limits_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.process_limits_disabled_major, var.process_limits_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.process_limits_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.process_limits_runbook_url, var.runbook_url), "")
    tip                   = var.process_limits_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "stby_replication" {
  name = format("%s %s", local.detector_name_prefix, "Oracle gap in standby database replication")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('oracledb_STBY_Replication_count', filter=${module.filtering.signalflow}, rollup='latest')${var.stby_replication_aggregation_function}${var.stby_replication_transformation_function}.publish('signal')
    detect(when(signal > ${var.stby_replication_threshold_critical}, lasting=%{if var.stby_replication_lasting_duration_critical == null}None%{else}'${var.stby_replication_lasting_duration_critical}'%{endif}, at_least=${var.stby_replication_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "GAP detected > ${var.stby_replication_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.stby_replication_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.stby_replication_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.stby_replication_runbook_url, var.runbook_url), "")
    tip                   = var.stby_replication_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "oracledb_export" {
  name = format("%s %s", local.detector_name_prefix, "Oracle database last export")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('oracledb_Oracle_exports_value', filter=${module.filtering.signalflow}, rollup='latest')${var.oracledb_export_aggregation_function}${var.oracledb_export_transformation_function}.publish('signal')
    detect(when(signal > ${var.oracledb_export_threshold_warning}, lasting=%{if var.oracledb_export_lasting_duration_warning == null}None%{else}'${var.oracledb_export_lasting_duration_warning}'%{endif}, at_least=${var.oracledb_export_at_least_percentage_warning})).publish('WARN')
EOF

  rule {
    description           = "is ko > ${var.oracledb_export_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.oracledb_export_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.oracledb_export_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.oracledb_export_runbook_url, var.runbook_url), "")
    tip                   = var.oracledb_export_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "oracle_rman_incr" {
  name = format("%s %s", local.detector_name_prefix, "Oracle rman incremental backup")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('oracledb_Oracle_RMAN_Incr_value', filter=${module.filtering.signalflow}, rollup='latest')${var.oracle_rman_incr_aggregation_function}${var.oracle_rman_incr_transformation_function}.publish('signal')
    detect(when(signal > ${var.oracle_rman_incr_threshold_critical}, lasting=%{if var.oracle_rman_incr_lasting_duration_critical == null}None%{else}'${var.oracle_rman_incr_lasting_duration_critical}'%{endif}, at_least=${var.oracle_rman_incr_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is ko > ${var.oracle_rman_incr_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.oracle_rman_incr_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.oracle_rman_incr_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.oracle_rman_incr_runbook_url, var.runbook_url), "")
    tip                   = var.oracle_rman_incr_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "oracle_rman_arch" {
  name = format("%s %s", local.detector_name_prefix, "Oracle rman archivelog backup")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('oracledb_Oracle_RMAN_Arch_value', filter=${module.filtering.signalflow}, rollup='latest')${var.oracle_rman_arch_aggregation_function}${var.oracle_rman_arch_transformation_function}.publish('signal')
    detect(when(signal > ${var.oracle_rman_arch_threshold_critical}, lasting=%{if var.oracle_rman_arch_lasting_duration_critical == null}None%{else}'${var.oracle_rman_arch_lasting_duration_critical}'%{endif}, at_least=${var.oracle_rman_arch_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is ko > ${var.oracle_rman_arch_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.oracle_rman_arch_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.oracle_rman_arch_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.oracle_rman_arch_runbook_url, var.runbook_url), "")
    tip                   = var.oracle_rman_arch_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "user_expiration" {
  name = format("%s %s", local.detector_name_prefix, "Oracle user expiration")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('oracledb_User_pass_expiration_V2_count', filter=${module.filtering.signalflow}, rollup='latest')${var.user_expiration_aggregation_function}${var.user_expiration_transformation_function}.publish('signal')
    detect(when(signal > ${var.user_expiration_threshold_critical}, lasting=%{if var.user_expiration_lasting_duration_critical == null}None%{else}'${var.user_expiration_lasting_duration_critical}'%{endif}, at_least=${var.user_expiration_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is detected > ${var.user_expiration_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.user_expiration_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.user_expiration_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.user_expiration_runbook_url, var.runbook_url), "")
    tip                   = var.user_expiration_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "tablespace_cdb" {
  name = format("%s %s", local.detector_name_prefix, "Oracle tablespace usage on container database")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('oracledb_tablespace_usage_pct_CDB_V2_real_ts_used_pct', filter=${module.filtering.signalflow}, rollup='latest')${var.tablespace_cdb_aggregation_function}${var.tablespace_cdb_transformation_function}.publish('signal')
    detect(when(signal > ${var.tablespace_cdb_threshold_critical}, lasting=%{if var.tablespace_cdb_lasting_duration_critical == null}None%{else}'${var.tablespace_cdb_lasting_duration_critical}'%{endif}, at_least=${var.tablespace_cdb_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "usage % detected > ${var.tablespace_cdb_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.tablespace_cdb_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.tablespace_cdb_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.tablespace_cdb_runbook_url, var.runbook_url), "")
    tip                   = var.tablespace_cdb_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "tablespace_pdb" {
  name = format("%s %s", local.detector_name_prefix, "Oracle tablespace usage on pluggable database")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('oracledb_tablespace_usage_pct_PDB_V2_real_ts_used_pct', filter=${module.filtering.signalflow}, rollup='latest')${var.tablespace_pdb_aggregation_function}${var.tablespace_pdb_transformation_function}.publish('signal')
    detect(when(signal > ${var.tablespace_pdb_threshold_critical}, lasting=%{if var.tablespace_pdb_lasting_duration_critical == null}None%{else}'${var.tablespace_pdb_lasting_duration_critical}'%{endif}, at_least=${var.tablespace_pdb_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "usage % detected > ${var.tablespace_pdb_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.tablespace_pdb_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.tablespace_pdb_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.tablespace_pdb_runbook_url, var.runbook_url), "")
    tip                   = var.tablespace_pdb_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "tablespace_single" {
  name = format("%s %s", local.detector_name_prefix, "Oracle tablespace usage on non-cdb database")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('oracledb_tablespace_usage_pct_NOCDB_V2_real_ts_used_pct', filter=${module.filtering.signalflow}, rollup='latest')${var.tablespace_single_aggregation_function}${var.tablespace_single_transformation_function}.publish('signal')
    detect(when(signal > ${var.tablespace_single_threshold_critical}, lasting=%{if var.tablespace_single_lasting_duration_critical == null}None%{else}'${var.tablespace_single_lasting_duration_critical}'%{endif}, at_least=${var.tablespace_single_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.tablespace_single_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.tablespace_single_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.tablespace_single_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.tablespace_single_runbook_url, var.runbook_url), "")
    tip                   = var.tablespace_single_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "dbvagent" {
  name = format("%s %s", local.detector_name_prefix, "Oracle process dbvagent")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('dbvagent', filter=${module.filtering.signalflow}, rollup='latest')${var.dbvagent_aggregation_function}${var.dbvagent_transformation_function}.publish('signal')
    detect(when(signal < ${var.dbvagent_threshold_critical}, lasting=%{if var.dbvagent_lasting_duration_critical == null}None%{else}'${var.dbvagent_lasting_duration_critical}'%{endif}, at_least=${var.dbvagent_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is not started < ${var.dbvagent_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.dbvagent_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.dbvagent_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.dbvagent_runbook_url, var.runbook_url), "")
    tip                   = var.dbvagent_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "dbvnet" {
  name = format("%s %s", local.detector_name_prefix, "Oracle process dbvnet")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('dbvnet', filter=${module.filtering.signalflow}, rollup='latest')${var.dbvnet_aggregation_function}${var.dbvnet_transformation_function}.publish('signal')
    detect(when(signal < ${var.dbvnet_threshold_critical}, lasting=%{if var.dbvnet_lasting_duration_critical == null}None%{else}'${var.dbvnet_lasting_duration_critical}'%{endif}, at_least=${var.dbvnet_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is not started < ${var.dbvnet_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.dbvnet_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.dbvnet_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.dbvnet_runbook_url, var.runbook_url), "")
    tip                   = var.dbvnet_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "dbvctl" {
  name = format("%s %s", local.detector_name_prefix, "Oracle process dbvctl")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('dbvctl', filter=${module.filtering.signalflow}, rollup='latest')${var.dbvctl_aggregation_function}${var.dbvctl_transformation_function}.publish('signal')
    detect(when(signal < ${var.dbvctl_threshold_critical}, lasting=%{if var.dbvctl_lasting_duration_critical == null}None%{else}'${var.dbvctl_lasting_duration_critical}'%{endif}, at_least=${var.dbvctl_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is not started < ${var.dbvctl_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.dbvctl_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.dbvctl_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.dbvctl_runbook_url, var.runbook_url), "")
    tip                   = var.dbvctl_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

