resource "signalfx_detector" "systemd_services" {
  name = format("%s %s", local.detector_name_prefix, "systemd services aliveness")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
        signal = data('gauge.substate.running', filter=${module.filtering.signalflow})${var.systemd_services_aggregation_function}${var.systemd_services_transformation_function}.publish('signal')
        detect(when(signal < 1)).publish('CRIT')
EOF

  rule {
    description           = "service is not running"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.systemd_services_disabled_critical, var.systemd_services_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.systemd_services_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.systemd_services_runbook_url, var.runbook_url), "")
    tip                   = var.systemd_services_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}
