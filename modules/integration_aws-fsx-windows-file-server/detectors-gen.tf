resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS FSx for Windows File Server heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('MetadataOperations', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "free_space" {
  name = format("%s %s", local.detector_name_prefix, "AWS FSx for Windows File Server free space")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Gibibyte"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/FSx')
    free_space = data('FreeStorageCapacity', filter=base_filtering and filter('stat', 'mean') and ${module.filtering.signalflow})${var.free_space_aggregation_function}${var.free_space_transformation_function}
    signal = free_space.scale(1/1024**3).publish('signal')
    detect(when(signal < ${var.free_space_threshold_critical}, lasting=%{if var.free_space_lasting_duration_critical == null}None%{else}'${var.free_space_lasting_duration_critical}'%{endif}, at_least=${var.free_space_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal < ${var.free_space_threshold_major}, lasting=%{if var.free_space_lasting_duration_major == null}None%{else}'${var.free_space_lasting_duration_major}'%{endif}, at_least=${var.free_space_at_least_percentage_major}) and (not when(signal < ${var.free_space_threshold_critical}, lasting=%{if var.free_space_lasting_duration_critical == null}None%{else}'${var.free_space_lasting_duration_critical}'%{endif}, at_least=${var.free_space_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.free_space_threshold_critical}Gibibyte"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.free_space_disabled_critical, var.free_space_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.free_space_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.free_space_runbook_url, var.runbook_url), "")
    tip                   = var.free_space_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.free_space_threshold_major}Gibibyte"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.free_space_disabled_major, var.free_space_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.free_space_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.free_space_runbook_url, var.runbook_url), "")
    tip                   = var.free_space_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.free_space_max_delay
}

resource "signalfx_detector" "cpu_utilization" {
  name = format("%s %s", local.detector_name_prefix, "AWS FSx for Windows File Server cpu utilization")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/FSx')
    signal = data('CPUUtilization', filter=base_filtering and filter('stat', 'mean') and ${module.filtering.signalflow})${var.cpu_utilization_aggregation_function}${var.cpu_utilization_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_utilization_threshold_major}, lasting=%{if var.cpu_utilization_lasting_duration_major == null}None%{else}'${var.cpu_utilization_lasting_duration_major}'%{endif}, at_least=${var.cpu_utilization_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.cpu_utilization_threshold_critical}, lasting=%{if var.cpu_utilization_lasting_duration_critical == null}None%{else}'${var.cpu_utilization_lasting_duration_critical}'%{endif}, at_least=${var.cpu_utilization_at_least_percentage_critical}) and (not when(signal > ${var.cpu_utilization_threshold_major}, lasting=%{if var.cpu_utilization_lasting_duration_major == null}None%{else}'${var.cpu_utilization_lasting_duration_major}'%{endif}, at_least=${var.cpu_utilization_at_least_percentage_major}))).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.cpu_utilization_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_utilization_disabled_major, var.cpu_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_utilization_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cpu_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cpu_utilization_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_utilization_disabled_critical, var.cpu_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_utilization_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cpu_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cpu_utilization_max_delay
}

resource "signalfx_detector" "memory_utilization" {
  name = format("%s %s", local.detector_name_prefix, "AWS FSx for Windows File Server memory utilization")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/FSx')
    signal = data('MemoryUtilization', filter=base_filtering and filter('stat', 'mean') and ${module.filtering.signalflow})${var.memory_utilization_aggregation_function}${var.memory_utilization_transformation_function}.publish('signal')
    detect(when(signal > ${var.memory_utilization_threshold_major}, lasting=%{if var.memory_utilization_lasting_duration_major == null}None%{else}'${var.memory_utilization_lasting_duration_major}'%{endif}, at_least=${var.memory_utilization_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.memory_utilization_threshold_critical}, lasting=%{if var.memory_utilization_lasting_duration_critical == null}None%{else}'${var.memory_utilization_lasting_duration_critical}'%{endif}, at_least=${var.memory_utilization_at_least_percentage_critical}) and (not when(signal > ${var.memory_utilization_threshold_major}, lasting=%{if var.memory_utilization_lasting_duration_major == null}None%{else}'${var.memory_utilization_lasting_duration_major}'%{endif}, at_least=${var.memory_utilization_at_least_percentage_major}))).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.memory_utilization_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_utilization_disabled_major, var.memory_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_utilization_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.memory_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.memory_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.memory_utilization_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_utilization_disabled_critical, var.memory_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_utilization_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.memory_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.memory_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memory_utilization_max_delay
}

resource "signalfx_detector" "network_throughput_utilization" {
  name = format("%s %s", local.detector_name_prefix, "AWS FSx for Windows File Server network throughput utilization")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/FSx')
    signal = data('NetworkThroughputUtilization', filter=base_filtering and filter('stat', 'mean') and ${module.filtering.signalflow})${var.network_throughput_utilization_aggregation_function}${var.network_throughput_utilization_transformation_function}.publish('signal')
    detect(when(signal > ${var.network_throughput_utilization_threshold_major}, lasting=%{if var.network_throughput_utilization_lasting_duration_major == null}None%{else}'${var.network_throughput_utilization_lasting_duration_major}'%{endif}, at_least=${var.network_throughput_utilization_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.network_throughput_utilization_threshold_critical}, lasting=%{if var.network_throughput_utilization_lasting_duration_critical == null}None%{else}'${var.network_throughput_utilization_lasting_duration_critical}'%{endif}, at_least=${var.network_throughput_utilization_at_least_percentage_critical}) and (not when(signal > ${var.network_throughput_utilization_threshold_major}, lasting=%{if var.network_throughput_utilization_lasting_duration_major == null}None%{else}'${var.network_throughput_utilization_lasting_duration_major}'%{endif}, at_least=${var.network_throughput_utilization_at_least_percentage_major}))).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.network_throughput_utilization_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.network_throughput_utilization_disabled_major, var.network_throughput_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.network_throughput_utilization_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.network_throughput_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.network_throughput_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.network_throughput_utilization_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.network_throughput_utilization_disabled_critical, var.network_throughput_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.network_throughput_utilization_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.network_throughput_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.network_throughput_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.network_throughput_utilization_max_delay
}

resource "signalfx_detector" "file_server_disk_throughput_utilization" {
  name = format("%s %s", local.detector_name_prefix, "AWS FSx for Windows File Server file server disk throughput utilization")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/FSx')
    signal = data('FileServerDiskThroughputUtilization', filter=base_filtering and filter('stat', 'mean') and ${module.filtering.signalflow})${var.file_server_disk_throughput_utilization_aggregation_function}${var.file_server_disk_throughput_utilization_transformation_function}.publish('signal')
    detect(when(signal > ${var.file_server_disk_throughput_utilization_threshold_major}, lasting=%{if var.file_server_disk_throughput_utilization_lasting_duration_major == null}None%{else}'${var.file_server_disk_throughput_utilization_lasting_duration_major}'%{endif}, at_least=${var.file_server_disk_throughput_utilization_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.file_server_disk_throughput_utilization_threshold_critical}, lasting=%{if var.file_server_disk_throughput_utilization_lasting_duration_critical == null}None%{else}'${var.file_server_disk_throughput_utilization_lasting_duration_critical}'%{endif}, at_least=${var.file_server_disk_throughput_utilization_at_least_percentage_critical}) and (not when(signal > ${var.file_server_disk_throughput_utilization_threshold_major}, lasting=%{if var.file_server_disk_throughput_utilization_lasting_duration_major == null}None%{else}'${var.file_server_disk_throughput_utilization_lasting_duration_major}'%{endif}, at_least=${var.file_server_disk_throughput_utilization_at_least_percentage_major}))).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.file_server_disk_throughput_utilization_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.file_server_disk_throughput_utilization_disabled_major, var.file_server_disk_throughput_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.file_server_disk_throughput_utilization_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.file_server_disk_throughput_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.file_server_disk_throughput_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.file_server_disk_throughput_utilization_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.file_server_disk_throughput_utilization_disabled_critical, var.file_server_disk_throughput_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.file_server_disk_throughput_utilization_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.file_server_disk_throughput_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.file_server_disk_throughput_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.file_server_disk_throughput_utilization_max_delay
}

resource "signalfx_detector" "storage_capacity_utilization" {
  name = format("%s %s", local.detector_name_prefix, "AWS FSx for Windows File Server storage capacity utilization")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/FSx')
    signal = data('StorageCapacityUtilization', filter=base_filtering and filter('stat', 'mean') and ${module.filtering.signalflow})${var.storage_capacity_utilization_aggregation_function}${var.storage_capacity_utilization_transformation_function}.publish('signal')
    detect(when(signal > ${var.storage_capacity_utilization_threshold_major}, lasting=%{if var.storage_capacity_utilization_lasting_duration_major == null}None%{else}'${var.storage_capacity_utilization_lasting_duration_major}'%{endif}, at_least=${var.storage_capacity_utilization_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.storage_capacity_utilization_threshold_critical}, lasting=%{if var.storage_capacity_utilization_lasting_duration_critical == null}None%{else}'${var.storage_capacity_utilization_lasting_duration_critical}'%{endif}, at_least=${var.storage_capacity_utilization_at_least_percentage_critical}) and (not when(signal > ${var.storage_capacity_utilization_threshold_major}, lasting=%{if var.storage_capacity_utilization_lasting_duration_major == null}None%{else}'${var.storage_capacity_utilization_lasting_duration_major}'%{endif}, at_least=${var.storage_capacity_utilization_at_least_percentage_major}))).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.storage_capacity_utilization_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.storage_capacity_utilization_disabled_major, var.storage_capacity_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.storage_capacity_utilization_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.storage_capacity_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.storage_capacity_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.storage_capacity_utilization_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.storage_capacity_utilization_disabled_critical, var.storage_capacity_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.storage_capacity_utilization_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.storage_capacity_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.storage_capacity_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.storage_capacity_utilization_max_delay
}

