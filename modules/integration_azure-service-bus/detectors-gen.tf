resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure Service Bus heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true')
    signal = data('Size', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "deadlettered_messages" {
  name = format("%s %s", local.detector_name_prefix, "Azure Service Bus deadlettered messages count")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true')
    signal = data('DeadletteredMessages', filter=base_filtering and ${module.filtering.signalflow})${var.deadlettered_messages_aggregation_function}${var.deadlettered_messages_transformation_function}.publish('signal')
    detect(when(signal > ${var.deadlettered_messages_threshold_critical}%{if var.deadlettered_messages_lasting_duration_critical != null}, lasting='${var.deadlettered_messages_lasting_duration_critical}', at_least=${var.deadlettered_messages_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.deadlettered_messages_threshold_major}%{if var.deadlettered_messages_lasting_duration_major != null}, lasting='${var.deadlettered_messages_lasting_duration_major}', at_least=${var.deadlettered_messages_at_least_percentage_major}%{endif}) and (not when(signal > ${var.deadlettered_messages_threshold_critical}%{if var.deadlettered_messages_lasting_duration_critical != null}, lasting='${var.deadlettered_messages_lasting_duration_critical}', at_least=${var.deadlettered_messages_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.deadlettered_messages_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.deadlettered_messages_disabled_critical, var.deadlettered_messages_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.deadlettered_messages_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.deadlettered_messages_runbook_url, var.runbook_url), "")
    tip                   = var.deadlettered_messages_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.deadlettered_messages_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.deadlettered_messages_disabled_major, var.deadlettered_messages_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.deadlettered_messages_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.deadlettered_messages_runbook_url, var.runbook_url), "")
    tip                   = var.deadlettered_messages_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.deadlettered_messages_max_delay
}

resource "signalfx_detector" "user_errors" {
  name = format("%s %s", local.detector_name_prefix, "Azure Service Bus user error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true')
    A = data('UserErrors', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.user_errors_aggregation_function}${var.user_errors_transformation_function}
    B = data('IncomingRequests', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.user_errors_aggregation_function}${var.user_errors_transformation_function}
    signal = (A/B).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.user_errors_threshold_critical}%{if var.user_errors_lasting_duration_critical != null}, lasting='${var.user_errors_lasting_duration_critical}', at_least=${var.user_errors_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.user_errors_threshold_major}%{if var.user_errors_lasting_duration_major != null}, lasting='${var.user_errors_lasting_duration_major}', at_least=${var.user_errors_at_least_percentage_major}%{endif}) and (not when(signal > ${var.user_errors_threshold_critical}%{if var.user_errors_lasting_duration_critical != null}, lasting='${var.user_errors_lasting_duration_critical}', at_least=${var.user_errors_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.user_errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.user_errors_disabled_critical, var.user_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.user_errors_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.user_errors_runbook_url, var.runbook_url), "")
    tip                   = var.user_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.user_errors_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.user_errors_disabled_major, var.user_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.user_errors_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.user_errors_runbook_url, var.runbook_url), "")
    tip                   = var.user_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.user_errors_max_delay
}

resource "signalfx_detector" "server_errors" {
  name = format("%s %s", local.detector_name_prefix, "Azure Service Bus server error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true')
    A = data('ServerErrors', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.server_errors_aggregation_function}${var.server_errors_transformation_function}
    B = data('IncomingRequests', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.server_errors_aggregation_function}${var.server_errors_transformation_function}
    signal = (A/B).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.server_errors_threshold_critical}%{if var.server_errors_lasting_duration_critical != null}, lasting='${var.server_errors_lasting_duration_critical}', at_least=${var.server_errors_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.server_errors_threshold_major}%{if var.server_errors_lasting_duration_major != null}, lasting='${var.server_errors_lasting_duration_major}', at_least=${var.server_errors_at_least_percentage_major}%{endif}) and (not when(signal > ${var.server_errors_threshold_critical}%{if var.server_errors_lasting_duration_critical != null}, lasting='${var.server_errors_lasting_duration_critical}', at_least=${var.server_errors_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.server_errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.server_errors_disabled_critical, var.server_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.server_errors_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.server_errors_runbook_url, var.runbook_url), "")
    tip                   = var.server_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.server_errors_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.server_errors_disabled_major, var.server_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.server_errors_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.server_errors_runbook_url, var.runbook_url), "")
    tip                   = var.server_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.server_errors_max_delay
}

resource "signalfx_detector" "throttled_requests" {
  name = format("%s %s", local.detector_name_prefix, "Azure Service Bus throttled requests rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true')
    A = data('ThrottledRequests', filter=base_filtering and ${module.filtering.signalflow})${var.throttled_requests_aggregation_function}${var.throttled_requests_transformation_function}
    B = data('IncomingRequests', filter=base_filtering and ${module.filtering.signalflow})${var.throttled_requests_aggregation_function}${var.throttled_requests_transformation_function}
    signal = (A/B).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.throttled_requests_threshold_critical}%{if var.throttled_requests_lasting_duration_critical != null}, lasting='${var.throttled_requests_lasting_duration_critical}', at_least=${var.throttled_requests_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.throttled_requests_threshold_major}%{if var.throttled_requests_lasting_duration_major != null}, lasting='${var.throttled_requests_lasting_duration_major}', at_least=${var.throttled_requests_at_least_percentage_major}%{endif}) and (not when(signal > ${var.throttled_requests_threshold_critical}%{if var.throttled_requests_lasting_duration_critical != null}, lasting='${var.throttled_requests_lasting_duration_critical}', at_least=${var.throttled_requests_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.throttled_requests_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.throttled_requests_disabled_critical, var.throttled_requests_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.throttled_requests_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.throttled_requests_runbook_url, var.runbook_url), "")
    tip                   = var.throttled_requests_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.throttled_requests_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.throttled_requests_disabled_major, var.throttled_requests_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.throttled_requests_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.throttled_requests_runbook_url, var.runbook_url), "")
    tip                   = var.throttled_requests_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.throttled_requests_max_delay
}

resource "signalfx_detector" "active_connections" {
  name = format("%s %s", local.detector_name_prefix, "Azure Service Bus no active connections")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true')
    signal = data('ActiveConnections', filter=base_filtering and ${module.filtering.signalflow})${var.active_connections_aggregation_function}${var.active_connections_transformation_function}.publish('signal')
    detect(when(signal < ${var.active_connections_threshold_critical}%{if var.active_connections_lasting_duration_critical != null}, lasting='${var.active_connections_lasting_duration_critical}', at_least=${var.active_connections_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.active_connections_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.active_connections_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.active_connections_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.active_connections_runbook_url, var.runbook_url), "")
    tip                   = var.active_connections_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.active_connections_max_delay
}

