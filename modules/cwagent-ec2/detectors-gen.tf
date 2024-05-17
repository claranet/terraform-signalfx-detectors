resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS CWAgent heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('mem_used_percent', filter=%{ if var.heartbeat_exclude_not_running_vm }${local.not_running_vm_filters} and %{ endif }${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "mem" {
  name = format("%s %s", local.detector_name_prefix, "AWS CWAgent memory used")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    signal = data('mem_used_percent', filter=${module.filtering.signalflow}, extrapolation='zero')${var.mem_aggregation_function}${var.mem_transformation_function}.publish('signal')
    detect(when(signal > ${var.mem_threshold_critical}%{if var.mem_lasting_duration_critical != null}, lasting='${var.mem_lasting_duration_critical}', at_least=${var.mem_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.mem_threshold_major}%{if var.mem_lasting_duration_major != null}, lasting='${var.mem_lasting_duration_major}', at_least=${var.mem_at_least_percentage_major}%{endif}) and (not when(signal > ${var.mem_threshold_critical}%{if var.mem_lasting_duration_critical != null}, lasting='${var.mem_lasting_duration_critical}', at_least=${var.mem_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.mem_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.mem_disabled_critical, var.mem_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.mem_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.mem_runbook_url, var.runbook_url), "")
    tip                   = var.mem_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.mem_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.mem_disabled_major, var.mem_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.mem_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.mem_runbook_url, var.runbook_url), "")
    tip                   = var.mem_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.mem_max_delay
}

resource "signalfx_detector" "disk" {
  name = format("%s %s", local.detector_name_prefix, "AWS CWAgent disk used")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    signal = data('disk_used_percent', filter=${module.filtering.signalflow}, extrapolation='zero')${var.disk_aggregation_function}${var.disk_transformation_function}.publish('signal')
    detect(when(signal > ${var.disk_threshold_critical}%{if var.disk_lasting_duration_critical != null}, lasting='${var.disk_lasting_duration_critical}', at_least=${var.disk_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.disk_threshold_major}%{if var.disk_lasting_duration_major != null}, lasting='${var.disk_lasting_duration_major}', at_least=${var.disk_at_least_percentage_major}%{endif}) and (not when(signal > ${var.disk_threshold_critical}%{if var.disk_lasting_duration_critical != null}, lasting='${var.disk_lasting_duration_critical}', at_least=${var.disk_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.disk_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.disk_disabled_critical, var.disk_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.disk_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.disk_runbook_url, var.runbook_url), "")
    tip                   = var.disk_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.disk_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.disk_disabled_major, var.disk_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.disk_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.disk_runbook_url, var.runbook_url), "")
    tip                   = var.disk_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.disk_max_delay
}

resource "signalfx_detector" "cpu" {
  name = format("%s %s", local.detector_name_prefix, "AWS CWAgent cpu usage active")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    signal = data('cpu_usage_active', filter=${module.filtering.signalflow}, extrapolation='zero')${var.cpu_aggregation_function}${var.cpu_transformation_function}.publish('signal')
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

