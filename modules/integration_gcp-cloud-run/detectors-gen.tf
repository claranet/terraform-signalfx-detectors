resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud Run heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('container/containers', filter=${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "cpu_utilizations" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud Run cpu utilizations")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    signal = data('container/cpu/utilizations', filter=${module.filtering.signalflow})${var.cpu_utilizations_aggregation_function}${var.cpu_utilizations_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_utilizations_threshold_critical}%{if var.cpu_utilizations_lasting_duration_critical != null}, lasting='${var.cpu_utilizations_lasting_duration_critical}', at_least=${var.cpu_utilizations_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.cpu_utilizations_threshold_major}%{if var.cpu_utilizations_lasting_duration_major != null}, lasting='${var.cpu_utilizations_lasting_duration_major}', at_least=${var.cpu_utilizations_at_least_percentage_major}%{endif}) and (not when(signal > ${var.cpu_utilizations_threshold_critical}%{if var.cpu_utilizations_lasting_duration_critical != null}, lasting='${var.cpu_utilizations_lasting_duration_critical}', at_least=${var.cpu_utilizations_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_utilizations_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_utilizations_disabled_critical, var.cpu_utilizations_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_utilizations_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cpu_utilizations_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_utilizations_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cpu_utilizations_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_utilizations_disabled_major, var.cpu_utilizations_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_utilizations_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cpu_utilizations_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_utilizations_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cpu_utilizations_max_delay
}

resource "signalfx_detector" "memory_utilizations" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud Run memory utilizations")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    signal = data('container/memory/utilizations', filter=${module.filtering.signalflow})${var.memory_utilizations_aggregation_function}${var.memory_utilizations_transformation_function}.publish('signal')
    detect(when(signal > ${var.memory_utilizations_threshold_critical}%{if var.memory_utilizations_lasting_duration_critical != null}, lasting='${var.memory_utilizations_lasting_duration_critical}', at_least=${var.memory_utilizations_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.memory_utilizations_threshold_major}%{if var.memory_utilizations_lasting_duration_major != null}, lasting='${var.memory_utilizations_lasting_duration_major}', at_least=${var.memory_utilizations_at_least_percentage_major}%{endif}) and (not when(signal > ${var.memory_utilizations_threshold_critical}%{if var.memory_utilizations_lasting_duration_critical != null}, lasting='${var.memory_utilizations_lasting_duration_critical}', at_least=${var.memory_utilizations_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memory_utilizations_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_utilizations_disabled_critical, var.memory_utilizations_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_utilizations_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.memory_utilizations_runbook_url, var.runbook_url), "")
    tip                   = var.memory_utilizations_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.memory_utilizations_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_utilizations_disabled_major, var.memory_utilizations_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_utilizations_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.memory_utilizations_runbook_url, var.runbook_url), "")
    tip                   = var.memory_utilizations_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memory_utilizations_max_delay
}

