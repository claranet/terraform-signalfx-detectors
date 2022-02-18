resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Redis heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('bytes.used_memory', filter=filter('plugin', 'redis_info') and ${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "evicted_keys" {
  name = format("%s %s", local.detector_name_prefix, "Redis evicted keys rate of change")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('counter.evicted_keys', filter=filter('plugin', 'redis_info') and ${module.filtering.signalflow}, rollup='delta').rateofchange()${var.evicted_keys_aggregation_function}${var.evicted_keys_transformation_function}.publish('signal')
    detect(when(signal > ${var.evicted_keys_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.evicted_keys_threshold_major}) and (not when(signal > ${var.evicted_keys_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "are too high > ${var.evicted_keys_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.evicted_keys_disabled_critical, var.evicted_keys_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.evicted_keys_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.evicted_keys_runbook_url, var.runbook_url), "")
    tip                   = var.evicted_keys_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "are too high > ${var.evicted_keys_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.evicted_keys_disabled_major, var.evicted_keys_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.evicted_keys_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.evicted_keys_runbook_url, var.runbook_url), "")
    tip                   = var.evicted_keys_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.evicted_keys_max_delay
}

resource "signalfx_detector" "expirations" {
  name = format("%s %s", local.detector_name_prefix, "Redis expired keys rate of change")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('counter.expired_keys', filter=filter('plugin', 'redis_info') and ${module.filtering.signalflow}, rollup='delta').rateofchange()${var.expirations_aggregation_function}${var.expirations_transformation_function}.publish('signal')
    detect(when(signal > ${var.expirations_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.expirations_threshold_major}) and (not when(signal > ${var.expirations_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "are too high > ${var.expirations_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.expirations_disabled_critical, var.expirations_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.expirations_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.expirations_runbook_url, var.runbook_url), "")
    tip                   = var.expirations_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "are too high > ${var.expirations_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.expirations_disabled_major, var.expirations_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.expirations_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.expirations_runbook_url, var.runbook_url), "")
    tip                   = var.expirations_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.expirations_max_delay
}

resource "signalfx_detector" "blocked_clients" {
  name = format("%s %s", local.detector_name_prefix, "Redis blocked client rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('gauge.blocked_clients', filter=filter('plugin', 'redis_info') and ${module.filtering.signalflow})${var.blocked_clients_aggregation_function}${var.blocked_clients_transformation_function}
    B = data('gauge.connected_clients', filter=filter('plugin', 'redis_info') and ${module.filtering.signalflow})${var.blocked_clients_aggregation_function}${var.blocked_clients_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.blocked_clients_threshold_minor})).publish('MINOR')
    detect(when(signal > ${var.blocked_clients_threshold_warning}) and (not when(signal > ${var.blocked_clients_threshold_minor}))).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.blocked_clients_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.blocked_clients_disabled_minor, var.blocked_clients_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.blocked_clients_notifications, "minor", []), var.notifications.minor)
    runbook_url           = try(coalesce(var.blocked_clients_runbook_url, var.runbook_url), "")
    tip                   = var.blocked_clients_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.blocked_clients_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.blocked_clients_disabled_warning, var.blocked_clients_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.blocked_clients_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.blocked_clients_runbook_url, var.runbook_url), "")
    tip                   = var.blocked_clients_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.blocked_clients_max_delay
}

resource "signalfx_detector" "keyspace_full" {
  name = format("%s %s", local.detector_name_prefix, "Redis keyspace seems full")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('gauge.db0_keys', filter=filter('plugin', 'redis_info') and ${module.filtering.signalflow}).rateofchange().abs()${var.keyspace_full_aggregation_function}${var.keyspace_full_transformation_function}.publish('signal')
    detect(when(signal == 0)).publish('MAJOR')
EOF

  rule {
    description           = "because number of keys saturates"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.keyspace_full_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.keyspace_full_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.keyspace_full_runbook_url, var.runbook_url), "")
    tip                   = var.keyspace_full_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.keyspace_full_max_delay
}

resource "signalfx_detector" "memory_used_max" {
  name = format("%s %s", local.detector_name_prefix, "Redis memory used over max memory (if configured)")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('bytes.used_memory', filter=filter('plugin', 'redis_info') and ${module.filtering.signalflow})${var.memory_used_max_aggregation_function}${var.memory_used_max_transformation_function}
    B = data('bytes.maxmemory', filter=filter('plugin', 'redis_info') and ${module.filtering.signalflow})${var.memory_used_max_aggregation_function}${var.memory_used_max_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.memory_used_max_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.memory_used_max_threshold_major}) and (not when(signal > ${var.memory_used_max_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memory_used_max_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_used_max_disabled_critical, var.memory_used_max_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_used_max_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.memory_used_max_runbook_url, var.runbook_url), "")
    tip                   = var.memory_used_max_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.memory_used_max_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_used_max_disabled_major, var.memory_used_max_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_used_max_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.memory_used_max_runbook_url, var.runbook_url), "")
    tip                   = var.memory_used_max_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memory_used_max_max_delay
}

resource "signalfx_detector" "memory_used_total" {
  name = format("%s %s", local.detector_name_prefix, "Redis memory used over total system memory")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('bytes.used_memory', filter=filter('plugin', 'redis_info') and ${module.filtering.signalflow})${var.memory_used_total_aggregation_function}${var.memory_used_total_transformation_function}
    B = data('bytes.total_system_memory', filter=filter('plugin', 'redis_info') and ${module.filtering.signalflow})${var.memory_used_total_aggregation_function}${var.memory_used_total_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.memory_used_total_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.memory_used_total_threshold_major}) and (not when(signal > ${var.memory_used_total_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memory_used_total_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_used_total_disabled_critical, var.memory_used_total_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_used_total_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.memory_used_total_runbook_url, var.runbook_url), "")
    tip                   = var.memory_used_total_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.memory_used_total_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_used_total_disabled_major, var.memory_used_total_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_used_total_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.memory_used_total_runbook_url, var.runbook_url), "")
    tip                   = var.memory_used_total_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memory_used_total_max_delay
}

