resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Kong heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    kong_signal = data('kong_datastore_reachable', filter=%{if var.heartbeat_exclude_not_running_vm}${local.not_running_vm_filters} and %{endif}${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}
    cpu_signal = data('cpu.utilization', filter=%{if var.heartbeat_exclude_not_running_vm}${local.not_running_vm_filters} and %{endif}${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}
    no_kong_data = (count(kong_signal) == 0 and count(cpu_signal) > 0).publish("no_kong_data")
    detect(when(no_kong_data, lasting="${var.heartbeat_timeframe}"), auto_resolve_after="${local.heartbeat_auto_resolve_after}").publish('CRIT')
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

resource "signalfx_detector" "treatment_limit" {
  name = format("%s %s", local.detector_name_prefix, "Kong treatment limit")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('kong_nginx_http_current_connections', filter=filter('state', 'handled') and ${module.filtering.signalflow})${var.treatment_limit_aggregation_function}${var.treatment_limit_transformation_function}
    B = data('kong_nginx_http_current_connections', filter=filter('state', 'accepted') and ${module.filtering.signalflow})${var.treatment_limit_aggregation_function}${var.treatment_limit_transformation_function}
    signal = ((A-B)/A).scale(100).publish('signal')
    detect(when(signal > ${var.treatment_limit_threshold_critical}%{if var.treatment_limit_lasting_duration_critical != null}, lasting='${var.treatment_limit_lasting_duration_critical}', at_least=${var.treatment_limit_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.treatment_limit_threshold_major}%{if var.treatment_limit_lasting_duration_major != null}, lasting='${var.treatment_limit_lasting_duration_major}', at_least=${var.treatment_limit_at_least_percentage_major}%{endif}) and (not when(signal > ${var.treatment_limit_threshold_critical}%{if var.treatment_limit_lasting_duration_critical != null}, lasting='${var.treatment_limit_lasting_duration_critical}', at_least=${var.treatment_limit_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.treatment_limit_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.treatment_limit_disabled_critical, var.treatment_limit_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.treatment_limit_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.treatment_limit_runbook_url, var.runbook_url), "")
    tip                   = var.treatment_limit_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.treatment_limit_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.treatment_limit_disabled_major, var.treatment_limit_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.treatment_limit_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.treatment_limit_runbook_url, var.runbook_url), "")
    tip                   = var.treatment_limit_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.treatment_limit_max_delay
}

