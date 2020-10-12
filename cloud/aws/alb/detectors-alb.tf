resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS ALB heartbeat")

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('RequestCount', filter=filter('stat', 'sum') and filter('namespace', 'AWS/ApplicationELB') and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "no_healthy_instances" {
  name = format("%s %s", local.detector_name_prefix, "AWS ALB healthy instances percentage")

  program_text = <<-EOF
    A = data('HealthyHostCount', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'lower') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom})${var.no_healthy_instances_aggregation_function}${var.no_healthy_instances_transformation_function}
    B = data('UnHealthyHostCount', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'upper') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom})${var.no_healthy_instances_aggregation_function}${var.no_healthy_instances_transformation_function}
    signal = (A / (A+B)).scale(100).publish('signal')
    detect(when(signal < ${var.no_healthy_instances_threshold_critical})).publish('CRIT')
    detect(when(signal < ${var.no_healthy_instances_threshold_major}) and when(signal >= ${var.no_healthy_instances_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "has fallen below critical capacity < ${var.no_healthy_instances_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.no_healthy_instances_disabled_critical, var.no_healthy_instances_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.no_healthy_instances_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is below nominal capacity < ${var.no_healthy_instances_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.no_healthy_instances_disabled_major, var.no_healthy_instances_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.no_healthy_instances_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "latency" {
  name = format("%s %s", local.detector_name_prefix, "AWS ALB latency")

  program_text = <<-EOF
    signal = data('TargetResponseTime', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'mean') and filter('TargetGroup', '*') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='average')${var.latency_aggregation_function}${var.latency_transformation_function}.publish('signal')
    detect(when(signal > threshold(${var.latency_threshold_critical}), lasting='${var.latency_lasting_duration_seconds}s', at_least=${var.latency_at_least_percentage})).publish('CRIT')
    detect((when(signal > threshold(${var.latency_threshold_major}), lasting='${var.latency_lasting_duration_seconds}s', at_least=${var.latency_at_least_percentage}) and when(signal <= ${var.latency_threshold_critical})), off=(when(signal <= ${var.latency_threshold_major}, lasting='${var.latency_lasting_duration_seconds / 2}s') or when(signal >= ${var.latency_threshold_critical}, lasting='${var.latency_lasting_duration_seconds}s', at_least=${var.latency_at_least_percentage})), mode='paired').publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.latency_threshold_critical}s"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.latency_disabled_critical, var.latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.latency_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.latency_threshold_major}s"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.latency_disabled_major, var.latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.latency_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "alb_5xx" {
  name = format("%s %s", local.detector_name_prefix, "AWS ALB 5xx error rate")

  program_text = <<-EOF
    A = data('HTTPCode_ELB_5XX_Count', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.alb_5xx_aggregation_function}${var.alb_5xx_transformation_function}
    B = data('RequestCount', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.alb_5xx_aggregation_function}${var.alb_5xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.alb_5xx_threshold_critical}), lasting='${var.alb_5xx_lasting_duration_seconds}s', at_least=${var.alb_5xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.alb_5xx_threshold_major}), lasting='${var.alb_5xx_lasting_duration_seconds}s', at_least=${var.alb_5xx_at_least_percentage}) and when(signal <= ${var.alb_5xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.alb_5xx_threshold_major}, lasting='${var.alb_5xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.alb_5xx_threshold_critical}, lasting='${var.alb_5xx_lasting_duration_seconds}s', at_least=${var.alb_5xx_at_least_percentage})), mode='paired').publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.alb_5xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.alb_5xx_disabled_critical, var.alb_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.alb_5xx_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.alb_5xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.alb_5xx_disabled_major, var.alb_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.alb_5xx_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "alb_4xx" {
  name = format("%s %s", local.detector_name_prefix, "AWS ALB 4xx error rate")

  program_text = <<-EOF
    A = data('HTTPCode_ELB_4XX_Count', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.alb_4xx_aggregation_function}${var.alb_4xx_transformation_function}
    B = data('RequestCount', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.alb_4xx_aggregation_function}${var.alb_4xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.alb_4xx_threshold_critical}), lasting='${var.alb_4xx_lasting_duration_seconds}s', at_least=${var.alb_4xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.alb_4xx_threshold_major}), lasting='${var.alb_4xx_lasting_duration_seconds}s', at_least=${var.alb_4xx_at_least_percentage}) and when(signal <= ${var.alb_4xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.alb_4xx_threshold_major}, lasting='${var.alb_4xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.alb_4xx_threshold_critical}, lasting='${var.alb_4xx_lasting_duration_seconds}s', at_least=${var.alb_4xx_at_least_percentage})), mode='paired').publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.alb_4xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.alb_4xx_disabled_critical, var.alb_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.alb_4xx_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.alb_4xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.alb_4xx_disabled_major, var.alb_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.alb_4xx_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "target_5xx" {
  name = format("%s %s", local.detector_name_prefix, "AWS ALB target 5xx error rate")

  program_text = <<-EOF
    A = data('HTTPCode_Target_5XX_Count', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and filter('TargetGroup', '*') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.target_5xx_aggregation_function}${var.target_5xx_transformation_function}
    B = data('RequestCount', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and filter('TargetGroup', '*') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.target_5xx_aggregation_function}${var.target_5xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.target_5xx_threshold_critical}), lasting='${var.target_5xx_lasting_duration_seconds}s', at_least=${var.target_5xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.target_5xx_threshold_major}), lasting='${var.target_5xx_lasting_duration_seconds}s', at_least=${var.target_5xx_at_least_percentage}) and when(signal <= ${var.target_5xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.target_5xx_threshold_major}, lasting='${var.target_5xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.target_5xx_threshold_critical}, lasting='${var.target_5xx_lasting_duration_seconds}s', at_least=${var.target_5xx_at_least_percentage})), mode='paired').publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.target_5xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.target_5xx_disabled_critical, var.target_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.target_5xx_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.target_5xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.target_5xx_disabled_major, var.target_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.target_5xx_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "target_4xx" {
  name = format("%s %s", local.detector_name_prefix, "AWS ALB target 4xx error rate")

  program_text = <<-EOF
    A = data('HTTPCode_Target_4XX_Count', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and filter('TargetGroup', '*') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.target_4xx_aggregation_function}${var.target_4xx_transformation_function}
    B = data('RequestCount', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and filter('TargetGroup', '*') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.target_4xx_aggregation_function}${var.target_4xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.target_4xx_threshold_critical}), lasting='${var.target_4xx_lasting_duration_seconds}s', at_least=${var.target_4xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.target_4xx_threshold_major}), lasting='${var.target_4xx_lasting_duration_seconds}s', at_least=${var.target_4xx_at_least_percentage}) and when(signal <= ${var.target_4xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.target_4xx_threshold_major}, lasting='${var.target_4xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.target_4xx_threshold_critical}, lasting='${var.target_4xx_lasting_duration_seconds}s', at_least=${var.target_4xx_at_least_percentage})), mode='paired').publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.target_4xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.target_4xx_disabled_critical, var.target_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.target_4xx_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.target_4xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.target_4xx_disabled_major, var.target_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.target_4xx_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

