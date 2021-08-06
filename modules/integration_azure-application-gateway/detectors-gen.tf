resource "signalfx_detector" "capacity_units" {
  name = format("%s %s", local.detector_name_prefix, "Azure Application Gateway capacity units")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Network/applicationGateways') and filter('primary_aggregation_type', 'true')
    signal = data('CapacityUnits', filter=base_filtering and ${module.filtering.signalflow})${var.capacity_units_aggregation_function}${var.capacity_units_transformation_function}.publish('signal')
    detect(when(signal > ${var.capacity_units_threshold_major}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.capacity_units_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.capacity_units_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.capacity_units_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.capacity_units_runbook_url, var.runbook_url), "")
    tip                   = var.capacity_units_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

