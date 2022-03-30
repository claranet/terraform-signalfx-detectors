resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure App Service Plan heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.Web/serverFarms') and filter('primary_aggregation_type', 'true')
        signal = data('CpuPercentage', filter=base_filter and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "cpu_percentage" {
  name = format("%s %s", local.detector_name_prefix, "Azure App Service Plan CPU percentage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Web/serverFarms') and filter('primary_aggregation_type', 'true')
        signal = data('CpuPercentage', filter=base_filter and ${module.filtering.signalflow})${var.cpu_percentage_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.cpu_percentage_threshold_critical}), lasting="${var.cpu_percentage_lasting_duration_critical}")).publish('CRIT')
        detect(when(signal > threshold(${var.cpu_percentage_threshold_major}), lasting="${var.cpu_percentage_lasting_duration_major}") and (not when(signal > ${var.cpu_percentage_threshold_critical}, lasting="${var.cpu_percentage_lasting_duration_critical}"))).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.cpu_percentage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_percentage_disabled_critical, var.cpu_percentage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_percentage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cpu_percentage_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_percentage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cpu_percentage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_percentage_disabled_major, var.cpu_percentage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_percentage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cpu_percentage_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_percentage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cpu_percentage_max_delay
}

resource "signalfx_detector" "memory_percentage" {
  name = format("%s %s", local.detector_name_prefix, "Azure App Service Plan memory percentage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Web/serverFarms') and filter('primary_aggregation_type', 'true')
        signal = data('MemoryPercentage', filter=base_filter and ${module.filtering.signalflow})${var.memory_percentage_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.memory_percentage_threshold_critical}), lasting="${var.memory_percentage_lasting_duration_critical}")).publish('CRIT')
        detect(when(signal > threshold(${var.memory_percentage_threshold_major}), lasting="${var.memory_percentage_lasting_duration_major}") and (not when(signal > ${var.memory_percentage_threshold_critical}, lasting="${var.memory_percentage_lasting_duration_critical}"))).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.memory_percentage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_percentage_disabled_critical, var.memory_percentage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_percentage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.memory_percentage_runbook_url, var.runbook_url), "")
    tip                   = var.memory_percentage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.memory_percentage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_percentage_disabled_major, var.memory_percentage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_percentage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.memory_percentage_runbook_url, var.runbook_url), "")
    tip                   = var.memory_percentage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memory_percentage_max_delay
}
