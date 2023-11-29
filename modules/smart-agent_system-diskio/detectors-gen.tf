resource "signalfx_detector" "disk_iotime" {
  name = format("%s %s", local.detector_name_prefix, "System disk io usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "usage"
    value_suffix = "%"
  }

  program_text = <<-EOF
    usage = data('system.disk.io_time', filter=${module.filtering.signalflow}, rollup='rate')${var.disk_iotime_aggregation_function}${var.disk_iotime_transformation_function}.publish('usage')
    detect(when(signal > ${var.disk_iotime_threshold_critical}, lasting=%{if var.disk_iotime_lasting_duration_critical == null}None%{else}'${var.disk_iotime_lasting_duration_critical}'%{endif}, at_least=${var.disk_iotime_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.disk_iotime_threshold_major}, lasting=%{if var.disk_iotime_lasting_duration_major == null}None%{else}'${var.disk_iotime_lasting_duration_major}'%{endif}, at_least=${var.disk_iotime_at_least_percentage_major}) and (not when(signal > ${var.disk_iotime_threshold_critical}, lasting=%{if var.disk_iotime_lasting_duration_critical == null}None%{else}'${var.disk_iotime_lasting_duration_critical}'%{endif}, at_least=${var.disk_iotime_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.disk_iotime_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.disk_iotime_disabled_critical, var.disk_iotime_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.disk_iotime_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.disk_iotime_runbook_url, var.runbook_url), "")
    tip                   = var.disk_iotime_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.disk_iotime_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.disk_iotime_disabled_major, var.disk_iotime_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.disk_iotime_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.disk_iotime_runbook_url, var.runbook_url), "")
    tip                   = var.disk_iotime_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.disk_iotime_max_delay
}

resource "signalfx_detector" "disk_weightediotime" {
  name = format("%s %s", local.detector_name_prefix, "System disk weighted io usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "usage"
    value_suffix = "%"
  }

  program_text = <<-EOF
    usage = data('system.disk.weighted_io_time', filter=${module.filtering.signalflow}, rollup='rate')${var.disk_weightediotime_aggregation_function}${var.disk_weightediotime_transformation_function}.publish('usage')
    detect(when(signal > ${var.disk_weightediotime_threshold_critical}, lasting=%{if var.disk_weightediotime_lasting_duration_critical == null}None%{else}'${var.disk_weightediotime_lasting_duration_critical}'%{endif}, at_least=${var.disk_weightediotime_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.disk_weightediotime_threshold_major}, lasting=%{if var.disk_weightediotime_lasting_duration_major == null}None%{else}'${var.disk_weightediotime_lasting_duration_major}'%{endif}, at_least=${var.disk_weightediotime_at_least_percentage_major}) and (not when(signal > ${var.disk_weightediotime_threshold_critical}, lasting=%{if var.disk_weightediotime_lasting_duration_critical == null}None%{else}'${var.disk_weightediotime_lasting_duration_critical}'%{endif}, at_least=${var.disk_weightediotime_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.disk_weightediotime_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.disk_weightediotime_disabled_critical, var.disk_weightediotime_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.disk_weightediotime_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.disk_weightediotime_runbook_url, var.runbook_url), "")
    tip                   = var.disk_weightediotime_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.disk_weightediotime_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.disk_weightediotime_disabled_major, var.disk_weightediotime_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.disk_weightediotime_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.disk_weightediotime_runbook_url, var.runbook_url), "")
    tip                   = var.disk_weightediotime_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.disk_weightediotime_max_delay
}

