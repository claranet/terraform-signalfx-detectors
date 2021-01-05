resource "signalfx_detector" "check_memory" {
  name = format("%s %s", local.detector_name_prefix, "Smart-agent_couchbase check memory")

  authorized_writer_teams = var.authorized_writer_teams

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    A = data('gauge.bucket.op.mem_used', filter=${module.filter-tags.filter_custom})${var.check_memory_aggregation_function}${var.check_memory_transformation_function}
    B = data('gauge.bucket.op.ep_mem_high_wat', filter=${module.filter-tags.filter_custom})${var.check_memory_aggregation_function}${var.check_memory_transformation_function}
    signal = (A/B).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.check_memory_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.check_memory_threshold_major}) and when(signal <= ${var.check_memory_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.check_memory_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.check_memory_disabled_critical, var.check_memory_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.check_memory_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.check_memory_runbook_url, var.runbook_url), "")
    tip                   = var.check_memory_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.check_memory_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.check_memory_disabled_major, var.check_memory_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.check_memory_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.check_memory_runbook_url, var.runbook_url), "")
    tip                   = var.check_memory_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

