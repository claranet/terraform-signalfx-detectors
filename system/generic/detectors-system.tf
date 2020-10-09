resource "signalfx_detector" "heartbeat" {
  name      = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] System heartbeat"
  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('cpu.utilization', filter=(not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}')) and (not filter('gcp_status', '{Code=3, Name=STOPPING}', '{Code=4, Name=TERMINATED}')) and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stopped', 'PowerState/deallocating', 'PowerState/deallocated')) and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "cpu" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] System cpu utilization"

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
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.cpu_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_disabled_major, var.cpu_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "load" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] System load 5m ratio"

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
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.load_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.load_disabled_major, var.load_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.load_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "disk_space" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] System disk space utilization"

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
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.disk_space_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.disk_space_disabled_major, var.disk_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_space_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "disk_inodes" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] System disk inodes utilization"

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
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.disk_inodes_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.disk_inodes_disabled_major, var.disk_inodes_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_inodes_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "disk_running_out" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] System disk space running out"

  program_text = <<-EOF
    from signalfx.detectors.countdown import countdown
    signal = data('disk.utilization', filter=${module.filter-tags.filter_custom}).publish('signal')
    countdown.hours_left_stream_incr_detector(stream=signal, maximum_capacity=${var.disk_running_out_maximum_capacity}, lower_threshold=${var.disk_running_out_hours_till_full}, fire_lasting=lasting('${var.disk_running_out_fire_lasting_time}', ${var.disk_running_out_fire_lasting_time_percent}), clear_threshold=${var.disk_running_out_clear_hours_remaining}, clear_lasting=lasting('${var.disk_running_out_clear_lasting_time}', ${var.disk_running_out_clear_lasting_time_percent}), use_double_ewma=${var.disk_running_out_use_ewma}).publish('MAJOR')
EOF

  rule {
    description           = "in ${var.disk_running_out_hours_till_full}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.disk_running_out_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_running_out_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "memory" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] System memory utilization"

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
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.memory_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_disabled_major, var.memory_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

