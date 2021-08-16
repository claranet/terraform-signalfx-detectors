resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS Beanstalk heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('EnvironmentHealth', filter=filter('stat', 'mean') and filter('namespace', 'AWS/ElasticBeanstalk') and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "health" {
  name = format("%s %s", local.detector_name_prefix, "AWS Beanstalk environment health")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('EnvironmentHealth', filter=filter('namespace', 'AWS/ElasticBeanstalk') and filter('stat', 'upper') and ${module.filtering.signalflow})${var.health_aggregation_function}${var.health_transformation_function}.publish('signal')
    detect(when(signal >= ${var.health_threshold_critical})).publish('CRIT')
    detect(when(signal >= ${var.health_threshold_major}) and (not when(signal >= ${var.health_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.health_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.health_disabled_critical, var.health_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.health_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.health_runbook_url, var.runbook_url), "")
    tip                   = var.health_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high >= ${var.health_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.health_disabled_major, var.health_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.health_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.health_runbook_url, var.runbook_url), "")
    tip                   = var.health_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "latency_p90" {
  name = format("%s %s", local.detector_name_prefix, "AWS Beanstalk application latency p90")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('ApplicationLatencyP90', filter=filter('namespace', 'AWS/ElasticBeanstalk') and filter('stat', 'lower') and (not filter('InstanceId', '*')) and ${module.filtering.signalflow})${var.latency_p90_aggregation_function}${var.latency_p90_transformation_function}.publish('signal')
    detect(when(signal >= ${var.latency_p90_threshold_critical})).publish('CRIT')
    detect(when(signal >= ${var.latency_p90_threshold_major}) and (not when(signal >= ${var.latency_p90_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.latency_p90_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.latency_p90_disabled_critical, var.latency_p90_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.latency_p90_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.latency_p90_runbook_url, var.runbook_url), "")
    tip                   = var.latency_p90_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.latency_p90_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.latency_p90_disabled_major, var.latency_p90_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.latency_p90_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.latency_p90_runbook_url, var.runbook_url), "")
    tip                   = var.latency_p90_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "app_5xx_error_rate" {
  name = format("%s %s", local.detector_name_prefix, "AWS Beanstalk application 5xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('ApplicationRequests5xx', filter=filter('namespace', 'AWS/ElasticBeanstalk') and filter('stat', 'sum') and (not filter('InstanceId', '*')) and ${module.filtering.signalflow})${var.app_5xx_error_rate_aggregation_function}${var.app_5xx_error_rate_transformation_function}
    B = data('ApplicationRequestsTotal', filter=filter('namespace', 'AWS/ElasticBeanstalk') and filter('stat', 'sum') and (not filter('InstanceId', '*')) and ${module.filtering.signalflow})${var.app_5xx_error_rate_aggregation_function}${var.app_5xx_error_rate_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.app_5xx_error_rate_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.app_5xx_error_rate_threshold_major}) and (not when(signal > ${var.app_5xx_error_rate_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.app_5xx_error_rate_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.app_5xx_error_rate_disabled_critical, var.app_5xx_error_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.app_5xx_error_rate_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.app_5xx_error_rate_runbook_url, var.runbook_url), "")
    tip                   = var.app_5xx_error_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.app_5xx_error_rate_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.app_5xx_error_rate_disabled_major, var.app_5xx_error_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.app_5xx_error_rate_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.app_5xx_error_rate_runbook_url, var.runbook_url), "")
    tip                   = var.app_5xx_error_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

}

resource "signalfx_detector" "root_filesystem_usage" {
  name = format("%s %s", local.detector_name_prefix, "AWS Beanstalk instance root filesystem usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('RootFilesystemUtil', filter=filter('namespace', 'AWS/ElasticBeanstalk') and filter('stat', 'lower') and (not filter('InstanceId', '*')) and ${module.filtering.signalflow})${var.root_filesystem_usage_aggregation_function}${var.root_filesystem_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.root_filesystem_usage_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.root_filesystem_usage_threshold_major}) and (not when(signal > ${var.root_filesystem_usage_threshold_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.root_filesystem_usage_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.root_filesystem_usage_disabled_critical, var.root_filesystem_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.root_filesystem_usage_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.root_filesystem_usage_runbook_url, var.runbook_url), "")
    tip                   = var.root_filesystem_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.root_filesystem_usage_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.root_filesystem_usage_disabled_major, var.root_filesystem_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.root_filesystem_usage_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.root_filesystem_usage_runbook_url, var.runbook_url), "")
    tip                   = var.root_filesystem_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

