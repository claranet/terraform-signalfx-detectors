resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "GCP Memorystore Redis heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('stats/cpu_utilization', filter=${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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
  name = format("%s %s", local.detector_name_prefix, "GCP Memorystore Redis blocked over connected clients ratio")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    A = data('clients/blocked', filter=${module.filtering.signalflow})${var.blocked_over_connected_clients_ratio_aggregation_function}${var.blocked_over_connected_clients_ratio_transformation_function}
    B = data('clients/connected', filter=${module.filtering.signalflow})${var.blocked_over_connected_clients_ratio_aggregation_function}${var.blocked_over_connected_clients_ratio_transformation_function}
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

resource "signalfx_detector" "system_memory_usage" {
  name = format("%s %s", local.detector_name_prefix, "GCP Memorystore Redis system memory usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    A = data('stats/memory/system_memory_usage_ratio', filter=${module.filtering.signalflow}, extrapolation='zero')${var.system_memory_usage_aggregation_function}${var.system_memory_usage_transformation_function}
    signal = A.scale(100).publish('signal')
    detect(when(signal > ${var.system_memory_usage_threshold_critical}%{if var.system_memory_usage_lasting_duration_critical != null}, lasting='${var.system_memory_usage_lasting_duration_critical}', at_least=${var.system_memory_usage_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.system_memory_usage_threshold_major}%{if var.system_memory_usage_lasting_duration_major != null}, lasting='${var.system_memory_usage_lasting_duration_major}', at_least=${var.system_memory_usage_at_least_percentage_major}%{endif}) and (not when(signal > ${var.system_memory_usage_threshold_critical}%{if var.system_memory_usage_lasting_duration_critical != null}, lasting='${var.system_memory_usage_lasting_duration_critical}', at_least=${var.system_memory_usage_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.system_memory_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.system_memory_usage_disabled_critical, var.system_memory_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.system_memory_usage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.system_memory_usage_runbook_url, var.runbook_url), "")
    tip                   = var.system_memory_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.system_memory_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.system_memory_usage_disabled_major, var.system_memory_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.system_memory_usage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.system_memory_usage_runbook_url, var.runbook_url), "")
    tip                   = var.system_memory_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.system_memory_usage_max_delay
}

resource "signalfx_detector" "memory_usage" {
  name = format("%s %s", local.detector_name_prefix, "GCP Memorystore Redis memory usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    A = data('stats/memory/usage_ratio', filter=${module.filtering.signalflow}, extrapolation='zero')${var.memory_usage_aggregation_function}${var.memory_usage_transformation_function}
    signal = A.scale(100).publish('signal')
    detect(when(signal > ${var.memory_usage_threshold_critical}%{if var.memory_usage_lasting_duration_critical != null}, lasting='${var.memory_usage_lasting_duration_critical}', at_least=${var.memory_usage_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.memory_usage_threshold_major}%{if var.memory_usage_lasting_duration_major != null}, lasting='${var.memory_usage_lasting_duration_major}', at_least=${var.memory_usage_at_least_percentage_major}%{endif}) and (not when(signal > ${var.memory_usage_threshold_critical}%{if var.memory_usage_lasting_duration_critical != null}, lasting='${var.memory_usage_lasting_duration_critical}', at_least=${var.memory_usage_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memory_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_usage_disabled_critical, var.memory_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_usage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.memory_usage_runbook_url, var.runbook_url), "")
    tip                   = var.memory_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.memory_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_usage_disabled_major, var.memory_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_usage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.memory_usage_runbook_url, var.runbook_url), "")
    tip                   = var.memory_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memory_usage_max_delay
}

