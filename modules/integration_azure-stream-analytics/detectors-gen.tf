resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure Stream Analytics heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('resource_type', 'Microsoft.StreamAnalytics/streamingjobs') and filter('primary_aggregation_type', 'true')
    signal = data('ResourceUtilization', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "su_utilization" {
  name = format("%s %s", local.detector_name_prefix, "Azure Stream Analytics resource utilization")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.StreamAnalytics/streamingjobs') and filter('primary_aggregation_type', 'true')
    signal = data('ResourceUtilization', filter=base_filtering and ${module.filtering.signalflow})${var.su_utilization_aggregation_function}${var.su_utilization_transformation_function}.publish('signal')
    detect(when(signal > ${var.su_utilization_threshold_critical}%{if var.su_utilization_lasting_duration_critical != null}, lasting='${var.su_utilization_lasting_duration_critical}', at_least=${var.su_utilization_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.su_utilization_threshold_major}%{if var.su_utilization_lasting_duration_major != null}, lasting='${var.su_utilization_lasting_duration_major}', at_least=${var.su_utilization_at_least_percentage_major}%{endif}) and (not when(signal > ${var.su_utilization_threshold_critical}%{if var.su_utilization_lasting_duration_critical != null}, lasting='${var.su_utilization_lasting_duration_critical}', at_least=${var.su_utilization_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.su_utilization_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.su_utilization_disabled_critical, var.su_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.su_utilization_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.su_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.su_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.su_utilization_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.su_utilization_disabled_major, var.su_utilization_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.su_utilization_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.su_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.su_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.su_utilization_max_delay
}

resource "signalfx_detector" "failed_function_requests" {
  name = format("%s %s", local.detector_name_prefix, "Azure Stream Analytics failed function requests rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.StreamAnalytics/streamingjobs') and filter('primary_aggregation_type', 'true')
    A = data('AMLCalloutFailedRequests', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.failed_function_requests_aggregation_function}${var.failed_function_requests_transformation_function}
    B = data('AMLCalloutRequests', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.failed_function_requests_aggregation_function}${var.failed_function_requests_transformation_function}
    signal = (A/B).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.failed_function_requests_threshold_critical}%{if var.failed_function_requests_lasting_duration_critical != null}, lasting='${var.failed_function_requests_lasting_duration_critical}', at_least=${var.failed_function_requests_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.failed_function_requests_threshold_major}%{if var.failed_function_requests_lasting_duration_major != null}, lasting='${var.failed_function_requests_lasting_duration_major}', at_least=${var.failed_function_requests_at_least_percentage_major}%{endif}) and (not when(signal > ${var.failed_function_requests_threshold_critical}%{if var.failed_function_requests_lasting_duration_critical != null}, lasting='${var.failed_function_requests_lasting_duration_critical}', at_least=${var.failed_function_requests_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.failed_function_requests_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.failed_function_requests_disabled_critical, var.failed_function_requests_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.failed_function_requests_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.failed_function_requests_runbook_url, var.runbook_url), "")
    tip                   = var.failed_function_requests_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.failed_function_requests_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.failed_function_requests_disabled_major, var.failed_function_requests_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.failed_function_requests_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.failed_function_requests_runbook_url, var.runbook_url), "")
    tip                   = var.failed_function_requests_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.failed_function_requests_max_delay
}

resource "signalfx_detector" "conversion_errors" {
  name = format("%s %s", local.detector_name_prefix, "Azure Stream Analytics conversion errors rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.StreamAnalytics/streamingjobs') and filter('primary_aggregation_type', 'true')
    signal = data('ConversionErrors', filter=base_filtering and ${module.filtering.signalflow})${var.conversion_errors_aggregation_function}${var.conversion_errors_transformation_function}.publish('signal')
    detect(when(signal > ${var.conversion_errors_threshold_critical}%{if var.conversion_errors_lasting_duration_critical != null}, lasting='${var.conversion_errors_lasting_duration_critical}', at_least=${var.conversion_errors_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.conversion_errors_threshold_major}%{if var.conversion_errors_lasting_duration_major != null}, lasting='${var.conversion_errors_lasting_duration_major}', at_least=${var.conversion_errors_at_least_percentage_major}%{endif}) and (not when(signal > ${var.conversion_errors_threshold_critical}%{if var.conversion_errors_lasting_duration_critical != null}, lasting='${var.conversion_errors_lasting_duration_critical}', at_least=${var.conversion_errors_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.conversion_errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.conversion_errors_disabled_critical, var.conversion_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.conversion_errors_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.conversion_errors_runbook_url, var.runbook_url), "")
    tip                   = var.conversion_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.conversion_errors_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.conversion_errors_disabled_major, var.conversion_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.conversion_errors_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.conversion_errors_runbook_url, var.runbook_url), "")
    tip                   = var.conversion_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.conversion_errors_max_delay
}

resource "signalfx_detector" "runtime_errors" {
  name = format("%s %s", local.detector_name_prefix, "Azure Stream Analytics runtime errors rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.StreamAnalytics/streamingjobs') and filter('primary_aggregation_type', 'true')
    signal = data('Errors', filter=base_filtering and ${module.filtering.signalflow})${var.runtime_errors_aggregation_function}${var.runtime_errors_transformation_function}.publish('signal')
    detect(when(signal > ${var.runtime_errors_threshold_critical}%{if var.runtime_errors_lasting_duration_critical != null}, lasting='${var.runtime_errors_lasting_duration_critical}', at_least=${var.runtime_errors_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.runtime_errors_threshold_major}%{if var.runtime_errors_lasting_duration_major != null}, lasting='${var.runtime_errors_lasting_duration_major}', at_least=${var.runtime_errors_at_least_percentage_major}%{endif}) and (not when(signal > ${var.runtime_errors_threshold_critical}%{if var.runtime_errors_lasting_duration_critical != null}, lasting='${var.runtime_errors_lasting_duration_critical}', at_least=${var.runtime_errors_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.runtime_errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.runtime_errors_disabled_critical, var.runtime_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.runtime_errors_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.runtime_errors_runbook_url, var.runbook_url), "")
    tip                   = var.runtime_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.runtime_errors_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.runtime_errors_disabled_major, var.runtime_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.runtime_errors_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.runtime_errors_runbook_url, var.runbook_url), "")
    tip                   = var.runtime_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.runtime_errors_max_delay
}

