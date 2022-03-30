resource "signalfx_detector" "failover_unavailable" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud SQL failover")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('database/available_for_failover', ${module.filtering.signalflow})${var.failover_unavailable_aggregation_function}${var.failover_unavailable_transformation_function}.publish('signal')
    detect(when(signal < 1)).publish('MAJOR')
EOF

  rule {
    description           = "is unavailable"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.failover_unavailable_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.failover_unavailable_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.failover_unavailable_runbook_url, var.runbook_url), "")
    tip                   = var.failover_unavailable_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.failover_unavailable_max_delay
}

