resource "signalfx_detector" "volume_space" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes node volume space usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = (((not filter('volume_type', 'configMap', 'secret')) and filter('volume_type', '*')) or ((not filter('k8s.volume.type', 'configMap', 'secret')) and filter('k8s.volume.type', '*')))
    A = data('kubernetes.volume_available_bytes', filter=base_filtering and ${module.filtering.signalflow})${var.volume_space_aggregation_function}${var.volume_space_transformation_function}
    B = data('kubernetes.volume_capacity_bytes', filter=base_filtering and ${module.filtering.signalflow})${var.volume_space_aggregation_function}${var.volume_space_transformation_function}
    signal = ((B-A)/B).scale(100).publish('signal')
    detect(when(signal > ${var.volume_space_threshold_critical}%{if var.volume_space_lasting_duration_critical != null}, lasting='${var.volume_space_lasting_duration_critical}', at_least=${var.volume_space_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.volume_space_threshold_major}%{if var.volume_space_lasting_duration_major != null}, lasting='${var.volume_space_lasting_duration_major}', at_least=${var.volume_space_at_least_percentage_major}%{endif}) and (not when(signal > ${var.volume_space_threshold_critical}%{if var.volume_space_lasting_duration_critical != null}, lasting='${var.volume_space_lasting_duration_critical}', at_least=${var.volume_space_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.volume_space_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.volume_space_disabled_critical, var.volume_space_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.volume_space_notifications, "critical", []), var.notifications.critical), null)
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
    notifications         = try(coalescelist(lookup(var.volume_space_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.volume_space_runbook_url, var.runbook_url), "")
    tip                   = var.volume_space_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.volume_space_max_delay
}

resource "signalfx_detector" "volume_inodes" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes node volume inodes usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = (((not filter('volume_type', 'configMap', 'secret')) and filter('volume_type', '*')) or ((not filter('k8s.volume.type', 'configMap', 'secret')) and filter('k8s.volume.type', '*')))
    A = data('kubernetes.volume_inodes_free', filter=base_filtering and ${module.filtering.signalflow})${var.volume_inodes_aggregation_function}${var.volume_inodes_transformation_function}
    B = data('kubernetes.volume_inodes', filter=base_filtering and ${module.filtering.signalflow})${var.volume_inodes_aggregation_function}${var.volume_inodes_transformation_function}
    signal = ((B-A)/B).scale(100).publish('signal')
    detect(when(signal > ${var.volume_inodes_threshold_critical}%{if var.volume_inodes_lasting_duration_critical != null}, lasting='${var.volume_inodes_lasting_duration_critical}', at_least=${var.volume_inodes_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.volume_inodes_threshold_major}%{if var.volume_inodes_lasting_duration_major != null}, lasting='${var.volume_inodes_lasting_duration_major}', at_least=${var.volume_inodes_at_least_percentage_major}%{endif}) and (not when(signal > ${var.volume_inodes_threshold_critical}%{if var.volume_inodes_lasting_duration_critical != null}, lasting='${var.volume_inodes_lasting_duration_critical}', at_least=${var.volume_inodes_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.volume_inodes_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.volume_inodes_disabled_critical, var.volume_inodes_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.volume_inodes_notifications, "critical", []), var.notifications.critical), null)
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
    notifications         = try(coalescelist(lookup(var.volume_inodes_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.volume_inodes_runbook_url, var.runbook_url), "")
    tip                   = var.volume_inodes_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.volume_inodes_max_delay
}

