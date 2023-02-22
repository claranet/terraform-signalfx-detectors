resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure FrontDoor v2 heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    A = data('fame.azure.frontdoor.probe_response_status', filter=${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}
    signal = (A.sum().fill(0)).publish('signal')
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

resource "signalfx_detector" "http_errors" {
  name = format("%s %s", local.detector_name_prefix, "Azure FrontDoor v2 http errors")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('fame.azure.frontdoor.response_status', filter=filter('http_status_code', '5**') or filter('http_status_code', '4**') and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.http_errors_aggregation_function}${var.http_errors_transformation_function}
    B = data('fame.azure.frontdoor.response_status', filter=${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.http_errors_aggregation_function}${var.http_errors_transformation_function}
    signal = (A.sum()/B.sum()).scale(100).fill(0).publish('signal')
    detect(when(signal >= ${var.http_errors_threshold_critical}, lasting=%{if var.http_errors_lasting_duration_critical == null}None%{else}'${var.http_errors_lasting_duration_critical}'%{endif}, at_least=${var.http_errors_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal >= ${var.http_errors_threshold_major}, lasting=%{if var.http_errors_lasting_duration_major == null}None%{else}'${var.http_errors_lasting_duration_major}'%{endif}, at_least=${var.http_errors_at_least_percentage_major}) and (not when(signal >= ${var.http_errors_threshold_critical}, lasting=%{if var.http_errors_lasting_duration_critical == null}None%{else}'${var.http_errors_lasting_duration_critical}'%{endif}, at_least=${var.http_errors_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.http_errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_errors_disabled_critical, var.http_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_errors_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.http_errors_runbook_url, var.runbook_url), "")
    tip                   = var.http_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high >= ${var.http_errors_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_errors_disabled_major, var.http_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.http_errors_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.http_errors_runbook_url, var.runbook_url), "")
    tip                   = var.http_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.http_errors_max_delay
}

resource "signalfx_detector" "probes_errors" {
  name = format("%s %s", local.detector_name_prefix, "Azure FrontDoor v2 probes errors")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('fame.azure.frontdoor.probe_response_status', filter=filter('http_status_code', '5**') or filter('http_status_code', '404') or filter('result', 'OriginTimeout') or filter('result', 'DNSNameNotResolved') and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.probes_errors_aggregation_function}${var.probes_errors_transformation_function}
    B = data('fame.azure.frontdoor.probe_response_status', filter=${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.probes_errors_aggregation_function}${var.probes_errors_transformation_function}
    signal = (A.sum()/B.sum()).scale(100).fill(0).publish('signal')
    detect(when(signal >= ${var.probes_errors_threshold_critical}, lasting=%{if var.probes_errors_lasting_duration_critical == null}None%{else}'${var.probes_errors_lasting_duration_critical}'%{endif}, at_least=${var.probes_errors_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal >= ${var.probes_errors_threshold_major}, lasting=%{if var.probes_errors_lasting_duration_major == null}None%{else}'${var.probes_errors_lasting_duration_major}'%{endif}, at_least=${var.probes_errors_at_least_percentage_major}) and (not when(signal >= ${var.probes_errors_threshold_critical}, lasting=%{if var.probes_errors_lasting_duration_critical == null}None%{else}'${var.probes_errors_lasting_duration_critical}'%{endif}, at_least=${var.probes_errors_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.probes_errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.probes_errors_disabled_critical, var.probes_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.probes_errors_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.probes_errors_runbook_url, var.runbook_url), "")
    tip                   = var.probes_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high >= ${var.probes_errors_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.probes_errors_disabled_major, var.probes_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.probes_errors_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.probes_errors_runbook_url, var.runbook_url), "")
    tip                   = var.probes_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.probes_errors_max_delay
}

resource "signalfx_detector" "cache_hit_rate" {
  name = format("%s %s", local.detector_name_prefix, "Azure FrontDoor v2 cache hit rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('fame.azure.frontdoor.cache_hit_rate', filter=${module.filtering.signalflow}, extrapolation='last_value')${var.cache_hit_rate_aggregation_function}${var.cache_hit_rate_transformation_function}
    signal = A.fill(0).mean(by="endpoint").publish('signal')
    detect(when(signal <= ${var.cache_hit_rate_threshold_warning}, lasting=%{if var.cache_hit_rate_lasting_duration_warning == null}None%{else}'${var.cache_hit_rate_lasting_duration_warning}'%{endif}, at_least=${var.cache_hit_rate_at_least_percentage_warning})).publish('WARN')
EOF

  rule {
    description           = "is too low <= ${var.cache_hit_rate_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.cache_hit_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cache_hit_rate_notifications, "warning", []), var.notifications.warning), null)
    runbook_url           = try(coalesce(var.cache_hit_rate_runbook_url, var.runbook_url), "")
    tip                   = var.cache_hit_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cache_hit_rate_max_delay
}

