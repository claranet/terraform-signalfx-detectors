resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Redis heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('plugin', 'redis_info')
    signal = data('bytes.used_memory', filter=${local.not_running_vm_filters} and base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "evicted_keys_change_rate" {
  name = format("%s %s", local.detector_name_prefix, "Redis evicted keys change rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'redis_info')
    signal = data('counter.evicted_keys', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta').rateofchange()${var.evicted_keys_change_rate_aggregation_function}${var.evicted_keys_change_rate_transformation_function}.publish('signal')
    detect(when(signal > ${var.evicted_keys_change_rate_threshold_critical}, lasting=%{if var.evicted_keys_change_rate_lasting_duration_critical == null}None%{else}'${var.evicted_keys_change_rate_lasting_duration_critical}'%{endif}, at_least=${var.evicted_keys_change_rate_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.evicted_keys_change_rate_threshold_major}, lasting=%{if var.evicted_keys_change_rate_lasting_duration_major == null}None%{else}'${var.evicted_keys_change_rate_lasting_duration_major}'%{endif}, at_least=${var.evicted_keys_change_rate_at_least_percentage_major}) and (not when(signal > ${var.evicted_keys_change_rate_threshold_critical}, lasting=%{if var.evicted_keys_change_rate_lasting_duration_critical == null}None%{else}'${var.evicted_keys_change_rate_lasting_duration_critical}'%{endif}, at_least=${var.evicted_keys_change_rate_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.evicted_keys_change_rate_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.evicted_keys_change_rate_disabled_critical, var.evicted_keys_change_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.evicted_keys_change_rate_notifications, "critical", []), var.notifications.critical)
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
    notifications         = coalescelist(lookup(var.evicted_keys_change_rate_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.evicted_keys_change_rate_runbook_url, var.runbook_url), "")
    tip                   = var.evicted_keys_change_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "expired_keys_change_rate" {
  name = format("%s %s", local.detector_name_prefix, "Redis expired keys change rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'redis_info')
    signal = data('counter.evicted_keys', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta').rateofchange()${var.expired_keys_change_rate_aggregation_function}${var.expired_keys_change_rate_transformation_function}.publish('signal')
    detect(when(signal > ${var.expired_keys_change_rate_threshold_critical}, lasting=%{if var.expired_keys_change_rate_lasting_duration_critical == null}None%{else}'${var.expired_keys_change_rate_lasting_duration_critical}'%{endif}, at_least=${var.expired_keys_change_rate_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.expired_keys_change_rate_threshold_major}, lasting=%{if var.expired_keys_change_rate_lasting_duration_major == null}None%{else}'${var.expired_keys_change_rate_lasting_duration_major}'%{endif}, at_least=${var.expired_keys_change_rate_at_least_percentage_major}) and (not when(signal > ${var.expired_keys_change_rate_threshold_critical}, lasting=%{if var.expired_keys_change_rate_lasting_duration_critical == null}None%{else}'${var.expired_keys_change_rate_lasting_duration_critical}'%{endif}, at_least=${var.expired_keys_change_rate_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.expired_keys_change_rate_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.expired_keys_change_rate_disabled_critical, var.expired_keys_change_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.expired_keys_change_rate_notifications, "critical", []), var.notifications.critical)
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
    notifications         = coalescelist(lookup(var.expired_keys_change_rate_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.expired_keys_change_rate_runbook_url, var.runbook_url), "")
    tip                   = var.expired_keys_change_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
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
    base_filtering = filter('plugin', 'redis_info')
    A = data('gauge.blocked_clients', filter=base_filtering and ${module.filtering.signalflow})${var.blocked_over_connected_clients_ratio_aggregation_function}${var.blocked_over_connected_clients_ratio_transformation_function}
    B = data('gauge.connected_clients', filter=base_filtering and ${module.filtering.signalflow})${var.blocked_over_connected_clients_ratio_aggregation_function}${var.blocked_over_connected_clients_ratio_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.blocked_over_connected_clients_ratio_threshold_critical}, lasting=%{if var.blocked_over_connected_clients_ratio_lasting_duration_critical == null}None%{else}'${var.blocked_over_connected_clients_ratio_lasting_duration_critical}'%{endif}, at_least=${var.blocked_over_connected_clients_ratio_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.blocked_over_connected_clients_ratio_threshold_major}, lasting=%{if var.blocked_over_connected_clients_ratio_lasting_duration_major == null}None%{else}'${var.blocked_over_connected_clients_ratio_lasting_duration_major}'%{endif}, at_least=${var.blocked_over_connected_clients_ratio_at_least_percentage_major}) and (not when(signal > ${var.blocked_over_connected_clients_ratio_threshold_critical}, lasting=%{if var.blocked_over_connected_clients_ratio_lasting_duration_critical == null}None%{else}'${var.blocked_over_connected_clients_ratio_lasting_duration_critical}'%{endif}, at_least=${var.blocked_over_connected_clients_ratio_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.blocked_over_connected_clients_ratio_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.blocked_over_connected_clients_ratio_disabled_critical, var.blocked_over_connected_clients_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.blocked_over_connected_clients_ratio_notifications, "critical", []), var.notifications.critical)
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
    notifications         = coalescelist(lookup(var.blocked_over_connected_clients_ratio_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.blocked_over_connected_clients_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.blocked_over_connected_clients_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "stored_keys_change_rate" {
  name = format("%s %s", local.detector_name_prefix, "Redis stored keys change rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'redis_info')
    signal = data('gauge.db0_keys', filter=base_filtering and ${module.filtering.signalflow}).rateofchange()${var.stored_keys_change_rate_aggregation_function}${var.stored_keys_change_rate_transformation_function}.publish('signal')
    detect(when(signal == ${var.stored_keys_change_rate_threshold_major}, lasting=%{if var.stored_keys_change_rate_lasting_duration_major == null}None%{else}'${var.stored_keys_change_rate_lasting_duration_major}'%{endif}, at_least=${var.stored_keys_change_rate_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is == ${var.stored_keys_change_rate_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.stored_keys_change_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.stored_keys_change_rate_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.stored_keys_change_rate_runbook_url, var.runbook_url), "")
    tip                   = var.stored_keys_change_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "used_over_maximum_memory_ratio" {
  name = format("%s %s", local.detector_name_prefix, "Redis used over maximum memory ratio")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('plugin', 'redis_info')
    A = data('bytes.used_memory', filter=base_filtering and ${module.filtering.signalflow})${var.used_over_maximum_memory_ratio_aggregation_function}${var.used_over_maximum_memory_ratio_transformation_function}
    B = data('bytes.maxmemory', filter=base_filtering and ${module.filtering.signalflow})${var.used_over_maximum_memory_ratio_aggregation_function}${var.used_over_maximum_memory_ratio_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.used_over_maximum_memory_ratio_threshold_critical}, lasting=%{if var.used_over_maximum_memory_ratio_lasting_duration_critical == null}None%{else}'${var.used_over_maximum_memory_ratio_lasting_duration_critical}'%{endif}, at_least=${var.used_over_maximum_memory_ratio_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.used_over_maximum_memory_ratio_threshold_major}, lasting=%{if var.used_over_maximum_memory_ratio_lasting_duration_major == null}None%{else}'${var.used_over_maximum_memory_ratio_lasting_duration_major}'%{endif}, at_least=${var.used_over_maximum_memory_ratio_at_least_percentage_major}) and (not when(signal > ${var.used_over_maximum_memory_ratio_threshold_critical}, lasting=%{if var.used_over_maximum_memory_ratio_lasting_duration_critical == null}None%{else}'${var.used_over_maximum_memory_ratio_lasting_duration_critical}'%{endif}, at_least=${var.used_over_maximum_memory_ratio_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.used_over_maximum_memory_ratio_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.used_over_maximum_memory_ratio_disabled_critical, var.used_over_maximum_memory_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.used_over_maximum_memory_ratio_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.used_over_maximum_memory_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.used_over_maximum_memory_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.used_over_maximum_memory_ratio_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.used_over_maximum_memory_ratio_disabled_major, var.used_over_maximum_memory_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.used_over_maximum_memory_ratio_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.used_over_maximum_memory_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.used_over_maximum_memory_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "used_over_system_memory_ratio" {
  name = format("%s %s", local.detector_name_prefix, "Redis used over system memory ratio")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('plugin', 'redis_info')
    A = data('bytes.used_memory', filter=base_filtering and ${module.filtering.signalflow})${var.used_over_system_memory_ratio_aggregation_function}${var.used_over_system_memory_ratio_transformation_function}
    B = data('bytes.total_system_memory', filter=base_filtering and ${module.filtering.signalflow})${var.used_over_system_memory_ratio_aggregation_function}${var.used_over_system_memory_ratio_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.used_over_system_memory_ratio_threshold_critical}, lasting=%{if var.used_over_system_memory_ratio_lasting_duration_critical == null}None%{else}'${var.used_over_system_memory_ratio_lasting_duration_critical}'%{endif}, at_least=${var.used_over_system_memory_ratio_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.used_over_system_memory_ratio_threshold_major}, lasting=%{if var.used_over_system_memory_ratio_lasting_duration_major == null}None%{else}'${var.used_over_system_memory_ratio_lasting_duration_major}'%{endif}, at_least=${var.used_over_system_memory_ratio_at_least_percentage_major}) and (not when(signal > ${var.used_over_system_memory_ratio_threshold_critical}, lasting=%{if var.used_over_system_memory_ratio_lasting_duration_critical == null}None%{else}'${var.used_over_system_memory_ratio_lasting_duration_critical}'%{endif}, at_least=${var.used_over_system_memory_ratio_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.used_over_system_memory_ratio_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.used_over_system_memory_ratio_disabled_critical, var.used_over_system_memory_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.used_over_system_memory_ratio_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.used_over_system_memory_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.used_over_system_memory_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.used_over_system_memory_ratio_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.used_over_system_memory_ratio_disabled_major, var.used_over_system_memory_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.used_over_system_memory_ratio_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.used_over_system_memory_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.used_over_system_memory_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "high_memory_fragmentation_ratio" {
  name = format("%s %s", local.detector_name_prefix, "Redis high memory fragmentation ratio")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'redis_info')
    A = data('bytes.used_memory_rss', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.high_memory_fragmentation_ratio_aggregation_function}${var.high_memory_fragmentation_ratio_transformation_function}
    B = data('bytes.used_memory', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.high_memory_fragmentation_ratio_aggregation_function}${var.high_memory_fragmentation_ratio_transformation_function}
    signal = (A/B).publish('signal')
    detect(when(signal > ${var.high_memory_fragmentation_ratio_threshold_critical}, lasting=%{if var.high_memory_fragmentation_ratio_lasting_duration_critical == null}None%{else}'${var.high_memory_fragmentation_ratio_lasting_duration_critical}'%{endif}, at_least=${var.high_memory_fragmentation_ratio_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.high_memory_fragmentation_ratio_threshold_major}, lasting=%{if var.high_memory_fragmentation_ratio_lasting_duration_major == null}None%{else}'${var.high_memory_fragmentation_ratio_lasting_duration_major}'%{endif}, at_least=${var.high_memory_fragmentation_ratio_at_least_percentage_major}) and (not when(signal > ${var.high_memory_fragmentation_ratio_threshold_critical}, lasting=%{if var.high_memory_fragmentation_ratio_lasting_duration_critical == null}None%{else}'${var.high_memory_fragmentation_ratio_lasting_duration_critical}'%{endif}, at_least=${var.high_memory_fragmentation_ratio_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.high_memory_fragmentation_ratio_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.high_memory_fragmentation_ratio_disabled_critical, var.high_memory_fragmentation_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.high_memory_fragmentation_ratio_notifications, "critical", []), var.notifications.critical)
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
    notifications         = coalescelist(lookup(var.high_memory_fragmentation_ratio_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.high_memory_fragmentation_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.high_memory_fragmentation_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "low_memory_fragmentation_ratio" {
  name = format("%s %s", local.detector_name_prefix, "Redis low memory fragmentation ratio")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'redis_info')
    A = data('bytes.used_memory_rss', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.low_memory_fragmentation_ratio_aggregation_function}${var.low_memory_fragmentation_ratio_transformation_function}
    B = data('bytes.used_memory', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.low_memory_fragmentation_ratio_aggregation_function}${var.low_memory_fragmentation_ratio_transformation_function}
    signal = (A/B).publish('signal')
    detect(when(signal < ${var.low_memory_fragmentation_ratio_threshold_critical}, lasting=%{if var.low_memory_fragmentation_ratio_lasting_duration_critical == null}None%{else}'${var.low_memory_fragmentation_ratio_lasting_duration_critical}'%{endif}, at_least=${var.low_memory_fragmentation_ratio_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal < ${var.low_memory_fragmentation_ratio_threshold_major}, lasting=%{if var.low_memory_fragmentation_ratio_lasting_duration_major == null}None%{else}'${var.low_memory_fragmentation_ratio_lasting_duration_major}'%{endif}, at_least=${var.low_memory_fragmentation_ratio_at_least_percentage_major}) and (not when(signal < ${var.low_memory_fragmentation_ratio_threshold_critical}, lasting=%{if var.low_memory_fragmentation_ratio_lasting_duration_critical == null}None%{else}'${var.low_memory_fragmentation_ratio_lasting_duration_critical}'%{endif}, at_least=${var.low_memory_fragmentation_ratio_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.low_memory_fragmentation_ratio_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.low_memory_fragmentation_ratio_disabled_critical, var.low_memory_fragmentation_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.low_memory_fragmentation_ratio_notifications, "critical", []), var.notifications.critical)
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
    notifications         = coalescelist(lookup(var.low_memory_fragmentation_ratio_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.low_memory_fragmentation_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.low_memory_fragmentation_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "rejected_connections" {
  name = format("%s %s", local.detector_name_prefix, "Redis rejected connections")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'redis_info')
    signal = data('counter.rejected_connections', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta')${var.rejected_connections_aggregation_function}${var.rejected_connections_transformation_function}.publish('signal')
    detect(when(signal > ${var.rejected_connections_threshold_critical}, lasting=%{if var.rejected_connections_lasting_duration_critical == null}None%{else}'${var.rejected_connections_lasting_duration_critical}'%{endif}, at_least=${var.rejected_connections_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.rejected_connections_threshold_major}, lasting=%{if var.rejected_connections_lasting_duration_major == null}None%{else}'${var.rejected_connections_lasting_duration_major}'%{endif}, at_least=${var.rejected_connections_at_least_percentage_major}) and (not when(signal > ${var.rejected_connections_threshold_critical}, lasting=%{if var.rejected_connections_lasting_duration_critical == null}None%{else}'${var.rejected_connections_lasting_duration_critical}'%{endif}, at_least=${var.rejected_connections_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.rejected_connections_threshold_critical}"
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
    description           = "is too high > ${var.rejected_connections_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.rejected_connections_disabled_major, var.rejected_connections_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.rejected_connections_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.rejected_connections_runbook_url, var.runbook_url), "")
    tip                   = var.rejected_connections_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
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
    base_filtering = filter('plugin', 'redis_info')
    A = data('derive.keyspace_hits', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta')${var.hitrate_aggregation_function}${var.hitrate_transformation_function}
    B = data('derive.keyspace_misses', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta')${var.hitrate_aggregation_function}${var.hitrate_transformation_function}
    signal = (A/(A+B)).scale(100).publish('signal')
    detect(when(signal < ${var.hitrate_threshold_critical}, lasting=%{if var.hitrate_lasting_duration_critical == null}None%{else}'${var.hitrate_lasting_duration_critical}'%{endif}, at_least=${var.hitrate_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal < ${var.hitrate_threshold_major}, lasting=%{if var.hitrate_lasting_duration_major == null}None%{else}'${var.hitrate_lasting_duration_major}'%{endif}, at_least=${var.hitrate_at_least_percentage_major}) and (not when(signal < ${var.hitrate_threshold_critical}, lasting=%{if var.hitrate_lasting_duration_critical == null}None%{else}'${var.hitrate_lasting_duration_critical}'%{endif}, at_least=${var.hitrate_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.hitrate_threshold_critical}%"
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
    description           = "is too low < ${var.hitrate_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.hitrate_disabled_major, var.hitrate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.hitrate_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.hitrate_runbook_url, var.runbook_url), "")
    tip                   = var.hitrate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

