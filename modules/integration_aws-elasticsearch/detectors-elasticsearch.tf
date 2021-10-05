resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElasticSearch heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('Nodes', filter=filter('namespace', 'AWS/ES') and filter('stat', 'mean') and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "cluster_status" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElasticSearch cluster status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('ClusterStatus.red', filter=filter('namespace', 'AWS/ES') and filter('stat', 'upper') and ${module.filtering.signalflow})${var.cluster_status_aggregation_function}${var.cluster_status_transformation_function}.publish('A')
    B = data('ClusterStatus.yellow', filter=filter('namespace', 'AWS/ES') and filter('stat', 'upper') and ${module.filtering.signalflow})${var.cluster_status_aggregation_function}${var.cluster_status_transformation_function}.publish('B')
    detect(when(A >= 1)).publish('CRIT')
    detect(when(B >= 1)).publish('MAJOR')
EOF

  rule {
    description           = "is red"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cluster_status_disabled_critical, var.cluster_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cluster_status_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.cluster_status_runbook_url, var.runbook_url), "")
    tip                   = var.cluster_status_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject_novalue : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is yellow"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cluster_status_disabled_major, var.cluster_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cluster_status_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.cluster_status_runbook_url, var.runbook_url), "")
    tip                   = var.cluster_status_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject_novalue : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "free_space" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElasticSearch cluster free storage space")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('FreeStorageSpace', filter=filter('namespace', 'AWS/ES') and filter('stat', 'lower') and filter('NodeId', '*') and ${module.filtering.signalflow})${var.free_space_aggregation_function}${var.free_space_transformation_function}.publish('signal')
    detect(when(signal < ${var.free_space_threshold_critical})).publish('CRIT')
    detect(when(signal < ${var.free_space_threshold_major}) and (not when(signal < ${var.free_space_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.free_space_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.free_space_disabled_critical, var.free_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.free_space_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.free_space_runbook_url, var.runbook_url), "")
    tip                   = var.free_space_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.free_space_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.free_space_disabled_major, var.free_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.free_space_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.free_space_runbook_url, var.runbook_url), "")
    tip                   = var.free_space_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "cpu_90_15min" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElasticSearch cluster CPU")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('CPUUtilization', filter=filter('namespace', 'AWS/ES') and filter('stat', 'upper') and filter('NodeId', '*') and ${module.filtering.signalflow})${var.cpu_90_15min_aggregation_function}${var.cpu_90_15min_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_90_15min_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_90_15min_threshold_major}) and (not when(signal > ${var.cpu_90_15min_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_90_15min_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_90_15min_disabled_critical, var.cpu_90_15min_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_90_15min_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.cpu_90_15min_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_90_15min_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cpu_90_15min_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_90_15min_disabled_major, var.cpu_90_15min_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_90_15min_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.cpu_90_15min_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_90_15min_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "jvm_memory_pressure" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElasticSearch JVMMemoryPressure")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('JVMMemoryPressure', filter=filter('namespace', 'AWS/ES') and filter('stat', 'upper') and filter('NodeId', '*') and ${module.filtering.signalflow})${var.jvm_memory_pressure_aggregation_function}${var.jvm_memory_pressure_transformation_function}.publish('signal')
    detect(when(signal > ${var.jvm_memory_pressure_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.jvm_memory_pressure_threshold_major}) and when(signal <= ${var.jvm_memory_pressure_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.jvm_memory_pressure_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.jvm_memory_pressure_disabled_critical, var.jvm_memory_pressure_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jvm_memory_pressure_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.jvm_memory_pressure_runbook_url, var.runbook_url), "")
    tip                   = var.jvm_memory_pressure_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.jvm_memory_pressure_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.jvm_memory_pressure_disabled_major, var.jvm_memory_pressure_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jvm_memory_pressure_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.jvm_memory_pressure_runbook_url, var.runbook_url), "")
    tip                   = var.jvm_memory_pressure_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}
