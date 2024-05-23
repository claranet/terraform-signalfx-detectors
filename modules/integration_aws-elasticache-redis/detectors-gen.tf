resource "signalfx_detector" "cache_hits" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache redis cache hit ratio")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*')
    hits = data('CacheHits', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.cache_hits_aggregation_function}${var.cache_hits_transformation_function}
    misses = data('CacheMisses', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.cache_hits_aggregation_function}${var.cache_hits_transformation_function}
    signal = (hits/(hits+misses)).fill(value=1).scale(100).publish('signal')
    detect(when(signal < ${var.cache_hits_threshold_major}%{if var.cache_hits_lasting_duration_major != null}, lasting='${var.cache_hits_lasting_duration_major}', at_least=${var.cache_hits_at_least_percentage_major}%{endif})).publish('MAJOR')
    detect(when(signal < ${var.cache_hits_threshold_minor}%{if var.cache_hits_lasting_duration_minor != null}, lasting='${var.cache_hits_lasting_duration_minor}', at_least=${var.cache_hits_at_least_percentage_minor}%{endif}) and (not when(signal < ${var.cache_hits_threshold_major}%{if var.cache_hits_lasting_duration_major != null}, lasting='${var.cache_hits_lasting_duration_major}', at_least=${var.cache_hits_at_least_percentage_major}%{endif}))).publish('MINOR')
EOF

  rule {
    description           = "is too low < ${var.cache_hits_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cache_hits_disabled_major, var.cache_hits_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cache_hits_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cache_hits_runbook_url, var.runbook_url), "")
    tip                   = var.cache_hits_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.cache_hits_threshold_minor}%"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.cache_hits_disabled_minor, var.cache_hits_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cache_hits_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.cache_hits_runbook_url, var.runbook_url), "")
    tip                   = var.cache_hits_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cache_hits_max_delay
}

