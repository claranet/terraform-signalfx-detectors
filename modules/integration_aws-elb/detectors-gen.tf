resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS ELB heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('namespace', 'AWS/ELB')
    signal = data('HealthyHostCount', filter=base_filtering and filter('stat', 'mean') and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "backend_latency" {
  name = format("%s %s", local.detector_name_prefix, "AWS ELB backend latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "s"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ApplicationELB')
    signal = data('Latency', filter=base_filtering and filter('stat', 'mean') and (not filter('AvailabilityZone', '*')) and filter('LoadBalancerName', '*') and ${module.filtering.signalflow}, rollup='average', extrapolation='zero')${var.backend_latency_aggregation_function}${var.backend_latency_transformation_function}.publish('signal')
    detect(when(signal > ${var.backend_latency_threshold_critical}, lasting=%{if var.backend_latency_lasting_duration_critical == null}None%{else}'${var.backend_latency_lasting_duration_critical}'%{endif}, at_least=${var.backend_latency_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.backend_latency_threshold_major}, lasting=%{if var.backend_latency_lasting_duration_major == null}None%{else}'${var.backend_latency_lasting_duration_major}'%{endif}, at_least=${var.backend_latency_at_least_percentage_major}) and (not when(signal > ${var.backend_latency_threshold_critical}, lasting=%{if var.backend_latency_lasting_duration_critical == null}None%{else}'${var.backend_latency_lasting_duration_critical}'%{endif}, at_least=${var.backend_latency_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.backend_latency_threshold_critical}s"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_latency_disabled_critical, var.backend_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_latency_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.backend_latency_runbook_url, var.runbook_url), "")
    tip                   = var.backend_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.backend_latency_threshold_major}s"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.backend_latency_disabled_major, var.backend_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_latency_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.backend_latency_runbook_url, var.runbook_url), "")
    tip                   = var.backend_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "elb_5xx" {
  name = format("%s %s", local.detector_name_prefix, "AWS ELB 5xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and filter('LoadBalancerName', '*')
    errors = data('HTTPCode_ELB_5XX', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.elb_5xx_aggregation_function}${var.elb_5xx_transformation_function}
    requests = data('RequestCount', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.elb_5xx_aggregation_function}${var.elb_5xx_transformation_function}
    signal = (errors/requests).scale(100).fill(value=0).publish('signal')
    detect(when(signal > ${var.elb_5xx_threshold_critical}, lasting=%{if var.elb_5xx_lasting_duration_critical == null}None%{else}'${var.elb_5xx_lasting_duration_critical}'%{endif}, at_least=${var.elb_5xx_at_least_percentage_critical}) and when(requests > ${var.minimum_traffic})).publish('CRIT')
    detect(when(signal > ${var.elb_5xx_threshold_major}, lasting=%{if var.elb_5xx_lasting_duration_major == null}None%{else}'${var.elb_5xx_lasting_duration_major}'%{endif}, at_least=${var.elb_5xx_at_least_percentage_major}) and when(requests > ${var.minimum_traffic}) and (not when(signal > ${var.elb_5xx_threshold_critical}, lasting=%{if var.elb_5xx_lasting_duration_critical == null}None%{else}'${var.elb_5xx_lasting_duration_critical}'%{endif}, at_least=${var.elb_5xx_at_least_percentage_critical}) and when(requests > ${var.minimum_traffic}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.elb_5xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.elb_5xx_disabled_critical, var.elb_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.elb_5xx_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.elb_5xx_runbook_url, var.runbook_url), "")
    tip                   = var.elb_5xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.elb_5xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.elb_5xx_disabled_major, var.elb_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.elb_5xx_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.elb_5xx_runbook_url, var.runbook_url), "")
    tip                   = var.elb_5xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "elb_4xx" {
  name = format("%s %s", local.detector_name_prefix, "AWS ELB 4xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and filter('LoadBalancerName', '*')
    errors = data('HTTPCode_ELB_4XX', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.elb_4xx_aggregation_function}${var.elb_4xx_transformation_function}
    requests = data('RequestCount', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.elb_4xx_aggregation_function}${var.elb_4xx_transformation_function}
    signal = (errors/requests).scale(100).fill(value=0).publish('signal')
    detect(when(signal > ${var.elb_4xx_threshold_critical}, lasting=%{if var.elb_4xx_lasting_duration_critical == null}None%{else}'${var.elb_4xx_lasting_duration_critical}'%{endif}, at_least=${var.elb_4xx_at_least_percentage_critical}) and when(requests > ${var.minimum_traffic})).publish('CRIT')
    detect(when(signal > ${var.elb_4xx_threshold_major}, lasting=%{if var.elb_4xx_lasting_duration_major == null}None%{else}'${var.elb_4xx_lasting_duration_major}'%{endif}, at_least=${var.elb_4xx_at_least_percentage_major}) and when(requests > ${var.minimum_traffic}) and (not when(signal > ${var.elb_4xx_threshold_critical}, lasting=%{if var.elb_4xx_lasting_duration_critical == null}None%{else}'${var.elb_4xx_lasting_duration_critical}'%{endif}, at_least=${var.elb_4xx_at_least_percentage_critical}) and when(requests > ${var.minimum_traffic}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.elb_4xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.elb_4xx_disabled_critical, var.elb_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.elb_4xx_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.elb_4xx_runbook_url, var.runbook_url), "")
    tip                   = var.elb_4xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.elb_4xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.elb_4xx_disabled_major, var.elb_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.elb_4xx_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.elb_4xx_runbook_url, var.runbook_url), "")
    tip                   = var.elb_4xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "backend_5xx" {
  name = format("%s %s", local.detector_name_prefix, "AWS ELB backend 5xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and filter('LoadBalancerName', '*')
    errors = data('HTTPCode_Backend_5XX', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.backend_5xx_aggregation_function}${var.backend_5xx_transformation_function}
    requests = data('RequestCount', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.backend_5xx_aggregation_function}${var.backend_5xx_transformation_function}
    signal = (errors/requests).scale(100).fill(value=0).publish('signal')
    detect(when(signal > ${var.backend_5xx_threshold_critical}, lasting=%{if var.backend_5xx_lasting_duration_critical == null}None%{else}'${var.backend_5xx_lasting_duration_critical}'%{endif}, at_least=${var.backend_5xx_at_least_percentage_critical}) and when(requests > ${var.minimum_traffic})).publish('CRIT')
    detect(when(signal > ${var.backend_5xx_threshold_major}, lasting=%{if var.backend_5xx_lasting_duration_major == null}None%{else}'${var.backend_5xx_lasting_duration_major}'%{endif}, at_least=${var.backend_5xx_at_least_percentage_major}) and when(requests > ${var.minimum_traffic}) and (not when(signal > ${var.backend_5xx_threshold_critical}, lasting=%{if var.backend_5xx_lasting_duration_critical == null}None%{else}'${var.backend_5xx_lasting_duration_critical}'%{endif}, at_least=${var.backend_5xx_at_least_percentage_critical}) and when(requests > ${var.minimum_traffic}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.backend_5xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_5xx_disabled_critical, var.backend_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_5xx_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.backend_5xx_runbook_url, var.runbook_url), "")
    tip                   = var.backend_5xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.backend_5xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.backend_5xx_disabled_major, var.backend_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_5xx_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.backend_5xx_runbook_url, var.runbook_url), "")
    tip                   = var.backend_5xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "backend_4xx" {
  name = format("%s %s", local.detector_name_prefix, "AWS ELB backend 4xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and filter('LoadBalancerName', '*')
    errors = data('HTTPCode_Backend_4XX', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.backend_4xx_aggregation_function}${var.backend_4xx_transformation_function}
    requests = data('RequestCount', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.backend_4xx_aggregation_function}${var.backend_4xx_transformation_function}
    signal = (errors/requests).scale(100).fill(value=0).publish('signal')
    detect(when(signal > ${var.backend_4xx_threshold_critical}, lasting=%{if var.backend_4xx_lasting_duration_critical == null}None%{else}'${var.backend_4xx_lasting_duration_critical}'%{endif}, at_least=${var.backend_4xx_at_least_percentage_critical}) and when(requests > ${var.minimum_traffic})).publish('CRIT')
    detect(when(signal > ${var.backend_4xx_threshold_major}, lasting=%{if var.backend_4xx_lasting_duration_major == null}None%{else}'${var.backend_4xx_lasting_duration_major}'%{endif}, at_least=${var.backend_4xx_at_least_percentage_major}) and when(requests > ${var.minimum_traffic}) and (not when(signal > ${var.backend_4xx_threshold_critical}, lasting=%{if var.backend_4xx_lasting_duration_critical == null}None%{else}'${var.backend_4xx_lasting_duration_critical}'%{endif}, at_least=${var.backend_4xx_at_least_percentage_critical}) and when(requests > ${var.minimum_traffic}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.backend_4xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_4xx_disabled_critical, var.backend_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_4xx_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.backend_4xx_runbook_url, var.runbook_url), "")
    tip                   = var.backend_4xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.backend_4xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.backend_4xx_disabled_major, var.backend_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_4xx_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.backend_4xx_runbook_url, var.runbook_url), "")
    tip                   = var.backend_4xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "healthy" {
  name = format("%s %s", local.detector_name_prefix, "AWS ELB healthy instances percentage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ELB') and (not filter('AvailabilityZone', '*')) and filter('LoadBalancerName', '*')
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
    notifications         = coalescelist(lookup(var.healthy_notifications, "critical", []), var.notifications.critical)
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
    notifications         = coalescelist(lookup(var.healthy_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.healthy_runbook_url, var.runbook_url), "")
    tip                   = var.healthy_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

