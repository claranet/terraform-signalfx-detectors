resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Apache heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('apache_connections', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "apache_workers" {
  name = format("%s %s", local.detector_name_prefix, "Apache busy workers")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    A = data('apache_connections', filter=${module.filtering.signalflow})${var.apache_workers_aggregation_function}${var.apache_workers_transformation_function}
    B = data('apache_idle_workers', filter=${module.filtering.signalflow})${var.apache_workers_aggregation_function}${var.apache_workers_transformation_function}
    signal = ((A / (A+B)).scale(100)).publish('signal')
    detect(when(signal > ${var.apache_workers_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.apache_workers_threshold_major}) and when(signal <= ${var.apache_workers_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "are too high > ${var.apache_workers_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.apache_workers_disabled_critical, var.apache_workers_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.apache_workers_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.apache_workers_runbook_url, var.runbook_url), "")
    tip                   = var.apache_workers_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "are too high > ${var.apache_workers_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.apache_workers_disabled_major, var.apache_workers_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.apache_workers_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.apache_workers_runbook_url, var.runbook_url), "")
    tip                   = var.apache_workers_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

