resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Zookeeper heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('plugin', 'zookeeper')
    signal = data('gauge.zk_max_file_descriptor_count', filter=%{if var.heartbeat_exclude_not_running_vm}${local.not_running_vm_filters} and %{endif}base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "zookeeper_health" {
  name = format("%s %s", local.detector_name_prefix, "Zookeeper service health")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'zookeeper')
    signal = data('gauge.zk_service_health', filter=base_filtering and ${module.filtering.signalflow})${var.zookeeper_health_aggregation_function}${var.zookeeper_health_transformation_function}.publish('signal')
    detect(when(signal != ${var.zookeeper_health_threshold_critical}%{if var.zookeeper_health_lasting_duration_critical != null}, lasting='${var.zookeeper_health_lasting_duration_critical}', at_least=${var.zookeeper_health_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is != ${var.zookeeper_health_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.zookeeper_health_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.zookeeper_health_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.zookeeper_health_runbook_url, var.runbook_url), "")
    tip                   = var.zookeeper_health_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.zookeeper_health_max_delay
}

resource "signalfx_detector" "zookeeper_latency" {
  name = format("%s %s", local.detector_name_prefix, "Zookeeper latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'zookeeper')
    signal = data('gauge.zk_avg_latency', filter=base_filtering and ${module.filtering.signalflow})${var.zookeeper_latency_aggregation_function}${var.zookeeper_latency_transformation_function}.publish('signal')
    detect(when(signal > ${var.zookeeper_latency_threshold_critical}%{if var.zookeeper_latency_lasting_duration_critical != null}, lasting='${var.zookeeper_latency_lasting_duration_critical}', at_least=${var.zookeeper_latency_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.zookeeper_latency_threshold_major}%{if var.zookeeper_latency_lasting_duration_major != null}, lasting='${var.zookeeper_latency_lasting_duration_major}', at_least=${var.zookeeper_latency_at_least_percentage_major}%{endif}) and (not when(signal > ${var.zookeeper_latency_threshold_critical}%{if var.zookeeper_latency_lasting_duration_critical != null}, lasting='${var.zookeeper_latency_lasting_duration_critical}', at_least=${var.zookeeper_latency_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.zookeeper_latency_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.zookeeper_latency_disabled_critical, var.zookeeper_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.zookeeper_latency_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.zookeeper_latency_runbook_url, var.runbook_url), "")
    tip                   = var.zookeeper_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.zookeeper_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.zookeeper_latency_disabled_major, var.zookeeper_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.zookeeper_latency_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.zookeeper_latency_runbook_url, var.runbook_url), "")
    tip                   = var.zookeeper_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.zookeeper_latency_max_delay
}

resource "signalfx_detector" "file_descriptors" {
  name = format("%s %s", local.detector_name_prefix, "Zookeeper file descriptors usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'zookeeper')
    A = data('gauge.zk_open_file_descriptor_count', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.file_descriptors_aggregation_function}${var.file_descriptors_transformation_function}
    B = data('gauge.zk_max_file_descriptor_count', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.file_descriptors_aggregation_function}${var.file_descriptors_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.file_descriptors_threshold_critical}%{if var.file_descriptors_lasting_duration_critical != null}, lasting='${var.file_descriptors_lasting_duration_critical}', at_least=${var.file_descriptors_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.file_descriptors_threshold_major}%{if var.file_descriptors_lasting_duration_major != null}, lasting='${var.file_descriptors_lasting_duration_major}', at_least=${var.file_descriptors_at_least_percentage_major}%{endif}) and (not when(signal > ${var.file_descriptors_threshold_critical}%{if var.file_descriptors_lasting_duration_critical != null}, lasting='${var.file_descriptors_lasting_duration_critical}', at_least=${var.file_descriptors_at_least_percentage_critical}%{endif}))).publish('MAJOR')
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

