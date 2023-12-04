resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure Container Apps heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('resource_type', 'Microsoft.App/containerApps') and filter('aggregation_type', 'minimum')
    signal = data('WorkingSetBytes', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "restarts" {
  name = format("%s %s", local.detector_name_prefix, "Azure Container Apps restarts")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.App/containerApps')
    signal = data('RestartCount', filter=base_filtering and ${module.filtering.signalflow})${var.restarts_aggregation_function}${var.restarts_transformation_function}.publish('signal')
    detect(when(signal > ${var.restarts_threshold_warning}, lasting=%{if var.restarts_lasting_duration_warning == null}None%{else}'${var.restarts_lasting_duration_warning}'%{endif}, at_least=${var.restarts_at_least_percentage_warning})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.restarts_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.restarts_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.restarts_notifications, "warning", []), var.notifications.warning), null)
    runbook_url           = try(coalesce(var.restarts_runbook_url, var.runbook_url), "")
    tip                   = var.restarts_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.restarts_max_delay
}

resource "signalfx_detector" "replicas" {
  name = format("%s %s", local.detector_name_prefix, "Azure Container Apps replicas")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.App/containerApps') and filter('aggregation_type', 'count')
    signal = data('Replicas', filter=base_filtering and ${module.filtering.signalflow})${var.replicas_transformation_function}.publish('signal')
    detect(when(signal > ${var.replicas_threshold_info}, lasting=%{if var.replicas_lasting_duration_info == null}None%{else}'${var.replicas_lasting_duration_info}'%{endif}, at_least=${var.replicas_at_least_percentage_info})).publish('INFO')
EOF

  rule {
    description           = "is too high > ${var.replicas_threshold_info}"
    severity              = "Info"
    detect_label          = "INFO"
    disabled              = coalesce(var.replicas_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.replicas_notifications, "info", []), var.notifications.info), null)
    runbook_url           = try(coalesce(var.replicas_runbook_url, var.runbook_url), "")
    tip                   = var.replicas_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.replicas_max_delay
}

