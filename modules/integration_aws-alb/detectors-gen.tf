resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS ALB heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('namespace', 'AWS/ApplicationELB')
    signal = data('RequestCount', filter=base_filtering and filter('stat', 'sum') and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "latency" {
  name = format("%s %s", local.detector_name_prefix, "AWS ALB target response time")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Second"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ApplicationELB')
    signal = data('TargetResponseTime', filter=base_filtering and filter('stat', 'mean') and filter('TargetGroup', '*') and (not filter('AvailabilityZone', '*')) and ${module.filtering.signalflow}, rollup='average', extrapolation='zero')${var.latency_aggregation_function}${var.latency_transformation_function}.publish('signal')
    detect(when(signal > ${var.latency_threshold_critical}, lasting=%{if var.latency_lasting_duration_critical == null}None%{else}'${var.latency_lasting_duration_critical}'%{endif}, at_least=${var.latency_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.latency_threshold_major}, lasting=%{if var.latency_lasting_duration_major == null}None%{else}'${var.latency_lasting_duration_major}'%{endif}, at_least=${var.latency_at_least_percentage_major}) and (not when(signal > ${var.latency_threshold_critical}, lasting=%{if var.latency_lasting_duration_critical == null}None%{else}'${var.latency_lasting_duration_critical}'%{endif}, at_least=${var.latency_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.latency_threshold_critical}Second"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.latency_disabled_critical, var.latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.latency_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.latency_runbook_url, var.runbook_url), "")
    tip                   = var.latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.latency_threshold_major}Second"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.latency_disabled_major, var.latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.latency_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.latency_runbook_url, var.runbook_url), "")
    tip                   = var.latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.latency_max_delay
}

resource "signalfx_detector" "alb_5xx" {
  name = format("%s %s", local.detector_name_prefix, "AWS ALB 5xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*'))
    errors = data('HTTPCode_ELB_5XX_Count', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.alb_5xx_aggregation_function}${var.alb_5xx_transformation_function}
    requests = data('RequestCount', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.alb_5xx_aggregation_function}${var.alb_5xx_transformation_function}
    signal = (errors/requests).scale(100).fill(value=0).publish('signal')
    detect(when(signal > ${var.alb_5xx_threshold_critical}, lasting=%{if var.alb_5xx_lasting_duration_critical == null}None%{else}'${var.alb_5xx_lasting_duration_critical}'%{endif}, at_least=${var.alb_5xx_at_least_percentage_critical}) and when(requests > ${var.minimum_traffic})).publish('CRIT')
    detect(when(signal > ${var.alb_5xx_threshold_major}, lasting=%{if var.alb_5xx_lasting_duration_major == null}None%{else}'${var.alb_5xx_lasting_duration_major}'%{endif}, at_least=${var.alb_5xx_at_least_percentage_major}) and when(requests > ${var.minimum_traffic}) and (not when(signal > ${var.alb_5xx_threshold_critical}, lasting=%{if var.alb_5xx_lasting_duration_critical == null}None%{else}'${var.alb_5xx_lasting_duration_critical}'%{endif}, at_least=${var.alb_5xx_at_least_percentage_critical}) and when(requests > ${var.minimum_traffic}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.alb_5xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.alb_5xx_disabled_critical, var.alb_5xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.alb_5xx_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.alb_5xx_runbook_url, var.runbook_url), "")
    tip                   = var.alb_5xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.alb_5xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.alb_5xx_disabled_major, var.alb_5xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.alb_5xx_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.alb_5xx_runbook_url, var.runbook_url), "")
    tip                   = var.alb_5xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.alb_5xx_max_delay
}

resource "signalfx_detector" "alb_4xx" {
  name = format("%s %s", local.detector_name_prefix, "AWS ALB 4xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*'))
    errors = data('HTTPCode_ELB_4XX_Count', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.alb_4xx_aggregation_function}${var.alb_4xx_transformation_function}
    requests = data('RequestCount', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.alb_4xx_aggregation_function}${var.alb_4xx_transformation_function}
    signal = (errors/requests).scale(100).fill(value=0).publish('signal')
    detect(when(signal > ${var.alb_4xx_threshold_critical}, lasting=%{if var.alb_4xx_lasting_duration_critical == null}None%{else}'${var.alb_4xx_lasting_duration_critical}'%{endif}, at_least=${var.alb_4xx_at_least_percentage_critical}) and when(requests > ${var.minimum_traffic})).publish('CRIT')
    detect(when(signal > ${var.alb_4xx_threshold_major}, lasting=%{if var.alb_4xx_lasting_duration_major == null}None%{else}'${var.alb_4xx_lasting_duration_major}'%{endif}, at_least=${var.alb_4xx_at_least_percentage_major}) and when(requests > ${var.minimum_traffic}) and (not when(signal > ${var.alb_4xx_threshold_critical}, lasting=%{if var.alb_4xx_lasting_duration_critical == null}None%{else}'${var.alb_4xx_lasting_duration_critical}'%{endif}, at_least=${var.alb_4xx_at_least_percentage_critical}) and when(requests > ${var.minimum_traffic}))).publish('MAJOR')
    detect(when(signal > ${var.alb_4xx_threshold_minor}, lasting=%{if var.alb_4xx_lasting_duration_minor == null}None%{else}'${var.alb_4xx_lasting_duration_minor}'%{endif}, at_least=${var.alb_4xx_at_least_percentage_minor}) and when(requests > ${var.minimum_traffic}) and (not when(signal > ${var.alb_4xx_threshold_major}, lasting=%{if var.alb_4xx_lasting_duration_major == null}None%{else}'${var.alb_4xx_lasting_duration_major}'%{endif}, at_least=${var.alb_4xx_at_least_percentage_major}) and when(requests > ${var.minimum_traffic}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.alb_4xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.alb_4xx_disabled_critical, var.alb_4xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.alb_4xx_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.alb_4xx_runbook_url, var.runbook_url), "")
    tip                   = var.alb_4xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.alb_4xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.alb_4xx_disabled_major, var.alb_4xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.alb_4xx_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.alb_4xx_runbook_url, var.runbook_url), "")
    tip                   = var.alb_4xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.alb_4xx_threshold_minor}%"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.alb_4xx_disabled_minor, var.alb_4xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.alb_4xx_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.alb_4xx_runbook_url, var.runbook_url), "")
    tip                   = var.alb_4xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.alb_4xx_max_delay
}

resource "signalfx_detector" "target_5xx" {
  name = format("%s %s", local.detector_name_prefix, "AWS ALB target 5xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and filter('TargetGroup', '*') and (not filter('AvailabilityZone', '*'))
    errors = data('HTTPCode_Target_5XX_Count', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.target_5xx_aggregation_function}${var.target_5xx_transformation_function}
    requests = data('RequestCount', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.target_5xx_aggregation_function}${var.target_5xx_transformation_function}
    signal = (errors/requests).scale(100).fill(value=0).publish('signal')
    detect(when(signal > ${var.target_5xx_threshold_critical}, lasting=%{if var.target_5xx_lasting_duration_critical == null}None%{else}'${var.target_5xx_lasting_duration_critical}'%{endif}, at_least=${var.target_5xx_at_least_percentage_critical}) and when(requests > ${var.minimum_traffic})).publish('CRIT')
    detect(when(signal > ${var.target_5xx_threshold_major}, lasting=%{if var.target_5xx_lasting_duration_major == null}None%{else}'${var.target_5xx_lasting_duration_major}'%{endif}, at_least=${var.target_5xx_at_least_percentage_major}) and when(requests > ${var.minimum_traffic}) and (not when(signal > ${var.target_5xx_threshold_critical}, lasting=%{if var.target_5xx_lasting_duration_critical == null}None%{else}'${var.target_5xx_lasting_duration_critical}'%{endif}, at_least=${var.target_5xx_at_least_percentage_critical}) and when(requests > ${var.minimum_traffic}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.target_5xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.target_5xx_disabled_critical, var.target_5xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.target_5xx_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.target_5xx_runbook_url, var.runbook_url), "")
    tip                   = var.target_5xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.target_5xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.target_5xx_disabled_major, var.target_5xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.target_5xx_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.target_5xx_runbook_url, var.runbook_url), "")
    tip                   = var.target_5xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.target_5xx_max_delay
}

resource "signalfx_detector" "target_4xx" {
  name = format("%s %s", local.detector_name_prefix, "AWS ALB target 4xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and filter('TargetGroup', '*') and (not filter('AvailabilityZone', '*'))
    errors = data('HTTPCode_Target_4XX_Count', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.target_4xx_aggregation_function}${var.target_4xx_transformation_function}
    requests = data('RequestCount', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.target_4xx_aggregation_function}${var.target_4xx_transformation_function}
    signal = (errors/requests).scale(100).fill(value=0).publish('signal')
    detect(when(signal > ${var.target_4xx_threshold_critical}, lasting=%{if var.target_4xx_lasting_duration_critical == null}None%{else}'${var.target_4xx_lasting_duration_critical}'%{endif}, at_least=${var.target_4xx_at_least_percentage_critical}) and when(requests > ${var.minimum_traffic})).publish('CRIT')
    detect(when(signal > ${var.target_4xx_threshold_major}, lasting=%{if var.target_4xx_lasting_duration_major == null}None%{else}'${var.target_4xx_lasting_duration_major}'%{endif}, at_least=${var.target_4xx_at_least_percentage_major}) and when(requests > ${var.minimum_traffic}) and (not when(signal > ${var.target_4xx_threshold_critical}, lasting=%{if var.target_4xx_lasting_duration_critical == null}None%{else}'${var.target_4xx_lasting_duration_critical}'%{endif}, at_least=${var.target_4xx_at_least_percentage_critical}) and when(requests > ${var.minimum_traffic}))).publish('MAJOR')
    detect(when(signal > ${var.target_4xx_threshold_minor}, lasting=%{if var.target_4xx_lasting_duration_minor == null}None%{else}'${var.target_4xx_lasting_duration_minor}'%{endif}, at_least=${var.target_4xx_at_least_percentage_minor}) and when(requests > ${var.minimum_traffic}) and (not when(signal > ${var.target_4xx_threshold_major}, lasting=%{if var.target_4xx_lasting_duration_major == null}None%{else}'${var.target_4xx_lasting_duration_major}'%{endif}, at_least=${var.target_4xx_at_least_percentage_major}) and when(requests > ${var.minimum_traffic}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.target_4xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.target_4xx_disabled_critical, var.target_4xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.target_4xx_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.target_4xx_runbook_url, var.runbook_url), "")
    tip                   = var.target_4xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.target_4xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.target_4xx_disabled_major, var.target_4xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.target_4xx_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.target_4xx_runbook_url, var.runbook_url), "")
    tip                   = var.target_4xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.target_4xx_threshold_minor}%"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.target_4xx_disabled_minor, var.target_4xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.target_4xx_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.target_4xx_runbook_url, var.runbook_url), "")
    tip                   = var.target_4xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.target_4xx_max_delay
}

resource "signalfx_detector" "healthy" {
  name = format("%s %s", local.detector_name_prefix, "AWS ALB healthy instances percentage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ApplicationELB') and (not filter('AvailabilityZone', '*'))
    healthy = data('HealthyHostCount', filter=base_filtering and filter('stat', 'lower') and ${module.filtering.signalflow})${var.healthy_aggregation_function}${var.healthy_transformation_function}
    unhealthy = data('UnHealthyHostCount', filter=base_filtering and filter('stat', 'upper') and ${module.filtering.signalflow})${var.healthy_aggregation_function}${var.healthy_transformation_function}
    signal = (healthy / (healthy+unhealthy)).scale(100).publish('signal')
    detect(when(signal < ${var.healthy_threshold_critical}, lasting=%{if var.healthy_lasting_duration_critical == null}None%{else}'${var.healthy_lasting_duration_critical}'%{endif}, at_least=${var.healthy_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal < ${var.healthy_threshold_major}, lasting=%{if var.healthy_lasting_duration_major == null}None%{else}'${var.healthy_lasting_duration_major}'%{endif}, at_least=${var.healthy_at_least_percentage_major}) and (not when(signal < ${var.healthy_threshold_critical}, lasting=%{if var.healthy_lasting_duration_critical == null}None%{else}'${var.healthy_lasting_duration_critical}'%{endif}, at_least=${var.healthy_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "has fallen below critical capacity < ${var.healthy_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.healthy_disabled_critical, var.healthy_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.healthy_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.healthy_runbook_url, var.runbook_url), "")
    tip                   = var.healthy_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is below nominal capacity < ${var.healthy_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.healthy_disabled_major, var.healthy_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.healthy_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.healthy_runbook_url, var.runbook_url), "")
    tip                   = var.healthy_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.healthy_max_delay
}

