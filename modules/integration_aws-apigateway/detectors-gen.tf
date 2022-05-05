resource "signalfx_detector" "latency" {
  name = format("%s %s", local.detector_name_prefix, "AWS APIGateway latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Millisecond"
  }

  program_text = <<-EOF
    signal = data('Latency', filter=filter('namespace', 'AWS/ApiGateway') and filter('stat', 'mean') and (not filter('Stage', '*')) and (not filter('Method', '*')) and (not filter('Resource', '*')) and ${module.filtering.signalflow}, rollup='average', extrapolation='zero')${var.latency_aggregation_function}${var.latency_transformation_function}.publish('signal')
    detect(when(signal > ${var.latency_threshold_critical}, lasting=%{if var.latency_lasting_duration_critical == null}None%{else}'${var.latency_lasting_duration_critical}'%{endif}, at_least=${var.latency_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.latency_threshold_major}, lasting=%{if var.latency_lasting_duration_major == null}None%{else}'${var.latency_lasting_duration_major}'%{endif}, at_least=${var.latency_at_least_percentage_major}) and (not when(signal > ${var.latency_threshold_critical}, lasting=%{if var.latency_lasting_duration_critical == null}None%{else}'${var.latency_lasting_duration_critical}'%{endif}, at_least=${var.latency_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.latency_threshold_critical}Millisecond"
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
    description           = "is too high > ${var.latency_threshold_major}Millisecond"
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

resource "signalfx_detector" "http_5xx" {
  name = format("%s %s", local.detector_name_prefix, "AWS APIGateway http 5xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    errors = data('${var.is_v2 ? "5xx" : "5XXError"}', filter=filter('namespace', 'AWS/ApiGateway') and filter('stat', 'sum') and (not filter('Stage', '*')) and (not filter('Method', '*')) and (not filter('Resource', '*')) and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.http_5xx_aggregation_function}${var.http_5xx_transformation_function}
    requests = data('Count', filter=filter('namespace', 'AWS/ApiGateway') and filter('stat', 'sum') and (not filter('Stage', '*')) and (not filter('Method', '*')) and (not filter('Resource', '*')) and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.http_5xx_aggregation_function}${var.http_5xx_transformation_function}
    signal = (errors/requests).scale(100).fill(value=0).publish('signal')
    detect(when(signal > ${var.http_5xx_threshold_critical}, lasting=%{if var.http_5xx_lasting_duration_critical == null}None%{else}'${var.http_5xx_lasting_duration_critical}'%{endif}, at_least=${var.http_5xx_at_least_percentage_critical}) and when(requests > ${var.minimum_traffic})).publish('CRIT')
    detect(when(signal > ${var.http_5xx_threshold_major}, lasting=%{if var.http_5xx_lasting_duration_major == null}None%{else}'${var.http_5xx_lasting_duration_major}'%{endif}, at_least=${var.http_5xx_at_least_percentage_major}) and when(requests > ${var.minimum_traffic}) and (not when(signal > ${var.http_5xx_threshold_critical}, lasting=%{if var.http_5xx_lasting_duration_critical == null}None%{else}'${var.http_5xx_lasting_duration_critical}'%{endif}, at_least=${var.http_5xx_at_least_percentage_critical}) and when(requests > ${var.minimum_traffic}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.http_5xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_5xx_disabled_critical, var.http_5xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_5xx_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.http_5xx_runbook_url, var.runbook_url), "")
    tip                   = var.http_5xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.http_5xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_5xx_disabled_major, var.http_5xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_5xx_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.http_5xx_runbook_url, var.runbook_url), "")
    tip                   = var.http_5xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.http_5xx_max_delay
}

resource "signalfx_detector" "http_4xx" {
  name = format("%s %s", local.detector_name_prefix, "AWS APIGateway http 4xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    errors = data('${var.is_v2 ? "4xx" : "4XXError"}', filter=filter('namespace', 'AWS/ApiGateway') and filter('stat', 'sum') and (not filter('Stage', '*')) and (not filter('Method', '*')) and (not filter('Resource', '*')) and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.http_4xx_aggregation_function}${var.http_4xx_transformation_function}
    requests = data('Count', filter=filter('namespace', 'AWS/ApiGateway') and filter('stat', 'sum') and (not filter('Stage', '*')) and (not filter('Method', '*')) and (not filter('Resource', '*')) and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.http_4xx_aggregation_function}${var.http_4xx_transformation_function}
    signal = (errors/requests).scale(100).fill(value=0).publish('signal')
    detect(when(signal > ${var.http_4xx_threshold_critical}, lasting=%{if var.http_4xx_lasting_duration_critical == null}None%{else}'${var.http_4xx_lasting_duration_critical}'%{endif}, at_least=${var.http_4xx_at_least_percentage_critical}) and when(requests > ${var.minimum_traffic})).publish('CRIT')
    detect(when(signal > ${var.http_4xx_threshold_major}, lasting=%{if var.http_4xx_lasting_duration_major == null}None%{else}'${var.http_4xx_lasting_duration_major}'%{endif}, at_least=${var.http_4xx_at_least_percentage_major}) and when(requests > ${var.minimum_traffic}) and (not when(signal > ${var.http_4xx_threshold_critical}, lasting=%{if var.http_4xx_lasting_duration_critical == null}None%{else}'${var.http_4xx_lasting_duration_critical}'%{endif}, at_least=${var.http_4xx_at_least_percentage_critical}) and when(requests > ${var.minimum_traffic}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.http_4xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_4xx_disabled_critical, var.http_4xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_4xx_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.http_4xx_runbook_url, var.runbook_url), "")
    tip                   = var.http_4xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.http_4xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_4xx_disabled_major, var.http_4xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_4xx_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.http_4xx_runbook_url, var.runbook_url), "")
    tip                   = var.http_4xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.http_4xx_max_delay
}