resource "signalfx_detector" "memory_frag_high" {
  name = format("%s %s", local.detector_name_prefix, "Redis memory fragmentation ratio (excessive fragmentation)")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('bytes.used_memory_rss', filter=filter('plugin', 'redis_info') and ${module.filtering.signalflow}, rollup='average')${var.memory_frag_high_aggregation_function}${var.memory_frag_high_transformation_function}
    B = data('bytes.used_memory', filter=filter('plugin', 'redis_info') and ${module.filtering.signalflow}, rollup='average')${var.memory_frag_high_aggregation_function}${var.memory_frag_high_transformation_function}
    signal = (A/B).publish('signal')
    detect(when(signal > ${var.memory_frag_high_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.memory_frag_high_threshold_major}) and (not when(signal > ${var.memory_frag_high_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memory_frag_high_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_frag_high_disabled_critical, var.memory_frag_high_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_frag_high_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.memory_frag_high_runbook_url, var.runbook_url), "")
    tip                   = var.memory_frag_high_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.memory_frag_high_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_frag_high_disabled_major, var.memory_frag_high_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_frag_high_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.memory_frag_high_runbook_url, var.runbook_url), "")
    tip                   = var.memory_frag_high_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memory_frag_high_max_delay
}

resource "signalfx_detector" "memory_frag_low" {
  name = format("%s %s", local.detector_name_prefix, "Redis memory fragmentation ratio (missing memory)")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('bytes.used_memory_rss', filter=filter('plugin', 'redis_info') and ${module.filtering.signalflow}, rollup='average')${var.memory_frag_low_aggregation_function}${var.memory_frag_low_transformation_function}
    B = data('bytes.used_memory', filter=filter('plugin', 'redis_info') and ${module.filtering.signalflow}, rollup='average')${var.memory_frag_low_aggregation_function}${var.memory_frag_low_transformation_function}
    signal = (A/B).publish('signal')
    detect(when(signal < ${var.memory_frag_low_threshold_critical})).publish('CRIT')
    detect(when(signal < ${var.memory_frag_low_threshold_major}) and (not when(signal < ${var.memory_frag_low_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.memory_frag_low_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_frag_low_disabled_critical, var.memory_frag_low_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_frag_low_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.memory_frag_low_runbook_url, var.runbook_url), "")
    tip                   = var.memory_frag_low_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.memory_frag_low_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_frag_low_disabled_major, var.memory_frag_low_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_frag_low_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.memory_frag_low_runbook_url, var.runbook_url), "")
    tip                   = var.memory_frag_low_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memory_frag_low_max_delay
}

resource "signalfx_detector" "rejected_connections" {
  name = format("%s %s", local.detector_name_prefix, "Redis rejected connections (maxclient reached)")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('counter.rejected_connections', filter=filter('plugin', 'redis_info') and ${module.filtering.signalflow}, rollup='delta').${var.rejected_connections_aggregation_function}${var.rejected_connections_transformation_function}.publish('signal')
    detect(when(signal > ${var.rejected_connections_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.rejected_connections_threshold_major}) and (not when(signal > ${var.rejected_connections_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "are too high > ${var.rejected_connections_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.rejected_connections_disabled_critical, var.rejected_connections_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.rejected_connections_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.rejected_connections_runbook_url, var.runbook_url), "")
    tip                   = var.rejected_connections_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "are too high > ${var.rejected_connections_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.rejected_connections_disabled_major, var.rejected_connections_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.rejected_connections_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.rejected_connections_runbook_url, var.runbook_url), "")
    tip                   = var.rejected_connections_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.rejected_connections_max_delay
}

resource "signalfx_detector" "hitrate" {
  name = format("%s %s", local.detector_name_prefix, "Redis hitrate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('derive.keyspace_hits', filter=filter('plugin', 'redis_info') and ${module.filtering.signalflow}, rollup='delta')${var.hitrate_aggregation_function}${var.hitrate_transformation_function}
    B = data('derive.keyspace_misses', filter=filter('plugin', 'redis_info') and ${module.filtering.signalflow}, rollup='delta')${var.hitrate_aggregation_function}${var.hitrate_transformation_function}
    signal = (A / (A+B)).scale(100).publish('signal')
    detect(when(signal < ${var.hitrate_threshold_critical})).publish('CRIT')
    detect(when(signal < ${var.hitrate_threshold_major}) and (not when(signal < ${var.hitrate_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.hitrate_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.hitrate_disabled_critical, var.hitrate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.hitrate_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.hitrate_runbook_url, var.runbook_url), "")
    tip                   = var.hitrate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.hitrate_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.hitrate_disabled_major, var.hitrate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.hitrate_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.hitrate_runbook_url, var.runbook_url), "")
    tip                   = var.hitrate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.hitrate_max_delay
}

