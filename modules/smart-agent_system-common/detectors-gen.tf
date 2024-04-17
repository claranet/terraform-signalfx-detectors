resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "System heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('cpu.utilization', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}', auto_resolve_after='${local.heartbeat_auto_resolve_after}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.heartbeat_runbook_url, var.runbook_url), "")
    tip                   = var.heartbeat_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject_novalue : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.heartbeat_max_delay
}

resource "signalfx_detector" "cpu" {
  name = format("%s %s", local.detector_name_prefix, "System cpu utilization")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    signal = data('cpu.utilization', filter=${module.filtering.signalflow}, extrapolation='zero')${var.cpu_aggregation_function}${var.cpu_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_threshold_critical}%{if var.cpu_lasting_duration_critical != null}, lasting='${var.cpu_lasting_duration_critical}', at_least=${var.cpu_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.cpu_threshold_major}%{if var.cpu_lasting_duration_major != null}, lasting='${var.cpu_lasting_duration_major}', at_least=${var.cpu_at_least_percentage_major}%{endif}) and (not when(signal > ${var.cpu_threshold_critical}%{if var.cpu_lasting_duration_critical != null}, lasting='${var.cpu_lasting_duration_critical}', at_least=${var.cpu_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_disabled_critical, var.cpu_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cpu_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cpu_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_disabled_major, var.cpu_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cpu_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cpu_max_delay
}

resource "signalfx_detector" "load" {
  name = format("%s %s", local.detector_name_prefix, "System load 5m ratio")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    load = data('load.midterm', filter=${module.filtering.signalflow})${var.load_aggregation_function}${var.load_transformation_function}
    num_processors = data('cpu.num_processors', filter=${module.filtering.signalflow})${var.load_aggregation_function}${var.load_transformation_function}
    signal = (${var.agent_per_cpu_enabled ? "load" : "load/num_processors"}).publish('signal')
    detect(when(signal > ${var.load_threshold_critical}%{if var.load_lasting_duration_critical != null}, lasting='${var.load_lasting_duration_critical}', at_least=${var.load_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.load_threshold_major}%{if var.load_lasting_duration_major != null}, lasting='${var.load_lasting_duration_major}', at_least=${var.load_at_least_percentage_major}%{endif}) and (not when(signal > ${var.load_threshold_critical}%{if var.load_lasting_duration_critical != null}, lasting='${var.load_lasting_duration_critical}', at_least=${var.load_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.load_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.load_disabled_critical, var.load_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.load_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.load_runbook_url, var.runbook_url), "")
    tip                   = var.load_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.load_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.load_disabled_major, var.load_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.load_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.load_runbook_url, var.runbook_url), "")
    tip                   = var.load_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.load_max_delay
}

resource "signalfx_detector" "disk_space" {
  name = format("%s %s", local.detector_name_prefix, "System disk space utilization")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    signal = data('disk.utilization', filter=(not filter('fs_type', 'squashfs') and not filter('type', 'squashfs')) and ${module.filtering.signalflow})${var.disk_space_aggregation_function}${var.disk_space_transformation_function}.publish('signal')
    detect(when(signal > ${var.disk_space_threshold_critical}%{if var.disk_space_lasting_duration_critical != null}, lasting='${var.disk_space_lasting_duration_critical}', at_least=${var.disk_space_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.disk_space_threshold_major}%{if var.disk_space_lasting_duration_major != null}, lasting='${var.disk_space_lasting_duration_major}', at_least=${var.disk_space_at_least_percentage_major}%{endif}) and (not when(signal > ${var.disk_space_threshold_critical}%{if var.disk_space_lasting_duration_critical != null}, lasting='${var.disk_space_lasting_duration_critical}', at_least=${var.disk_space_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.disk_space_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.disk_space_disabled_critical, var.disk_space_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.disk_space_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.disk_space_runbook_url, var.runbook_url), "")
    tip                   = var.disk_space_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.disk_space_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.disk_space_disabled_major, var.disk_space_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.disk_space_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.disk_space_runbook_url, var.runbook_url), "")
    tip                   = var.disk_space_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.disk_space_max_delay
}

resource "signalfx_detector" "filesystem_inodes" {
  name = format("%s %s", local.detector_name_prefix, "System filesystem inodes utilization")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    used = data('system.filesystem.inodes.usage', filter=filter('state', 'used') and ${module.filtering.signalflow})${var.filesystem_inodes_aggregation_function}${var.filesystem_inodes_transformation_function}
    free = data('system.filesystem.inodes.usage', filter=filter('state', 'free') and ${module.filtering.signalflow})${var.filesystem_inodes_aggregation_function}${var.filesystem_inodes_transformation_function}
    signal = (used / (used + free) * 100).publish('signal')
    detect(when(signal > ${var.filesystem_inodes_threshold_critical}%{if var.filesystem_inodes_lasting_duration_critical != null}, lasting='${var.filesystem_inodes_lasting_duration_critical}', at_least=${var.filesystem_inodes_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.filesystem_inodes_threshold_major}%{if var.filesystem_inodes_lasting_duration_major != null}, lasting='${var.filesystem_inodes_lasting_duration_major}', at_least=${var.filesystem_inodes_at_least_percentage_major}%{endif}) and (not when(signal > ${var.filesystem_inodes_threshold_critical}%{if var.filesystem_inodes_lasting_duration_critical != null}, lasting='${var.filesystem_inodes_lasting_duration_critical}', at_least=${var.filesystem_inodes_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.filesystem_inodes_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.filesystem_inodes_disabled_critical, var.filesystem_inodes_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.filesystem_inodes_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.filesystem_inodes_runbook_url, var.runbook_url), "")
    tip                   = var.filesystem_inodes_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.filesystem_inodes_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.filesystem_inodes_disabled_major, var.filesystem_inodes_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.filesystem_inodes_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.filesystem_inodes_runbook_url, var.runbook_url), "")
    tip                   = var.filesystem_inodes_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.filesystem_inodes_max_delay
}

resource "signalfx_detector" "disk_inodes" {
  name = format("%s %s", local.detector_name_prefix, "System disk inodes utilization")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    signal = data('percent_inodes.used', filter=and not filter('fs_type', 'squashfs')) and ${module.filtering.signalflow})${var.disk_inodes_aggregation_function}${var.disk_inodes_transformation_function}.publish('signal')
    detect(when(signal > ${var.disk_inodes_threshold_critical}%{if var.disk_inodes_lasting_duration_critical != null}, lasting='${var.disk_inodes_lasting_duration_critical}', at_least=${var.disk_inodes_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.disk_inodes_threshold_major}%{if var.disk_inodes_lasting_duration_major != null}, lasting='${var.disk_inodes_lasting_duration_major}', at_least=${var.disk_inodes_at_least_percentage_major}%{endif}) and (not when(signal > ${var.disk_inodes_threshold_critical}%{if var.disk_inodes_lasting_duration_critical != null}, lasting='${var.disk_inodes_lasting_duration_critical}', at_least=${var.disk_inodes_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.disk_inodes_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.disk_inodes_disabled_critical, var.disk_inodes_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.disk_inodes_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.disk_inodes_runbook_url, var.runbook_url), "")
    tip                   = var.disk_inodes_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.disk_inodes_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.disk_inodes_disabled_major, var.disk_inodes_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.disk_inodes_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.disk_inodes_runbook_url, var.runbook_url), "")
    tip                   = var.disk_inodes_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.disk_inodes_max_delay
}

resource "signalfx_detector" "memory" {
  name = format("%s %s", local.detector_name_prefix, "System memory utilization")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    signal = data('memory.utilization', filter=${module.filtering.signalflow})${var.memory_aggregation_function}${var.memory_transformation_function}.publish('signal')
    detect(when(signal > ${var.memory_threshold_critical}%{if var.memory_lasting_duration_critical != null}, lasting='${var.memory_lasting_duration_critical}', at_least=${var.memory_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.memory_threshold_major}%{if var.memory_lasting_duration_major != null}, lasting='${var.memory_lasting_duration_major}', at_least=${var.memory_at_least_percentage_major}%{endif}) and (not when(signal > ${var.memory_threshold_critical}%{if var.memory_lasting_duration_critical != null}, lasting='${var.memory_lasting_duration_critical}', at_least=${var.memory_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memory_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_disabled_critical, var.memory_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.memory_runbook_url, var.runbook_url), "")
    tip                   = var.memory_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.memory_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_disabled_major, var.memory_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.memory_runbook_url, var.runbook_url), "")
    tip                   = var.memory_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memory_max_delay
}

resource "signalfx_detector" "swap_io" {
  name = format("%s %s", local.detector_name_prefix, "System swap in/out")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "iops"
  }

  program_text = <<-EOF
    A = data('vmpage_io.swap.in', filter=${module.filtering.signalflow}, rollup='rate')${var.swap_io_aggregation_function}${var.swap_io_transformation_function}
    B = data('vmpage_io.swap.out', filter=${module.filtering.signalflow}, rollup='rate')${var.swap_io_aggregation_function}${var.swap_io_transformation_function}
    signal = (A+B).publish('signal')
    detect(when(signal > ${var.swap_io_threshold_critical}%{if var.swap_io_lasting_duration_critical != null}, lasting='${var.swap_io_lasting_duration_critical}', at_least=${var.swap_io_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.swap_io_threshold_major}%{if var.swap_io_lasting_duration_major != null}, lasting='${var.swap_io_lasting_duration_major}', at_least=${var.swap_io_at_least_percentage_major}%{endif}) and (not when(signal > ${var.swap_io_threshold_critical}%{if var.swap_io_lasting_duration_critical != null}, lasting='${var.swap_io_lasting_duration_critical}', at_least=${var.swap_io_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.swap_io_threshold_critical}iops"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.swap_io_disabled_critical, var.swap_io_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.swap_io_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.swap_io_runbook_url, var.runbook_url), "")
    tip                   = var.swap_io_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.swap_io_threshold_major}iops"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.swap_io_disabled_major, var.swap_io_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.swap_io_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.swap_io_runbook_url, var.runbook_url), "")
    tip                   = var.swap_io_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.swap_io_max_delay
}

