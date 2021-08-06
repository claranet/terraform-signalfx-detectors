resource "signalfx_detector" "health_checker_value" {
  name = format("%s %s", local.detector_name_prefix, "Health-checker value")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('gauge.service.health.value', filter=${module.filtering.signalflow})${var.health_checker_value_transformation_function}.publish('signal')
    detect(when(signal != ${var.health_checker_value_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "is != ${var.health_checker_value_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.health_checker_value_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.health_checker_value_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.health_checker_value_runbook_url, var.runbook_url), "")
    tip                   = var.health_checker_value_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "health_checker_status" {
  name = format("%s %s", local.detector_name_prefix, "Health-checker status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('gauge.service.health.status', filter=${module.filtering.signalflow})${var.health_checker_status_transformation_function}.publish('signal')
    detect(when(signal != ${var.health_checker_status_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "is != ${var.health_checker_status_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.health_checker_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.health_checker_status_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.health_checker_status_runbook_url, var.runbook_url), "")
    tip                   = var.health_checker_status_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

