resource "signalfx_detector" "volume_space" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes node volume space usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('kubernetes.volume_available_bytes', filter=${module.filtering.signalflow} and (not filter('volume_type', 'configMap', 'secret')) and filter('volume_type', '*'))${var.volume_space_aggregation_function}${var.volume_space_transformation_function}
    B = data('kubernetes.volume_capacity_bytes', filter=${module.filtering.signalflow} and (not filter('volume_type', 'configMap', 'secret')) and filter('volume_type', '*'))${var.volume_space_aggregation_function}${var.volume_space_transformation_function}
    signal = ((B-A)/B).scale(100).publish('signal')
    detect(when(signal > ${var.volume_space_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.volume_space_threshold_major}) and when(signal < ${var.volume_space_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.volume_space_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.volume_space_disabled_critical, var.volume_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.volume_space_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.volume_space_runbook_url, var.runbook_url), "")
    tip                   = var.volume_space_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.volume_space_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.volume_space_disabled_major, var.volume_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.volume_space_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.volume_space_runbook_url, var.runbook_url), "")
    tip                   = var.volume_space_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "volume_inodes" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes node volume inodes usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('kubernetes.volume_inodes_free', filter=${module.filtering.signalflow} and (not filter('volume_type', 'configMap', 'secret')) and filter('volume_type', '*'))${var.volume_inodes_aggregation_function}${var.volume_inodes_transformation_function}
    B = data('kubernetes.volume_inodes', filter=${module.filtering.signalflow} and (not filter('volume_type', 'configMap', 'secret')) and filter('volume_type', '*'))${var.volume_inodes_aggregation_function}${var.volume_inodes_transformation_function}
    signal = ((B-A)/B).scale(100).publish('signal')
    detect(when(signal > ${var.volume_inodes_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.volume_inodes_threshold_major}) and when(signal < ${var.volume_inodes_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.volume_inodes_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.volume_inodes_disabled_critical, var.volume_inodes_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.volume_inodes_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.volume_inodes_runbook_url, var.runbook_url), "")
    tip                   = var.volume_inodes_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.volume_inodes_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.volume_inodes_disabled_major, var.volume_inodes_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.volume_inodes_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.volume_inodes_runbook_url, var.runbook_url), "")
    tip                   = var.volume_inodes_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

