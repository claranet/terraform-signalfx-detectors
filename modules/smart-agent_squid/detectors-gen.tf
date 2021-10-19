resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Squid heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('squid_up', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "status" {
  name = format("%s %s", local.detector_name_prefix, "Squid status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('squid_up', filter=${module.filtering.signalflow})${var.status_aggregation_function}${var.status_transformation_function}.publish('signal')
    detect(when(signal < ${var.status_threshold_critical}, lasting=%{if var.status_lasting_duration_critical == null}None%{else}'${var.status_lasting_duration_critical}'%{endif}, at_least=${var.status_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.status_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.status_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.status_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.status_runbook_url, var.runbook_url), "")
    tip                   = var.status_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "server_errors" {
  name = format("%s %s", local.detector_name_prefix, "Squid server_errors")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('squid_server_all_errors_total', filter=${module.filtering.signalflow}, extrapolation='zero')${var.server_errors_aggregation_function}${var.server_errors_transformation_function}
    B = data('squid_server_all_requests_total', filter=${module.filtering.signalflow}, extrapolation='zero')${var.server_errors_aggregation_function}${var.server_errors_transformation_function}
    signal = (A/B).scale(100).fill(0).publish('signal')
    detect(when(signal >= ${var.server_errors_threshold_critical}, lasting=%{if var.server_errors_lasting_duration_critical == null}None%{else}'${var.server_errors_lasting_duration_critical}'%{endif}, at_least=${var.server_errors_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal >= ${var.server_errors_threshold_major}, lasting=%{if var.server_errors_lasting_duration_major == null}None%{else}'${var.server_errors_lasting_duration_major}'%{endif}, at_least=${var.server_errors_at_least_percentage_major}) and (not when(signal >= ${var.server_errors_threshold_critical}, lasting=%{if var.server_errors_lasting_duration_critical == null}None%{else}'${var.server_errors_lasting_duration_critical}'%{endif}, at_least=${var.server_errors_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.server_errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.server_errors_disabled_critical, var.server_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.server_errors_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.server_errors_runbook_url, var.runbook_url), "")
    tip                   = var.server_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high >= ${var.server_errors_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.server_errors_disabled_major, var.server_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.server_errors_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.server_errors_runbook_url, var.runbook_url), "")
    tip                   = var.server_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "total_requests" {
  name = format("%s %s", local.detector_name_prefix, "Squid total_requests")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('squid_client_http_requests_total', filter=${module.filtering.signalflow})${var.total_requests_transformation_function}.publish('signal')
    detect(when(signal <= ${var.total_requests_threshold_critical}, lasting=%{if var.total_requests_lasting_duration_critical == null}None%{else}'${var.total_requests_lasting_duration_critical}'%{endif}, at_least=${var.total_requests_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too low <= ${var.total_requests_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.total_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.total_requests_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.total_requests_runbook_url, var.runbook_url), "")
    tip                   = var.total_requests_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

