resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure PostgreSQL heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('resource_type', 'Microsoft.DB*orPostgreSQL/servers') and filter('primary_aggregation_type', 'true')
    signal = data('network_bytes_ingress', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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
  name = format("%s %s", local.detector_name_prefix, "Azure PostgreSQL cpu usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DB*orPostgreSQL/servers') and filter('primary_aggregation_type', 'true')
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

resource "signalfx_detector" "active_connections" {
  name = format("%s %s", local.detector_name_prefix, "Azure PostgreSQL active connections")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DB*orPostgreSQL/servers') and filter('primary_aggregation_type', 'true')
    signal = data('active_connections', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.active_connections_aggregation_function}${var.active_connections_transformation_function}.publish('signal')
    detect(when(signal < ${var.active_connections_threshold_critical}%{if var.active_connections_lasting_duration_critical != null}, lasting='${var.active_connections_lasting_duration_critical}', at_least=${var.active_connections_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.active_connections_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.active_connections_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.active_connections_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.active_connections_runbook_url, var.runbook_url), "")
    tip                   = var.active_connections_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.active_connections_max_delay
}

resource "signalfx_detector" "storage_usage" {
  name = format("%s %s", local.detector_name_prefix, "Azure PostgreSQL storage usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DB*orPostgreSQL/servers') and filter('primary_aggregation_type', 'true')
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
  name = format("%s %s", local.detector_name_prefix, "Azure PostgreSQL io consumption")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DB*orPostgreSQL/servers') and filter('primary_aggregation_type', 'true')
    signal = data('io_consumption_percent', filter=base_filtering and ${module.filtering.signalflow})${var.io_consumption_aggregation_function}${var.io_consumption_transformation_function}.publish('signal')
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
  name = format("%s %s", local.detector_name_prefix, "Azure PostgreSQL memory usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DB*orPostgreSQL/servers') and filter('primary_aggregation_type', 'true')
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

resource "signalfx_detector" "serverlog_storage_usage" {
  name = format("%s %s", local.detector_name_prefix, "Azure PostgreSQL serverlog storage usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DB*orPostgreSQL/servers') and filter('primary_aggregation_type', 'true')
    signal = data('serverlog_storage_percent', filter=base_filtering and ${module.filtering.signalflow})${var.serverlog_storage_usage_aggregation_function}${var.serverlog_storage_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.serverlog_storage_usage_threshold_critical}%{if var.serverlog_storage_usage_lasting_duration_critical != null}, lasting='${var.serverlog_storage_usage_lasting_duration_critical}', at_least=${var.serverlog_storage_usage_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.serverlog_storage_usage_threshold_major}%{if var.serverlog_storage_usage_lasting_duration_major != null}, lasting='${var.serverlog_storage_usage_lasting_duration_major}', at_least=${var.serverlog_storage_usage_at_least_percentage_major}%{endif}) and (not when(signal > ${var.serverlog_storage_usage_threshold_critical}%{if var.serverlog_storage_usage_lasting_duration_critical != null}, lasting='${var.serverlog_storage_usage_lasting_duration_critical}', at_least=${var.serverlog_storage_usage_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.serverlog_storage_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.serverlog_storage_usage_disabled_critical, var.serverlog_storage_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.serverlog_storage_usage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.serverlog_storage_usage_runbook_url, var.runbook_url), "")
    tip                   = var.serverlog_storage_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.serverlog_storage_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.serverlog_storage_usage_disabled_major, var.serverlog_storage_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.serverlog_storage_usage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.serverlog_storage_usage_runbook_url, var.runbook_url), "")
    tip                   = var.serverlog_storage_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.serverlog_storage_usage_max_delay
}

