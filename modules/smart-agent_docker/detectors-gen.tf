resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Docker heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('plugin', 'docker')
    signal = data('cpu.usage.system', filter=${local.not_running_vm_filters} and base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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
  name = format("%s %s", local.detector_name_prefix, "Docker container usage of cpu host")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'docker')
    signal = data('cpu.percent', filter=base_filtering and ${module.filtering.signalflow})${var.cpu_aggregation_function}${var.cpu_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_threshold_major}%{if var.cpu_lasting_duration_major != null}, lasting='${var.cpu_lasting_duration_major}', at_least=${var.cpu_at_least_percentage_major}%{endif})).publish('MAJOR')
    detect(when(signal > ${var.cpu_threshold_minor}%{if var.cpu_lasting_duration_minor != null}, lasting='${var.cpu_lasting_duration_minor}', at_least=${var.cpu_at_least_percentage_minor}%{endif}) and (not when(signal > ${var.cpu_threshold_major}%{if var.cpu_lasting_duration_major != null}, lasting='${var.cpu_lasting_duration_major}', at_least=${var.cpu_at_least_percentage_major}%{endif}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_disabled_major, var.cpu_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cpu_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cpu_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.cpu_disabled_minor, var.cpu_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.cpu_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cpu_max_delay
}

resource "signalfx_detector" "throttling" {
  name = format("%s %s", local.detector_name_prefix, "Docker container cpu throttling time")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'docker')
    A = data('cpu.throttling_data.throttled_time', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta')${var.throttling_aggregation_function}${var.throttling_transformation_function}
    B = data('cpu.throttling_data.throttled_time', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta')${var.throttling_aggregation_function}${var.throttling_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.throttling_threshold_major}%{if var.throttling_lasting_duration_major != null}, lasting='${var.throttling_lasting_duration_major}', at_least=${var.throttling_at_least_percentage_major}%{endif})).publish('MAJOR')
    detect(when(signal > ${var.throttling_threshold_minor}%{if var.throttling_lasting_duration_minor != null}, lasting='${var.throttling_lasting_duration_minor}', at_least=${var.throttling_at_least_percentage_minor}%{endif}) and (not when(signal > ${var.throttling_threshold_major}%{if var.throttling_lasting_duration_major != null}, lasting='${var.throttling_lasting_duration_major}', at_least=${var.throttling_at_least_percentage_major}%{endif}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.throttling_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.throttling_disabled_major, var.throttling_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.throttling_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.throttling_runbook_url, var.runbook_url), "")
    tip                   = var.throttling_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.throttling_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.throttling_disabled_minor, var.throttling_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.throttling_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.throttling_runbook_url, var.runbook_url), "")
    tip                   = var.throttling_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.throttling_max_delay
}

resource "signalfx_detector" "memory" {
  name = format("%s %s", local.detector_name_prefix, "Docker memory usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'docker')
    A = data('memory.usage.total', filter=base_filtering and ${module.filtering.signalflow})${var.memory_aggregation_function}${var.memory_transformation_function}
    B = data('memory.usage.limit', filter=base_filtering and ${module.filtering.signalflow})${var.memory_aggregation_function}${var.memory_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.memory_threshold_major}%{if var.memory_lasting_duration_major != null}, lasting='${var.memory_lasting_duration_major}', at_least=${var.memory_at_least_percentage_major}%{endif})).publish('MAJOR')
    detect(when(signal > ${var.memory_threshold_minor}%{if var.memory_lasting_duration_minor != null}, lasting='${var.memory_lasting_duration_minor}', at_least=${var.memory_at_least_percentage_minor}%{endif}) and (not when(signal > ${var.memory_threshold_major}%{if var.memory_lasting_duration_major != null}, lasting='${var.memory_lasting_duration_major}', at_least=${var.memory_at_least_percentage_major}%{endif}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.memory_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_disabled_major, var.memory_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.memory_runbook_url, var.runbook_url), "")
    tip                   = var.memory_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.memory_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.memory_disabled_minor, var.memory_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.memory_runbook_url, var.runbook_url), "")
    tip                   = var.memory_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memory_max_delay
}

