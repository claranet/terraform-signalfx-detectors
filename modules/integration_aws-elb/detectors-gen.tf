resource "signalfx_detector" "unhealthy_instances_absolute" {
  name = format("%s %s", local.detector_name_prefix, "AWS ELB unhealthy instances")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('UnHealthyHostCount', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'upper') and (not filter('AvailabilityZone', '*')) and ${module.filtering.signalflow})${var.unhealthy_instances_absolute_aggregation_function}${var.unhealthy_instances_absolute_transformation_function}.publish('signal')
    detect(when(signal >= ${var.unhealthy_instances_absolute_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high >= ${var.unhealthy_instances_absolute_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.unhealthy_instances_absolute_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.unhealthy_instances_absolute_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.unhealthy_instances_absolute_runbook_url, var.runbook_url), "")
    tip                   = var.unhealthy_instances_absolute_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