resource "signalfx_detector" "cpu_high" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache redis cpu")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ElastiCache') and filter('stat', 'upper') and filter('CacheNodeId', '*')
    signal = data('EngineCPUUtilization', filter=base_filtering and ${module.filtering.signalflow})${var.cpu_high_aggregation_function}${var.cpu_high_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_high_threshold_critical}%{if var.cpu_high_lasting_duration_critical != null}, lasting='${var.cpu_high_lasting_duration_critical}', at_least=${var.cpu_high_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.cpu_high_threshold_major}%{if var.cpu_high_lasting_duration_major != null}, lasting='${var.cpu_high_lasting_duration_major}', at_least=${var.cpu_high_at_least_percentage_major}%{endif}) and (not when(signal > ${var.cpu_high_threshold_critical}%{if var.cpu_high_lasting_duration_critical != null}, lasting='${var.cpu_high_lasting_duration_critical}', at_least=${var.cpu_high_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_high_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_high_disabled_critical, var.cpu_high_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_high_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cpu_high_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_high_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cpu_high_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_high_disabled_major, var.cpu_high_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_high_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cpu_high_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_high_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cpu_high_max_delay
}

resource "signalfx_detector" "replication_lag" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache redis replication lag")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Second"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ElastiCache') and filter('stat', 'upper') and filter('CacheNodeId', '*')
    signal = data('ReplicationLag', filter=base_filtering and ${module.filtering.signalflow})${var.replication_lag_aggregation_function}${var.replication_lag_transformation_function}.publish('signal')
    detect(when(signal > ${var.replication_lag_threshold_critical}%{if var.replication_lag_lasting_duration_critical != null}, lasting='${var.replication_lag_lasting_duration_critical}', at_least=${var.replication_lag_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.replication_lag_threshold_major}%{if var.replication_lag_lasting_duration_major != null}, lasting='${var.replication_lag_lasting_duration_major}', at_least=${var.replication_lag_at_least_percentage_major}%{endif}) and (not when(signal > ${var.replication_lag_threshold_critical}%{if var.replication_lag_lasting_duration_critical != null}, lasting='${var.replication_lag_lasting_duration_critical}', at_least=${var.replication_lag_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

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

  max_delay = var.replication_lag_max_delay
}

resource "signalfx_detector" "commands" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache redis commands")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ElastiCache') and filter('stat', 'lower') and filter('CacheNodeId', '*')
    get = data('GetTypeCmds', filter=base_filtering and ${module.filtering.signalflow})${var.commands_aggregation_function}${var.commands_transformation_function}
    set = data('SetTypeCmds', filter=base_filtering and ${module.filtering.signalflow})${var.commands_aggregation_function}${var.commands_transformation_function}
    signal = (get+set).publish('signal')
    detect(when(signal <= ${var.commands_threshold_major}%{if var.commands_lasting_duration_major != null}, lasting='${var.commands_lasting_duration_major}', at_least=${var.commands_at_least_percentage_major}%{endif})).publish('MAJOR')
EOF

  rule {
    description           = "is too low <= ${var.commands_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.commands_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.commands_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.commands_runbook_url, var.runbook_url), "")
    tip                   = var.commands_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.commands_max_delay
}

resource "signalfx_detector" "network_conntrack_allowance_exceeded" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache redis network conntrack allowance exceeded")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ElastiCache') and filter('stat', 'upper') and filter('CacheNodeId', '*')
    signal = data('NetworkConntrackAllowanceExceeded', filter=base_filtering and ${module.filtering.signalflow})${var.network_conntrack_allowance_exceeded_aggregation_function}${var.network_conntrack_allowance_exceeded_transformation_function}.publish('signal')
    detect(when(signal > ${var.network_conntrack_allowance_exceeded_threshold_critical}%{if var.network_conntrack_allowance_exceeded_lasting_duration_critical != null}, lasting='${var.network_conntrack_allowance_exceeded_lasting_duration_critical}', at_least=${var.network_conntrack_allowance_exceeded_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.network_conntrack_allowance_exceeded_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.network_conntrack_allowance_exceeded_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.network_conntrack_allowance_exceeded_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.network_conntrack_allowance_exceeded_runbook_url, var.runbook_url), "")
    tip                   = var.network_conntrack_allowance_exceeded_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.network_conntrack_allowance_exceeded_max_delay
}

resource "signalfx_detector" "database_capacity_usage" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache redis Database Capacity Usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ElastiCache') and filter('stat', 'upper') and filter('CacheNodeId', '*')
    signal = data('DatabaseCapacityUsagePercentage', filter=base_filtering and ${module.filtering.signalflow})${var.database_capacity_usage_aggregation_function}${var.database_capacity_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.database_capacity_usage_threshold_critical}%{if var.database_capacity_usage_lasting_duration_critical != null}, lasting='${var.database_capacity_usage_lasting_duration_critical}', at_least=${var.database_capacity_usage_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.database_capacity_usage_threshold_major}%{if var.database_capacity_usage_lasting_duration_major != null}, lasting='${var.database_capacity_usage_lasting_duration_major}', at_least=${var.database_capacity_usage_at_least_percentage_major}%{endif}) and (not when(signal > ${var.database_capacity_usage_threshold_critical}%{if var.database_capacity_usage_lasting_duration_critical != null}, lasting='${var.database_capacity_usage_lasting_duration_critical}', at_least=${var.database_capacity_usage_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.database_capacity_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.database_capacity_usage_disabled_critical, var.database_capacity_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.database_capacity_usage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.database_capacity_usage_runbook_url, var.runbook_url), "")
    tip                   = var.database_capacity_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.database_capacity_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.database_capacity_usage_disabled_major, var.database_capacity_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.database_capacity_usage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.database_capacity_usage_runbook_url, var.runbook_url), "")
    tip                   = var.database_capacity_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.database_capacity_usage_max_delay
}
