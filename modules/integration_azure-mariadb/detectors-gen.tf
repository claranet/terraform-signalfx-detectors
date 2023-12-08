resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure MariaDB heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('resource_type', 'Microsoft.DB*orMariaDB/servers') and filter('primary_aggregation_type', 'true')
    signal = data('active_connections', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "cpu" {
  name = format("%s %s", local.detector_name_prefix, "Azure MariaDB cpu usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DB*orMariaDB/servers') and filter('primary_aggregation_type', 'true')
    signal = data('cpu_percent', filter=base_filtering and ${module.filtering.signalflow})${var.cpu_aggregation_function}${var.cpu_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_threshold_major}%{if var.cpu_lasting_duration_major != null}, lasting='${var.cpu_lasting_duration_major}', at_least=${var.cpu_at_least_percentage_major}%{endif}) and (not when(signal > ${var.cpu_threshold_critical}%{if var.cpu_lasting_duration_critical != null}, lasting='${var.cpu_lasting_duration_critical}', at_least=${var.cpu_at_least_percentage_critical}%{endif}))).publish('MAJOR')
    detect(when(signal > ${var.cpu_threshold_critical}%{if var.cpu_lasting_duration_critical != null}, lasting='${var.cpu_lasting_duration_critical}', at_least=${var.cpu_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.cpu_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_disabled_major, var.cpu_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cpu_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cpu_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_disabled_critical, var.cpu_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cpu_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cpu_max_delay
}

resource "signalfx_detector" "storage" {
  name = format("%s %s", local.detector_name_prefix, "Azure MariaDB storage usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DB*orMariaDB/servers') and filter('primary_aggregation_type', 'true')
    signal = data('storage_percent', filter=base_filtering and ${module.filtering.signalflow})${var.storage_aggregation_function}${var.storage_transformation_function}.publish('signal')
    detect(when(signal > ${var.storage_threshold_critical}%{if var.storage_lasting_duration_critical != null}, lasting='${var.storage_lasting_duration_critical}', at_least=${var.storage_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.storage_threshold_major}%{if var.storage_lasting_duration_major != null}, lasting='${var.storage_lasting_duration_major}', at_least=${var.storage_at_least_percentage_major}%{endif}) and (not when(signal > ${var.storage_threshold_critical}%{if var.storage_lasting_duration_critical != null}, lasting='${var.storage_lasting_duration_critical}', at_least=${var.storage_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.storage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.storage_disabled_critical, var.storage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.storage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.storage_runbook_url, var.runbook_url), "")
    tip                   = var.storage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.storage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.storage_disabled_major, var.storage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.storage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.storage_runbook_url, var.runbook_url), "")
    tip                   = var.storage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.storage_max_delay
}

resource "signalfx_detector" "io" {
  name = format("%s %s", local.detector_name_prefix, "Azure MariaDB io consumption")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DB*orMariaDB/servers') and filter('primary_aggregation_type', 'true')
    signal = data('io_consumption_percent', filter=base_filtering and ${module.filtering.signalflow})${var.io_aggregation_function}${var.io_transformation_function}.publish('signal')
    detect(when(signal > ${var.io_threshold_major}%{if var.io_lasting_duration_major != null}, lasting='${var.io_lasting_duration_major}', at_least=${var.io_at_least_percentage_major}%{endif}) and (not when(signal > ${var.io_threshold_critical}%{if var.io_lasting_duration_critical != null}, lasting='${var.io_lasting_duration_critical}', at_least=${var.io_at_least_percentage_critical}%{endif}))).publish('MAJOR')
    detect(when(signal > ${var.io_threshold_critical}%{if var.io_lasting_duration_critical != null}, lasting='${var.io_lasting_duration_critical}', at_least=${var.io_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.io_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.io_disabled_major, var.io_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.io_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.io_runbook_url, var.runbook_url), "")
    tip                   = var.io_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.io_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.io_disabled_critical, var.io_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.io_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.io_runbook_url, var.runbook_url), "")
    tip                   = var.io_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.io_max_delay
}

resource "signalfx_detector" "memory" {
  name = format("%s %s", local.detector_name_prefix, "Azure MariaDB memory usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DB*orMariaDB/servers') and filter('primary_aggregation_type', 'true')
    signal = data('memory_percent', filter=base_filtering and ${module.filtering.signalflow})${var.memory_aggregation_function}${var.memory_transformation_function}.publish('signal')
    detect(when(signal > ${var.memory_threshold_critical}%{if var.memory_lasting_duration_critical != null}, lasting='${var.memory_lasting_duration_critical}', at_least=${var.memory_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.memory_threshold_major}%{if var.memory_lasting_duration_major != null}, lasting='${var.memory_lasting_duration_major}', at_least=${var.memory_at_least_percentage_major}%{endif}) and (not when(signal > ${var.memory_threshold_critical}%{if var.memory_lasting_duration_critical != null}, lasting='${var.memory_lasting_duration_critical}', at_least=${var.memory_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memory_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_disabled_critical, var.memory_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.memory_runbook_url, var.runbook_url), "")
    tip                   = var.memory_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.memory_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_disabled_major, var.memory_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.memory_runbook_url, var.runbook_url), "")
    tip                   = var.memory_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memory_max_delay
}

resource "signalfx_detector" "replication_lag" {
  name = format("%s %s", local.detector_name_prefix, "Azure MariaDB replication lag")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Second"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DB*orMariaDB/servers') and filter('primary_aggregation_type', 'true')
    signal = data('seconds_behind_master', filter=base_filtering and ${module.filtering.signalflow})${var.replication_lag_aggregation_function}${var.replication_lag_transformation_function}.publish('signal')
    detect(when(signal > ${var.replication_lag_threshold_major}%{if var.replication_lag_lasting_duration_major != null}, lasting='${var.replication_lag_lasting_duration_major}', at_least=${var.replication_lag_at_least_percentage_major}%{endif}) and (not when(signal > ${var.replication_lag_threshold_critical}%{if var.replication_lag_lasting_duration_critical != null}, lasting='${var.replication_lag_lasting_duration_critical}', at_least=${var.replication_lag_at_least_percentage_critical}%{endif}))).publish('MAJOR')
    detect(when(signal > ${var.replication_lag_threshold_critical}%{if var.replication_lag_lasting_duration_critical != null}, lasting='${var.replication_lag_lasting_duration_critical}', at_least=${var.replication_lag_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.replication_lag_threshold_major}Second"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.replication_lag_disabled_major, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.replication_lag_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.replication_lag_runbook_url, var.runbook_url), "")
    tip                   = var.replication_lag_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.replication_lag_threshold_critical}Second"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.replication_lag_disabled_critical, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.replication_lag_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.replication_lag_runbook_url, var.runbook_url), "")
    tip                   = var.replication_lag_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.replication_lag_max_delay
}

