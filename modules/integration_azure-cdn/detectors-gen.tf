resource "signalfx_detector" "cdn_total_latency" {
  name = format("%s %s", local.detector_name_prefix, "Azure CDN latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "ms"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Cdn/profiles') and filter('primary_aggregation_type', 'true')
    signal = data('TotalLatency', filter=base_filtering and ${module.filtering.signalflow})${var.cdn_total_latency_aggregation_function}${var.cdn_total_latency_transformation_function}.publish('signal')
    detect(when(signal > ${var.cdn_total_latency_threshold_critical}, lasting=%{if var.cdn_total_latency_lasting_duration_critical == null}None%{else}'${var.cdn_total_latency_lasting_duration_critical}'%{endif}, at_least=${var.cdn_total_latency_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.cdn_total_latency_threshold_major}, lasting=%{if var.cdn_total_latency_lasting_duration_major == null}None%{else}'${var.cdn_total_latency_lasting_duration_major}'%{endif}, at_least=${var.cdn_total_latency_at_least_percentage_major}) and (not when(signal > ${var.cdn_total_latency_threshold_critical}, lasting=%{if var.cdn_total_latency_lasting_duration_critical == null}None%{else}'${var.cdn_total_latency_lasting_duration_critical}'%{endif}, at_least=${var.cdn_total_latency_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cdn_total_latency_threshold_critical}ms"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cdn_total_latency_disabled_critical, var.cdn_total_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cdn_total_latency_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cdn_total_latency_runbook_url, var.runbook_url), "")
    tip                   = var.cdn_total_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cdn_total_latency_threshold_major}ms"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cdn_total_latency_disabled_major, var.cdn_total_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cdn_total_latency_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cdn_total_latency_runbook_url, var.runbook_url), "")
    tip                   = var.cdn_total_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cdn_total_latency_max_delay
}

resource "signalfx_detector" "cdn_origin_health" {
  name = format("%s %s", local.detector_name_prefix, "Azure CDN origin health")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Cdn/profiles') and filter('primary_aggregation_type', 'true')
    signal = data('OriginHealthPercentage', filter=base_filtering and ${module.filtering.signalflow})${var.cdn_origin_health_aggregation_function}${var.cdn_origin_health_transformation_function}.publish('signal')
    detect(when(signal < ${var.cdn_origin_health_threshold_critical}, lasting=%{if var.cdn_origin_health_lasting_duration_critical == null}None%{else}'${var.cdn_origin_health_lasting_duration_critical}'%{endif}, at_least=${var.cdn_origin_health_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal < ${var.cdn_origin_health_threshold_major}, lasting=%{if var.cdn_origin_health_lasting_duration_major == null}None%{else}'${var.cdn_origin_health_lasting_duration_major}'%{endif}, at_least=${var.cdn_origin_health_at_least_percentage_major}) and (not when(signal < ${var.cdn_origin_health_threshold_critical}, lasting=%{if var.cdn_origin_health_lasting_duration_critical == null}None%{else}'${var.cdn_origin_health_lasting_duration_critical}'%{endif}, at_least=${var.cdn_origin_health_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.cdn_origin_health_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cdn_origin_health_disabled_critical, var.cdn_origin_health_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cdn_origin_health_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cdn_origin_health_runbook_url, var.runbook_url), "")
    tip                   = var.cdn_origin_health_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.cdn_origin_health_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cdn_origin_health_disabled_major, var.cdn_origin_health_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cdn_origin_health_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cdn_origin_health_runbook_url, var.runbook_url), "")
    tip                   = var.cdn_origin_health_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cdn_origin_health_max_delay
}

