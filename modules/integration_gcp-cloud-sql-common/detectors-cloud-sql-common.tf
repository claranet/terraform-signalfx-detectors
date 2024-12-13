resource "signalfx_detector" "disk_utilization_forecast" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud SQL disk space is running out")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.countdown import countdown
    signal = data('database/disk/utilization', filter=${module.filtering.signalflow}).publish('signal')
    countdown.hours_left_stream_incr_detector(stream=signal, maximum_capacity=${var.disk_utilization_forecast_maximum_capacity}, lower_threshold=${var.disk_utilization_forecast_hours_till_full}, fire_lasting=lasting('${var.disk_utilization_forecast_fire_lasting_time}', ${var.disk_utilization_forecast_fire_lasting_time_percent}), clear_threshold=${var.disk_utilization_forecast_clear_hours_remaining}, clear_lasting=lasting('${var.disk_utilization_forecast_clear_lasting_time}', ${var.disk_utilization_forecast_clear_lasting_time_percent}), use_double_ewma=${var.disk_utilization_forecast_use_ewma}).publish('CRIT')
EOF

  rule {
    description           = "in ${var.disk_utilization_forecast_hours_till_full}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.disk_utilization_forecast_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.disk_utilization_forecast_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.disk_utilization_forecast_runbook_url, var.runbook_url), "")
    tip                   = var.disk_utilization_forecast_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject_novalue : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.disk_utilization_forecast_max_delay
}

resource "signalfx_detector" "memory_utilization_forecast" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud SQL memory is running out")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.countdown import countdown
    signal = data('database/memory/utilization', filter=${module.filtering.signalflow}).publish('signal')
    countdown.hours_left_stream_incr_detector(stream=signal, maximum_capacity=${var.memory_utilization_forecast_maximum_capacity}, lower_threshold=${var.memory_utilization_forecast_hours_till_full}, fire_lasting=lasting('${var.memory_utilization_forecast_fire_lasting_time}', ${var.memory_utilization_forecast_fire_lasting_time_percent}), clear_threshold=${var.memory_utilization_forecast_clear_hours_remaining}, clear_lasting=lasting('${var.memory_utilization_forecast_clear_lasting_time}', ${var.memory_utilization_forecast_clear_lasting_time_percent}), use_double_ewma=${var.memory_utilization_forecast_use_ewma}).publish('CRIT')
EOF

  rule {
    description           = "in ${var.memory_utilization_forecast_hours_till_full}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_utilization_forecast_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_utilization_forecast_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.memory_utilization_forecast_runbook_url, var.runbook_url), "")
    tip                   = var.memory_utilization_forecast_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject_novalue : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memory_utilization_forecast_max_delay
}

