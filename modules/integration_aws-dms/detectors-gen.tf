resource "signalfx_detector" "task_restart" {
  name = format("%s %s", local.detector_name_prefix, "AWS DMS task has restarted")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/DMS')
    runcounter_delta = data('RunCounter', filter=base_filtering and filter('stat', 'upper') and ${module.filtering.signalflow}, rollup='delta', extrapolation='last_value')${var.task_restart_aggregation_function}${var.task_restart_transformation_function}
    signal = runcounter_delta.publish('signal')
    detect(when(signal > ${var.task_restart_threshold_critical}, lasting=%{if var.task_restart_lasting_duration_critical == null}None%{else}'${var.task_restart_lasting_duration_critical}'%{endif}, at_least=${var.task_restart_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.task_restart_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.task_restart_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.task_restart_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.task_restart_runbook_url, var.runbook_url), "")
    tip                   = var.task_restart_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.task_restart_max_delay
}

