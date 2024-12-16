resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "GCP Firebase database heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('network/active_connections', filter=${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "load" {
  name = format("%s %s", local.detector_name_prefix, "GCP Firebase database load")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('io/database_load', filter=${module.filtering.signalflow})${var.load_aggregation_function}${var.load_transformation_function}.publish('signal')
    detect(when(signal > ${var.load_threshold_critical}%{if var.load_lasting_duration_critical != null}, lasting='${var.load_lasting_duration_critical}', at_least=${var.load_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.load_threshold_major}%{if var.load_lasting_duration_major != null}, lasting='${var.load_lasting_duration_major}', at_least=${var.load_at_least_percentage_major}%{endif}) and (not when(signal > ${var.load_threshold_critical}%{if var.load_lasting_duration_critical != null}, lasting='${var.load_lasting_duration_critical}', at_least=${var.load_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.load_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.load_disabled_critical, var.load_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.load_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.load_runbook_url, var.runbook_url), "")
    tip                   = var.load_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.load_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.load_disabled_major, var.load_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.load_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.load_runbook_url, var.runbook_url), "")
    tip                   = var.load_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.load_max_delay
}

resource "signalfx_detector" "io_utilization" {
  name = format("%s %s", local.detector_name_prefix, "GCP Firebase database io utilization")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('io/utilization', filter=${module.filtering.signalflow})${var.io_utilization_aggregation_function}${var.io_utilization_transformation_function}.publish('signal')
    detect(when(signal > ${var.io_utilization_threshold_critical}%{if var.io_utilization_lasting_duration_critical != null}, lasting='${var.io_utilization_lasting_duration_critical}', at_least=${var.io_utilization_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.io_utilization_threshold_major}%{if var.io_utilization_lasting_duration_major != null}, lasting='${var.io_utilization_lasting_duration_major}', at_least=${var.io_utilization_at_least_percentage_major}%{endif}) and (not when(signal > ${var.io_utilization_threshold_critical}%{if var.io_utilization_lasting_duration_critical != null}, lasting='${var.io_utilization_lasting_duration_critical}', at_least=${var.io_utilization_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.io_utilization_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.io_utilization_disabled_critical, var.io_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.io_utilization_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.io_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.io_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.io_utilization_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.io_utilization_disabled_major, var.io_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.io_utilization_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.io_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.io_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.io_utilization_max_delay
}

