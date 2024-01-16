resource "signalfx_detector" "mysql_threads_anomaly" {
  name = format("%s %s", local.detector_name_prefix, "MySQL running threads changed abruptly")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.against_periods import against_periods
    signal = data('threads.running', filter=filter('plugin', 'mysql') and ${module.filtering.signalflow}, rollup='average')${var.threads_anomaly_aggregation_function}${var.threads_anomaly_transformation_function}.publish('signal')
    against_periods.detector_growth_rate(signal, window_to_compare=duration('${var.threads_anomaly_window_to_compare}'), space_between_windows=duration('${var.threads_anomaly_space_between_windows}'), num_windows=${var.threads_anomaly_num_windows}, fire_growth_rate_threshold=${var.threads_anomaly_fire_growth_rate_threshold}, clear_growth_rate_threshold=${var.threads_anomaly_clear_growth_rate_threshold}, discard_historical_outliers=True, orientation='${var.threads_anomaly_orientation}').publish('CRIT')
EOF

  rule {
    description           = "with rate > ${var.threads_anomaly_fire_growth_rate_threshold}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.threads_anomaly_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.threads_anomaly_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.threads_anomaly_runbook_url, var.runbook_url), "")
    tip                   = var.threads_anomaly_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.threads_anomaly_max_delay
}

resource "signalfx_detector" "mysql_questions_anomaly" {
  name = format("%s %s", local.detector_name_prefix, "MySQL running queries changed abruptly")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.against_periods import against_periods
    signal = data('mysql_commands.*', filter=filter('plugin', 'mysql') and ${module.filtering.signalflow}, rollup='delta')${var.questions_anomaly_aggregation_function}${var.questions_anomaly_transformation_function}.publish('signal')
    against_periods.detector_growth_rate(signal, window_to_compare=duration('${var.questions_anomaly_window_to_compare}'), space_between_windows=duration('${var.questions_anomaly_space_between_windows}'), num_windows=${var.questions_anomaly_num_windows}, fire_growth_rate_threshold=${var.questions_anomaly_fire_growth_rate_threshold}, clear_growth_rate_threshold=${var.questions_anomaly_clear_growth_rate_threshold}, discard_historical_outliers=True, orientation='${var.questions_anomaly_orientation}').publish('CRIT')
EOF

  rule {
    description           = "with rate > ${var.questions_anomaly_fire_growth_rate_threshold}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.questions_anomaly_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.questions_anomaly_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.questions_anomaly_runbook_url, var.runbook_url), "")
    tip                   = var.questions_anomaly_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.questions_anomaly_max_delay
}

