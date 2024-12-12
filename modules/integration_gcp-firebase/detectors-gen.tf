resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Webcheck heartbeat")

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

resource "signalfx_detector" "firebase_database_load" {
  name = format("%s %s", local.detector_name_prefix, "GCP Firebase database firebase database load")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('io/database_load', filter=${module.filtering.signalflow})${var.firebase_database_load_aggregation_function}${var.firebase_database_load_transformation_function}.publish('signal')
    detect(when(signal > ${var.firebase_database_load_threshold_critical}%{if var.firebase_database_load_lasting_duration_critical != null}, lasting='${var.firebase_database_load_lasting_duration_critical}', at_least=${var.firebase_database_load_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.firebase_database_load_threshold_major}%{if var.firebase_database_load_lasting_duration_major != null}, lasting='${var.firebase_database_load_lasting_duration_major}', at_least=${var.firebase_database_load_at_least_percentage_major}%{endif}) and (not when(signal > ${var.firebase_database_load_threshold_critical}%{if var.firebase_database_load_lasting_duration_critical != null}, lasting='${var.firebase_database_load_lasting_duration_critical}', at_least=${var.firebase_database_load_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.firebase_database_load_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.firebase_database_load_disabled_critical, var.firebase_database_load_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.firebase_database_load_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.firebase_database_load_runbook_url, var.runbook_url), "")
    tip                   = var.firebase_database_load_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.firebase_database_load_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.firebase_database_load_disabled_major, var.firebase_database_load_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.firebase_database_load_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.firebase_database_load_runbook_url, var.runbook_url), "")
    tip                   = var.firebase_database_load_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.firebase_database_load_max_delay
}

resource "signalfx_detector" "firebase_database_io_utilization" {
  name = format("%s %s", local.detector_name_prefix, "GCP Firebase database firebase database io utilization")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('io/utilization', filter=${module.filtering.signalflow})${var.firebase_database_io_utilization_aggregation_function}${var.firebase_database_io_utilization_transformation_function}.publish('signal')
    detect(when(signal > ${var.firebase_database_io_utilization_threshold_critical}%{if var.firebase_database_io_utilization_lasting_duration_critical != null}, lasting='${var.firebase_database_io_utilization_lasting_duration_critical}', at_least=${var.firebase_database_io_utilization_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.firebase_database_io_utilization_threshold_major}%{if var.firebase_database_io_utilization_lasting_duration_major != null}, lasting='${var.firebase_database_io_utilization_lasting_duration_major}', at_least=${var.firebase_database_io_utilization_at_least_percentage_major}%{endif}) and (not when(signal > ${var.firebase_database_io_utilization_threshold_critical}%{if var.firebase_database_io_utilization_lasting_duration_critical != null}, lasting='${var.firebase_database_io_utilization_lasting_duration_critical}', at_least=${var.firebase_database_io_utilization_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.firebase_database_io_utilization_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.firebase_database_io_utilization_disabled_critical, var.firebase_database_io_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.firebase_database_io_utilization_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.firebase_database_io_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.firebase_database_io_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.firebase_database_io_utilization_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.firebase_database_io_utilization_disabled_major, var.firebase_database_io_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.firebase_database_io_utilization_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.firebase_database_io_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.firebase_database_io_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.firebase_database_io_utilization_max_delay
}

