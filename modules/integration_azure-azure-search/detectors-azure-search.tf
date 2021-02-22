resource "signalfx_detector" "search_latency" {
  name = format("%s %s", local.detector_name_prefix, "Azure Search latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Search/searchServices') and filter('primary_aggregation_type', 'true')
        signal = data('SearchLatency', filter=base_filter and ${module.filter-tags.filter_custom})${var.search_latency_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.search_latency_threshold_critical}), lasting="${var.search_latency_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.search_latency_threshold_major}), lasting="${var.search_latency_timer}") and when(signal <= ${var.search_latency_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.search_latency_threshold_critical}ms"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.search_latency_disabled_critical, var.search_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.search_latency_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.search_latency_runbook_url, var.runbook_url), "")
    tip                   = var.search_latency_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.search_latency_threshold_major}ms"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.search_latency_disabled_major, var.search_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.search_latency_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.search_latency_runbook_url, var.runbook_url), "")
    tip                   = var.search_latency_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "search_throttled_queries_rate" {
  name = format("%s %s", local.detector_name_prefix, "Azure Search throttled queries rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Search/searchServices') and filter('primary_aggregation_type', 'true')
        signal = data('ThrottledSearchQueriesPercentage', filter=base_filter and ${module.filter-tags.filter_custom})${var.search_throttled_queries_rate_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.search_throttled_queries_rate_threshold_critical}), lasting="${var.search_throttled_queries_rate_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.search_throttled_queries_rate_threshold_major}), lasting="${var.search_throttled_queries_rate_timer}") and when(signal <= ${var.search_throttled_queries_rate_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.search_throttled_queries_rate_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.search_throttled_queries_rate_disabled_critical, var.search_throttled_queries_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.search_throttled_queries_rate_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.search_throttled_queries_rate_runbook_url, var.runbook_url), "")
    tip                   = var.search_throttled_queries_rate_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.search_throttled_queries_rate_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.search_throttled_queries_rate_disabled_major, var.search_throttled_queries_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.search_throttled_queries_rate_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.search_throttled_queries_rate_runbook_url, var.runbook_url), "")
    tip                   = var.search_throttled_queries_rate_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

}
