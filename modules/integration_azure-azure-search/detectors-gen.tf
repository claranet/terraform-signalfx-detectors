resource "signalfx_detector" "latency" {
  name = format("%s %s", local.detector_name_prefix, "Azure Search latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "ms"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Search/searchServices') and filter('primary_aggregation_type', 'true')
    signal = data('SearchLatency', filter=base_filtering and ${module.filtering.signalflow})${var.latency_aggregation_function}${var.latency_transformation_function}.publish('signal')
    detect(when(signal > ${var.latency_threshold_critical}%{if var.latency_lasting_duration_critical != null}, lasting='${var.latency_lasting_duration_critical}', at_least=${var.latency_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.latency_threshold_major}%{if var.latency_lasting_duration_major != null}, lasting='${var.latency_lasting_duration_major}', at_least=${var.latency_at_least_percentage_major}%{endif}) and (not when(signal > ${var.latency_threshold_critical}%{if var.latency_lasting_duration_critical != null}, lasting='${var.latency_lasting_duration_critical}', at_least=${var.latency_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.latency_threshold_critical}ms"
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
    description           = "is too high > ${var.latency_threshold_major}ms"
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

resource "signalfx_detector" "throttled_queries_rate" {
  name = format("%s %s", local.detector_name_prefix, "Azure Search throttled queries rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Search/searchServices') and filter('primary_aggregation_type', 'true')
    signal = data('ThrottledSearchQueriesPercentage', filter=base_filtering and ${module.filtering.signalflow})${var.throttled_queries_rate_aggregation_function}${var.throttled_queries_rate_transformation_function}.publish('signal')
    detect(when(signal > ${var.throttled_queries_rate_threshold_critical}%{if var.throttled_queries_rate_lasting_duration_critical != null}, lasting='${var.throttled_queries_rate_lasting_duration_critical}', at_least=${var.throttled_queries_rate_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.throttled_queries_rate_threshold_major}%{if var.throttled_queries_rate_lasting_duration_major != null}, lasting='${var.throttled_queries_rate_lasting_duration_major}', at_least=${var.throttled_queries_rate_at_least_percentage_major}%{endif}) and (not when(signal > ${var.throttled_queries_rate_threshold_critical}%{if var.throttled_queries_rate_lasting_duration_critical != null}, lasting='${var.throttled_queries_rate_lasting_duration_critical}', at_least=${var.throttled_queries_rate_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.throttled_queries_rate_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.throttled_queries_rate_disabled_critical, var.throttled_queries_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.throttled_queries_rate_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.throttled_queries_rate_runbook_url, var.runbook_url), "")
    tip                   = var.throttled_queries_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.throttled_queries_rate_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.throttled_queries_rate_disabled_major, var.throttled_queries_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.throttled_queries_rate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.throttled_queries_rate_runbook_url, var.runbook_url), "")
    tip                   = var.throttled_queries_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.throttled_queries_rate_max_delay
}

