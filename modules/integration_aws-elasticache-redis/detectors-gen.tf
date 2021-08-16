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
    hits = data('CacheHits', filter=base_filtering and ${module.filtering.signalflow})${var.cache_hits_aggregation_function}${var.cache_hits_transformation_function}
    misses = data('CacheMisses', filter=base_filtering and ${module.filtering.signalflow})${var.cache_hits_aggregation_function}${var.cache_hits_transformation_function}
    signal = (hits/(hits+misses).fill(value=1).scale(100).publish('signal')
    detect(when(signal < ${var.cache_hits_threshold_critical}, lasting=%{if var.cache_hits_lasting_duration_critical == null}None%{else}'${var.cache_hits_lasting_duration_critical}'%{endif}, at_least=${var.cache_hits_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal < ${var.cache_hits_threshold_major}, lasting=%{if var.cache_hits_lasting_duration_major == null}None%{else}'${var.cache_hits_lasting_duration_major}'%{endif}, at_least=${var.cache_hits_at_least_percentage_major}) and (not when(signal < ${var.cache_hits_threshold_critical}, lasting=%{if var.cache_hits_lasting_duration_critical == null}None%{else}'${var.cache_hits_lasting_duration_critical}'%{endif}, at_least=${var.cache_hits_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.cache_hits_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cache_hits_disabled_critical, var.cache_hits_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cache_hits_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.cache_hits_runbook_url, var.runbook_url), "")
    tip                   = var.cache_hits_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.cache_hits_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cache_hits_disabled_major, var.cache_hits_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cache_hits_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.cache_hits_runbook_url, var.runbook_url), "")
    tip                   = var.cache_hits_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
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
    detect(when(signal > ${var.cpu_high_threshold_critical}, lasting=%{if var.cpu_high_lasting_duration_critical == null}None%{else}'${var.cpu_high_lasting_duration_critical}'%{endif}, at_least=${var.cpu_high_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_high_threshold_major}, lasting=%{if var.cpu_high_lasting_duration_major == null}None%{else}'${var.cpu_high_lasting_duration_major}'%{endif}, at_least=${var.cpu_high_at_least_percentage_major}) and (not when(signal > ${var.cpu_high_threshold_critical}, lasting=%{if var.cpu_high_lasting_duration_critical == null}None%{else}'${var.cpu_high_lasting_duration_critical}'%{endif}, at_least=${var.cpu_high_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_high_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_high_disabled_critical, var.cpu_high_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_high_notifications, "critical", []), var.notifications.critical)
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
    notifications         = coalescelist(lookup(var.cpu_high_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.cpu_high_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_high_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "replication_lag" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache redis replication lag")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "s"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ElastiCache') and filter('stat', 'upper') and filter('CacheNodeId', '*')
    signal = data('ReplicationLag', filter=base_filtering and ${module.filtering.signalflow})${var.replication_lag_aggregation_function}${var.replication_lag_transformation_function}.publish('signal')
    detect(when(signal > ${var.replication_lag_threshold_critical}, lasting=%{if var.replication_lag_lasting_duration_critical == null}None%{else}'${var.replication_lag_lasting_duration_critical}'%{endif}, at_least=${var.replication_lag_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.replication_lag_threshold_major}, lasting=%{if var.replication_lag_lasting_duration_major == null}None%{else}'${var.replication_lag_lasting_duration_major}'%{endif}, at_least=${var.replication_lag_at_least_percentage_major}) and (not when(signal > ${var.replication_lag_threshold_critical}, lasting=%{if var.replication_lag_lasting_duration_critical == null}None%{else}'${var.replication_lag_lasting_duration_critical}'%{endif}, at_least=${var.replication_lag_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.replication_lag_threshold_critical}s"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.replication_lag_disabled_critical, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.replication_lag_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.replication_lag_runbook_url, var.runbook_url), "")
    tip                   = var.replication_lag_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.replication_lag_threshold_major}s"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.replication_lag_disabled_major, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.replication_lag_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.replication_lag_runbook_url, var.runbook_url), "")
    tip                   = var.replication_lag_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
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
    detect(when(signal <= ${var.commands_threshold_major}, lasting=%{if var.commands_lasting_duration_major == null}None%{else}'${var.commands_lasting_duration_major}'%{endif}, at_least=${var.commands_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too low <= ${var.commands_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.commands_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.commands_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.commands_runbook_url, var.runbook_url), "")
    tip                   = var.commands_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

