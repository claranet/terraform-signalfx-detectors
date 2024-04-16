resource "signalfx_detector" "value" {
  name = format("%s %s", local.detector_name_prefix, "Health-checker value")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('gauge.service.health.value', filter=${module.filtering.signalflow})${var.value_aggregation_function}${var.value_transformation_function}.publish('signal')
    detect(when(signal != ${var.value_threshold_critical}%{if var.value_lasting_duration_critical != null}, lasting='${var.value_lasting_duration_critical}', at_least=${var.value_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is != ${var.value_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.value_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.value_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.value_runbook_url, var.runbook_url), "")
    tip                   = var.value_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.value_max_delay
}

resource "signalfx_detector" "status" {
  name = format("%s %s", local.detector_name_prefix, "Health-checker status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('gauge.service.health.status', filter=${module.filtering.signalflow})${var.status_aggregation_function}${var.status_transformation_function}.publish('signal')
    detect(when(signal != ${var.status_threshold_critical}%{if var.status_lasting_duration_critical != null}, lasting='${var.status_lasting_duration_critical}', at_least=${var.status_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is != ${var.status_threshold_critical}"
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

