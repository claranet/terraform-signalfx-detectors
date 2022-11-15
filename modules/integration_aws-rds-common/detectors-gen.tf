resource "signalfx_detector" "dbload" {
  name = format("%s %s", local.detector_name_prefix, "AWS RDS Common db load")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/RDS')
    signal = data('DBLoad', filter=base_filtering and ${module.filtering.signalflow})${var.dbload_aggregation_function}${var.dbload_transformation_function}.publish('signal')
    detect(when(signal > ${var.dbload_threshold_critical}, lasting=%{if var.dbload_lasting_duration_critical == null}None%{else}'${var.dbload_lasting_duration_critical}'%{endif}, at_least=${var.dbload_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.dbload_threshold_major}, lasting=%{if var.dbload_lasting_duration_major == null}None%{else}'${var.dbload_lasting_duration_major}'%{endif}, at_least=${var.dbload_at_least_percentage_major}) and (not when(signal > ${var.dbload_threshold_critical}, lasting=%{if var.dbload_lasting_duration_critical == null}None%{else}'${var.dbload_lasting_duration_critical}'%{endif}, at_least=${var.dbload_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.dbload_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.dbload_disabled_critical, var.dbload_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.dbload_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.dbload_runbook_url, var.runbook_url), "")
    tip                   = var.dbload_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.dbload_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.dbload_disabled_major, var.dbload_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.dbload_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.dbload_runbook_url, var.runbook_url), "")
    tip                   = var.dbload_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.dbload_max_delay
}

