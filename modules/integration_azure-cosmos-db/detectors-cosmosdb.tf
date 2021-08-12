resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure Cosmos DB heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.DocumentDB/databaseAccounts') and filter('primary_aggregation_type', 'true')
        signal = data('AvailableStorage', filter=base_filter and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "db_4xx_requests" {
  name = format("%s %s", local.detector_name_prefix, "Azure Cosmos DB 4xx request rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.DocumentDB/databaseAccounts') and filter('primary_aggregation_type', 'true')
        A = data('TotalRequests', extrapolation='zero', filter=base_filter and filter('statuscode', '4*') and ${module.filtering.signalflow})${var.db_4xx_requests_aggregation_function}
        B = data('TotalRequests', extrapolation='zero', filter=base_filter and ${module.filtering.signalflow})${var.db_4xx_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.db_4xx_requests_threshold_critical}), lasting="${var.db_4xx_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.db_4xx_requests_threshold_major}), lasting="${var.db_4xx_requests_timer}") and (not when(signal > ${var.db_4xx_requests_threshold_critical}))).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.db_4xx_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.db_4xx_requests_disabled_critical, var.db_4xx_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.db_4xx_requests_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.db_4xx_requests_runbook_url, var.runbook_url), "")
    tip                   = var.db_4xx_requests_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.db_4xx_requests_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.db_4xx_requests_disabled_major, var.db_4xx_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.db_4xx_requests_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.db_4xx_requests_runbook_url, var.runbook_url), "")
    tip                   = var.db_4xx_requests_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "db_5xx_requests" {
  name = format("%s %s", local.detector_name_prefix, "Azure Cosmos DB 5xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.DocumentDB/databaseAccounts') and filter('primary_aggregation_type', 'true')
        A = data('TotalRequests', extrapolation='zero', filter=base_filter and filter('statuscode', '5*') and ${module.filtering.signalflow})${var.db_5xx_requests_aggregation_function}
        B = data('TotalRequests', extrapolation='zero', filter=base_filter and ${module.filtering.signalflow})${var.db_5xx_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.db_5xx_requests_threshold_critical}), lasting="${var.db_5xx_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.db_5xx_requests_threshold_major}), lasting="${var.db_5xx_requests_timer}") and (not when(signal > ${var.db_5xx_requests_threshold_critical}))).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.db_5xx_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.db_5xx_requests_disabled_critical, var.db_5xx_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.db_5xx_requests_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.db_5xx_requests_runbook_url, var.runbook_url), "")
    tip                   = var.db_5xx_requests_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.db_5xx_requests_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.db_5xx_requests_disabled_major, var.db_5xx_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.db_5xx_requests_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.db_5xx_requests_runbook_url, var.runbook_url), "")
    tip                   = var.db_5xx_requests_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "scaling" {
  name = format("%s %s", local.detector_name_prefix, "Azure Cosmos DB scaling errors rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.DocumentDB/databaseAccounts') and filter('primary_aggregation_type', 'true')
        A = data('TotalRequests', extrapolation='zero', filter=base_filter and filter('statuscode', '429') and ${module.filtering.signalflow})${var.scaling_aggregation_function}
        B = data('TotalRequests', extrapolation='zero', filter=base_filter and ${module.filtering.signalflow})${var.scaling_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.scaling_threshold_critical}), lasting="${var.scaling_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.scaling_threshold_major}), lasting="${var.scaling_timer}") and (not when(signal > ${var.scaling_threshold_critical}))).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.scaling_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.scaling_disabled_critical, var.scaling_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.scaling_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.scaling_runbook_url, var.runbook_url), "")
    tip                   = var.scaling_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.scaling_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.scaling_disabled_major, var.scaling_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.scaling_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.scaling_runbook_url, var.runbook_url), "")
    tip                   = var.scaling_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "used_rus_capacity" {
  name = format("%s %s", local.detector_name_prefix, "Azure Cosmos DB used RUs capacity")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filter = filter('resource_type', 'Microsoft.DocumentDB/databaseAccounts') and filter('primary_aggregation_type', 'true')
    signal = data('NormalizedruConsumption', filter=base_filter and ${module.filtering.signalflow})${var.used_rus_capacity_aggregation_function}${var.used_rus_capacity_transformation_function}.publish('signal')
    detect(when(signal > ${var.used_rus_capacity_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.used_rus_capacity_threshold_major}) and (not when(signal > ${var.used_rus_capacity_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.used_rus_capacity_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.used_rus_capacity_disabled_critical, var.used_rus_capacity_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.used_rus_capacity_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.used_rus_capacity_runbook_url, var.runbook_url), "")
    tip                   = var.used_rus_capacity_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.used_rus_capacity_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.used_rus_capacity_disabled_major, var.used_rus_capacity_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.used_rus_capacity_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.used_rus_capacity_runbook_url, var.runbook_url), "")
    tip                   = var.used_rus_capacity_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}
