resource "signalfx_detector" "listener" {
  name = format("%s %s", local.detector_name_prefix, "Oracle process listener")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('tnslsnr', filter=${module.filtering.signalflow})${var.listener_aggregation_function}${var.listener_transformation_function}.publish('signal')
    detect(when(signal < ${var.listener_threshold_critical}, lasting=%{if var.listener_lasting_duration_critical == null}None%{else}'${var.listener_lasting_duration_critical}'%{endif}, at_least=${var.listener_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is not started < ${var.listener_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.listener_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.listener_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.listener_runbook_url, var.runbook_url), "")
    tip                   = var.listener_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

