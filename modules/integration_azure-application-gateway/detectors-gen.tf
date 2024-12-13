resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
    signal = data('Throughput', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "compute_units" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway compute units")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
    signal = data('ComputeUnits', filter=base_filtering and ${module.filtering.signalflow})${var.compute_units_aggregation_function}${var.compute_units_transformation_function}.publish('signal')
    detect(when(signal > ${var.compute_units_threshold_major}%{if var.compute_units_lasting_duration_major != null}, lasting='${var.compute_units_lasting_duration_major}', at_least=${var.compute_units_at_least_percentage_major}%{endif})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.compute_units_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.compute_units_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.compute_units_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.compute_units_runbook_url, var.runbook_url), "")
    tip                   = var.compute_units_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.compute_units_max_delay
}

resource "signalfx_detector" "total_requests" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway has no request")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
    signal = data('TotalRequests', filter=base_filtering and ${module.filtering.signalflow})${var.total_requests_aggregation_function}${var.total_requests_transformation_function}.publish('signal')
    detect(when(signal < ${var.total_requests_threshold_critical}%{if var.total_requests_lasting_duration_critical != null}, lasting='${var.total_requests_lasting_duration_critical}', at_least=${var.total_requests_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.total_requests_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.total_requests_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.total_requests_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.total_requests_runbook_url, var.runbook_url), "")
    tip                   = var.total_requests_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.total_requests_max_delay
}

resource "signalfx_detector" "backend_connect_time" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway backend connect time")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
    signal = data('BackendConnectTime', filter=base_filtering and ${module.filtering.signalflow})${var.backend_connect_time_aggregation_function}${var.backend_connect_time_transformation_function}.publish('signal')
    detect(when(signal > ${var.backend_connect_time_threshold_critical}%{if var.backend_connect_time_lasting_duration_critical != null}, lasting='${var.backend_connect_time_lasting_duration_critical}', at_least=${var.backend_connect_time_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.backend_connect_time_threshold_major}%{if var.backend_connect_time_lasting_duration_major != null}, lasting='${var.backend_connect_time_lasting_duration_major}', at_least=${var.backend_connect_time_at_least_percentage_major}%{endif}) and (not when(signal > ${var.backend_connect_time_threshold_critical}%{if var.backend_connect_time_lasting_duration_critical != null}, lasting='${var.backend_connect_time_lasting_duration_critical}', at_least=${var.backend_connect_time_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.backend_connect_time_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_connect_time_disabled_critical, var.backend_connect_time_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backend_connect_time_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.backend_connect_time_runbook_url, var.runbook_url), "")
    tip                   = var.backend_connect_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.backend_connect_time_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.backend_connect_time_disabled_major, var.backend_connect_time_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backend_connect_time_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.backend_connect_time_runbook_url, var.runbook_url), "")
    tip                   = var.backend_connect_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.backend_connect_time_max_delay
}

resource "signalfx_detector" "failed_requests" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway failed request rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
    error_stream = data('FailedRequests', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.failed_requests_aggregation_function}${var.failed_requests_transformation_function}
    count_stream = data('TotalRequests', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.failed_requests_aggregation_function}${var.failed_requests_transformation_function}
    signal = (error_stream / count_stream).fill(value=0).scale(100).publish('signal')
    detect(when(signal > ${var.failed_requests_threshold_critical}%{if var.failed_requests_lasting_duration_critical != null}, lasting='${var.failed_requests_lasting_duration_critical}', at_least=${var.failed_requests_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.failed_requests_threshold_major}%{if var.failed_requests_lasting_duration_major != null}, lasting='${var.failed_requests_lasting_duration_major}', at_least=${var.failed_requests_at_least_percentage_major}%{endif}) and (not when(signal > ${var.failed_requests_threshold_critical}%{if var.failed_requests_lasting_duration_critical != null}, lasting='${var.failed_requests_lasting_duration_critical}', at_least=${var.failed_requests_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.failed_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.failed_requests_disabled_critical, var.failed_requests_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.failed_requests_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.failed_requests_runbook_url, var.runbook_url), "")
    tip                   = var.failed_requests_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.failed_requests_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.failed_requests_disabled_major, var.failed_requests_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.failed_requests_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.failed_requests_runbook_url, var.runbook_url), "")
    tip                   = var.failed_requests_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.failed_requests_max_delay
}

