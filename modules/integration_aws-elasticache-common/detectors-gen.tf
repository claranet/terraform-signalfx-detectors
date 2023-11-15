resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('stat', 'mean') and filter('namespace', 'AWS/ElastiCache')
    signal = data('CPUUtilization', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "evictions" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache evictions")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ElastiCache')
    signal = data('Evictions', filter=base_filtering and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filtering.signalflow})${var.evictions_aggregation_function}${var.evictions_transformation_function}.publish('signal')
    detect(when(signal > ${var.evictions_threshold_major}, lasting=%{if var.evictions_lasting_duration_major == null}None%{else}'${var.evictions_lasting_duration_major}'%{endif}, at_least=${var.evictions_at_least_percentage_major}) and (not when(signal > ${var.evictions_threshold_critical}, lasting=%{if var.evictions_lasting_duration_critical == null}None%{else}'${var.evictions_lasting_duration_critical}'%{endif}, at_least=${var.evictions_at_least_percentage_critical}))).publish('MAJOR')
    detect(when(signal > ${var.evictions_threshold_critical}, lasting=%{if var.evictions_lasting_duration_critical == null}None%{else}'${var.evictions_lasting_duration_critical}'%{endif}, at_least=${var.evictions_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.evictions_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.evictions_disabled_major, var.evictions_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.evictions_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.evictions_runbook_url, var.runbook_url), "")
    tip                   = var.evictions_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.evictions_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.evictions_disabled_critical, var.evictions_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.evictions_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.evictions_runbook_url, var.runbook_url), "")
    tip                   = var.evictions_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.evictions_max_delay
}

resource "signalfx_detector" "max_connection" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache max connection")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ElastiCache')
    signal = data('CurrConnections', filter=base_filtering and filter('stat', 'upper') and filter('CacheNodeId', '*') and ${module.filtering.signalflow})${var.max_connection_aggregation_function}${var.max_connection_transformation_function}.publish('signal')
    detect(when(signal > ${var.max_connection_threshold_critical}, lasting=%{if var.max_connection_lasting_duration_critical == null}None%{else}'${var.max_connection_lasting_duration_critical}'%{endif}, at_least=${var.max_connection_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.max_connection_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.max_connection_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.max_connection_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.max_connection_runbook_url, var.runbook_url), "")
    tip                   = var.max_connection_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.max_connection_max_delay
}

resource "signalfx_detector" "no_connection" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache no connection")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ElastiCache')
    signal = data('CurrConnections', filter=base_filtering and filter('stat', 'lower') and filter('CacheNodeId', '*') and ${module.filtering.signalflow})${var.no_connection_aggregation_function}${var.no_connection_transformation_function}.publish('signal')
    detect(when(signal <= ${var.no_connection_threshold_critical}, lasting=%{if var.no_connection_lasting_duration_critical == null}None%{else}'${var.no_connection_lasting_duration_critical}'%{endif}, at_least=${var.no_connection_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too low <= ${var.no_connection_threshold_critical}"
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

resource "signalfx_detector" "swap" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache swap usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ElastiCache')
    signal = data('SwapUsage', filter=base_filtering and filter('stat', 'upper') and filter('CacheNodeId', '*') and ${module.filtering.signalflow})${var.swap_aggregation_function}${var.swap_transformation_function}.publish('signal')
    detect(when(signal > ${var.swap_threshold_major}, lasting=%{if var.swap_lasting_duration_major == null}None%{else}'${var.swap_lasting_duration_major}'%{endif}, at_least=${var.swap_at_least_percentage_major}) and (not when(signal > ${var.swap_threshold_critical}, lasting=%{if var.swap_lasting_duration_critical == null}None%{else}'${var.swap_lasting_duration_critical}'%{endif}, at_least=${var.swap_at_least_percentage_critical}))).publish('MAJOR')
    detect(when(signal > ${var.swap_threshold_critical}, lasting=%{if var.swap_lasting_duration_critical == null}None%{else}'${var.swap_lasting_duration_critical}'%{endif}, at_least=${var.swap_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.swap_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.swap_disabled_major, var.swap_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.swap_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.swap_runbook_url, var.runbook_url), "")
    tip                   = var.swap_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.swap_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.swap_disabled_critical, var.swap_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.swap_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.swap_runbook_url, var.runbook_url), "")
    tip                   = var.swap_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.swap_max_delay
}

resource "signalfx_detector" "free_memory" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache free memory")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ElastiCache')
    signal = data('FreeableMemory', filter=base_filtering and filter('stat', 'lower') and filter('CacheNodeId', '*') and ${module.filtering.signalflow})${var.free_memory_aggregation_function}${var.free_memory_transformation_function}.publish('signal')
    detect(when(signal < ${var.free_memory_threshold_minor}, lasting=%{if var.free_memory_lasting_duration_minor == null}None%{else}'${var.free_memory_lasting_duration_minor}'%{endif}, at_least=${var.free_memory_at_least_percentage_minor}) and (not when(signal < ${var.free_memory_threshold_major}, lasting=%{if var.free_memory_lasting_duration_major == null}None%{else}'${var.free_memory_lasting_duration_major}'%{endif}, at_least=${var.free_memory_at_least_percentage_major}))).publish('MINOR')
    detect(when(signal < ${var.free_memory_threshold_major}, lasting=%{if var.free_memory_lasting_duration_major == null}None%{else}'${var.free_memory_lasting_duration_major}'%{endif}, at_least=${var.free_memory_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.free_memory_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.free_memory_disabled_minor, var.free_memory_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.free_memory_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.free_memory_runbook_url, var.runbook_url), "")
    tip                   = var.free_memory_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.free_memory_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.free_memory_disabled_major, var.free_memory_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.free_memory_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.free_memory_runbook_url, var.runbook_url), "")
    tip                   = var.free_memory_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.free_memory_max_delay
}

resource "signalfx_detector" "evictions_growing" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache evictions growing")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ElastiCache')
    signal = data('Evictions', filter=base_filtering and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filtering.signalflow})${var.evictions_growing_aggregation_function}${var.evictions_growing_transformation_function}.publish('signal')
    detect(when(signal > ${var.evictions_growing_threshold_major}, lasting=%{if var.evictions_growing_lasting_duration_major == null}None%{else}'${var.evictions_growing_lasting_duration_major}'%{endif}, at_least=${var.evictions_growing_at_least_percentage_major}) and (not when(signal > ${var.evictions_growing_threshold_critical}, lasting=%{if var.evictions_growing_lasting_duration_critical == null}None%{else}'${var.evictions_growing_lasting_duration_critical}'%{endif}, at_least=${var.evictions_growing_at_least_percentage_critical}))).publish('MAJOR')
    detect(when(signal > ${var.evictions_growing_threshold_critical}, lasting=%{if var.evictions_growing_lasting_duration_critical == null}None%{else}'${var.evictions_growing_lasting_duration_critical}'%{endif}, at_least=${var.evictions_growing_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.evictions_growing_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.evictions_growing_disabled_major, var.evictions_growing_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.evictions_growing_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.evictions_growing_runbook_url, var.runbook_url), "")
    tip                   = var.evictions_growing_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.evictions_growing_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.evictions_growing_disabled_critical, var.evictions_growing_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.evictions_growing_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.evictions_growing_runbook_url, var.runbook_url), "")
    tip                   = var.evictions_growing_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.evictions_growing_max_delay
}

