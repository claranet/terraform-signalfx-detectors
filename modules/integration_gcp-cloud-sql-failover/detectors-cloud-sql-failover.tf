resource "signalfx_detector" "failover_unavailable" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud SQL failover")

  authorized_writer_teams = var.authorized_writer_teams


  program_text = <<-EOF
    signal = data('database/available_for_failover', ${module.filter-tags.filter_custom})${var.failover_unavailable_aggregation_function}${var.failover_unavailable_transformation_function}.publish('signal')
    detect(when(signal < 1)).publish('MAJOR')
EOF

  rule {
    description           = "is unavailable"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.failover_unavailable_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.failover_unavailable_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.failover_unavailable_runbook_url, var.runbook_url), "")
    tip                   = var.failover_unavailable_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

