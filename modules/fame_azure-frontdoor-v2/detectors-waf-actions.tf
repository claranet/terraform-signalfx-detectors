resource "signalfx_detector" "waf_actions" {
  name = format("%s %s", local.detector_name_prefix, "Azure FrontDoor v2 waf actions")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.against_recent import against_recent
    A = data('fame.azure.frontdoor.waf_actions', filter=${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.waf_actions_aggregation_function}${var.waf_actions_transformation_function}
    signal = A.fill(0).mean(by="host").publish('signal')
    against_recent.detector_mean_std(signal, current_window=duration('${var.waf_actions_current_window_duration}'), historical_window=duration('${var.waf_actions_historical_window_duration}'), fire_num_stddev=${var.waf_actions_fire_num_stddev}).publish('WARN')
EOF

  rule {
    description           = "sudden change"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.waf_actions_disabled_warning, var.waf_actions_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.waf_actions_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.waf_actions_runbook_url, var.runbook_url), "")
    tip                   = var.waf_actions_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}
