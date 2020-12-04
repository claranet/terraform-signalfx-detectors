resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS ELB heartbeat")

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('HealthyHostCount', filter=filter('stat', 'mean') and filter('namespace', 'AWS/ELB') and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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
  name = format("%s %s", local.detector_name_prefix, "AWS ELB healthy instances percentage")

  program_text = <<-EOF
    A = data('HealthyHostCount', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'lower') and (not filter('AvailabilityZone', '*')) and filter('LoadBalancerName', '*') and ${module.filter-tags.filter_custom})${var.no_healthy_instances_aggregation_function}${var.no_healthy_instances_transformation_function}
    B = data('UnHealthyHostCount', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'upper') and (not filter('AvailabilityZone', '*')) and filter('LoadBalancerName', '*') and ${module.filter-tags.filter_custom})${var.no_healthy_instances_aggregation_function}${var.no_healthy_instances_transformation_function}
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

resource "signalfx_detector" "elb_4xx" {
  name = format("%s %s", local.detector_name_prefix, "AWS ELB 4xx error rate")

  program_text = <<-EOF
    A = data('HTTPCode_ELB_4XX', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and filter('LoadBalancerName', '*') and ${module.filter-tags.filter_custom}, rollup='sum', extrapolation='zero')${var.elb_4xx_aggregation_function}${var.elb_4xx_transformation_function}
    B = data('RequestCount', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and filter('LoadBalancerName', '*') and ${module.filter-tags.filter_custom}, rollup='sum', extrapolation='zero')${var.elb_4xx_aggregation_function}${var.elb_4xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.elb_4xx_threshold_critical}), lasting='${var.elb_4xx_lasting_duration_seconds}s', at_least=${var.elb_4xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.elb_4xx_threshold_major}), lasting='${var.elb_4xx_lasting_duration_seconds}s', at_least=${var.elb_4xx_at_least_percentage}) and when(signal <= ${var.elb_4xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.elb_4xx_threshold_major}, lasting='${var.elb_4xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.elb_4xx_threshold_critical}, lasting='${var.elb_4xx_lasting_duration_seconds}s', at_least=${var.elb_4xx_at_least_percentage})), mode='paired').publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.elb_4xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.elb_4xx_disabled_critical, var.elb_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.elb_4xx_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.elb_4xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.elb_4xx_disabled_major, var.elb_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.elb_4xx_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "elb_5xx" {
  name = format("%s %s", local.detector_name_prefix, "AWS ELB 5xx error rate")

  program_text = <<-EOF
    A = data('HTTPCode_ELB_5XX', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and filter('LoadBalancerName', '*') and ${module.filter-tags.filter_custom}, rollup='sum', extrapolation='zero')${var.elb_5xx_aggregation_function}${var.elb_5xx_transformation_function}
    B = data('RequestCount', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and filter('LoadBalancerName', '*') and ${module.filter-tags.filter_custom}, rollup='sum', extrapolation='zero')${var.elb_5xx_aggregation_function}${var.elb_5xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.elb_5xx_threshold_critical}), lasting='${var.elb_5xx_lasting_duration_seconds}s', at_least=${var.elb_5xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.elb_5xx_threshold_major}), lasting='${var.elb_5xx_lasting_duration_seconds}s', at_least=${var.elb_5xx_at_least_percentage}) and when(signal <= ${var.elb_5xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.elb_5xx_threshold_major}, lasting='${var.elb_5xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.elb_5xx_threshold_critical}, lasting='${var.elb_5xx_lasting_duration_seconds}s', at_least=${var.elb_5xx_at_least_percentage})), mode='paired').publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.elb_5xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.elb_5xx_disabled_critical, var.elb_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.elb_5xx_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.elb_5xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.elb_5xx_disabled_major, var.elb_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.elb_5xx_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "backend_4xx" {
  name = format("%s %s", local.detector_name_prefix, "AWS ELB backend 4xx error rate")

  program_text = <<-EOF
    A = data('HTTPCode_Backend_4XX', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and filter('LoadBalancerName', '*') and ${module.filter-tags.filter_custom}, rollup='sum', extrapolation='zero')${var.backend_4xx_aggregation_function}${var.backend_4xx_transformation_function}
    B = data('RequestCount', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and filter('LoadBalancerName', '*') and ${module.filter-tags.filter_custom}, rollup='sum', extrapolation='zero')${var.backend_4xx_aggregation_function}${var.backend_4xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.backend_4xx_threshold_critical}), lasting='${var.backend_4xx_lasting_duration_seconds}s', at_least=${var.backend_4xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.backend_4xx_threshold_major}), lasting='${var.backend_4xx_lasting_duration_seconds}s', at_least=${var.backend_4xx_at_least_percentage}) and when(signal <= ${var.backend_4xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.backend_4xx_threshold_major}, lasting='${var.backend_4xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.backend_4xx_threshold_critical}, lasting='${var.backend_4xx_lasting_duration_seconds}s', at_least=${var.backend_4xx_at_least_percentage})), mode='paired').publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.backend_4xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_4xx_disabled_critical, var.backend_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_4xx_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.backend_4xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.backend_4xx_disabled_major, var.backend_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_4xx_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "backend_5xx" {
  name = format("%s %s", local.detector_name_prefix, "AWS ELB backend 5xx error rate")

  program_text = <<-EOF
    A = data('HTTPCode_Backend_5XX', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and filter('LoadBalancerName', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.backend_5xx_aggregation_function}${var.backend_5xx_transformation_function}
    B = data('RequestCount', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and filter('LoadBalancerName', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.backend_5xx_aggregation_function}${var.backend_5xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.backend_5xx_threshold_critical}), lasting='${var.backend_5xx_lasting_duration_seconds}s', at_least=${var.backend_5xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.backend_5xx_threshold_major}), lasting='${var.backend_5xx_lasting_duration_seconds}s', at_least=${var.backend_5xx_at_least_percentage}) and when(signal <= ${var.backend_5xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.backend_5xx_threshold_major}, lasting='${var.backend_5xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.backend_5xx_threshold_critical}, lasting='${var.backend_5xx_lasting_duration_seconds}s', at_least=${var.backend_5xx_at_least_percentage})), mode='paired').publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.backend_5xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_5xx_disabled_critical, var.backend_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_5xx_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.backend_5xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.backend_5xx_disabled_major, var.backend_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_5xx_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "backend_latency" {
  name = format("%s %s", local.detector_name_prefix, "AWS ELB backend latency")

  program_text = <<-EOF
    signal = data('Latency', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'mean') and (not filter('AvailabilityZone', '*')) and filter('LoadBalancerName', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='average')${var.backend_latency_aggregation_function}${var.backend_latency_transformation_function}.publish('signal')
    detect(when(signal > threshold(${var.backend_latency_threshold_critical}), lasting='${var.backend_latency_lasting_duration_seconds}s', at_least=${var.backend_latency_at_least_percentage})).publish('CRIT')
    detect((when(signal > threshold(${var.backend_latency_threshold_major}), lasting='${var.backend_latency_lasting_duration_seconds}s', at_least=${var.backend_latency_at_least_percentage}) and when(signal <= ${var.backend_latency_threshold_critical})), off=(when(signal <= ${var.backend_latency_threshold_major}, lasting='${var.backend_latency_lasting_duration_seconds / 2}s') or when(signal >= ${var.backend_latency_threshold_critical}, lasting='${var.backend_latency_lasting_duration_seconds}s', at_least=${var.backend_latency_at_least_percentage})), mode='paired').publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.backend_latency_threshold_critical}s"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_latency_disabled_critical, var.backend_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_latency_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.backend_latency_threshold_major}s"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.backend_latency_disabled_major, var.backend_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_latency_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

