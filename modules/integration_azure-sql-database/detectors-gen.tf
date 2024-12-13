resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure SQL Database heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('resource_type', 'Microsoft.Sql/servers/databases') and filter('primary_aggregation_type', 'true')
    signal = data('sessions_count', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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
  name = format("%s %s", local.detector_name_prefix, "Azure SQL Database cpu")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Sql/servers/databases') and filter('primary_aggregation_type', 'true')
    signal = data('cpu_percent', filter=base_filtering and ${module.filtering.signalflow})${var.cpu_aggregation_function}${var.cpu_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_threshold_critical}%{if var.cpu_lasting_duration_critical != null}, lasting='${var.cpu_lasting_duration_critical}', at_least=${var.cpu_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.cpu_threshold_major}%{if var.cpu_lasting_duration_major != null}, lasting='${var.cpu_lasting_duration_major}', at_least=${var.cpu_at_least_percentage_major}%{endif}) and (not when(signal > ${var.cpu_threshold_critical}%{if var.cpu_lasting_duration_critical != null}, lasting='${var.cpu_lasting_duration_critical}', at_least=${var.cpu_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

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

  max_delay = var.cpu_max_delay
}

resource "signalfx_detector" "storage_usage" {
  name = format("%s %s", local.detector_name_prefix, "Azure SQL Database storage usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Sql/servers/databases') and filter('primary_aggregation_type', 'true')
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

resource "signalfx_detector" "deadlocks_count" {
  name = format("%s %s", local.detector_name_prefix, "Azure SQL Database deadlocks count")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Sql/servers/databases') and filter('primary_aggregation_type', 'true')
    signal = data('deadlock', filter=base_filtering and ${module.filtering.signalflow})${var.deadlocks_count_aggregation_function}${var.deadlocks_count_transformation_function}.publish('signal')
    detect(when(signal > ${var.deadlocks_count_threshold_critical}%{if var.deadlocks_count_lasting_duration_critical != null}, lasting='${var.deadlocks_count_lasting_duration_critical}', at_least=${var.deadlocks_count_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.deadlocks_count_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.deadlocks_count_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.deadlocks_count_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.deadlocks_count_runbook_url, var.runbook_url), "")
    tip                   = var.deadlocks_count_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.deadlocks_count_max_delay
}

resource "signalfx_detector" "dtu_consumption" {
  name = format("%s %s", local.detector_name_prefix, "Azure SQL Database dtu consumption")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Sql/servers/databases') and filter('primary_aggregation_type', 'true')
    signal = data('dtu_consumption_percent', filter=base_filtering and ${module.filtering.signalflow})${var.dtu_consumption_aggregation_function}${var.dtu_consumption_transformation_function}.publish('signal')
    detect(when(signal > ${var.dtu_consumption_threshold_critical}%{if var.dtu_consumption_lasting_duration_critical != null}, lasting='${var.dtu_consumption_lasting_duration_critical}', at_least=${var.dtu_consumption_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.dtu_consumption_threshold_major}%{if var.dtu_consumption_lasting_duration_major != null}, lasting='${var.dtu_consumption_lasting_duration_major}', at_least=${var.dtu_consumption_at_least_percentage_major}%{endif}) and (not when(signal > ${var.dtu_consumption_threshold_critical}%{if var.dtu_consumption_lasting_duration_critical != null}, lasting='${var.dtu_consumption_lasting_duration_critical}', at_least=${var.dtu_consumption_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.dtu_consumption_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.dtu_consumption_disabled_critical, var.dtu_consumption_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.dtu_consumption_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.dtu_consumption_runbook_url, var.runbook_url), "")
    tip                   = var.dtu_consumption_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.dtu_consumption_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.dtu_consumption_disabled_major, var.dtu_consumption_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.dtu_consumption_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.dtu_consumption_runbook_url, var.runbook_url), "")
    tip                   = var.dtu_consumption_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.dtu_consumption_max_delay
}

