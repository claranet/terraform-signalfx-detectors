resource "signalfx_detector" "hpa_scale_exceeded_capacity" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes hpa scale exceeded capacity")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    max = data('kubernetes.hpa.spec.max_replicas', filter=${module.filtering.signalflow})${var.hpa_scale_exceeded_capacity_aggregation_function}${var.hpa_scale_exceeded_capacity_transformation_function}
    desired = data('kubernetes.hpa.status.desired_replicas', filter=${module.filtering.signalflow})${var.hpa_scale_exceeded_capacity_aggregation_function}${var.hpa_scale_exceeded_capacity_transformation_function}
    signal = (desired-max).publish('signal')
    detect(when(signal >= ${var.hpa_scale_exceeded_capacity_threshold_major}, lasting=%{if var.hpa_scale_exceeded_capacity_lasting_duration_major == null}None%{else}'${var.hpa_scale_exceeded_capacity_lasting_duration_major}'%{endif}, at_least=${var.hpa_scale_exceeded_capacity_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.hpa_scale_exceeded_capacity_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.hpa_scale_exceeded_capacity_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.hpa_scale_exceeded_capacity_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.hpa_scale_exceeded_capacity_runbook_url, var.runbook_url), "")
    tip                   = var.hpa_scale_exceeded_capacity_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

