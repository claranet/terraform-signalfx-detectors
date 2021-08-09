resource "signalfx_detector" "aliveness" {
  name = format("%s %s", local.detector_name_prefix, "Systemd-services aliveness")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('gauge.substate.running', filter=${module.filtering.signalflow})${var.aliveness_aggregation_function}${var.aliveness_transformation_function}.publish('signal')
    detect(when(signal != ${var.aliveness_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "is != ${var.aliveness_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.aliveness_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.aliveness_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.aliveness_runbook_url, var.runbook_url), "")
    tip                   = var.aliveness_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

