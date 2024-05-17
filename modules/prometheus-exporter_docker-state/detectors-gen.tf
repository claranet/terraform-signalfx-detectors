resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Docker-state heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('container_state_status', filter=%{ if var.heartbeat_exclude_not_running_vm }${local.not_running_vm_filters} and %{ endif }${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "state_health_status" {
  name = format("%s %s", local.detector_name_prefix, "Docker-state state health status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('service.name', 'docker-state-exporter') and filter('status', 'unhealthy')
    signal = data('container_state_health_status', filter=base_filtering and ${module.filtering.signalflow})${var.state_health_status_aggregation_function}${var.state_health_status_transformation_function}.publish('signal')
    detect(when(signal > ${var.state_health_status_threshold_critical}%{if var.state_health_status_lasting_duration_critical != null}, lasting='${var.state_health_status_lasting_duration_critical}', at_least=${var.state_health_status_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.state_health_status_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.state_health_status_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.state_health_status_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.state_health_status_runbook_url, var.runbook_url), "")
    tip                   = var.state_health_status_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.state_health_status_max_delay
}

resource "signalfx_detector" "state_status" {
  name = format("%s %s", local.detector_name_prefix, "Docker-state state status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('service.name', 'docker-state-exporter') and not filter('status', 'running')
    signal = data('container_state_status', filter=base_filtering and ${module.filtering.signalflow})${var.state_status_aggregation_function}${var.state_status_transformation_function}.publish('signal')
    detect(when(signal > ${var.state_status_threshold_critical}%{if var.state_status_lasting_duration_critical != null}, lasting='${var.state_status_lasting_duration_critical}', at_least=${var.state_status_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.state_status_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.state_status_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.state_status_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.state_status_runbook_url, var.runbook_url), "")
    tip                   = var.state_status_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.state_status_max_delay
}

resource "signalfx_detector" "state_oom_killed" {
  name = format("%s %s", local.detector_name_prefix, "Docker-state state oom killed")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('service.name', 'docker-state-exporter')
    signal = data('container_state_oomkilled', filter=base_filtering and ${module.filtering.signalflow})${var.state_oom_killed_aggregation_function}${var.state_oom_killed_transformation_function}.publish('signal')
    detect(when(signal > ${var.state_oom_killed_threshold_critical}%{if var.state_oom_killed_lasting_duration_critical != null}, lasting='${var.state_oom_killed_lasting_duration_critical}', at_least=${var.state_oom_killed_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.state_oom_killed_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.state_oom_killed_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.state_oom_killed_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.state_oom_killed_runbook_url, var.runbook_url), "")
    tip                   = var.state_oom_killed_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.state_oom_killed_max_delay
}

