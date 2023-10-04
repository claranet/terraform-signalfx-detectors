resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Redis heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('${var.use_otel_receiver ? "redis.memory.used" : "bytes.used_memory"}', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "evicted_keys_change_rate" {
  name = format("%s %s", local.detector_name_prefix, "Redis evicted keys change rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('${var.use_otel_receiver ? "redis.keys.evicted" : "counter.evicted_keys"}', filter=${module.filtering.signalflow}, rollup='delta')${var.evicted_keys_change_rate_aggregation_function}${var.evicted_keys_change_rate_transformation_function}
    signal = A.rateofchange().publish('signal')
    detect(when(signal > ${var.evicted_keys_change_rate_threshold_critical}, lasting=%{if var.evicted_keys_change_rate_lasting_duration_critical == null}None%{else}'${var.evicted_keys_change_rate_lasting_duration_critical}'%{endif}, at_least=${var.evicted_keys_change_rate_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.evicted_keys_change_rate_threshold_major}, lasting=%{if var.evicted_keys_change_rate_lasting_duration_major == null}None%{else}'${var.evicted_keys_change_rate_lasting_duration_major}'%{endif}, at_least=${var.evicted_keys_change_rate_at_least_percentage_major}) and (not when(signal > ${var.evicted_keys_change_rate_threshold_critical}, lasting=%{if var.evicted_keys_change_rate_lasting_duration_critical == null}None%{else}'${var.evicted_keys_change_rate_lasting_duration_critical}'%{endif}, at_least=${var.evicted_keys_change_rate_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.evicted_keys_change_rate_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.evicted_keys_change_rate_disabled_critical, var.evicted_keys_change_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.evicted_keys_change_rate_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.evicted_keys_change_rate_runbook_url, var.runbook_url), "")
    tip                   = var.evicted_keys_change_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.evicted_keys_change_rate_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.evicted_keys_change_rate_disabled_major, var.evicted_keys_change_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.evicted_keys_change_rate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.evicted_keys_change_rate_runbook_url, var.runbook_url), "")
    tip                   = var.evicted_keys_change_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.evicted_keys_change_rate_max_delay
}

resource "signalfx_detector" "expired_keys_change_rate" {
  name = format("%s %s", local.detector_name_prefix, "Redis expired keys change rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('${var.use_otel_receiver ? "redis.keys.expired" : "counter.expired_keys"}', filter=${module.filtering.signalflow}, rollup='delta')${var.expired_keys_change_rate_aggregation_function}${var.expired_keys_change_rate_transformation_function}
    signal = A.rateofchange().publish('signal')
    detect(when(signal > ${var.expired_keys_change_rate_threshold_critical}, lasting=%{if var.expired_keys_change_rate_lasting_duration_critical == null}None%{else}'${var.expired_keys_change_rate_lasting_duration_critical}'%{endif}, at_least=${var.expired_keys_change_rate_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.expired_keys_change_rate_threshold_major}, lasting=%{if var.expired_keys_change_rate_lasting_duration_major == null}None%{else}'${var.expired_keys_change_rate_lasting_duration_major}'%{endif}, at_least=${var.expired_keys_change_rate_at_least_percentage_major}) and (not when(signal > ${var.expired_keys_change_rate_threshold_critical}, lasting=%{if var.expired_keys_change_rate_lasting_duration_critical == null}None%{else}'${var.expired_keys_change_rate_lasting_duration_critical}'%{endif}, at_least=${var.expired_keys_change_rate_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.expired_keys_change_rate_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.expired_keys_change_rate_disabled_critical, var.expired_keys_change_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.expired_keys_change_rate_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.expired_keys_change_rate_runbook_url, var.runbook_url), "")
    tip                   = var.expired_keys_change_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.expired_keys_change_rate_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.expired_keys_change_rate_disabled_major, var.expired_keys_change_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.expired_keys_change_rate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.expired_keys_change_rate_runbook_url, var.runbook_url), "")
    tip                   = var.expired_keys_change_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.expired_keys_change_rate_max_delay
}

resource "signalfx_detector" "blocked_over_connected_clients_ratio" {
  name = format("%s %s", local.detector_name_prefix, "Redis blocked over connected clients ratio")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    A = data('${var.use_otel_receiver ? "redis.client.blocked" : "gauge.blocked_clients"}', filter=${module.filtering.signalflow})${var.blocked_over_connected_clients_ratio_aggregation_function}${var.blocked_over_connected_clients_ratio_transformation_function}
    B = data('${var.use_otel_receiver ? "redis.client.connected" : "gauge.connected_clients"}', filter=${module.filtering.signalflow})${var.blocked_over_connected_clients_ratio_aggregation_function}${var.blocked_over_connected_clients_ratio_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.blocked_over_connected_clients_ratio_threshold_critical}, lasting=%{if var.blocked_over_connected_clients_ratio_lasting_duration_critical == null}None%{else}'${var.blocked_over_connected_clients_ratio_lasting_duration_critical}'%{endif}, at_least=${var.blocked_over_connected_clients_ratio_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.blocked_over_connected_clients_ratio_threshold_major}, lasting=%{if var.blocked_over_connected_clients_ratio_lasting_duration_major == null}None%{else}'${var.blocked_over_connected_clients_ratio_lasting_duration_major}'%{endif}, at_least=${var.blocked_over_connected_clients_ratio_at_least_percentage_major}) and (not when(signal > ${var.blocked_over_connected_clients_ratio_threshold_critical}, lasting=%{if var.blocked_over_connected_clients_ratio_lasting_duration_critical == null}None%{else}'${var.blocked_over_connected_clients_ratio_lasting_duration_critical}'%{endif}, at_least=${var.blocked_over_connected_clients_ratio_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.blocked_over_connected_clients_ratio_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.blocked_over_connected_clients_ratio_disabled_critical, var.blocked_over_connected_clients_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.blocked_over_connected_clients_ratio_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.blocked_over_connected_clients_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.blocked_over_connected_clients_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.blocked_over_connected_clients_ratio_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.blocked_over_connected_clients_ratio_disabled_major, var.blocked_over_connected_clients_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.blocked_over_connected_clients_ratio_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.blocked_over_connected_clients_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.blocked_over_connected_clients_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.blocked_over_connected_clients_ratio_max_delay
}

resource "signalfx_detector" "stored_keys_change_rate" {
  name = format("%s %s", local.detector_name_prefix, "Redis stored keys change rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('${var.use_otel_receiver ? "redis.db.keys" : "gauge.db0_keys"}', filter=${module.filtering.signalflow})${var.stored_keys_change_rate_aggregation_function}${var.stored_keys_change_rate_transformation_function}
    signal = A.rateofchange().abs().publish('signal')
    detect(when(signal == ${var.stored_keys_change_rate_threshold_major}, lasting=%{if var.stored_keys_change_rate_lasting_duration_major == null}None%{else}'${var.stored_keys_change_rate_lasting_duration_major}'%{endif}, at_least=${var.stored_keys_change_rate_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is == ${var.stored_keys_change_rate_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.stored_keys_change_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.stored_keys_change_rate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.stored_keys_change_rate_runbook_url, var.runbook_url), "")
    tip                   = var.stored_keys_change_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.stored_keys_change_rate_max_delay
}

resource "signalfx_detector" "percentage_memory_used_over_max_memory_set" {
  count = (!var.use_otel_receiver) ? 1 : 0

  name = format("%s %s", local.detector_name_prefix, "Redis percentage memory used over max memory set")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('plugin', 'redis_info')
    A = data('bytes.used_memory', filter=base_filtering and ${module.filtering.signalflow})${var.percentage_memory_used_over_max_memory_set_aggregation_function}${var.percentage_memory_used_over_max_memory_set_transformation_function}
    B = data('bytes.maxmemory', filter=base_filtering and ${module.filtering.signalflow})${var.percentage_memory_used_over_max_memory_set_aggregation_function}${var.percentage_memory_used_over_max_memory_set_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.percentage_memory_used_over_max_memory_set_threshold_critical}, lasting=%{if var.percentage_memory_used_over_max_memory_set_lasting_duration_critical == null}None%{else}'${var.percentage_memory_used_over_max_memory_set_lasting_duration_critical}'%{endif}, at_least=${var.percentage_memory_used_over_max_memory_set_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.percentage_memory_used_over_max_memory_set_threshold_major}, lasting=%{if var.percentage_memory_used_over_max_memory_set_lasting_duration_major == null}None%{else}'${var.percentage_memory_used_over_max_memory_set_lasting_duration_major}'%{endif}, at_least=${var.percentage_memory_used_over_max_memory_set_at_least_percentage_major}) and (not when(signal > ${var.percentage_memory_used_over_max_memory_set_threshold_critical}, lasting=%{if var.percentage_memory_used_over_max_memory_set_lasting_duration_critical == null}None%{else}'${var.percentage_memory_used_over_max_memory_set_lasting_duration_critical}'%{endif}, at_least=${var.percentage_memory_used_over_max_memory_set_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.percentage_memory_used_over_max_memory_set_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.percentage_memory_used_over_max_memory_set_disabled_critical, var.percentage_memory_used_over_max_memory_set_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.percentage_memory_used_over_max_memory_set_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.percentage_memory_used_over_max_memory_set_runbook_url, var.runbook_url), "")
    tip                   = var.percentage_memory_used_over_max_memory_set_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.percentage_memory_used_over_max_memory_set_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.percentage_memory_used_over_max_memory_set_disabled_major, var.percentage_memory_used_over_max_memory_set_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.percentage_memory_used_over_max_memory_set_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.percentage_memory_used_over_max_memory_set_runbook_url, var.runbook_url), "")
    tip                   = var.percentage_memory_used_over_max_memory_set_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.percentage_memory_used_over_max_memory_set_max_delay
}

resource "signalfx_detector" "percentage_memory_used_over_system_memory" {
  count = (!var.use_otel_receiver) ? 1 : 0

  name = format("%s %s", local.detector_name_prefix, "Redis percentage memory used over system memory")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('plugin', 'redis_info')
    A = data('bytes.used_memory', filter=base_filtering and ${module.filtering.signalflow})${var.percentage_memory_used_over_system_memory_aggregation_function}${var.percentage_memory_used_over_system_memory_transformation_function}
    B = data('bytes.total_system_memory', filter=base_filtering and ${module.filtering.signalflow})${var.percentage_memory_used_over_system_memory_aggregation_function}${var.percentage_memory_used_over_system_memory_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.percentage_memory_used_over_system_memory_threshold_critical}, lasting=%{if var.percentage_memory_used_over_system_memory_lasting_duration_critical == null}None%{else}'${var.percentage_memory_used_over_system_memory_lasting_duration_critical}'%{endif}, at_least=${var.percentage_memory_used_over_system_memory_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.percentage_memory_used_over_system_memory_threshold_major}, lasting=%{if var.percentage_memory_used_over_system_memory_lasting_duration_major == null}None%{else}'${var.percentage_memory_used_over_system_memory_lasting_duration_major}'%{endif}, at_least=${var.percentage_memory_used_over_system_memory_at_least_percentage_major}) and (not when(signal > ${var.percentage_memory_used_over_system_memory_threshold_critical}, lasting=%{if var.percentage_memory_used_over_system_memory_lasting_duration_critical == null}None%{else}'${var.percentage_memory_used_over_system_memory_lasting_duration_critical}'%{endif}, at_least=${var.percentage_memory_used_over_system_memory_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.percentage_memory_used_over_system_memory_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.percentage_memory_used_over_system_memory_disabled_critical, var.percentage_memory_used_over_system_memory_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.percentage_memory_used_over_system_memory_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.percentage_memory_used_over_system_memory_runbook_url, var.runbook_url), "")
    tip                   = var.percentage_memory_used_over_system_memory_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.percentage_memory_used_over_system_memory_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.percentage_memory_used_over_system_memory_disabled_major, var.percentage_memory_used_over_system_memory_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.percentage_memory_used_over_system_memory_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.percentage_memory_used_over_system_memory_runbook_url, var.runbook_url), "")
    tip                   = var.percentage_memory_used_over_system_memory_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.percentage_memory_used_over_system_memory_max_delay
}

resource "signalfx_detector" "high_memory_fragmentation_ratio" {
  name = format("%s %s", local.detector_name_prefix, "Redis high memory fragmentation ratio")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('${var.use_otel_receiver ? "redis.memory.rss" : "bytes.used_memory_rss"}', filter=${module.filtering.signalflow}, rollup='average')${var.high_memory_fragmentation_ratio_aggregation_function}${var.high_memory_fragmentation_ratio_transformation_function}
    B = data('${var.use_otel_receiver ? "redis.memory.used" : "bytes.used_memory"}', filter=${module.filtering.signalflow}, rollup='average')${var.high_memory_fragmentation_ratio_aggregation_function}${var.high_memory_fragmentation_ratio_transformation_function}
    signal = (A/B).publish('signal')
    detect(when(signal > ${var.high_memory_fragmentation_ratio_threshold_critical}, lasting=%{if var.high_memory_fragmentation_ratio_lasting_duration_critical == null}None%{else}'${var.high_memory_fragmentation_ratio_lasting_duration_critical}'%{endif}, at_least=${var.high_memory_fragmentation_ratio_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.high_memory_fragmentation_ratio_threshold_major}, lasting=%{if var.high_memory_fragmentation_ratio_lasting_duration_major == null}None%{else}'${var.high_memory_fragmentation_ratio_lasting_duration_major}'%{endif}, at_least=${var.high_memory_fragmentation_ratio_at_least_percentage_major}) and (not when(signal > ${var.high_memory_fragmentation_ratio_threshold_critical}, lasting=%{if var.high_memory_fragmentation_ratio_lasting_duration_critical == null}None%{else}'${var.high_memory_fragmentation_ratio_lasting_duration_critical}'%{endif}, at_least=${var.high_memory_fragmentation_ratio_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.high_memory_fragmentation_ratio_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.high_memory_fragmentation_ratio_disabled_critical, var.high_memory_fragmentation_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.high_memory_fragmentation_ratio_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.high_memory_fragmentation_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.high_memory_fragmentation_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.high_memory_fragmentation_ratio_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.high_memory_fragmentation_ratio_disabled_major, var.high_memory_fragmentation_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.high_memory_fragmentation_ratio_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.high_memory_fragmentation_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.high_memory_fragmentation_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.high_memory_fragmentation_ratio_max_delay
}

resource "signalfx_detector" "low_memory_fragmentation_ratio" {
  name = format("%s %s", local.detector_name_prefix, "Redis low memory fragmentation ratio")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('${var.use_otel_receiver ? "redis.memory.rss" : "bytes.used_memory_rss"}', filter=${module.filtering.signalflow}, rollup='average')${var.low_memory_fragmentation_ratio_aggregation_function}${var.low_memory_fragmentation_ratio_transformation_function}
    B = data('${var.use_otel_receiver ? "redis.memory.used" : "bytes.used_memory"}', filter=${module.filtering.signalflow}, rollup='average')${var.low_memory_fragmentation_ratio_aggregation_function}${var.low_memory_fragmentation_ratio_transformation_function}
    signal = (A/B).publish('signal')
    detect(when(signal < ${var.low_memory_fragmentation_ratio_threshold_critical}, lasting=%{if var.low_memory_fragmentation_ratio_lasting_duration_critical == null}None%{else}'${var.low_memory_fragmentation_ratio_lasting_duration_critical}'%{endif}, at_least=${var.low_memory_fragmentation_ratio_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal < ${var.low_memory_fragmentation_ratio_threshold_major}, lasting=%{if var.low_memory_fragmentation_ratio_lasting_duration_major == null}None%{else}'${var.low_memory_fragmentation_ratio_lasting_duration_major}'%{endif}, at_least=${var.low_memory_fragmentation_ratio_at_least_percentage_major}) and (not when(signal < ${var.low_memory_fragmentation_ratio_threshold_critical}, lasting=%{if var.low_memory_fragmentation_ratio_lasting_duration_critical == null}None%{else}'${var.low_memory_fragmentation_ratio_lasting_duration_critical}'%{endif}, at_least=${var.low_memory_fragmentation_ratio_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.low_memory_fragmentation_ratio_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.low_memory_fragmentation_ratio_disabled_critical, var.low_memory_fragmentation_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.low_memory_fragmentation_ratio_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.low_memory_fragmentation_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.low_memory_fragmentation_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.low_memory_fragmentation_ratio_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.low_memory_fragmentation_ratio_disabled_major, var.low_memory_fragmentation_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.low_memory_fragmentation_ratio_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.low_memory_fragmentation_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.low_memory_fragmentation_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.low_memory_fragmentation_ratio_max_delay
}

resource "signalfx_detector" "rejected_connections" {
  name = format("%s %s", local.detector_name_prefix, "Redis rejected connections")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('${var.use_otel_receiver ? "redis.connections.rejected" : "counter.rejected_connections"}', filter=${module.filtering.signalflow}, rollup='delta')${var.rejected_connections_aggregation_function}${var.rejected_connections_transformation_function}.publish('signal')
    detect(when(signal > ${var.rejected_connections_threshold_critical}, lasting=%{if var.rejected_connections_lasting_duration_critical == null}None%{else}'${var.rejected_connections_lasting_duration_critical}'%{endif}, at_least=${var.rejected_connections_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.rejected_connections_threshold_major}, lasting=%{if var.rejected_connections_lasting_duration_major == null}None%{else}'${var.rejected_connections_lasting_duration_major}'%{endif}, at_least=${var.rejected_connections_at_least_percentage_major}) and (not when(signal > ${var.rejected_connections_threshold_critical}, lasting=%{if var.rejected_connections_lasting_duration_critical == null}None%{else}'${var.rejected_connections_lasting_duration_critical}'%{endif}, at_least=${var.rejected_connections_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.rejected_connections_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.rejected_connections_disabled_critical, var.rejected_connections_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.rejected_connections_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.rejected_connections_runbook_url, var.runbook_url), "")
    tip                   = var.rejected_connections_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.rejected_connections_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.rejected_connections_disabled_major, var.rejected_connections_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.rejected_connections_notifications, "major", []), var.notifications.major), null)
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

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    A = data('${var.use_otel_receiver ? "redis.keyspace.hits" : "counter.keyspace_hits"}', filter=${module.filtering.signalflow}, rollup='delta')${var.hitrate_aggregation_function}${var.hitrate_transformation_function}
    B = data('${var.use_otel_receiver ? "redis.keyspace.hits" : "counter.keyspace_hits"}', filter=${module.filtering.signalflow}, rollup='delta')${var.hitrate_aggregation_function}${var.hitrate_transformation_function}
    signal = (A/(A+B)).scale(100).publish('signal')
    detect(when(signal < ${var.hitrate_threshold_critical}, lasting=%{if var.hitrate_lasting_duration_critical == null}None%{else}'${var.hitrate_lasting_duration_critical}'%{endif}, at_least=${var.hitrate_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal < ${var.hitrate_threshold_major}, lasting=%{if var.hitrate_lasting_duration_major == null}None%{else}'${var.hitrate_lasting_duration_major}'%{endif}, at_least=${var.hitrate_at_least_percentage_major}) and (not when(signal < ${var.hitrate_threshold_critical}, lasting=%{if var.hitrate_lasting_duration_critical == null}None%{else}'${var.hitrate_lasting_duration_critical}'%{endif}, at_least=${var.hitrate_at_least_percentage_critical}))).publish('MAJOR')
    detect(when(signal < ${var.hitrate_threshold_minor}, lasting=%{if var.hitrate_lasting_duration_minor == null}None%{else}'${var.hitrate_lasting_duration_minor}'%{endif}, at_least=${var.hitrate_at_least_percentage_minor}) and (not when(signal < ${var.hitrate_threshold_major}, lasting=%{if var.hitrate_lasting_duration_major == null}None%{else}'${var.hitrate_lasting_duration_major}'%{endif}, at_least=${var.hitrate_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too low < ${var.hitrate_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.hitrate_disabled_critical, var.hitrate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.hitrate_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.hitrate_runbook_url, var.runbook_url), "")
    tip                   = var.hitrate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.hitrate_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.hitrate_disabled_major, var.hitrate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.hitrate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.hitrate_runbook_url, var.runbook_url), "")
    tip                   = var.hitrate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.hitrate_threshold_minor}%"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.hitrate_disabled_minor, var.hitrate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.hitrate_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.hitrate_runbook_url, var.runbook_url), "")
    tip                   = var.hitrate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.hitrate_max_delay
}

