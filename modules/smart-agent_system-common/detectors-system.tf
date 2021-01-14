resource "signalfx_detector" "disk_running_out" {
  name = format("%s %s", local.detector_name_prefix, "System disk space running out")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    from signalfx.detectors.countdown import countdown
    signal = data('disk.utilization', filter=${module.filter-tags.filter_custom}).publish('signal')
    countdown.hours_left_stream_incr_detector(stream=signal, maximum_capacity=${var.disk_running_out_maximum_capacity}, lower_threshold=${var.disk_running_out_hours_till_full}, fire_lasting=lasting('${var.disk_running_out_fire_lasting_time}', ${var.disk_running_out_fire_lasting_time_percent}), clear_threshold=${var.disk_running_out_clear_hours_remaining}, clear_lasting=lasting('${var.disk_running_out_clear_lasting_time}', ${var.disk_running_out_clear_lasting_time_percent}), use_double_ewma=${var.disk_running_out_use_ewma}).publish('MAJOR')
EOF

  rule {
    description           = "in ${var.disk_running_out_hours_till_full}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.disk_running_out_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_running_out_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.disk_running_out_runbook_url, var.runbook_url), "")
    tip                   = var.disk_running_out_tip
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }
}

