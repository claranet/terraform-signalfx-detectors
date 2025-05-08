resource "signalfx_detector" "mongodb_code_matched" {
  name = format("%s %s", local.detector_name_prefix, "MongoDB service DOWN")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('mongodb.status_code', filter=${module.filtering.signalflow}, rollup='min')${var.mongodb_code_matched_aggregation_function}${var.mongodb_code_matched_transformation_function}.publish('signal')
    detect(when(signal > ${var.mongodb_code_matched_threshold_critical}%{if var.mongodb_code_matched_lasting_duration_critical != null}, lasting='${var.mongodb_code_matched_lasting_duration_critical}', at_least=${var.mongodb_code_matched_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "does not match expected result > ${var.mongodb_code_matched_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.mongodb_code_matched_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.mongodb_code_matched_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.mongodb_code_matched_runbook_url, var.runbook_url), "")
    tip                   = var.mongodb_code_matched_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.mongodb_code_matched_max_delay
}
