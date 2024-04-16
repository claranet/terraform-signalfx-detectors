resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure API Management Service heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true')
    signal = data('NetworkConnectivity', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "capacity" {
  name = format("%s %s", local.detector_name_prefix, "Azure API Management Service capacity")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true')
    signal = data('Capacity', filter=base_filtering and ${module.filtering.signalflow})${var.capacity_aggregation_function}${var.capacity_transformation_function}.publish('signal')
    detect(when(signal > ${var.capacity_threshold_critical}%{if var.capacity_lasting_duration_critical != null}, lasting='${var.capacity_lasting_duration_critical}', at_least=${var.capacity_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.capacity_threshold_major}%{if var.capacity_lasting_duration_major != null}, lasting='${var.capacity_lasting_duration_major}', at_least=${var.capacity_at_least_percentage_major}%{endif}) and (not when(signal > ${var.capacity_threshold_critical}%{if var.capacity_lasting_duration_critical != null}, lasting='${var.capacity_lasting_duration_critical}', at_least=${var.capacity_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.capacity_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.capacity_disabled_critical, var.capacity_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.capacity_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.capacity_runbook_url, var.runbook_url), "")
    tip                   = var.capacity_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.capacity_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.capacity_disabled_major, var.capacity_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.capacity_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.capacity_runbook_url, var.runbook_url), "")
    tip                   = var.capacity_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.capacity_max_delay
}

resource "signalfx_detector" "duration_of_gateway_request" {
  name = format("%s %s", local.detector_name_prefix, "Azure API Management Service duration of gateway request")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "s"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true')
    signal = data('Duration', filter=base_filtering and ${module.filtering.signalflow})${var.duration_of_gateway_request_aggregation_function}${var.duration_of_gateway_request_transformation_function}.publish('signal')
    detect(when(signal > ${var.duration_of_gateway_request_threshold_critical}%{if var.duration_of_gateway_request_lasting_duration_critical != null}, lasting='${var.duration_of_gateway_request_lasting_duration_critical}', at_least=${var.duration_of_gateway_request_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.duration_of_gateway_request_threshold_major}%{if var.duration_of_gateway_request_lasting_duration_major != null}, lasting='${var.duration_of_gateway_request_lasting_duration_major}', at_least=${var.duration_of_gateway_request_at_least_percentage_major}%{endif}) and (not when(signal > ${var.duration_of_gateway_request_threshold_critical}%{if var.duration_of_gateway_request_lasting_duration_critical != null}, lasting='${var.duration_of_gateway_request_lasting_duration_critical}', at_least=${var.duration_of_gateway_request_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.duration_of_gateway_request_threshold_critical}s"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.duration_of_gateway_request_disabled_critical, var.duration_of_gateway_request_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.duration_of_gateway_request_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.duration_of_gateway_request_runbook_url, var.runbook_url), "")
    tip                   = var.duration_of_gateway_request_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.duration_of_gateway_request_threshold_major}s"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.duration_of_gateway_request_disabled_major, var.duration_of_gateway_request_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.duration_of_gateway_request_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.duration_of_gateway_request_runbook_url, var.runbook_url), "")
    tip                   = var.duration_of_gateway_request_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.duration_of_gateway_request_max_delay
}

resource "signalfx_detector" "duration_of_backend_request" {
  name = format("%s %s", local.detector_name_prefix, "Azure API Management Service duration of backend request")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "s"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.ApiManagement/service') and filter('primary_aggregation_type', 'true')
    signal = data('BackendDuration', filter=base_filtering and ${module.filtering.signalflow})${var.duration_of_backend_request_aggregation_function}${var.duration_of_backend_request_transformation_function}.publish('signal')
    detect(when(signal > ${var.duration_of_backend_request_threshold_critical}%{if var.duration_of_backend_request_lasting_duration_critical != null}, lasting='${var.duration_of_backend_request_lasting_duration_critical}', at_least=${var.duration_of_backend_request_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.duration_of_backend_request_threshold_major}%{if var.duration_of_backend_request_lasting_duration_major != null}, lasting='${var.duration_of_backend_request_lasting_duration_major}', at_least=${var.duration_of_backend_request_at_least_percentage_major}%{endif}) and (not when(signal > ${var.duration_of_backend_request_threshold_critical}%{if var.duration_of_backend_request_lasting_duration_critical != null}, lasting='${var.duration_of_backend_request_lasting_duration_critical}', at_least=${var.duration_of_backend_request_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.duration_of_backend_request_threshold_critical}s"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.duration_of_backend_request_disabled_critical, var.duration_of_backend_request_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.duration_of_backend_request_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.duration_of_backend_request_runbook_url, var.runbook_url), "")
    tip                   = var.duration_of_backend_request_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.duration_of_backend_request_threshold_major}s"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.duration_of_backend_request_disabled_major, var.duration_of_backend_request_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.duration_of_backend_request_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.duration_of_backend_request_runbook_url, var.runbook_url), "")
    tip                   = var.duration_of_backend_request_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.duration_of_backend_request_max_delay
}

