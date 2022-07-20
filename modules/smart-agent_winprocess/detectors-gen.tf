resource "signalfx_detector" "status" {
  name = format("%s %s", local.detector_name_prefix, "Winprocess status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('win_services.state', filter=${module.filtering.signalflow})${var.status_aggregation_function}${var.status_transformation_function}
    signal = A.publish('signal')
    detect(when(signal < ${var.status_threshold_critical}, lasting=%{if var.status_lasting_duration_critical == null}None%{else}'${var.status_lasting_duration_critical}'%{endif}, at_least=${var.status_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.status_threshold_critical}"
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

