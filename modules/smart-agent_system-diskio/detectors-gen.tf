resource "signalfx_detector" "disk_io_usage" {
  count = (var.disk_io_usage_enabled) ? 1 : 0

  name = format("%s %s", local.detector_name_prefix, "System disk io usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    signal = data('system.disk.io_time', filter=${module.filtering.signalflow}, rollup='rate')${var.disk_io_usage_aggregation_function}${var.disk_io_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.disk_io_usage_threshold_critical}%{if var.disk_io_usage_lasting_duration_critical != null}, lasting='${var.disk_io_usage_lasting_duration_critical}', at_least=${var.disk_io_usage_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.disk_io_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.disk_io_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.disk_io_usage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.disk_io_usage_runbook_url, var.runbook_url), "")
    tip                   = var.disk_io_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.disk_io_usage_max_delay
}

resource "signalfx_detector" "disk_weighted_io_usage" {
  count = (var.disk_weighted_io_usage_enabled) ? 1 : 0

  name = format("%s %s", local.detector_name_prefix, "System disk weighted io usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    signal = data('system.disk.weighted_io_time', filter=${module.filtering.signalflow}, rollup='rate')${var.disk_weighted_io_usage_aggregation_function}${var.disk_weighted_io_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.disk_weighted_io_usage_threshold_critical}%{if var.disk_weighted_io_usage_lasting_duration_critical != null}, lasting='${var.disk_weighted_io_usage_lasting_duration_critical}', at_least=${var.disk_weighted_io_usage_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.disk_weighted_io_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.disk_weighted_io_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.disk_weighted_io_usage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.disk_weighted_io_usage_runbook_url, var.runbook_url), "")
    tip                   = var.disk_weighted_io_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.disk_weighted_io_usage_max_delay
}

