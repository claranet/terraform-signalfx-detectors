resource "signalfx_detector" "compute_units" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway compute units")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
    signal = data('ComputeUnits', filter=base_filtering and ${module.filtering.signalflow})${var.compute_units_aggregation_function}${var.compute_units_transformation_function}.publish('signal')
    detect(when(signal > ${var.compute_units_threshold_major}, lasting=%{if var.compute_units_lasting_duration_major == null}None%{else}'${var.compute_units_lasting_duration_major}'%{endif}, at_least=${var.compute_units_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.compute_units_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.compute_units_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.compute_units_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.compute_units_runbook_url, var.runbook_url), "")
    tip                   = var.compute_units_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.compute_units_max_delay
}

