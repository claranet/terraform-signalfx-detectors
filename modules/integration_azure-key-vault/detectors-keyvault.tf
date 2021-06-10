resource "signalfx_detector" "api_result" {
  name = format("%s %s", local.detector_name_prefix, "Azure Key Vault API result rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.KeyVault/vaults') and filter('primary_aggregation_type', 'true')
        A = data('ServiceApiResult', extrapolation="zero", filter=base_filter and filter('statuscode', '200') and ${module.filtering.signalflow})${var.api_result_aggregation_function}
        B = data('ServiceApiResult', extrapolation="zero", filter=base_filter and ${module.filtering.signalflow})${var.api_result_aggregation_function}
        signal = (A/B).scale(100).fill(100).publish('signal')
        detect(when(signal < threshold(${var.api_result_threshold_critical}), lasting="${var.api_result_timer}")).publish('CRIT')
        detect(when(signal < threshold(${var.api_result_threshold_major}), lasting="${var.api_result_timer}") and when(signal >= ${var.api_result_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too low < ${var.api_result_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.api_result_disabled_critical, var.api_result_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.api_result_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.api_result_runbook_url, var.runbook_url), "")
    tip                   = var.api_result_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too low < ${var.api_result_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.api_result_disabled_major, var.api_result_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.api_result_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.api_result_runbook_url, var.runbook_url), "")
    tip                   = var.api_result_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "api_latency" {
  name = format("%s %s", local.detector_name_prefix, "Azure Key Vault API latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.KeyVault/vaults') and filter('primary_aggregation_type', 'true')
        signal = data('ServiceApiLatency', extrapolation="zero", filter=base_filter and not filter('activityname', 'secretlist') and ${module.filtering.signalflow})${var.api_latency_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.api_latency_threshold_critical}), lasting="${var.api_latency_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.api_latency_threshold_major}), lasting="${var.api_latency_timer}") and when(signal <= ${var.api_latency_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.api_latency_threshold_critical}ms"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.api_latency_disabled_critical, var.api_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.api_latency_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.api_latency_runbook_url, var.runbook_url), "")
    tip                   = var.api_latency_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.api_latency_threshold_major}ms"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.api_latency_disabled_major, var.api_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.api_latency_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.api_latency_runbook_url, var.runbook_url), "")
    tip                   = var.api_latency_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}
