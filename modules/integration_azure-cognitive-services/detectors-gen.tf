resource "signalfx_detector" "success_rate" {
  name = format("%s %s", local.detector_name_prefix, "Azure Cognitive Services success rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.CognitiveServices/accounts') and filter('primary_aggregation_type', 'true')
    signal = data('SuccessRate', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='last_value')${var.success_rate_aggregation_function}${var.success_rate_transformation_function}.publish('signal')
    detect(when(signal < ${var.success_rate_threshold_major}%{if var.success_rate_lasting_duration_major != null}, lasting='${var.success_rate_lasting_duration_major}', at_least=${var.success_rate_at_least_percentage_major}%{endif})).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.success_rate_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.success_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.success_rate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.success_rate_runbook_url, var.runbook_url), "")
    tip                   = var.success_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.success_rate_max_delay
}

