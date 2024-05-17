resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Haproxy heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('haproxy_session_current', filter=%{if var.heartbeat_exclude_not_running_vm}${local.not_running_vm_filters} and %{endif}${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "server_status" {
  name = format("%s %s", local.detector_name_prefix, "Haproxy server status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('type', '2')
    signal = data('haproxy_status', filter=base_filtering and ${module.filtering.signalflow})${var.server_status_aggregation_function}${var.server_status_transformation_function}.publish('signal')
    detect(when(signal < ${var.server_status_threshold_critical}%{if var.server_status_lasting_duration_critical != null}, lasting='${var.server_status_lasting_duration_critical}', at_least=${var.server_status_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.server_status_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.server_status_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.server_status_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.server_status_runbook_url, var.runbook_url), "")
    tip                   = var.server_status_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.server_status_max_delay
}

resource "signalfx_detector" "backend_status" {
  name = format("%s %s", local.detector_name_prefix, "Haproxy backend status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('type', '1')
    signal = data('haproxy_status', filter=base_filtering and ${module.filtering.signalflow})${var.backend_status_aggregation_function}${var.backend_status_transformation_function}.publish('signal')
    detect(when(signal < ${var.backend_status_threshold_critical}%{if var.backend_status_lasting_duration_critical != null}, lasting='${var.backend_status_lasting_duration_critical}', at_least=${var.backend_status_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.backend_status_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_status_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backend_status_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.backend_status_runbook_url, var.runbook_url), "")
    tip                   = var.backend_status_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.backend_status_max_delay
}

resource "signalfx_detector" "session_limit" {
  name = format("%s %s", local.detector_name_prefix, "Haproxy session")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('haproxy_session_current', filter=filter('type', '0', '2') and ${module.filtering.signalflow})${var.session_limit_aggregation_function}${var.session_limit_transformation_function}
    B = data('haproxy_session_limit', filter=${module.filtering.signalflow})${var.session_limit_aggregation_function}${var.session_limit_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.session_limit_threshold_critical}%{if var.session_limit_lasting_duration_critical != null}, lasting='${var.session_limit_lasting_duration_critical}', at_least=${var.session_limit_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.session_limit_threshold_major}%{if var.session_limit_lasting_duration_major != null}, lasting='${var.session_limit_lasting_duration_major}', at_least=${var.session_limit_at_least_percentage_major}%{endif}) and (not when(signal > ${var.session_limit_threshold_critical}%{if var.session_limit_lasting_duration_critical != null}, lasting='${var.session_limit_lasting_duration_critical}', at_least=${var.session_limit_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.session_limit_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.session_limit_disabled_critical, var.session_limit_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.session_limit_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.session_limit_runbook_url, var.runbook_url), "")
    tip                   = var.session_limit_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.session_limit_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.session_limit_disabled_major, var.session_limit_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.session_limit_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.session_limit_runbook_url, var.runbook_url), "")
    tip                   = var.session_limit_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.session_limit_max_delay
}

resource "signalfx_detector" "http_5xx_response" {
  name = format("%s %s", local.detector_name_prefix, "Haproxy 5xx response rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('haproxy_response_5xx', filter=${module.filtering.signalflow}, rollup='delta')${var.http_5xx_response_aggregation_function}${var.http_5xx_response_transformation_function}
    B = data('haproxy_request_total', filter=${module.filtering.signalflow}, rollup='delta')${var.http_5xx_response_aggregation_function}${var.http_5xx_response_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.http_5xx_response_threshold_critical}%{if var.http_5xx_response_lasting_duration_critical != null}, lasting='${var.http_5xx_response_lasting_duration_critical}', at_least=${var.http_5xx_response_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.http_5xx_response_threshold_major}%{if var.http_5xx_response_lasting_duration_major != null}, lasting='${var.http_5xx_response_lasting_duration_major}', at_least=${var.http_5xx_response_at_least_percentage_major}%{endif}) and (not when(signal > ${var.http_5xx_response_threshold_critical}%{if var.http_5xx_response_lasting_duration_critical != null}, lasting='${var.http_5xx_response_lasting_duration_critical}', at_least=${var.http_5xx_response_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.http_5xx_response_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_5xx_response_disabled_critical, var.http_5xx_response_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_5xx_response_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.http_5xx_response_runbook_url, var.runbook_url), "")
    tip                   = var.http_5xx_response_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.http_5xx_response_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_5xx_response_disabled_major, var.http_5xx_response_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_5xx_response_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.http_5xx_response_runbook_url, var.runbook_url), "")
    tip                   = var.http_5xx_response_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.http_5xx_response_max_delay
}

resource "signalfx_detector" "http_4xx_response" {
  name = format("%s %s", local.detector_name_prefix, "Haproxy 4xx response rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('haproxy_response_4xx', filter=${module.filtering.signalflow}, rollup='delta')${var.http_4xx_response_aggregation_function}${var.http_4xx_response_transformation_function}
    B = data('haproxy_request_total', filter=${module.filtering.signalflow}, rollup='delta')${var.http_4xx_response_aggregation_function}${var.http_4xx_response_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.http_4xx_response_threshold_critical}%{if var.http_4xx_response_lasting_duration_critical != null}, lasting='${var.http_4xx_response_lasting_duration_critical}', at_least=${var.http_4xx_response_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.http_4xx_response_threshold_major}%{if var.http_4xx_response_lasting_duration_major != null}, lasting='${var.http_4xx_response_lasting_duration_major}', at_least=${var.http_4xx_response_at_least_percentage_major}%{endif}) and (not when(signal > ${var.http_4xx_response_threshold_critical}%{if var.http_4xx_response_lasting_duration_critical != null}, lasting='${var.http_4xx_response_lasting_duration_critical}', at_least=${var.http_4xx_response_at_least_percentage_critical}%{endif}))).publish('MAJOR')
    detect(when(signal > ${var.http_4xx_response_threshold_minor}%{if var.http_4xx_response_lasting_duration_minor != null}, lasting='${var.http_4xx_response_lasting_duration_minor}', at_least=${var.http_4xx_response_at_least_percentage_minor}%{endif}) and (not when(signal > ${var.http_4xx_response_threshold_major}%{if var.http_4xx_response_lasting_duration_major != null}, lasting='${var.http_4xx_response_lasting_duration_major}', at_least=${var.http_4xx_response_at_least_percentage_major}%{endif}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.http_4xx_response_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_4xx_response_disabled_critical, var.http_4xx_response_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_4xx_response_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.http_4xx_response_runbook_url, var.runbook_url), "")
    tip                   = var.http_4xx_response_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.http_4xx_response_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_4xx_response_disabled_major, var.http_4xx_response_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_4xx_response_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.http_4xx_response_runbook_url, var.runbook_url), "")
    tip                   = var.http_4xx_response_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.http_4xx_response_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.http_4xx_response_disabled_minor, var.http_4xx_response_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_4xx_response_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.http_4xx_response_runbook_url, var.runbook_url), "")
    tip                   = var.http_4xx_response_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.http_4xx_response_max_delay
}

