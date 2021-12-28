resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure MariaDB heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('resource_type', 'Microsoft.DBforMariaDB/servers') and filter('primary_aggregation_type', 'true')
    signal = data('active_connections', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "cpu_usage" {
  name = format("%s %s", local.detector_name_prefix, "Azure MariaDB cpu usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DBforMariaDB/servers') and filter('primary_aggregation_type', 'true')
    signal = data('cpu_percent', filter=base_filtering and ${module.filtering.signalflow})${var.cpu_usage_aggregation_function}${var.cpu_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_usage_threshold_major}, lasting=%{if var.cpu_usage_lasting_duration_major == null}None%{else}'${var.cpu_usage_lasting_duration_major}'%{endif}, at_least=${var.cpu_usage_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.cpu_usage_threshold_critical}, lasting=%{if var.cpu_usage_lasting_duration_critical == null}None%{else}'${var.cpu_usage_lasting_duration_critical}'%{endif}, at_least=${var.cpu_usage_at_least_percentage_critical}) and (not when(signal > ${var.cpu_usage_threshold_major}, lasting=%{if var.cpu_usage_lasting_duration_major == null}None%{else}'${var.cpu_usage_lasting_duration_major}'%{endif}, at_least=${var.cpu_usage_at_least_percentage_major}))).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.cpu_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_usage_disabled_major, var.cpu_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_usage_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.cpu_usage_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cpu_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_usage_disabled_critical, var.cpu_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_usage_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.cpu_usage_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "storage_usage" {
  name = format("%s %s", local.detector_name_prefix, "Azure MariaDB storage usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DBforMariaDB/servers') and filter('primary_aggregation_type', 'true')
    signal = data('storage_percent', filter=base_filtering and ${module.filtering.signalflow})${var.storage_usage_aggregation_function}${var.storage_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.storage_usage_threshold_major}, lasting=%{if var.storage_usage_lasting_duration_major == null}None%{else}'${var.storage_usage_lasting_duration_major}'%{endif}, at_least=${var.storage_usage_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.storage_usage_threshold_critical}, lasting=%{if var.storage_usage_lasting_duration_critical == null}None%{else}'${var.storage_usage_lasting_duration_critical}'%{endif}, at_least=${var.storage_usage_at_least_percentage_critical}) and (not when(signal > ${var.storage_usage_threshold_major}, lasting=%{if var.storage_usage_lasting_duration_major == null}None%{else}'${var.storage_usage_lasting_duration_major}'%{endif}, at_least=${var.storage_usage_at_least_percentage_major}))).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.storage_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.storage_usage_disabled_major, var.storage_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.storage_usage_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.storage_usage_runbook_url, var.runbook_url), "")
    tip                   = var.storage_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.storage_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.storage_usage_disabled_critical, var.storage_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.storage_usage_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.storage_usage_runbook_url, var.runbook_url), "")
    tip                   = var.storage_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "io_consumption" {
  name = format("%s %s", local.detector_name_prefix, "Azure MariaDB io consumption")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DBforMariaDB/servers') and filter('primary_aggregation_type', 'true')
    signal = data('io_consumption_percent', filter=base_filtering and ${module.filtering.signalflow})${var.io_consumption_aggregation_function}${var.io_consumption_transformation_function}.publish('signal')
    detect(when(signal > ${var.io_consumption_threshold_major}, lasting=%{if var.io_consumption_lasting_duration_major == null}None%{else}'${var.io_consumption_lasting_duration_major}'%{endif}, at_least=${var.io_consumption_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.io_consumption_threshold_critical}, lasting=%{if var.io_consumption_lasting_duration_critical == null}None%{else}'${var.io_consumption_lasting_duration_critical}'%{endif}, at_least=${var.io_consumption_at_least_percentage_critical}) and (not when(signal > ${var.io_consumption_threshold_major}, lasting=%{if var.io_consumption_lasting_duration_major == null}None%{else}'${var.io_consumption_lasting_duration_major}'%{endif}, at_least=${var.io_consumption_at_least_percentage_major}))).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.io_consumption_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.io_consumption_disabled_major, var.io_consumption_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.io_consumption_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.io_consumption_runbook_url, var.runbook_url), "")
    tip                   = var.io_consumption_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.io_consumption_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.io_consumption_disabled_critical, var.io_consumption_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.io_consumption_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.io_consumption_runbook_url, var.runbook_url), "")
    tip                   = var.io_consumption_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "memory_usage" {
  name = format("%s %s", local.detector_name_prefix, "Azure MariaDB memory usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DBforMariaDB/servers') and filter('primary_aggregation_type', 'true')
    signal = data('memory_percent', filter=base_filtering and ${module.filtering.signalflow})${var.memory_usage_aggregation_function}${var.memory_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.memory_usage_threshold_major}, lasting=%{if var.memory_usage_lasting_duration_major == null}None%{else}'${var.memory_usage_lasting_duration_major}'%{endif}, at_least=${var.memory_usage_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.memory_usage_threshold_critical}, lasting=%{if var.memory_usage_lasting_duration_critical == null}None%{else}'${var.memory_usage_lasting_duration_critical}'%{endif}, at_least=${var.memory_usage_at_least_percentage_critical}) and (not when(signal > ${var.memory_usage_threshold_major}, lasting=%{if var.memory_usage_lasting_duration_major == null}None%{else}'${var.memory_usage_lasting_duration_major}'%{endif}, at_least=${var.memory_usage_at_least_percentage_major}))).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.memory_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_usage_disabled_major, var.memory_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_usage_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.memory_usage_runbook_url, var.runbook_url), "")
    tip                   = var.memory_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.memory_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_usage_disabled_critical, var.memory_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_usage_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.memory_usage_runbook_url, var.runbook_url), "")
    tip                   = var.memory_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "replication_lag" {
  name = format("%s %s", local.detector_name_prefix, "Azure MariaDB replication lag")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "seconds"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DBforMariaDB/servers') and filter('primary_aggregation_type', 'true')
    signal = data('seconds_behind_master', filter=base_filtering and ${module.filtering.signalflow})${var.replication_lag_aggregation_function}${var.replication_lag_transformation_function}.publish('signal')
    detect(when(signal > ${var.replication_lag_threshold_major}, lasting=%{if var.replication_lag_lasting_duration_major == null}None%{else}'${var.replication_lag_lasting_duration_major}'%{endif}, at_least=${var.replication_lag_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.replication_lag_threshold_critical}, lasting=%{if var.replication_lag_lasting_duration_critical == null}None%{else}'${var.replication_lag_lasting_duration_critical}'%{endif}, at_least=${var.replication_lag_at_least_percentage_critical}) and (not when(signal > ${var.replication_lag_threshold_major}, lasting=%{if var.replication_lag_lasting_duration_major == null}None%{else}'${var.replication_lag_lasting_duration_major}'%{endif}, at_least=${var.replication_lag_at_least_percentage_major}))).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.replication_lag_threshold_major}seconds"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.replication_lag_disabled_major, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.replication_lag_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.replication_lag_runbook_url, var.runbook_url), "")
    tip                   = var.replication_lag_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.replication_lag_threshold_critical}seconds"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.replication_lag_disabled_critical, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.replication_lag_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.replication_lag_runbook_url, var.runbook_url), "")
    tip                   = var.replication_lag_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

