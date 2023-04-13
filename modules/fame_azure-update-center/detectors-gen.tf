resource "signalfx_detector" "failed_updates" {
  name = format("%s %s", local.detector_name_prefix, "Azure Update Center failed updates")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('fame.azure.update_center.updates_status', filter=filter('status', 'failed') and ${module.filtering.signalflow})${var.failed_updates_aggregation_function}${var.failed_updates_transformation_function}.publish('signal')
    detect(when(signal > ${var.failed_updates_threshold_major}, lasting=%{if var.failed_updates_lasting_duration_major == null}None%{else}'${var.failed_updates_lasting_duration_major}'%{endif}, at_least=${var.failed_updates_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.failed_updates_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.failed_updates_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.failed_updates_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.failed_updates_runbook_url, var.runbook_url), "")
    tip                   = var.failed_updates_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.failed_updates_max_delay
}

resource "signalfx_detector" "missing_updates" {
  name = format("%s %s", local.detector_name_prefix, "Azure Update Center missing updates")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('fame.azure.update_center.missing_updates', filter=filter('classification', 'security', 'critical') and ${module.filtering.signalflow})${var.missing_updates_aggregation_function}${var.missing_updates_transformation_function}.publish('signal')
    detect(when(signal > ${var.missing_updates_threshold_major}, lasting=%{if var.missing_updates_lasting_duration_major == null}None%{else}'${var.missing_updates_lasting_duration_major}'%{endif}, at_least=${var.missing_updates_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.missing_updates_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.missing_updates_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.missing_updates_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.missing_updates_runbook_url, var.runbook_url), "")
    tip                   = var.missing_updates_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.missing_updates_max_delay
}

