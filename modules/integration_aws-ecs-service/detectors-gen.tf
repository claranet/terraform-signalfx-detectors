resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS ECS Service heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('namespace', 'AWS/ECS')
    signal = data('CPUUtilization', filter=base_filtering and filter('stat', 'mean') and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "cpu_utilization" {
  name = format("%s %s", local.detector_name_prefix, "AWS ECS Service cpu utilization")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ECS')
    signal = data('CPUUtilization', filter=base_filtering and filter('stat', 'mean') and filter('ServiceName', '*') and ${module.filtering.signalflow})${var.cpu_utilization_aggregation_function}${var.cpu_utilization_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_utilization_threshold_critical}%{if var.cpu_utilization_lasting_duration_critical != null}, lasting='${var.cpu_utilization_lasting_duration_critical}', at_least=${var.cpu_utilization_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.cpu_utilization_threshold_major}%{if var.cpu_utilization_lasting_duration_major != null}, lasting='${var.cpu_utilization_lasting_duration_major}', at_least=${var.cpu_utilization_at_least_percentage_major}%{endif}) and (not when(signal > ${var.cpu_utilization_threshold_critical}%{if var.cpu_utilization_lasting_duration_critical != null}, lasting='${var.cpu_utilization_lasting_duration_critical}', at_least=${var.cpu_utilization_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_utilization_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_utilization_disabled_critical, var.cpu_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_utilization_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cpu_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cpu_utilization_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_utilization_disabled_major, var.cpu_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_utilization_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cpu_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cpu_utilization_max_delay
}

resource "signalfx_detector" "memory_utilization" {
  name = format("%s %s", local.detector_name_prefix, "AWS ECS Service memory utilization")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ECS')
    signal = data('MemoryUtilization', filter=base_filtering and filter('stat', 'mean') and filter('ServiceName', '*') and ${module.filtering.signalflow})${var.memory_utilization_aggregation_function}${var.memory_utilization_transformation_function}.publish('signal')
    detect(when(signal > ${var.memory_utilization_threshold_critical}%{if var.memory_utilization_lasting_duration_critical != null}, lasting='${var.memory_utilization_lasting_duration_critical}', at_least=${var.memory_utilization_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.memory_utilization_threshold_major}%{if var.memory_utilization_lasting_duration_major != null}, lasting='${var.memory_utilization_lasting_duration_major}', at_least=${var.memory_utilization_at_least_percentage_major}%{endif}) and (not when(signal > ${var.memory_utilization_threshold_critical}%{if var.memory_utilization_lasting_duration_critical != null}, lasting='${var.memory_utilization_lasting_duration_critical}', at_least=${var.memory_utilization_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memory_utilization_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_utilization_disabled_critical, var.memory_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_utilization_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.memory_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.memory_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.memory_utilization_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_utilization_disabled_major, var.memory_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_utilization_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.memory_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.memory_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memory_utilization_max_delay
}

