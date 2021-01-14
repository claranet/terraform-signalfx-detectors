resource "signalfx_detector" "used_capacity" {
  name = format("%s %s", local.detector_name_prefix, "Azure storage account Used capacity")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts') and filter('primary_aggregation_type', 'true')
    signal = data('UsedCapacity', filter=base_filter and ${module.filter-tags.filter_custom})${var.used_capacity_aggregation_function}${var.used_capacity_transformation_function}.scale(0.0000000008).publish('signal')
    detect(when(signal > ${var.used_capacity_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.used_capacity_threshold_major}) and when(signal <= ${var.used_capacity_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.used_capacity_threshold_critical} GB"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.used_capacity_disabled_critical, var.used_capacity_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.used_capacity_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.used_capacity_runbook_url, var.runbook_url), "")
    tip                   = var.used_capacity_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.used_capacity_threshold_major} GB"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.used_capacity_disabled_major, var.used_capacity_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.used_capacity_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.used_capacity_runbook_url, var.runbook_url), "")
    tip                   = var.used_capacity_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}
