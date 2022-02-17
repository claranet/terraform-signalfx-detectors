resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure PostgreSQL heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.DB*orPostgreSQL/servers') and filter('primary_aggregation_type', 'true')
        signal = data('network_bytes_ingress', filter=base_filter and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

  max_delay = var.heartbeat_max_delay
}

resource "signalfx_detector" "cpu_usage" {
  name = format("%s %s", local.detector_name_prefix, "Azure PostgreSQL CPU usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.DB*orPostgreSQL/servers') and filter('primary_aggregation_type', 'true')
        signal = data('cpu_percent', filter=base_filter and ${module.filtering.signalflow})${var.cpu_usage_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.cpu_usage_threshold_critical}), lasting="${var.cpu_usage_lasting_duration_critical}")).publish('CRIT')
        detect(when(signal > threshold(${var.cpu_usage_threshold_major}), lasting="${var.cpu_usage_lasting_duration_major}") and (not when(signal > ${var.cpu_usage_threshold_critical}, lasting="${var.cpu_usage_lasting_duration_critical}"))).publish('MAJOR')
    EOF

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

  max_delay = var.cpu_usage_max_delay
}

resource "signalfx_detector" "no_connection" {
  name = format("%s %s", local.detector_name_prefix, "Azure PostgreSQL has no connection")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.DB*orPostgreSQL/servers') and filter('primary_aggregation_type', 'true')
        signal = data('active_connections', extrapolation="zero", filter=base_filter and ${module.filtering.signalflow})${var.no_connection_aggregation_function}.publish('signal')
        detect(when(signal < threshold(1), lasting="${var.no_connection_lasting_duration_critical}")).publish('CRIT')
    EOF

  rule {
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.no_connection_disabled_critical, var.no_connection_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.no_connection_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.no_connection_runbook_url, var.runbook_url), "")
    tip                   = var.no_connection_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.no_connection_max_delay
}

resource "signalfx_detector" "storage_usage" {
  name = format("%s %s", local.detector_name_prefix, "Azure PostgreSQL storage usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.DB*orPostgreSQL/servers') and filter('primary_aggregation_type', 'true')
        signal = data('storage_percent', filter=base_filter and ${module.filtering.signalflow})${var.storage_usage_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.storage_usage_threshold_critical}), lasting="${var.storage_usage_lasting_duration_critical}")).publish('CRIT')
        detect(when(signal > threshold(${var.storage_usage_threshold_major}), lasting="${var.storage_usage_lasting_duration_major}") and (not when(signal > ${var.storage_usage_threshold_critical}, lasting="${var.storage_usage_lasting_duration_critical}"))).publish('MAJOR')
    EOF

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

  max_delay = var.storage_usage_max_delay
}

resource "signalfx_detector" "io_consumption" {
  name = format("%s %s", local.detector_name_prefix, "Azure PostgreSQL IO consumption")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.DB*orPostgreSQL/servers') and filter('primary_aggregation_type', 'true')
        signal = data('io_consumption_percent', filter=base_filter and ${module.filtering.signalflow})${var.io_consumption_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.io_consumption_threshold_critical}), lasting="${var.io_consumption_lasting_duration_critical}")).publish('CRIT')
        detect(when(signal > threshold(${var.io_consumption_threshold_major}), lasting="${var.io_consumption_lasting_duration_major}") and (not when(signal > ${var.io_consumption_threshold_critical}, lasting="${var.io_consumption_lasting_duration_critical}"))).publish('MAJOR')
    EOF

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

  max_delay = var.io_consumption_max_delay
}

resource "signalfx_detector" "memory_usage" {
  name = format("%s %s", local.detector_name_prefix, "Azure PostgreSQL memory usage ")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.DB*orPostgreSQL/servers') and filter('primary_aggregation_type', 'true')
        signal = data('memory_percent', filter=base_filter and ${module.filtering.signalflow})${var.memory_usage_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.memory_usage_threshold_critical}), lasting="${var.memory_usage_lasting_duration_critical}")).publish('CRIT')
        detect(when(signal > threshold(${var.memory_usage_threshold_major}), lasting="${var.memory_usage_lasting_duration_major}") and (not when(signal > ${var.memory_usage_threshold_critical}, lasting="${var.memory_usage_lasting_duration_critical}"))).publish('MAJOR')
    EOF

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

  max_delay = var.memory_usage_max_delay
}

resource "signalfx_detector" "serverlog_storage_usage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure PostgreSQL serverlog storage usage"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.DB*orPostgreSQL/servers') and filter('primary_aggregation_type', 'true')
        signal = data('serverlog_storage_percent', filter=base_filter and ${module.filtering.signalflow})${var.serverlog_storage_usage_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.serverlog_storage_usage_threshold_critical}), lasting="${var.serverlog_storage_usage_lasting_duration_critical}")).publish('CRIT')
        detect(when(signal > threshold(${var.serverlog_storage_usage_threshold_major}), lasting="${var.serverlog_storage_usage_lasting_duration_major}") and (not when(signal > ${var.serverlog_storage_usage_threshold_critical}, lasting="${var.serverlog_storage_usage_lasting_duration_critical}"))).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.serverlog_storage_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.serverlog_storage_usage_disabled_critical, var.serverlog_storage_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.serverlog_storage_usage_notifications, "critical", []), var.notifications.critical)
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
    notifications         = coalescelist(lookup(var.serverlog_storage_usage_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.serverlog_storage_usage_runbook_url, var.runbook_url), "")
    tip                   = var.serverlog_storage_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.serverlog_storage_usage_max_delay
}

