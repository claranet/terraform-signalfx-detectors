resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "DNS heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('dns.result_code', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "dns_query_time" {
  name = format("%s %s", local.detector_name_prefix, "DNS query time")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'telegraf/dns')
    signal = data('dns.query_time_ms', filter=base_filtering and ${module.filtering.signalflow})${var.dns_query_time_aggregation_function}${var.dns_query_time_transformation_function}.publish('signal')
    detect(when(signal > ${var.dns_query_time_threshold_critical}%{if var.dns_query_time_lasting_duration_critical != null}, lasting='${var.dns_query_time_lasting_duration_critical}', at_least=${var.dns_query_time_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.dns_query_time_threshold_major}%{if var.dns_query_time_lasting_duration_major != null}, lasting='${var.dns_query_time_lasting_duration_major}', at_least=${var.dns_query_time_at_least_percentage_major}%{endif}) and (not when(signal > ${var.dns_query_time_threshold_critical}%{if var.dns_query_time_lasting_duration_critical != null}, lasting='${var.dns_query_time_lasting_duration_critical}', at_least=${var.dns_query_time_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.dns_query_time_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.dns_query_time_disabled_critical, var.dns_query_time_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.dns_query_time_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.dns_query_time_runbook_url, var.runbook_url), "")
    tip                   = var.dns_query_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.dns_query_time_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.dns_query_time_disabled_major, var.dns_query_time_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.dns_query_time_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.dns_query_time_runbook_url, var.runbook_url), "")
    tip                   = var.dns_query_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.dns_query_time_max_delay
}

resource "signalfx_detector" "dns_result_code" {
  name = format("%s %s", local.detector_name_prefix, "DNS query result")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'telegraf/dns')
    signal = data('dns.result_code', filter=base_filtering and ${module.filtering.signalflow})${var.dns_result_code_aggregation_function}${var.dns_result_code_transformation_function}.publish('signal')
    detect(when(signal > ${var.dns_result_code_threshold_critical}%{if var.dns_result_code_lasting_duration_critical != null}, lasting='${var.dns_result_code_lasting_duration_critical}', at_least=${var.dns_result_code_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.dns_result_code_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.dns_result_code_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.dns_result_code_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.dns_result_code_runbook_url, var.runbook_url), "")
    tip                   = var.dns_result_code_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.dns_result_code_max_delay
}