resource "signalfx_detector" "unhealthy_host_ratio" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway backend unhealthy host ratio")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
    error_stream = data('UnhealthyHostCount', filter=base_filtering and ${module.filtering.signalflow})${var.unhealthy_host_ratio_aggregation_function}${var.unhealthy_host_ratio_transformation_function}
    ok_stream = data('HealthyHostCount', filter=base_filtering and ${module.filtering.signalflow})${var.unhealthy_host_ratio_aggregation_function}${var.unhealthy_host_ratio_transformation_function}
    signal = (error_stream / (ok_stream + error_stream)).scale(100).publish('signal')
    detect(when(signal >= ${var.unhealthy_host_ratio_threshold_critical}%{if var.unhealthy_host_ratio_lasting_duration_critical != null}, lasting='${var.unhealthy_host_ratio_lasting_duration_critical}', at_least=${var.unhealthy_host_ratio_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal >= ${var.unhealthy_host_ratio_threshold_major}%{if var.unhealthy_host_ratio_lasting_duration_major != null}, lasting='${var.unhealthy_host_ratio_lasting_duration_major}', at_least=${var.unhealthy_host_ratio_at_least_percentage_major}%{endif}) and (not when(signal >= ${var.unhealthy_host_ratio_threshold_critical}%{if var.unhealthy_host_ratio_lasting_duration_critical != null}, lasting='${var.unhealthy_host_ratio_lasting_duration_critical}', at_least=${var.unhealthy_host_ratio_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.unhealthy_host_ratio_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.unhealthy_host_ratio_disabled_critical, var.unhealthy_host_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.unhealthy_host_ratio_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.unhealthy_host_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.unhealthy_host_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high >= ${var.unhealthy_host_ratio_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.unhealthy_host_ratio_disabled_major, var.unhealthy_host_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.unhealthy_host_ratio_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.unhealthy_host_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.unhealthy_host_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.unhealthy_host_ratio_max_delay
}

resource "signalfx_detector" "http_4xx_errors" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway 4xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
    error_stream = data('ResponseStatus', filter=base_filtering and filter('httpstatusgroup', '4xx') and ${module.filtering.signalflow}, extrapolation='zero')${var.http_4xx_errors_aggregation_function}${var.http_4xx_errors_transformation_function}
    count_stream = data('ResponseStatus', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.http_4xx_errors_aggregation_function}${var.http_4xx_errors_transformation_function}
    signal = (error_stream / count_stream).fill(value=0).scale(100).publish('signal')
    detect(when(signal > ${var.http_4xx_errors_threshold_critical}%{if var.http_4xx_errors_lasting_duration_critical != null}, lasting='${var.http_4xx_errors_lasting_duration_critical}', at_least=${var.http_4xx_errors_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.http_4xx_errors_threshold_major}%{if var.http_4xx_errors_lasting_duration_major != null}, lasting='${var.http_4xx_errors_lasting_duration_major}', at_least=${var.http_4xx_errors_at_least_percentage_major}%{endif}) and (not when(signal > ${var.http_4xx_errors_threshold_critical}%{if var.http_4xx_errors_lasting_duration_critical != null}, lasting='${var.http_4xx_errors_lasting_duration_critical}', at_least=${var.http_4xx_errors_at_least_percentage_critical}%{endif}))).publish('MAJOR')
    detect(when(signal > ${var.http_4xx_errors_threshold_minor}%{if var.http_4xx_errors_lasting_duration_minor != null}, lasting='${var.http_4xx_errors_lasting_duration_minor}', at_least=${var.http_4xx_errors_at_least_percentage_minor}%{endif}) and (not when(signal > ${var.http_4xx_errors_threshold_major}%{if var.http_4xx_errors_lasting_duration_major != null}, lasting='${var.http_4xx_errors_lasting_duration_major}', at_least=${var.http_4xx_errors_at_least_percentage_major}%{endif}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.http_4xx_errors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_4xx_errors_disabled_critical, var.http_4xx_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_4xx_errors_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.http_4xx_errors_runbook_url, var.runbook_url), "")
    tip                   = var.http_4xx_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.http_4xx_errors_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_4xx_errors_disabled_major, var.http_4xx_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_4xx_errors_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.http_4xx_errors_runbook_url, var.runbook_url), "")
    tip                   = var.http_4xx_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.http_4xx_errors_threshold_minor}%"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.http_4xx_errors_disabled_minor, var.http_4xx_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_4xx_errors_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.http_4xx_errors_runbook_url, var.runbook_url), "")
    tip                   = var.http_4xx_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.http_4xx_errors_max_delay
}

resource "signalfx_detector" "http_5xx_errors" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway 5xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
    error_stream = data('ResponseStatus', filter=base_filtering and filter('httpstatusgroup', '5xx') and ${module.filtering.signalflow}, extrapolation='zero')${var.http_5xx_errors_aggregation_function}${var.http_5xx_errors_transformation_function}
    count_stream = data('ResponseStatus', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.http_5xx_errors_aggregation_function}${var.http_5xx_errors_transformation_function}
    signal = (error_stream / count_stream).fill(value=0).scale(100).publish('signal')
    detect(when(signal > ${var.http_5xx_errors_threshold_critical}%{if var.http_5xx_errors_lasting_duration_critical != null}, lasting='${var.http_5xx_errors_lasting_duration_critical}', at_least=${var.http_5xx_errors_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.http_5xx_errors_threshold_major}%{if var.http_5xx_errors_lasting_duration_major != null}, lasting='${var.http_5xx_errors_lasting_duration_major}', at_least=${var.http_5xx_errors_at_least_percentage_major}%{endif}) and (not when(signal > ${var.http_5xx_errors_threshold_critical}%{if var.http_5xx_errors_lasting_duration_critical != null}, lasting='${var.http_5xx_errors_lasting_duration_critical}', at_least=${var.http_5xx_errors_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.http_5xx_errors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_5xx_errors_disabled_critical, var.http_5xx_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_5xx_errors_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.http_5xx_errors_runbook_url, var.runbook_url), "")
    tip                   = var.http_5xx_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.http_5xx_errors_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_5xx_errors_disabled_major, var.http_5xx_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_5xx_errors_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.http_5xx_errors_runbook_url, var.runbook_url), "")
    tip                   = var.http_5xx_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.http_5xx_errors_max_delay
}

resource "signalfx_detector" "backend_http_4xx_errors" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway backend 4xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
    error_stream = data('BackendResponseStatus', filter=base_filtering and filter('httpstatusgroup', '4xx') and ${module.filtering.signalflow}, extrapolation='zero')${var.backend_http_4xx_errors_aggregation_function}${var.backend_http_4xx_errors_transformation_function}
    count_stream = data('BackendResponseStatus', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.backend_http_4xx_errors_aggregation_function}${var.backend_http_4xx_errors_transformation_function}
    signal = (error_stream / count_stream).fill(value=0).scale(100).publish('signal')
    detect(when(signal > ${var.backend_http_4xx_errors_threshold_critical}%{if var.backend_http_4xx_errors_lasting_duration_critical != null}, lasting='${var.backend_http_4xx_errors_lasting_duration_critical}', at_least=${var.backend_http_4xx_errors_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.backend_http_4xx_errors_threshold_major}%{if var.backend_http_4xx_errors_lasting_duration_major != null}, lasting='${var.backend_http_4xx_errors_lasting_duration_major}', at_least=${var.backend_http_4xx_errors_at_least_percentage_major}%{endif}) and (not when(signal > ${var.backend_http_4xx_errors_threshold_critical}%{if var.backend_http_4xx_errors_lasting_duration_critical != null}, lasting='${var.backend_http_4xx_errors_lasting_duration_critical}', at_least=${var.backend_http_4xx_errors_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.backend_http_4xx_errors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_http_4xx_errors_disabled_critical, var.backend_http_4xx_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backend_http_4xx_errors_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.backend_http_4xx_errors_runbook_url, var.runbook_url), "")
    tip                   = var.backend_http_4xx_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.backend_http_4xx_errors_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.backend_http_4xx_errors_disabled_major, var.backend_http_4xx_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backend_http_4xx_errors_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.backend_http_4xx_errors_runbook_url, var.runbook_url), "")
    tip                   = var.backend_http_4xx_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.backend_http_4xx_errors_max_delay
}

