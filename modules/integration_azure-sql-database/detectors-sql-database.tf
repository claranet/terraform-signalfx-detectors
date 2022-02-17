resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure SQL Database heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.Sql/servers/databases') and filter('primary_aggregation_type', 'true')
        signal = data('connection_successful', filter=base_filter and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "cpu" {
  name = format("%s %s", local.detector_name_prefix, "Azure Sql Database CPU")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Sql/servers/databases') and filter('primary_aggregation_type', 'true')
        signal = data('cpu_percent', filter=base_filter and ${module.filtering.signalflow})${var.cpu_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.cpu_threshold_critical}), lasting="${var.cpu_lasting_duration_critical}")).publish('CRIT')
        detect(when(signal > threshold(${var.cpu_threshold_major}), lasting="${var.cpu_lasting_duration_major}") and (not when(signal > ${var.cpu_threshold_critical}, lasting="${var.cpu_lasting_duration_critical}"))).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.cpu_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_disabled_critical, var.cpu_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_notifications, "critical", []), var.notifications.critical)
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
    notifications         = coalescelist(lookup(var.cpu_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.cpu_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cpu_max_delay
}

resource "signalfx_detector" "free_space" {
  name = format("%s %s", local.detector_name_prefix, "Azure SQL Database disk usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Sql/servers/databases') and filter('primary_aggregation_type', 'true')
        signal = data('storage_percent', filter=base_filter and ${module.filtering.signalflow})${var.free_space_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.free_space_threshold_critical}), lasting="${var.free_space_lasting_duration_critical}")).publish('CRIT')
        detect(when(signal > threshold(${var.free_space_threshold_major}), lasting="${var.free_space_lasting_duration_major}") and (not when(signal > ${var.free_space_threshold_critical}, lasting="${var.free_space_lasting_duration_critical}"))).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.free_space_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.free_space_disabled_critical, var.free_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.free_space_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.free_space_runbook_url, var.runbook_url), "")
    tip                   = var.free_space_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.free_space_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.free_space_disabled_major, var.free_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.free_space_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.free_space_runbook_url, var.runbook_url), "")
    tip                   = var.free_space_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.free_space_max_delay
}

resource "signalfx_detector" "dtu_consumption" {
  name = format("%s %s", local.detector_name_prefix, "Azure SQL Database DTU consumption")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Sql/servers/databases') and filter('primary_aggregation_type', 'true')
        signal = data('dtu_consumption_percent', filter=base_filter and ${module.filtering.signalflow})${var.dtu_consumption_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.dtu_consumption_threshold_critical}), lasting="${var.dtu_consumption_lasting_duration_critical}")).publish('CRIT')
        detect(when(signal > threshold(${var.dtu_consumption_threshold_major}), lasting="${var.dtu_consumption_lasting_duration_major}") and (not when(signal > ${var.dtu_consumption_threshold_critical}, lasting="${var.dtu_consumption_lasting_duration_critical}"))).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.dtu_consumption_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.dtu_consumption_disabled_critical, var.dtu_consumption_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.dtu_consumption_notifications, "critical", []), var.notifications.critical)
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
    notifications         = coalescelist(lookup(var.dtu_consumption_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.dtu_consumption_runbook_url, var.runbook_url), "")
    tip                   = var.dtu_consumption_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.dtu_consumption_max_delay
}

resource "signalfx_detector" "deadlocks_count" {
  name = format("%s %s", local.detector_name_prefix, "Azure SQL Database deadlocks count")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Sql/servers/databases') and filter('primary_aggregation_type', 'true')
        signal = data('deadlock', filter=base_filter and ${module.filtering.signalflow})${var.deadlocks_count_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.deadlocks_count_threshold_critical}), lasting="${var.deadlocks_count_lasting_duration_critical}")).publish('CRIT')
    EOF

  rule {
    description           = "is too high > ${var.deadlocks_count_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.deadlocks_count_disabled_critical, var.deadlocks_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.deadlocks_count_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.deadlocks_count_runbook_url, var.runbook_url), "")
    tip                   = var.deadlocks_count_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.deadlocks_count_max_delay
}
