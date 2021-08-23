resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure Redis heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  max_delay = 900

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.Cache/Redis') and filter('primary_aggregation_type', 'true')
        signal = data('usedmemory', filter=base_filter and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "evictedkeys" {
  name = format("%s %s", local.detector_name_prefix, "Azure Redis evicted keys")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Cache/Redis') and filter('primary_aggregation_type', 'true')
        signal = data('evictedkeys', filter=base_filter and ${module.filtering.signalflow})${var.evictedkeys_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.evictedkeys_threshold_critical}), lasting="${var.evictedkeys_lasting_duration_critical}")).publish('CRIT')
        detect(when(signal > threshold(${var.evictedkeys_threshold_major}), lasting="${var.evictedkeys_lasting_duration_major}") and (not when(signal > ${var.evictedkeys_threshold_critical}, lasting="${var.evictedkeys_lasting_duration_critical}"))).publish('MAJOR')
    EOF

  rule {
    description           = "are too high > ${var.evictedkeys_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.evictedkeys_disabled_critical, var.evictedkeys_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.evictedkeys_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.evictedkeys_runbook_url, var.runbook_url), "")
    tip                   = var.evictedkeys_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "are too high > ${var.evictedkeys_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.evictedkeys_disabled_major, var.evictedkeys_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.evictedkeys_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.evictedkeys_runbook_url, var.runbook_url), "")
    tip                   = var.evictedkeys_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "percent_processor_time" {
  name = format("%s %s", local.detector_name_prefix, "Azure Redis processor time")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Cache/Redis') and filter('primary_aggregation_type', 'true')
        signal = data('percentProcessorTime', filter=base_filter and ${module.filtering.signalflow})${var.percent_processor_time_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.percent_processor_time_threshold_critical}), lasting="${var.percent_processor_time_lasting_duration_critical}")).publish('CRIT')
        detect(when(signal > threshold(${var.percent_processor_time_threshold_major}), lasting="${var.percent_processor_time_lasting_duration_major}") and (not when(signal > ${var.percent_processor_time_threshold_critical}, lasting="${var.percent_processor_time_lasting_duration_critical}"))).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.percent_processor_time_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.percent_processor_time_disabled_critical, var.percent_processor_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.percent_processor_time_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.percent_processor_time_runbook_url, var.runbook_url), "")
    tip                   = var.percent_processor_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.percent_processor_time_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.percent_processor_time_disabled_major, var.percent_processor_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.percent_processor_time_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.percent_processor_time_runbook_url, var.runbook_url), "")
    tip                   = var.percent_processor_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "load" {
  name = format("%s %s", local.detector_name_prefix, "Azure Redis load")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Cache/Redis') and filter('primary_aggregation_type', 'true')
        signal = data('serverLoad', filter=base_filter and ${module.filtering.signalflow})${var.load_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.load_threshold_critical}), lasting="${var.load_lasting_duration_critical}")).publish('CRIT')
        detect(when(signal > threshold(${var.load_threshold_major}), lasting="${var.load_lasting_duration_major}") and (not when(signal > ${var.load_threshold_critical}, lasting="${var.load_lasting_duration_critical}"))).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.load_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.load_disabled_critical, var.load_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.load_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.load_runbook_url, var.runbook_url), "")
    tip                   = var.load_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.load_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.load_disabled_major, var.load_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.load_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.load_runbook_url, var.runbook_url), "")
    tip                   = var.load_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}
