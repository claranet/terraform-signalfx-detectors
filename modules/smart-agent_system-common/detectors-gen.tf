resource "signalfx_detector" "heartbeat" {
  name      = format("%s %s", local.detector_name_prefix, "System heartbeat")
  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('cpu.utilization', filter=${local.not_running_vm_filters} and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    runbook_url           = var.heartbeat_runbook_url
    tip                   = var.heartbeat_tip
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "cpu" {
  name = format("%s %s", local.detector_name_prefix, "System cpu utilization")

  program_text = <<-EOF
    signal = data('cpu.utilization', filter=${module.filter-tags.filter_custom}, extrapolation='zero')${var.cpu_aggregation_function}${var.cpu_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_threshold_major}) and when(signal <= ${var.cpu_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_disabled_critical, var.cpu_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_notifications, "critical", []), var.notifications.critical)
    runbook_url           = var.cpu_runbook_url
    tip                   = var.cpu_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.cpu_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_disabled_major, var.cpu_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_notifications, "major", []), var.notifications.major)
    runbook_url           = var.cpu_runbook_url
    tip                   = var.cpu_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "load" {
  name = format("%s %s", local.detector_name_prefix, "System load 5m ratio")

  program_text = <<-EOF
    signal = data('load.midterm', filter=${module.filter-tags.filter_custom})${var.load_aggregation_function}${var.load_transformation_function}.publish('signal')
    detect(when(signal > ${var.load_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.load_threshold_major}) and when(signal <= ${var.load_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.load_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.load_disabled_critical, var.load_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.load_notifications, "critical", []), var.notifications.critical)
    runbook_url           = var.load_runbook_url
    tip                   = var.load_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.load_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.load_disabled_major, var.load_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.load_notifications, "major", []), var.notifications.major)
    runbook_url           = var.load_runbook_url
    tip                   = var.load_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "disk_space" {
  name = format("%s %s", local.detector_name_prefix, "System disk space utilization")

  program_text = <<-EOF
    signal = data('disk.utilization', filter=${module.filter-tags.filter_custom})${var.disk_space_aggregation_function}${var.disk_space_transformation_function}.publish('signal')
    detect(when(signal > ${var.disk_space_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.disk_space_threshold_major}) and when(signal <= ${var.disk_space_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.disk_space_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.disk_space_disabled_critical, var.disk_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_space_notifications, "critical", []), var.notifications.critical)
    runbook_url           = var.disk_space_runbook_url
    tip                   = var.disk_space_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.disk_space_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.disk_space_disabled_major, var.disk_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_space_notifications, "major", []), var.notifications.major)
    runbook_url           = var.disk_space_runbook_url
    tip                   = var.disk_space_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "disk_inodes" {
  name = format("%s %s", local.detector_name_prefix, "System disk inodes utilization")

  program_text = <<-EOF
    signal = data('percent_inodes.used', filter=${module.filter-tags.filter_custom})${var.disk_inodes_aggregation_function}${var.disk_inodes_transformation_function}.publish('signal')
    detect(when(signal > ${var.disk_inodes_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.disk_inodes_threshold_major}) and when(signal <= ${var.disk_inodes_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.disk_inodes_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.disk_inodes_disabled_critical, var.disk_inodes_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_inodes_notifications, "critical", []), var.notifications.critical)
    runbook_url           = var.disk_inodes_runbook_url
    tip                   = var.disk_inodes_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.disk_inodes_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.disk_inodes_disabled_major, var.disk_inodes_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_inodes_notifications, "major", []), var.notifications.major)
    runbook_url           = var.disk_inodes_runbook_url
    tip                   = var.disk_inodes_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "memory" {
  name = format("%s %s", local.detector_name_prefix, "System memory utilization")

  program_text = <<-EOF
    signal = data('memory.utilization', filter=${module.filter-tags.filter_custom})${var.memory_aggregation_function}${var.memory_transformation_function}.publish('signal')
    detect(when(signal > ${var.memory_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.memory_threshold_major}) and when(signal <= ${var.memory_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memory_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_disabled_critical, var.memory_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_notifications, "critical", []), var.notifications.critical)
    runbook_url           = var.memory_runbook_url
    tip                   = var.memory_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.memory_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_disabled_major, var.memory_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_notifications, "major", []), var.notifications.major)
    runbook_url           = var.memory_runbook_url
    tip                   = var.memory_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

