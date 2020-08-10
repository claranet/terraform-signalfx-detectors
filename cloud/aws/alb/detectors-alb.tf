resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ALB heartbeat"

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('RequestCount', filter=filter('stat', 'sum') and filter('namespace', 'AWS/ApplicationELB') and (not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}') and ${module.filter-tags.filter_custom})).publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=['LoadBalancer'], duration='${var.heartbeat_timeframe}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.heartbeat_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "no_healthy_instances" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ALB healthy instances percentage"

  program_text = <<-EOF
    A = data('HealthyHostCount', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'lower') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom})${var.no_healthy_instances_aggregation_function}
    B = data('UnHealthyHostCount', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'upper') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom})${var.no_healthy_instances_aggregation_function}
    signal = (A/(A+B)).scale(100)${var.no_healthy_instances_transformation_function}.publish('signal')
    detect(when(signal < ${var.no_healthy_instances_threshold_critical})).publish('CRIT')
    detect(when(signal < ${var.no_healthy_instances_threshold_warning}) and when(signal >= ${var.no_healthy_instances_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "has fallen below critical capacity < ${var.no_healthy_instances_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.no_healthy_instances_disabled_critical, var.no_healthy_instances_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.no_healthy_instances_notifications_critical, var.no_healthy_instances_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is below nominal capacity < ${var.no_healthy_instances_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.no_healthy_instances_disabled_warning, var.no_healthy_instances_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.no_healthy_instances_notifications_warning, var.no_healthy_instances_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "latency" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ALB latency"

  program_text = <<-EOF
    signal = data('TargetResponseTime', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'mean') and filter('TargetGroup', '*') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='average')${var.latency_aggregation_function}${var.latency_transformation_function}.publish('signal')
    detect(when(signal > threshold(${var.latency_threshold_critical}), lasting='${var.latency_lasting_duration_seconds}s', at_least=${var.latency_at_least_percentage})).publish('CRIT')
    detect((when(signal > threshold(${var.latency_threshold_warning}), lasting='${var.latency_lasting_duration_seconds}s', at_least=${var.latency_at_least_percentage}) and when(signal <= ${var.latency_threshold_critical})), off=(when(signal <= ${var.latency_threshold_warning}, lasting='${var.latency_lasting_duration_seconds / 2}s') or when(signal >= ${var.latency_threshold_critical}, lasting='${var.latency_lasting_duration_seconds}s', at_least=${var.latency_at_least_percentage})), mode='paired').publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.latency_threshold_critical}s"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.latency_disabled_critical, var.latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.latency_notifications_critical, var.latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.latency_threshold_warning}s"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.latency_disabled_warning, var.latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.latency_notifications_warning, var.latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "alb_5xx" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ALB 5xx error rate"

  program_text = <<-EOF
    A = data('alb_ELB_5XX_Count', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and filter('TargetGroup', '*') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.alb_5xx_aggregation_function}${var.alb_5xx_transformation_function}
    B = data('RequestCount', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and filter('TargetGroup', '*') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.alb_5xx_aggregation_function}${var.alb_5xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.alb_5xx_threshold_critical}), lasting='${var.alb_5xx_lasting_duration_seconds}s', at_least=${var.alb_5xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.alb_5xx_threshold_warning}), lasting='${var.alb_5xx_lasting_duration_seconds}s', at_least=${var.alb_5xx_at_least_percentage}) and when(signal <= ${var.alb_5xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.alb_5xx_threshold_warning}, lasting='${var.alb_5xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.alb_5xx_threshold_critical}, lasting='${var.alb_5xx_lasting_duration_seconds}s', at_least=${var.alb_5xx_at_least_percentage})), mode='paired').publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.alb_5xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.alb_5xx_disabled_critical, var.alb_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.alb_5xx_notifications_critical, var.alb_5xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.alb_5xx_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.alb_5xx_disabled_warning, var.alb_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.alb_5xx_notifications_warning, var.alb_5xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "alb_4xx" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ALB 4xx error rate"

  program_text = <<-EOF
    A = data('alb_ELB_4XX_Count', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and filter('TargetGroup', '*') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.alb_4xx_aggregation_function}${var.alb_4xx_transformation_function}
    B = data('RequestCount', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and filter('TargetGroup', '*') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.alb_4xx_aggregation_function}${var.alb_4xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.alb_4xx_threshold_critical}), lasting='${var.alb_4xx_lasting_duration_seconds}s', at_least=${var.alb_4xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.alb_4xx_threshold_warning}), lasting='${var.alb_4xx_lasting_duration_seconds}s', at_least=${var.alb_4xx_at_least_percentage}) and when(signal <= ${var.alb_4xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.alb_4xx_threshold_warning}, lasting='${var.alb_4xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.alb_4xx_threshold_critical}, lasting='${var.alb_4xx_lasting_duration_seconds}s', at_least=${var.alb_4xx_at_least_percentage})), mode='paired').publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.alb_4xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.alb_4xx_disabled_critical, var.alb_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.alb_4xx_notifications_critical, var.alb_4xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.alb_4xx_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.alb_4xx_disabled_warning, var.alb_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.alb_4xx_notifications_warning, var.alb_4xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "target_5xx" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ALB target 5xx error rate"

  program_text = <<-EOF
    A = data('target_5XX_Count', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and filter('TargetGroup', '*') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.target_5xx_aggregation_function}${var.target_5xx_transformation_function}
    B = data('RequestCount', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and filter('TargetGroup', '*') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.target_5xx_aggregation_function}${var.target_5xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.target_5xx_threshold_critical}), lasting='${var.target_5xx_lasting_duration_seconds}s', at_least=${var.target_5xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.target_5xx_threshold_warning}), lasting='${var.target_5xx_lasting_duration_seconds}s', at_least=${var.target_5xx_at_least_percentage}) and when(signal <= ${var.target_5xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.target_5xx_threshold_warning}, lasting='${var.target_5xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.target_5xx_threshold_critical}, lasting='${var.target_5xx_lasting_duration_seconds}s', at_least=${var.target_5xx_at_least_percentage})), mode='paired').publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.target_5xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.target_5xx_disabled_critical, var.target_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.target_5xx_notifications_critical, var.target_5xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.target_5xx_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.target_5xx_disabled_warning, var.target_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.target_5xx_notifications_warning, var.target_5xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "target_4xx" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ALB target 4xx error rate"

  program_text = <<-EOF
    A = data('target_4XX_Count', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and filter('TargetGroup', '*') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.target_4xx_aggregation_function}${var.target_4xx_transformation_function}
    B = data('RequestCount', filter=filter('namespace', 'AWS/ApplicationELB') and filter('stat', 'sum') and filter('TargetGroup', '*') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.target_4xx_aggregation_function}${var.target_4xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.target_4xx_threshold_critical}), lasting='${var.target_4xx_lasting_duration_seconds}s', at_least=${var.target_4xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.target_4xx_threshold_warning}), lasting='${var.target_4xx_lasting_duration_seconds}s', at_least=${var.target_4xx_at_least_percentage}) and when(signal <= ${var.target_4xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.target_4xx_threshold_warning}, lasting='${var.target_4xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.target_4xx_threshold_critical}, lasting='${var.target_4xx_lasting_duration_seconds}s', at_least=${var.target_4xx_at_least_percentage})), mode='paired').publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.target_4xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.target_4xx_disabled_critical, var.target_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.target_4xx_notifications_critical, var.target_4xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.target_4xx_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.target_4xx_disabled_warning, var.target_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.target_4xx_notifications_warning, var.target_4xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}
