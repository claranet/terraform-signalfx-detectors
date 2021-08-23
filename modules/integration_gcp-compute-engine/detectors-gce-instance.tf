resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "GCP GCE Instance heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('instance/cpu/usage_time', filter=${local.not_running_vm_filters_gcp} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}', auto_resolve_after='${local.heartbeat_auto_resolve_after}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.heartbeat_runbook_url, var.runbook_url), "")
    tip                   = var.heartbeat_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject_novalue : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "cpu_utilization" {
  name = format("%s %s", local.detector_name_prefix, "GCP GCE Instance CPU utilization")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('instance/cpu/utilization', ${module.filtering.signalflow})${var.cpu_utilization_aggregation_function}${var.cpu_utilization_transformation_function}.scale(100).publish('signal')
    detect(when(signal > ${var.cpu_utilization_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_utilization_threshold_major}) and (not when(signal > ${var.cpu_utilization_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_utilization_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_utilization_disabled_critical, var.cpu_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_utilization_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.cpu_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cpu_utilization_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_utilization_disabled_major, var.cpu_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_utilization_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.cpu_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "disk_throttled_bps" {
  name = format("%s %s", local.detector_name_prefix, "GCP GCE Instance disk throttled bps")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('instance/disk/throttled_read_bytes_count', ${module.filtering.signalflow})${var.disk_throttled_bps_aggregation_function}${var.disk_throttled_bps_transformation_function}
    B = data('instance/disk/throttled_write_bytes_count', ${module.filtering.signalflow})${var.disk_throttled_bps_aggregation_function}${var.disk_throttled_bps_transformation_function}
    C = data('instance/disk/read_bytes_count', ${module.filtering.signalflow})${var.disk_throttled_bps_aggregation_function}${var.disk_throttled_bps_transformation_function}
    D = data('instance/disk/write_bytes_count', ${module.filtering.signalflow})${var.disk_throttled_bps_aggregation_function}${var.disk_throttled_bps_transformation_function}
    signal = ((A+B) / (C+D)).scale(100).publish('signal')
    detect(when(signal > ${var.disk_throttled_bps_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.disk_throttled_bps_threshold_major}) and (not when(signal > ${var.disk_throttled_bps_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.disk_throttled_bps_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.disk_throttled_bps_disabled_critical, var.disk_throttled_bps_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_throttled_bps_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.disk_throttled_bps_runbook_url, var.runbook_url), "")
    tip                   = var.disk_throttled_bps_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.disk_throttled_bps_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.disk_throttled_bps_disabled_major, var.disk_throttled_bps_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_throttled_bps_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.disk_throttled_bps_runbook_url, var.runbook_url), "")
    tip                   = var.disk_throttled_bps_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "disk_throttled_ops" {
  name = format("%s %s", local.detector_name_prefix, "GCP GCE Instance disk throttled ops")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('instance/disk/throttled_read_ops_count', ${module.filtering.signalflow})${var.disk_throttled_ops_aggregation_function}${var.disk_throttled_ops_transformation_function}
    B = data('instance/disk/throttled_write_ops_count', ${module.filtering.signalflow})${var.disk_throttled_ops_aggregation_function}${var.disk_throttled_ops_transformation_function}
    C = data('instance/disk/read_ops_count', ${module.filtering.signalflow})${var.disk_throttled_ops_aggregation_function}${var.disk_throttled_ops_transformation_function}
    D = data('instance/disk/write_ops_count', ${module.filtering.signalflow})${var.disk_throttled_ops_aggregation_function}${var.disk_throttled_ops_transformation_function}
    signal = ((A+B) / (C+D)).scale(100).publish('signal')
    detect(when(signal > ${var.disk_throttled_ops_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.disk_throttled_ops_threshold_major}) and (not when(signal > ${var.disk_throttled_ops_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.disk_throttled_ops_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.disk_throttled_ops_disabled_critical, var.disk_throttled_ops_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_throttled_ops_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.disk_throttled_ops_runbook_url, var.runbook_url), "")
    tip                   = var.disk_throttled_ops_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.disk_throttled_ops_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.disk_throttled_ops_disabled_major, var.disk_throttled_ops_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_throttled_ops_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.disk_throttled_ops_runbook_url, var.runbook_url), "")
    tip                   = var.disk_throttled_ops_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

