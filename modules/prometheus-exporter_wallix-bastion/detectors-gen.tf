resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Wallix-bastion heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('wallix_bastion_up', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "status" {
  name = format("%s %s", local.detector_name_prefix, "Wallix-bastion status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('wallix_bastion_up', filter=${module.filtering.signalflow})${var.status_aggregation_function}${var.status_transformation_function}.publish('signal')
    detect(when(signal < ${var.status_threshold_critical}%{if var.status_lasting_duration_critical != null}, lasting='${var.status_lasting_duration_critical}', at_least=${var.status_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.status_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.status_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.status_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.status_runbook_url, var.runbook_url), "")
    tip                   = var.status_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.status_max_delay
}

resource "signalfx_detector" "current_sessions" {
  name = format("%s %s", local.detector_name_prefix, "Wallix-bastion total number of current sessions")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('wallix_bastion_sessions', filter=filter('status', 'current') and ${module.filtering.signalflow})${var.current_sessions_aggregation_function}${var.current_sessions_transformation_function}.publish('signal')
    detect(when(signal > ${var.current_sessions_threshold_major}%{if var.current_sessions_lasting_duration_major != null}, lasting='${var.current_sessions_lasting_duration_major}', at_least=${var.current_sessions_at_least_percentage_major}%{endif})).publish('MAJOR')
    detect(when(signal > ${var.current_sessions_threshold_minor}%{if var.current_sessions_lasting_duration_minor != null}, lasting='${var.current_sessions_lasting_duration_minor}', at_least=${var.current_sessions_at_least_percentage_minor}%{endif}) and (not when(signal > ${var.current_sessions_threshold_major}%{if var.current_sessions_lasting_duration_major != null}, lasting='${var.current_sessions_lasting_duration_major}', at_least=${var.current_sessions_at_least_percentage_major}%{endif}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.current_sessions_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.current_sessions_disabled_major, var.current_sessions_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.current_sessions_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.current_sessions_runbook_url, var.runbook_url), "")
    tip                   = var.current_sessions_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.current_sessions_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.current_sessions_disabled_minor, var.current_sessions_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.current_sessions_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.current_sessions_runbook_url, var.runbook_url), "")
    tip                   = var.current_sessions_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.current_sessions_max_delay
}

resource "signalfx_detector" "encryption_status" {
  name = format("%s %s", local.detector_name_prefix, "Wallix-bastion encryption status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    status = data('wallix_bastion_encryption_status', filter=${module.filtering.signalflow})${var.encryption_status_aggregation_function}${var.encryption_status_transformation_function}
    signal = status.fill(value=1).publish('signal')
    detect(when(signal != ${var.encryption_status_threshold_critical}%{if var.encryption_status_lasting_duration_critical != null}, lasting='${var.encryption_status_lasting_duration_critical}', at_least=${var.encryption_status_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is not ready != ${var.encryption_status_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.encryption_status_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.encryption_status_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.encryption_status_runbook_url, var.runbook_url), "")
    tip                   = var.encryption_status_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.encryption_status_max_delay
}

resource "signalfx_detector" "license" {
  name = format("%s %s", local.detector_name_prefix, "Wallix-bastion license")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('wallix_bastion_license_is_expired', filter=${module.filtering.signalflow}, extrapolation='zero')${var.license_aggregation_function}${var.license_transformation_function}.publish('signal')
    detect(when(signal > ${var.license_threshold_critical}%{if var.license_lasting_duration_critical != null}, lasting='${var.license_lasting_duration_critical}', at_least=${var.license_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is expired > ${var.license_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.license_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.license_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.license_runbook_url, var.runbook_url), "")
    tip                   = var.license_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.license_max_delay
}

