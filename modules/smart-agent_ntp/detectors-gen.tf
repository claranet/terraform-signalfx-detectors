resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "NTP heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('ntp.offset_seconds', filter=%{if var.heartbeat_exclude_not_running_vm}${local.not_running_vm_filters} and %{endif}${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "ntp" {
  name = format("%s %s", local.detector_name_prefix, "NTP offset")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('ntp.offset_seconds', filter=${module.filtering.signalflow})${var.ntp_aggregation_function}${var.ntp_transformation_function}.publish('signal')
    detect(when(signal > ${var.ntp_threshold_major}%{if var.ntp_lasting_duration_major != null}, lasting='${var.ntp_lasting_duration_major}', at_least=${var.ntp_at_least_percentage_major}%{endif})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.ntp_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.ntp_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.ntp_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.ntp_runbook_url, var.runbook_url), "")
    tip                   = var.ntp_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.ntp_max_delay
}

