resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Redis heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('redis_memory_used_bytes', filter=%{if var.heartbeat_exclude_not_running_vm}${local.not_running_vm_filters} and %{endif}${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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
    A = data('redis_blocked_clients', filter=${module.filtering.signalflow})${var.blocked_over_connected_clients_ratio_aggregation_function}${var.blocked_over_connected_clients_ratio_transformation_function}
    B = data('redis_connected_clients', filter=${module.filtering.signalflow})${var.blocked_over_connected_clients_ratio_aggregation_function}${var.blocked_over_connected_clients_ratio_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.blocked_over_connected_clients_ratio_threshold_critical}%{if var.blocked_over_connected_clients_ratio_lasting_duration_critical != null}, lasting='${var.blocked_over_connected_clients_ratio_lasting_duration_critical}', at_least=${var.blocked_over_connected_clients_ratio_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.blocked_over_connected_clients_ratio_threshold_major}%{if var.blocked_over_connected_clients_ratio_lasting_duration_major != null}, lasting='${var.blocked_over_connected_clients_ratio_lasting_duration_major}', at_least=${var.blocked_over_connected_clients_ratio_at_least_percentage_major}%{endif}) and (not when(signal > ${var.blocked_over_connected_clients_ratio_threshold_critical}%{if var.blocked_over_connected_clients_ratio_lasting_duration_critical != null}, lasting='${var.blocked_over_connected_clients_ratio_lasting_duration_critical}', at_least=${var.blocked_over_connected_clients_ratio_at_least_percentage_critical}%{endif}))).publish('MAJOR')
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

resource "signalfx_detector" "evicted_keys_change_rate" {
  name = format("%s %s", local.detector_name_prefix, "Redis evicted keys change rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('redis_evicted_keys_total', filter=${module.filtering.signalflow}, rollup='delta')${var.evicted_keys_change_rate_aggregation_function}${var.evicted_keys_change_rate_transformation_function}
    signal = A.rateofchange().publish('signal')
    detect(when(signal > ${var.evicted_keys_change_rate_threshold_critical}%{if var.evicted_keys_change_rate_lasting_duration_critical != null}, lasting='${var.evicted_keys_change_rate_lasting_duration_critical}', at_least=${var.evicted_keys_change_rate_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.evicted_keys_change_rate_threshold_major}%{if var.evicted_keys_change_rate_lasting_duration_major != null}, lasting='${var.evicted_keys_change_rate_lasting_duration_major}', at_least=${var.evicted_keys_change_rate_at_least_percentage_major}%{endif}) and (not when(signal > ${var.evicted_keys_change_rate_threshold_critical}%{if var.evicted_keys_change_rate_lasting_duration_critical != null}, lasting='${var.evicted_keys_change_rate_lasting_duration_critical}', at_least=${var.evicted_keys_change_rate_at_least_percentage_critical}%{endif}))).publish('MAJOR')
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
    A = data('redis_expired_keys_total', filter=${module.filtering.signalflow}, rollup='delta')${var.expired_keys_change_rate_aggregation_function}${var.expired_keys_change_rate_transformation_function}
    signal = A.rateofchange().publish('signal')
    detect(when(signal > ${var.expired_keys_change_rate_threshold_critical}%{if var.expired_keys_change_rate_lasting_duration_critical != null}, lasting='${var.expired_keys_change_rate_lasting_duration_critical}', at_least=${var.expired_keys_change_rate_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.expired_keys_change_rate_threshold_major}%{if var.expired_keys_change_rate_lasting_duration_major != null}, lasting='${var.expired_keys_change_rate_lasting_duration_major}', at_least=${var.expired_keys_change_rate_at_least_percentage_major}%{endif}) and (not when(signal > ${var.expired_keys_change_rate_threshold_critical}%{if var.expired_keys_change_rate_lasting_duration_critical != null}, lasting='${var.expired_keys_change_rate_lasting_duration_critical}', at_least=${var.expired_keys_change_rate_at_least_percentage_critical}%{endif}))).publish('MAJOR')
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

resource "signalfx_detector" "rejected_connections" {
  name = format("%s %s", local.detector_name_prefix, "Redis rejected connections")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('redis_rejected_connections_total', filter=${module.filtering.signalflow}, rollup='delta')${var.rejected_connections_aggregation_function}${var.rejected_connections_transformation_function}.publish('signal')
    detect(when(signal > ${var.rejected_connections_threshold_critical}%{if var.rejected_connections_lasting_duration_critical != null}, lasting='${var.rejected_connections_lasting_duration_critical}', at_least=${var.rejected_connections_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.rejected_connections_threshold_major}%{if var.rejected_connections_lasting_duration_major != null}, lasting='${var.rejected_connections_lasting_duration_major}', at_least=${var.rejected_connections_at_least_percentage_major}%{endif}) and (not when(signal > ${var.rejected_connections_threshold_critical}%{if var.rejected_connections_lasting_duration_critical != null}, lasting='${var.rejected_connections_lasting_duration_critical}', at_least=${var.rejected_connections_at_least_percentage_critical}%{endif}))).publish('MAJOR')
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

