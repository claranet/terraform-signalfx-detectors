resource "signalfx_detector" "heartbeat" {
  count = (var.heartbeat_detector_enabled) ? 1 : 0

  name = format("%s %s", local.detector_name_prefix, "AWS NLB heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('stat', 'mean') and filter('namespace', 'AWS/NetworkELB')
    signal = data('ConsumedLCUs', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "no_healthy_instances" {
  count = (var.healthy_instances_detector_enabled) ? 1 : 0

  name = format("%s %s", local.detector_name_prefix, "AWS NLB healthy instances percentage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/NetworkELB') and (not filter('AvailabilityZone', '*'))
    A = data('HealthyHostCount', filter=base_filtering and filter('stat', 'lower') and ${module.filtering.signalflow})${var.no_healthy_instances_aggregation_function}${var.no_healthy_instances_transformation_function}
    B = data('UnHealthyHostCount', filter=base_filtering and filter('stat', 'upper') and ${module.filtering.signalflow})${var.no_healthy_instances_aggregation_function}${var.no_healthy_instances_transformation_function}
    signal = (A / (A+B)).scale(100).publish('signal')
    detect(when(signal < ${var.no_healthy_instances_threshold_critical}%{if var.no_healthy_instances_lasting_duration_critical != null}, lasting='${var.no_healthy_instances_lasting_duration_critical}', at_least=${var.no_healthy_instances_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal < ${var.no_healthy_instances_threshold_major}%{if var.no_healthy_instances_lasting_duration_major != null}, lasting='${var.no_healthy_instances_lasting_duration_major}', at_least=${var.no_healthy_instances_at_least_percentage_major}%{endif}) and (not when(signal < ${var.no_healthy_instances_threshold_critical}%{if var.no_healthy_instances_lasting_duration_critical != null}, lasting='${var.no_healthy_instances_lasting_duration_critical}', at_least=${var.no_healthy_instances_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.no_healthy_instances_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.no_healthy_instances_disabled_critical, var.no_healthy_instances_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.no_healthy_instances_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.no_healthy_instances_runbook_url, var.runbook_url), "")
    tip                   = var.no_healthy_instances_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.no_healthy_instances_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.no_healthy_instances_disabled_major, var.no_healthy_instances_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.no_healthy_instances_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.no_healthy_instances_runbook_url, var.runbook_url), "")
    tip                   = var.no_healthy_instances_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.no_healthy_instances_max_delay
}