resource "signalfx_detector" "backend_http_5xx_errors" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway backend 5xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
    error_stream = data('BackendResponseStatus', filter=base_filtering and filter('httpstatusgroup', '5xx') and ${module.filtering.signalflow}, extrapolation='zero')${var.backend_http_5xx_errors_aggregation_function}${var.backend_http_5xx_errors_transformation_function}
    count_stream = data('BackendResponseStatus', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.backend_http_5xx_errors_aggregation_function}${var.backend_http_5xx_errors_transformation_function}
    signal = (error_stream / count_stream).fill(value=0).scale(100).publish('signal')
    detect(when(signal > ${var.backend_http_5xx_errors_threshold_critical}%{if var.backend_http_5xx_errors_lasting_duration_critical != null}, lasting='${var.backend_http_5xx_errors_lasting_duration_critical}', at_least=${var.backend_http_5xx_errors_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.backend_http_5xx_errors_threshold_major}%{if var.backend_http_5xx_errors_lasting_duration_major != null}, lasting='${var.backend_http_5xx_errors_lasting_duration_major}', at_least=${var.backend_http_5xx_errors_at_least_percentage_major}%{endif}) and (not when(signal > ${var.backend_http_5xx_errors_threshold_critical}%{if var.backend_http_5xx_errors_lasting_duration_critical != null}, lasting='${var.backend_http_5xx_errors_lasting_duration_critical}', at_least=${var.backend_http_5xx_errors_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.backend_http_5xx_errors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_http_5xx_errors_disabled_critical, var.backend_http_5xx_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backend_http_5xx_errors_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.backend_http_5xx_errors_runbook_url, var.runbook_url), "")
    tip                   = var.backend_http_5xx_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.backend_http_5xx_errors_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.backend_http_5xx_errors_disabled_major, var.backend_http_5xx_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backend_http_5xx_errors_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.backend_http_5xx_errors_runbook_url, var.runbook_url), "")
    tip                   = var.backend_http_5xx_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.backend_http_5xx_errors_max_delay
}

