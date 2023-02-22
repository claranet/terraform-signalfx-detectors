resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS Redshift heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('namespace', 'AWS/Redshift')
    signal = data('CPUUtilization', filter=base_filtering and filter('stat', 'mean') and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "cpu_usage" {
  name = format("%s %s", local.detector_name_prefix, "AWS Redshift cpu usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/Redshift')
    signal = data('CPUUtilization', filter=base_filtering and filter('stat', 'mean') and filter('ClusterIdentifier', '*') and filter('NodeID', '*') and ${module.filtering.signalflow})${var.cpu_usage_aggregation_function}${var.cpu_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_usage_threshold_critical}, lasting=%{if var.cpu_usage_lasting_duration_critical == null}None%{else}'${var.cpu_usage_lasting_duration_critical}'%{endif}, at_least=${var.cpu_usage_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_usage_threshold_major}, lasting=%{if var.cpu_usage_lasting_duration_major == null}None%{else}'${var.cpu_usage_lasting_duration_major}'%{endif}, at_least=${var.cpu_usage_at_least_percentage_major}) and (not when(signal > ${var.cpu_usage_threshold_critical}, lasting=%{if var.cpu_usage_lasting_duration_critical == null}None%{else}'${var.cpu_usage_lasting_duration_critical}'%{endif}, at_least=${var.cpu_usage_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_usage_disabled_critical, var.cpu_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_usage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cpu_usage_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cpu_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_usage_disabled_major, var.cpu_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_usage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cpu_usage_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cpu_usage_max_delay
}

resource "signalfx_detector" "storage_usage" {
  name = format("%s %s", local.detector_name_prefix, "AWS Redshift storage usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/Redshift')
    signal = data('PercentageDiskSpaceUsed', filter=base_filtering and filter('stat', 'mean') and filter('ClusterIdentifier', '*') and filter('NodeID', '*') and ${module.filtering.signalflow})${var.storage_usage_aggregation_function}${var.storage_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.storage_usage_threshold_major}, lasting=%{if var.storage_usage_lasting_duration_major == null}None%{else}'${var.storage_usage_lasting_duration_major}'%{endif}, at_least=${var.storage_usage_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.storage_usage_threshold_critical}, lasting=%{if var.storage_usage_lasting_duration_critical == null}None%{else}'${var.storage_usage_lasting_duration_critical}'%{endif}, at_least=${var.storage_usage_at_least_percentage_critical}) and (not when(signal > ${var.storage_usage_threshold_major}, lasting=%{if var.storage_usage_lasting_duration_major == null}None%{else}'${var.storage_usage_lasting_duration_major}'%{endif}, at_least=${var.storage_usage_at_least_percentage_major}))).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.storage_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.storage_usage_disabled_major, var.storage_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.storage_usage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.storage_usage_runbook_url, var.runbook_url), "")
    tip                   = var.storage_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.storage_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.storage_usage_disabled_critical, var.storage_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.storage_usage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.storage_usage_runbook_url, var.runbook_url), "")
    tip                   = var.storage_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.storage_usage_max_delay
}

