resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure App Service heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true')
    signal = data('CpuTime', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "response_time" {
  name = format("%s %s", local.detector_name_prefix, "Azure App Service response time")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "s"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true')
    signal = data('HttpResponseTime', filter=base_filtering and ${module.filtering.signalflow})${var.response_time_aggregation_function}${var.response_time_transformation_function}.publish('signal')
    detect(when(signal > ${var.response_time_threshold_critical}, lasting=%{if var.response_time_lasting_duration_critical == null}None%{else}'${var.response_time_lasting_duration_critical}'%{endif}, at_least=${var.response_time_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.response_time_threshold_major}, lasting=%{if var.response_time_lasting_duration_major == null}None%{else}'${var.response_time_lasting_duration_major}'%{endif}, at_least=${var.response_time_at_least_percentage_major}) and (not when(signal > ${var.response_time_threshold_critical}, lasting=%{if var.response_time_lasting_duration_critical == null}None%{else}'${var.response_time_lasting_duration_critical}'%{endif}, at_least=${var.response_time_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.response_time_threshold_critical}s"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.response_time_disabled_critical, var.response_time_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.response_time_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.response_time_runbook_url, var.runbook_url), "")
    tip                   = var.response_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.response_time_threshold_major}s"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.response_time_disabled_major, var.response_time_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.response_time_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.response_time_runbook_url, var.runbook_url), "")
    tip                   = var.response_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.response_time_max_delay
}

resource "signalfx_detector" "http_5xx_error_rate" {
  name = format("%s %s", local.detector_name_prefix, "Azure App Service http 5xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true')
    http5xx = data('Http5xx', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.http_5xx_error_rate_aggregation_function}${var.http_5xx_error_rate_transformation_function}
    requests = data('Requests', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.http_5xx_error_rate_aggregation_function}${var.http_5xx_error_rate_transformation_function}
    signal = (http5xx/requests).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.http_5xx_error_rate_threshold_major}, lasting=%{if var.http_5xx_error_rate_lasting_duration_major == null}None%{else}'${var.http_5xx_error_rate_lasting_duration_major}'%{endif}, at_least=${var.http_5xx_error_rate_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.http_5xx_error_rate_threshold_minor}, lasting=%{if var.http_5xx_error_rate_lasting_duration_minor == null}None%{else}'${var.http_5xx_error_rate_lasting_duration_minor}'%{endif}, at_least=${var.http_5xx_error_rate_at_least_percentage_minor}) and (not when(signal > ${var.http_5xx_error_rate_threshold_major}, lasting=%{if var.http_5xx_error_rate_lasting_duration_major == null}None%{else}'${var.http_5xx_error_rate_lasting_duration_major}'%{endif}, at_least=${var.http_5xx_error_rate_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.http_5xx_error_rate_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_5xx_error_rate_disabled_major, var.http_5xx_error_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_5xx_error_rate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.http_5xx_error_rate_runbook_url, var.runbook_url), "")
    tip                   = var.http_5xx_error_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.http_5xx_error_rate_threshold_minor}%"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.http_5xx_error_rate_disabled_minor, var.http_5xx_error_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_5xx_error_rate_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.http_5xx_error_rate_runbook_url, var.runbook_url), "")
    tip                   = var.http_5xx_error_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.http_5xx_error_rate_max_delay
}

resource "signalfx_detector" "http_4xx_error_rate" {
  name = format("%s %s", local.detector_name_prefix, "Azure App Service http 4xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true')
    http4xx = data('Http4xx', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.http_4xx_error_rate_aggregation_function}${var.http_4xx_error_rate_transformation_function}
    requests = data('Requests', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.http_4xx_error_rate_aggregation_function}${var.http_4xx_error_rate_transformation_function}
    signal = (http4xx/requests).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.http_4xx_error_rate_threshold_major}, lasting=%{if var.http_4xx_error_rate_lasting_duration_major == null}None%{else}'${var.http_4xx_error_rate_lasting_duration_major}'%{endif}, at_least=${var.http_4xx_error_rate_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.http_4xx_error_rate_threshold_minor}, lasting=%{if var.http_4xx_error_rate_lasting_duration_minor == null}None%{else}'${var.http_4xx_error_rate_lasting_duration_minor}'%{endif}, at_least=${var.http_4xx_error_rate_at_least_percentage_minor}) and (not when(signal > ${var.http_4xx_error_rate_threshold_major}, lasting=%{if var.http_4xx_error_rate_lasting_duration_major == null}None%{else}'${var.http_4xx_error_rate_lasting_duration_major}'%{endif}, at_least=${var.http_4xx_error_rate_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.http_4xx_error_rate_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_4xx_error_rate_disabled_major, var.http_4xx_error_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_4xx_error_rate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.http_4xx_error_rate_runbook_url, var.runbook_url), "")
    tip                   = var.http_4xx_error_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.http_4xx_error_rate_threshold_minor}%"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.http_4xx_error_rate_disabled_minor, var.http_4xx_error_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_4xx_error_rate_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.http_4xx_error_rate_runbook_url, var.runbook_url), "")
    tip                   = var.http_4xx_error_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.http_4xx_error_rate_max_delay
}

resource "signalfx_detector" "http_success_status_rate" {
  name = format("%s %s", local.detector_name_prefix, "Azure App Service http success status rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'false') and filter('primary_aggregation_type', 'true')
    http2xx = data('Http2xx', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.http_success_status_rate_aggregation_function}${var.http_success_status_rate_transformation_function}
    http3xx = data('Http3xx', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.http_success_status_rate_aggregation_function}${var.http_success_status_rate_transformation_function}
    requests = data('Requests', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.http_success_status_rate_aggregation_function}${var.http_success_status_rate_transformation_function}
    signal = ((http2xx+http3xx)/requests).scale(100).fill(100).publish('signal')
    detect(when(signal < ${var.http_success_status_rate_threshold_major}, lasting=%{if var.http_success_status_rate_lasting_duration_major == null}None%{else}'${var.http_success_status_rate_lasting_duration_major}'%{endif}, at_least=${var.http_success_status_rate_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal < ${var.http_success_status_rate_threshold_minor}, lasting=%{if var.http_success_status_rate_lasting_duration_minor == null}None%{else}'${var.http_success_status_rate_lasting_duration_minor}'%{endif}, at_least=${var.http_success_status_rate_at_least_percentage_minor}) and (not when(signal < ${var.http_success_status_rate_threshold_major}, lasting=%{if var.http_success_status_rate_lasting_duration_major == null}None%{else}'${var.http_success_status_rate_lasting_duration_major}'%{endif}, at_least=${var.http_success_status_rate_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too low < ${var.http_success_status_rate_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_success_status_rate_disabled_major, var.http_success_status_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_success_status_rate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.http_success_status_rate_runbook_url, var.runbook_url), "")
    tip                   = var.http_success_status_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.http_success_status_rate_threshold_minor}%"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.http_success_status_rate_disabled_minor, var.http_success_status_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_success_status_rate_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.http_success_status_rate_runbook_url, var.runbook_url), "")
    tip                   = var.http_success_status_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.http_success_status_rate_max_delay
}

