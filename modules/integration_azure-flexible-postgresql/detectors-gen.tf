resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure PostgreSQL flexible heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('resource_type', 'Microsoft.DB*orPostgreSQL/flexibleServers') and filter('primary_aggregation_type', 'true')
    signal = data('cpu_percent', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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
  name = format("%s %s", local.detector_name_prefix, "Azure PostgreSQL flexible cpu usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DB*orPostgreSQL/flexibleServers') and filter('primary_aggregation_type', 'true')
    signal = data('cpu_percent', filter=base_filtering and ${module.filtering.signalflow})${var.cpu_usage_aggregation_function}${var.cpu_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_usage_threshold_critical}%{if var.cpu_usage_lasting_duration_critical != null}, lasting='${var.cpu_usage_lasting_duration_critical}', at_least=${var.cpu_usage_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.cpu_usage_threshold_major}%{if var.cpu_usage_lasting_duration_major != null}, lasting='${var.cpu_usage_lasting_duration_major}', at_least=${var.cpu_usage_at_least_percentage_major}%{endif}) and (not when(signal > ${var.cpu_usage_threshold_critical}%{if var.cpu_usage_lasting_duration_critical != null}, lasting='${var.cpu_usage_lasting_duration_critical}', at_least=${var.cpu_usage_at_least_percentage_critical}%{endif}))).publish('MAJOR')
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

resource "signalfx_detector" "no_connection" {
  name = format("%s %s", local.detector_name_prefix, "Azure PostgreSQL flexible has no connection")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DB*orPostgreSQL/flexibleServers') and filter('primary_aggregation_type', 'true')
    signal = data('active_connections', filter=base_filtering and ${module.filtering.signalflow})${var.no_connection_aggregation_function}${var.no_connection_transformation_function}.publish('signal')
    detect(when(signal < ${var.no_connection_threshold_critical}%{if var.no_connection_lasting_duration_critical != null}, lasting='${var.no_connection_lasting_duration_critical}', at_least=${var.no_connection_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.no_connection_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.no_connection_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.no_connection_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.no_connection_runbook_url, var.runbook_url), "")
    tip                   = var.no_connection_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.no_connection_max_delay
}

resource "signalfx_detector" "storage_usage" {
  name = format("%s %s", local.detector_name_prefix, "Azure PostgreSQL flexible storage usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DB*orPostgreSQL/flexibleServers') and filter('primary_aggregation_type', 'true')
    signal = data('storage_percent', filter=base_filtering and ${module.filtering.signalflow})${var.storage_usage_aggregation_function}${var.storage_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.storage_usage_threshold_critical}%{if var.storage_usage_lasting_duration_critical != null}, lasting='${var.storage_usage_lasting_duration_critical}', at_least=${var.storage_usage_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.storage_usage_threshold_major}%{if var.storage_usage_lasting_duration_major != null}, lasting='${var.storage_usage_lasting_duration_major}', at_least=${var.storage_usage_at_least_percentage_major}%{endif}) and (not when(signal > ${var.storage_usage_threshold_critical}%{if var.storage_usage_lasting_duration_critical != null}, lasting='${var.storage_usage_lasting_duration_critical}', at_least=${var.storage_usage_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.storage_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.storage_usage_disabled_critical, var.storage_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.storage_usage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.storage_usage_runbook_url, var.runbook_url), "")
    tip                   = var.storage_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.storage_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.storage_usage_disabled_major, var.storage_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.storage_usage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.storage_usage_runbook_url, var.runbook_url), "")
    tip                   = var.storage_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.storage_usage_max_delay
}

resource "signalfx_detector" "io_consumption" {
  name = format("%s %s", local.detector_name_prefix, "Azure PostgreSQL flexible disk iops consumption")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DB*orPostgreSQL/flexibleServers') and filter('primary_aggregation_type', 'true')
    signal = data('disk_iops_consumed_percentage', filter=base_filtering and ${module.filtering.signalflow})${var.io_consumption_aggregation_function}${var.io_consumption_transformation_function}.publish('signal')
    detect(when(signal > ${var.io_consumption_threshold_critical}%{if var.io_consumption_lasting_duration_critical != null}, lasting='${var.io_consumption_lasting_duration_critical}', at_least=${var.io_consumption_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.io_consumption_threshold_major}%{if var.io_consumption_lasting_duration_major != null}, lasting='${var.io_consumption_lasting_duration_major}', at_least=${var.io_consumption_at_least_percentage_major}%{endif}) and (not when(signal > ${var.io_consumption_threshold_critical}%{if var.io_consumption_lasting_duration_critical != null}, lasting='${var.io_consumption_lasting_duration_critical}', at_least=${var.io_consumption_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.io_consumption_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.io_consumption_disabled_critical, var.io_consumption_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.io_consumption_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.io_consumption_runbook_url, var.runbook_url), "")
    tip                   = var.io_consumption_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.io_consumption_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.io_consumption_disabled_major, var.io_consumption_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.io_consumption_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.io_consumption_runbook_url, var.runbook_url), "")
    tip                   = var.io_consumption_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.io_consumption_max_delay
}

resource "signalfx_detector" "memory_usage" {
  name = format("%s %s", local.detector_name_prefix, "Azure PostgreSQL flexible memory usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DB*orPostgreSQL/flexibleServers') and filter('primary_aggregation_type', 'true')
    signal = data('memory_percent', filter=base_filtering and ${module.filtering.signalflow})${var.memory_usage_aggregation_function}${var.memory_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.memory_usage_threshold_critical}%{if var.memory_usage_lasting_duration_critical != null}, lasting='${var.memory_usage_lasting_duration_critical}', at_least=${var.memory_usage_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.memory_usage_threshold_major}%{if var.memory_usage_lasting_duration_major != null}, lasting='${var.memory_usage_lasting_duration_major}', at_least=${var.memory_usage_at_least_percentage_major}%{endif}) and (not when(signal > ${var.memory_usage_threshold_critical}%{if var.memory_usage_lasting_duration_critical != null}, lasting='${var.memory_usage_lasting_duration_critical}', at_least=${var.memory_usage_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memory_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_usage_disabled_critical, var.memory_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_usage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.memory_usage_runbook_url, var.runbook_url), "")
    tip                   = var.memory_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.memory_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_usage_disabled_major, var.memory_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_usage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.memory_usage_runbook_url, var.runbook_url), "")
    tip                   = var.memory_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memory_usage_max_delay
}

resource "signalfx_detector" "replication_lag" {
  name = format("%s %s", local.detector_name_prefix, "Azure PostgreSQL flexible replication lag")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "s"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DB*orPostgreSQL/flexibleServers') and filter('primary_aggregation_type', 'true')
    signal = data('physical_replication_delay_in_seconds', filter=base_filtering and ${module.filtering.signalflow})${var.replication_lag_aggregation_function}${var.replication_lag_transformation_function}.publish('signal')
    detect(when(signal > ${var.replication_lag_threshold_critical}%{if var.replication_lag_lasting_duration_critical != null}, lasting='${var.replication_lag_lasting_duration_critical}', at_least=${var.replication_lag_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.replication_lag_threshold_major}%{if var.replication_lag_lasting_duration_major != null}, lasting='${var.replication_lag_lasting_duration_major}', at_least=${var.replication_lag_at_least_percentage_major}%{endif}) and (not when(signal > ${var.replication_lag_threshold_critical}%{if var.replication_lag_lasting_duration_critical != null}, lasting='${var.replication_lag_lasting_duration_critical}', at_least=${var.replication_lag_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.replication_lag_threshold_critical}s"
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
    description           = "is too high > ${var.replication_lag_threshold_major}s"
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

