resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Active-directory heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('windows_ad_replication_sync_requests_total', filter=%{ if var.heartbeat_exclude_not_running_vm }${local.not_running_vm_filters} and %{ endif }${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "replication_errors" {
  name = format("%s %s", local.detector_name_prefix, "Active-directory replication errors")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('windows_ad_replication_sync_requests_success_total', filter=${module.filtering.signalflow}, extrapolation='zero')${var.replication_errors_aggregation_function}${var.replication_errors_transformation_function}
    B = data('windows_ad_replication_sync_requests_total', filter=${module.filtering.signalflow}, extrapolation='zero')${var.replication_errors_aggregation_function}${var.replication_errors_transformation_function}
    signal = (A/B).scale(100).fill(0).publish('signal')
    detect(when(signal < ${var.replication_errors_threshold_critical}%{if var.replication_errors_lasting_duration_critical != null}, lasting='${var.replication_errors_lasting_duration_critical}', at_least=${var.replication_errors_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal <= ${var.replication_errors_threshold_major}%{if var.replication_errors_lasting_duration_major != null}, lasting='${var.replication_errors_lasting_duration_major}', at_least=${var.replication_errors_at_least_percentage_major}%{endif}) and (not when(signal < ${var.replication_errors_threshold_critical}%{if var.replication_errors_lasting_duration_critical != null}, lasting='${var.replication_errors_lasting_duration_critical}', at_least=${var.replication_errors_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.replication_errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.replication_errors_disabled_critical, var.replication_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.replication_errors_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.replication_errors_runbook_url, var.runbook_url), "")
    tip                   = var.replication_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low <= ${var.replication_errors_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.replication_errors_disabled_major, var.replication_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.replication_errors_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.replication_errors_runbook_url, var.runbook_url), "")
    tip                   = var.replication_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.replication_errors_max_delay
}

resource "signalfx_detector" "active_directory_services" {
  name = format("%s %s", local.detector_name_prefix, "Active-directory active directory services")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('state', 'running') and filter('name','kdc', 'adws', 'dfs', 'dfsr', 'dns', 'ismserv', 'lanmanserver', 'lanmanworkstation', 'netlogon', 'ntds', 'w32time')
    signal = data('windows_service_state', filter=base_filtering and ${module.filtering.signalflow})${var.active_directory_services_aggregation_function}${var.active_directory_services_transformation_function}.publish('signal')
    detect(when(signal < ${var.active_directory_services_threshold_critical}%{if var.active_directory_services_lasting_duration_critical != null}, lasting='${var.active_directory_services_lasting_duration_critical}', at_least=${var.active_directory_services_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.active_directory_services_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.active_directory_services_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.active_directory_services_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.active_directory_services_runbook_url, var.runbook_url), "")
    tip                   = var.active_directory_services_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.active_directory_services_max_delay
}

