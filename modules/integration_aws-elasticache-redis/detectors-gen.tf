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
    hits = data('CacheHits', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.cache_hits_aggregation_function}${var.cache_hits_transformation_function}
    misses = data('CacheMisses', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.cache_hits_aggregation_function}${var.cache_hits_transformation_function}
    signal = (hits/(hits+misses)).fill(value=1).scale(100).publish('signal')
    detect(when(signal < ${var.cache_hits_threshold_major}, lasting=%{if var.cache_hits_lasting_duration_major == null}None%{else}'${var.cache_hits_lasting_duration_major}'%{endif}, at_least=${var.cache_hits_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal < ${var.cache_hits_threshold_minor}, lasting=%{if var.cache_hits_lasting_duration_minor == null}None%{else}'${var.cache_hits_lasting_duration_minor}'%{endif}, at_least=${var.cache_hits_at_least_percentage_minor}) and (not when(signal < ${var.cache_hits_threshold_major}, lasting=%{if var.cache_hits_lasting_duration_major == null}None%{else}'${var.cache_hits_lasting_duration_major}'%{endif}, at_least=${var.cache_hits_at_least_percentage_major}))).publish('MINOR')
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
    signal = data('EngineCPUUtilization', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'upper') and filter('CacheNodeId', '*') and ${module.filtering.signalflow})${var.cpu_high_aggregation_function}${var.cpu_high_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_high_threshold_critical}, lasting=%{if var.cpu_high_lasting_duration_critical == null}None%{else}'${var.cpu_high_lasting_duration_critical}'%{endif}, at_least=${var.cpu_high_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_high_threshold_major}, lasting=%{if var.cpu_high_lasting_duration_major == null}None%{else}'${var.cpu_high_lasting_duration_major}'%{endif}, at_least=${var.cpu_high_at_least_percentage_major}) and (not when(signal > ${var.cpu_high_threshold_critical}, lasting=%{if var.cpu_high_lasting_duration_critical == null}None%{else}'${var.cpu_high_lasting_duration_critical}'%{endif}, at_least=${var.cpu_high_at_least_percentage_critical}))).publish('MAJOR')
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
    signal = data('ReplicationLag', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'upper') and filter('CacheNodeId', '*') and ${module.filtering.signalflow})${var.replication_lag_aggregation_function}${var.replication_lag_transformation_function}.publish('signal')
    detect(when(signal > ${var.replication_lag_threshold_critical}, lasting=%{if var.replication_lag_lasting_duration_critical == null}None%{else}'${var.replication_lag_lasting_duration_critical}'%{endif}, at_least=${var.replication_lag_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.replication_lag_threshold_major}, lasting=%{if var.replication_lag_lasting_duration_major == null}None%{else}'${var.replication_lag_lasting_duration_major}'%{endif}, at_least=${var.replication_lag_at_least_percentage_major}) and (not when(signal > ${var.replication_lag_threshold_critical}, lasting=%{if var.replication_lag_lasting_duration_critical == null}None%{else}'${var.replication_lag_lasting_duration_critical}'%{endif}, at_least=${var.replication_lag_at_least_percentage_critical}))).publish('MAJOR')
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
    get = data('GetTypeCmds', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'lower') and filter('CacheNodeId', '*') and ${module.filtering.signalflow})${var.commands_aggregation_function}${var.commands_transformation_function}
    set = data('SetTypeCmds', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'lower') and filter('CacheNodeId', '*') and ${module.filtering.signalflow})${var.commands_aggregation_function}${var.commands_transformation_function}
    signal = (get+set).publish('signal')
    detect(when(signal <= ${var.commands_threshold_major}, lasting=%{if var.commands_lasting_duration_major == null}None%{else}'${var.commands_lasting_duration_major}'%{endif}, at_least=${var.commands_at_least_percentage_major})).publish('MAJOR')
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

