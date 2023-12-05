resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure Functions heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'true') and filter('primary_aggregation_type', 'true')
    signal = data('AppConnections', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "errors" {
  name = format("%s %s", local.detector_name_prefix, "Azure Functions wrapper errors")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('is_Azure_Function', 'true')
    errors = data('azure.function.errors', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='last_value')${var.errors_aggregation_function}${var.errors_transformation_function}
    invocations = data('azure.function.invocations', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='last_value')${var.errors_aggregation_function}${var.errors_transformation_function}
    signal = (errors / invocations).fill(value=0).scale(100).publish('signal')
    detect(when(signal > ${var.errors_threshold_critical}, lasting=%{if var.errors_lasting_duration_critical == null}None%{else}'${var.errors_lasting_duration_critical}'%{endif}, at_least=${var.errors_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.errors_threshold_major}, lasting=%{if var.errors_lasting_duration_major == null}None%{else}'${var.errors_lasting_duration_major}'%{endif}, at_least=${var.errors_at_least_percentage_major}) and (not when(signal > ${var.errors_threshold_critical}, lasting=%{if var.errors_lasting_duration_critical == null}None%{else}'${var.errors_lasting_duration_critical}'%{endif}, at_least=${var.errors_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.errors_disabled_critical, var.errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.errors_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.errors_runbook_url, var.runbook_url), "")
    tip                   = var.errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.errors_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.errors_disabled_major, var.errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.errors_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.errors_runbook_url, var.runbook_url), "")
    tip                   = var.errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.errors_max_delay
}

resource "signalfx_detector" "http_5xx_errors_rate" {
  name = format("%s %s", local.detector_name_prefix, "Azure Functions http 5xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'true') and filter('primary_aggregation_type', 'true')
    error_stream = data('Http5xx', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.http_5xx_errors_rate_aggregation_function}${var.http_5xx_errors_rate_transformation_function}
    count_stream = data('FunctionExecutionCount', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.http_5xx_errors_rate_aggregation_function}${var.http_5xx_errors_rate_transformation_function}
    signal = (error_stream / count_stream).fill(value=0).scale(100).publish('signal')
    detect(when(signal > ${var.http_5xx_errors_rate_threshold_critical}, lasting=%{if var.http_5xx_errors_rate_lasting_duration_critical == null}None%{else}'${var.http_5xx_errors_rate_lasting_duration_critical}'%{endif}, at_least=${var.http_5xx_errors_rate_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.http_5xx_errors_rate_threshold_major}, lasting=%{if var.http_5xx_errors_rate_lasting_duration_major == null}None%{else}'${var.http_5xx_errors_rate_lasting_duration_major}'%{endif}, at_least=${var.http_5xx_errors_rate_at_least_percentage_major}) and (not when(signal > ${var.http_5xx_errors_rate_threshold_critical}, lasting=%{if var.http_5xx_errors_rate_lasting_duration_critical == null}None%{else}'${var.http_5xx_errors_rate_lasting_duration_critical}'%{endif}, at_least=${var.http_5xx_errors_rate_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.http_5xx_errors_rate_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_5xx_errors_rate_disabled_critical, var.http_5xx_errors_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_5xx_errors_rate_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.http_5xx_errors_rate_runbook_url, var.runbook_url), "")
    tip                   = var.http_5xx_errors_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.http_5xx_errors_rate_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_5xx_errors_rate_disabled_major, var.http_5xx_errors_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_5xx_errors_rate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.http_5xx_errors_rate_runbook_url, var.runbook_url), "")
    tip                   = var.http_5xx_errors_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.http_5xx_errors_rate_max_delay
}

resource "signalfx_detector" "high_connections_count" {
  name = format("%s %s", local.detector_name_prefix, "Azure Functions connections count")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'true') and filter('primary_aggregation_type', 'true')
    signal = data('AppConnections', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='last_value')${var.high_connections_count_aggregation_function}${var.high_connections_count_transformation_function}.publish('signal')
    detect(when(signal > ${var.high_connections_count_threshold_critical}, lasting=%{if var.high_connections_count_lasting_duration_critical == null}None%{else}'${var.high_connections_count_lasting_duration_critical}'%{endif}, at_least=${var.high_connections_count_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.high_connections_count_threshold_major}, lasting=%{if var.high_connections_count_lasting_duration_major == null}None%{else}'${var.high_connections_count_lasting_duration_major}'%{endif}, at_least=${var.high_connections_count_at_least_percentage_major}) and (not when(signal > ${var.high_connections_count_threshold_critical}, lasting=%{if var.high_connections_count_lasting_duration_critical == null}None%{else}'${var.high_connections_count_lasting_duration_critical}'%{endif}, at_least=${var.high_connections_count_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.high_connections_count_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.high_connections_count_disabled_critical, var.high_connections_count_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.high_connections_count_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.high_connections_count_runbook_url, var.runbook_url), "")
    tip                   = var.high_connections_count_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.high_connections_count_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.high_connections_count_disabled_major, var.high_connections_count_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.high_connections_count_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.high_connections_count_runbook_url, var.runbook_url), "")
    tip                   = var.high_connections_count_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.high_connections_count_max_delay
}

resource "signalfx_detector" "high_threads_count" {
  name = format("%s %s", local.detector_name_prefix, "Azure Functions thread count")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Web/sites') and filter('is_Azure_Function', 'true') and filter('primary_aggregation_type', 'true')
    signal = data('Threads', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='last_value')${var.high_threads_count_aggregation_function}${var.high_threads_count_transformation_function}.publish('signal')
    detect(when(signal > ${var.high_threads_count_threshold_critical}, lasting=%{if var.high_threads_count_lasting_duration_critical == null}None%{else}'${var.high_threads_count_lasting_duration_critical}'%{endif}, at_least=${var.high_threads_count_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.high_threads_count_threshold_major}, lasting=%{if var.high_threads_count_lasting_duration_major == null}None%{else}'${var.high_threads_count_lasting_duration_major}'%{endif}, at_least=${var.high_threads_count_at_least_percentage_major}) and (not when(signal > ${var.high_threads_count_threshold_critical}, lasting=%{if var.high_threads_count_lasting_duration_critical == null}None%{else}'${var.high_threads_count_lasting_duration_critical}'%{endif}, at_least=${var.high_threads_count_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.high_threads_count_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.high_threads_count_disabled_critical, var.high_threads_count_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.high_threads_count_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.high_threads_count_runbook_url, var.runbook_url), "")
    tip                   = var.high_threads_count_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.high_threads_count_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.high_threads_count_disabled_major, var.high_threads_count_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.high_threads_count_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.high_threads_count_runbook_url, var.runbook_url), "")
    tip                   = var.high_threads_count_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.high_threads_count_max_delay
}

