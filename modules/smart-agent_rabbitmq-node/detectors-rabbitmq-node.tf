resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "RabbitMQ  heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('gauge.node.uptime', filter=${local.not_running_vm_filters} and filter('plugin', 'rabbitmq') and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "file_descriptors" {
  name = format("%s %s", local.detector_name_prefix, "RabbitMQ Node file descriptors usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('gauge.node.fd_used', filter=filter('plugin', 'rabbitmq') and ${module.filtering.signalflow})${var.file_descriptors_aggregation_function}${var.file_descriptors_transformation_function}
    B = data('gauge.node.fd_total', filter=filter('plugin', 'rabbitmq') and ${module.filtering.signalflow})${var.file_descriptors_aggregation_function}${var.file_descriptors_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.file_descriptors_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.file_descriptors_threshold_major}) and (not when(signal > ${var.file_descriptors_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.file_descriptors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.file_descriptors_disabled_critical, var.file_descriptors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.file_descriptors_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.file_descriptors_runbook_url, var.runbook_url), "")
    tip                   = var.file_descriptors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.file_descriptors_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.file_descriptors_disabled_major, var.file_descriptors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.file_descriptors_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.file_descriptors_runbook_url, var.runbook_url), "")
    tip                   = var.file_descriptors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.file_descriptors_max_delay
}

resource "signalfx_detector" "processes" {
  name = format("%s %s", local.detector_name_prefix, "RabbitMQ Node process usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('gauge.node.proc_used', filter=filter('plugin', 'rabbitmq') and ${module.filtering.signalflow})${var.processes_aggregation_function}${var.processes_transformation_function}
    B = data('gauge.node.proc_total', filter=filter('plugin', 'rabbitmq') and ${module.filtering.signalflow})${var.processes_aggregation_function}${var.processes_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.processes_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.processes_threshold_major}) and (not when(signal > ${var.processes_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.processes_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.processes_disabled_critical, var.processes_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.processes_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.processes_runbook_url, var.runbook_url), "")
    tip                   = var.processes_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.processes_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.processes_disabled_major, var.processes_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.processes_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.processes_runbook_url, var.runbook_url), "")
    tip                   = var.processes_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.processes_max_delay
}

resource "signalfx_detector" "sockets" {
  name = format("%s %s", local.detector_name_prefix, "RabbitMQ Node sockets usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('gauge.node.sockets_used', filter=filter('plugin', 'rabbitmq') and ${module.filtering.signalflow})${var.sockets_aggregation_function}${var.sockets_transformation_function}
    B = data('gauge.node.sockets_total', filter=filter('plugin', 'rabbitmq') and ${module.filtering.signalflow})${var.sockets_aggregation_function}${var.sockets_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.sockets_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.sockets_threshold_major}) and (not when(signal > ${var.sockets_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.sockets_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.sockets_disabled_critical, var.sockets_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.sockets_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.sockets_runbook_url, var.runbook_url), "")
    tip                   = var.sockets_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.sockets_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.sockets_disabled_major, var.sockets_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.sockets_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.sockets_runbook_url, var.runbook_url), "")
    tip                   = var.sockets_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.sockets_max_delay
}

resource "signalfx_detector" "vm_memory" {
  name = format("%s %s", local.detector_name_prefix, "RabbitMQ Node vm_memory usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('gauge.node.mem_used', filter=filter('plugin', 'rabbitmq') and ${module.filtering.signalflow})${var.vm_memory_aggregation_function}${var.vm_memory_transformation_function}
    B = data('gauge.node.mem_limit', filter=filter('plugin', 'rabbitmq') and ${module.filtering.signalflow})${var.vm_memory_aggregation_function}${var.vm_memory_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.vm_memory_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.vm_memory_threshold_major}) and (not when(signal > ${var.vm_memory_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is approaching the limit"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.vm_memory_disabled_critical, var.vm_memory_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.vm_memory_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.vm_memory_runbook_url, var.runbook_url), "")
    tip                   = var.vm_memory_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is approaching the limit"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.vm_memory_disabled_major, var.vm_memory_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.vm_memory_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.vm_memory_runbook_url, var.runbook_url), "")
    tip                   = var.vm_memory_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.vm_memory_max_delay
}

