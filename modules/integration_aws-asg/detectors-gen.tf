resource "signalfx_detector" "max_capacity" {
  name = format("%s %s", local.detector_name_prefix, "AWS ASG desired reached the max capacity")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/AutoScaling') and filter('stat', 'mean') and filter('AutoScalingGroupName', '*')
    desired_capacity = data('GroupDesiredCapacity', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='last_value')${var.max_capacity_aggregation_function}${var.max_capacity_transformation_function}
    max_capacity = data('GroupMaxSize', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='last_value')${var.max_capacity_aggregation_function}${var.max_capacity_transformation_function}.above(${var.max_capacity_above_filter})
    signal = (desired_capacity/max_capacity).scale(100).publish('signal')
    detect(when(signal > ${var.max_capacity_threshold_critical}%{if var.max_capacity_lasting_duration_critical != null}, lasting='${var.max_capacity_lasting_duration_critical}', at_least=${var.max_capacity_at_least_percentage_critical}%{endif})).publish('CRITICAL')
    detect(when(signal > ${var.max_capacity_threshold_major}%{if var.max_capacity_lasting_duration_major != null}, lasting='${var.max_capacity_lasting_duration_major}', at_least=${var.max_capacity_at_least_percentage_major}%{endif}) and (not when(signal < ${var.max_capacity_threshold_critical}%{if var.max_capacity_lasting_duration_critical != null}, lasting='${var.max_capacity_lasting_duration_critical}', at_least=${var.max_capacity_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.max_capacity_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRITICAL"
    disabled              = coalesce(var.max_capacity_disabled_critical, var.max_capacity_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.max_capacity_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.max_capacity_runbook_url, var.runbook_url), "")
    tip                   = var.max_capacity_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.max_capacity_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.max_capacity_disabled_major, var.max_capacity_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.max_capacity_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.max_capacity_runbook_url, var.runbook_url), "")
    tip                   = var.max_capacity_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.max_capacity_max_delay
}
