resource "signalfx_detector" "ftp_code_matched" {
  name = format("%s %s", local.detector_name_prefix, "FTP service DOWN")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('ftp.status_code', filter=${module.filtering.signalflow}, rollup='min')${var.ftp_code_matched_aggregation_function}${var.ftp_code_matched_transformation_function}.publish('signal')
    detect(when(signal > ${var.ftp_code_matched_threshold_critical}%{if var.ftp_code_matched_lasting_duration_critical != null}, lasting='${var.ftp_code_matched_lasting_duration_critical}', at_least=${var.ftp_code_matched_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "does not match expected result > ${var.ftp_code_matched_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.ftp_code_matched_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.ftp_code_matched_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.ftp_code_matched_runbook_url, var.runbook_url), "")
    tip                   = var.ftp_code_matched_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.ftp_code_matched_max_delay
}
