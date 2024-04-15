resource "signalfx_detector" "processes" {
  name = format("%s %s", local.detector_name_prefix, "Processes aliveness count")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('ps_count.processes', filter=${module.filtering.signalflow})${var.processes_aggregation_function}${var.processes_transformation_function}.publish('signal')
    detect(when(signal < ${var.processes_threshold_critical}%{if var.processes_lasting_duration_critical != null}, lasting='${var.processes_lasting_duration_critical}', at_least=${var.processes_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal < ${var.processes_threshold_major}%{if var.processes_lasting_duration_major != null}, lasting='${var.processes_lasting_duration_major}', at_least=${var.processes_at_least_percentage_major}%{endif}) and (not when(signal < ${var.processes_threshold_critical}%{if var.processes_lasting_duration_critical != null}, lasting='${var.processes_lasting_duration_critical}', at_least=${var.processes_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.processes_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.processes_disabled_critical, var.processes_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.processes_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.processes_runbook_url, var.runbook_url), "")
    tip                   = var.processes_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.processes_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.processes_disabled_major, var.processes_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.processes_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.processes_runbook_url, var.runbook_url), "")
    tip                   = var.processes_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.processes_max_delay
}

