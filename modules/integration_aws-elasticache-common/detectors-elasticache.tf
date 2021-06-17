resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('CPUUtilization', filter=filter('stat', 'mean') and filter('namespace', 'AWS/ElastiCache') and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "evictions" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache evictions")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    signal = data('Evictions', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filtering.signalflow})${var.evictions_aggregation_function}${var.evictions_transformation_function}.publish('signal')
    detect(when(signal > ${var.evictions_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.evictions_threshold_major}) and when(signal <= ${var.evictions_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.evictions_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.evictions_disabled_critical, var.evictions_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.evictions_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.evictions_runbook_url, var.runbook_url), "")
    tip                   = var.evictions_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.evictions_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.evictions_disabled_major, var.evictions_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.evictions_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.evictions_runbook_url, var.runbook_url), "")
    tip                   = var.evictions_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "max_connection" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache connections over max allowed")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    signal = data('CurrConnections', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'upper') and filter('CacheNodeId', '*') and ${module.filtering.signalflow})${var.max_connection_aggregation_function}${var.max_connection_transformation_function}.publish('signal')
    detect(when(signal > ${var.max_connection_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.max_connection_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.max_connection_disabled_critical, var.max_connection_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.max_connection_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.max_connection_runbook_url, var.runbook_url), "")
    tip                   = var.max_connection_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "no_connection" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache current connections")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    signal = data('CurrConnections', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'lower') and filter('CacheNodeId', '*') and ${module.filtering.signalflow})${var.no_connection_aggregation_function}${var.no_connection_transformation_function}.publish('signal')
    detect(when(signal <= ${var.no_connection_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "are too low <= ${var.no_connection_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.no_connection_disabled_critical, var.no_connection_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.no_connection_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.no_connection_runbook_url, var.runbook_url), "")
    tip                   = var.no_connection_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "swap" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache swap")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    signal = data('SwapUsage', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'upper') and filter('CacheNodeId', '*') and ${module.filtering.signalflow})${var.swap_aggregation_function}${var.swap_transformation_function}.publish('signal')
    detect(when(signal > ${var.swap_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.swap_threshold_major}) and when(signal <= ${var.swap_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.swap_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.swap_disabled_critical, var.swap_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.swap_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.swap_runbook_url, var.runbook_url), "")
    tip                   = var.swap_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.swap_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.swap_disabled_major, var.swap_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.swap_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.swap_runbook_url, var.runbook_url), "")
    tip                   = var.swap_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "free_memory" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache freeable memory")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    signal = data('FreeableMemory', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'lower') and filter('CacheNodeId', '*') and ${module.filtering.signalflow}).rateofchange()${var.free_memory_aggregation_function}${var.free_memory_transformation_function}.publish('signal')
    detect(when(signal < ${var.free_memory_threshold_major})).publish('MAJOR')
    detect(when(signal < ${var.free_memory_threshold_minor}) and when(signal >= ${var.free_memory_threshold_major})).publish('MINOR')
EOF

  rule {
    description           = "is too low < ${var.free_memory_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.free_memory_disabled_major, var.free_memory_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.free_memory_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.free_memory_runbook_url, var.runbook_url), "")
    tip                   = var.free_memory_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too low < ${var.free_memory_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.free_memory_disabled_minor, var.free_memory_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.free_memory_notifications, "minor", []), var.notifications.minor)
    runbook_url           = try(coalesce(var.free_memory_runbook_url, var.runbook_url), "")
    tip                   = var.free_memory_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "evictions_growing" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache evictions changing rate grows")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    signal = data('Evictions', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filtering.signalflow})${var.evictions_growing_aggregation_function}${var.evictions_growing_transformation_function}.rateofchange().scale(100).publish('signal')
    detect(when(signal > ${var.evictions_growing_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.evictions_growing_threshold_major}) and when(signal <= ${var.evictions_growing_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "too fast > ${var.evictions_growing_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.evictions_growing_disabled_critical, var.evictions_growing_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.evictions_growing_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.evictions_growing_runbook_url, var.runbook_url), "")
    tip                   = var.evictions_growing_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "too fast > ${var.evictions_growing_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.evictions_growing_disabled_major, var.evictions_growing_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.evictions_growing_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.evictions_growing_runbook_url, var.runbook_url), "")
    tip                   = var.evictions_growing_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

