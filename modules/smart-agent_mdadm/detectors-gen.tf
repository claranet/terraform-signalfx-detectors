resource "signalfx_detector" "disk_failed" {
  name = format("%s %s", local.detector_name_prefix, "Mdadm disk failed")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('md_disks.failed', filter=${module.filtering.signalflow})${var.disk_failed_aggregation_function}${var.disk_failed_transformation_function}.publish('signal')
    detect(when(signal > ${var.disk_failed_threshold_critical}%{ if var.disk_failed_lasting_duration_critical != "None" }, lasting='${var.disk_failed_lasting_duration_critical}', at_least=${var.disk_failed_at_least_percentage_critical}%{ endif })).publish('CRIT')
    detect(when(signal > ${var.disk_failed_threshold_major}%{ if var.disk_failed_lasting_duration_major != "None" }, lasting='${var.disk_failed_lasting_duration_major}', at_least=${var.disk_failed_at_least_percentage_major}%{ endif }) and not when(signal > ${var.disk_failed_threshold_critical}%{ if var.disk_failed_lasting_duration_critical != "None" }, lasting='${var.disk_failed_lasting_duration_critical}', at_least=${var.disk_failed_at_least_percentage_critical}%{ endif })).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.disk_failed_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.disk_failed_disabled_critical, var.disk_failed_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_failed_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.disk_failed_runbook_url, var.runbook_url), "")
    tip                   = var.disk_failed_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.disk_failed_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.disk_failed_disabled_major, var.disk_failed_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_failed_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.disk_failed_runbook_url, var.runbook_url), "")
    tip                   = var.disk_failed_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "disk_missing" {
  name = format("%s %s", local.detector_name_prefix, "Mdadm disk missing")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('md_disks.missing', filter=${module.filtering.signalflow})${var.disk_missing_aggregation_function}${var.disk_missing_transformation_function}.publish('signal')
    detect(when(signal > ${var.disk_missing_threshold_critical}%{ if var.disk_missing_lasting_duration_critical != "None" }, lasting='${var.disk_missing_lasting_duration_critical}', at_least=${var.disk_missing_at_least_percentage_critical}%{ endif })).publish('CRIT')
    detect(when(signal > ${var.disk_missing_threshold_major}%{ if var.disk_missing_lasting_duration_major != "None" }, lasting='${var.disk_missing_lasting_duration_major}', at_least=${var.disk_missing_at_least_percentage_major}%{ endif }) and not when(signal > ${var.disk_missing_threshold_critical}%{ if var.disk_missing_lasting_duration_critical != "None" }, lasting='${var.disk_missing_lasting_duration_critical}', at_least=${var.disk_missing_at_least_percentage_critical}%{ endif })).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.disk_missing_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.disk_missing_disabled_critical, var.disk_missing_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_missing_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.disk_missing_runbook_url, var.runbook_url), "")
    tip                   = var.disk_missing_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.disk_missing_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.disk_missing_disabled_major, var.disk_missing_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_missing_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.disk_missing_runbook_url, var.runbook_url), "")
    tip                   = var.disk_missing_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

