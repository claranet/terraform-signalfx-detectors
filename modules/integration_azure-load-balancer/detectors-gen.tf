resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure Load Balancer heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('resource_type', 'Microsoft.Network/loadBalancers') and filter('primary_aggregation_type', 'true')
    signal = data('ByteCount', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "backend_unhealthy_host_ratio" {
  name = format("%s %s", local.detector_name_prefix, "Azure Load Balancer backend unhealthy host ratio")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Network/loadBalancers') and filter('primary_aggregation_type', 'true')
    signal = data('DipAvailability', filter=base_filtering and ${module.filtering.signalflow})${var.backend_unhealthy_host_ratio_aggregation_function}${var.backend_unhealthy_host_ratio_transformation_function}.publish('signal')
    detect(when(signal < ${var.backend_unhealthy_host_ratio_threshold_critical}%{if var.backend_unhealthy_host_ratio_lasting_duration_critical != null}, lasting='${var.backend_unhealthy_host_ratio_lasting_duration_critical}', at_least=${var.backend_unhealthy_host_ratio_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal < ${var.backend_unhealthy_host_ratio_threshold_major}%{if var.backend_unhealthy_host_ratio_lasting_duration_major != null}, lasting='${var.backend_unhealthy_host_ratio_lasting_duration_major}', at_least=${var.backend_unhealthy_host_ratio_at_least_percentage_major}%{endif}) and (not when(signal < ${var.backend_unhealthy_host_ratio_threshold_critical}%{if var.backend_unhealthy_host_ratio_lasting_duration_critical != null}, lasting='${var.backend_unhealthy_host_ratio_lasting_duration_critical}', at_least=${var.backend_unhealthy_host_ratio_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.backend_unhealthy_host_ratio_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_unhealthy_host_ratio_disabled_critical, var.backend_unhealthy_host_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backend_unhealthy_host_ratio_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.backend_unhealthy_host_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.backend_unhealthy_host_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.backend_unhealthy_host_ratio_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.backend_unhealthy_host_ratio_disabled_major, var.backend_unhealthy_host_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backend_unhealthy_host_ratio_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.backend_unhealthy_host_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.backend_unhealthy_host_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.backend_unhealthy_host_ratio_max_delay
}

