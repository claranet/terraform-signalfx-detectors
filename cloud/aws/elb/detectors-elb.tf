resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ELB heartbeat"

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('RequestCount', filter=filter('stat', 'sum') and filter('namespace', 'AWS/ELB')and (not filter('AvailabilityZone', '*')) and (not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}')) and ${module.filter-tags.filter_custom}).publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=['LoadBalancerName'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ELB healthy instances percentage"

  program_text = <<-EOF
    A = data('HealthyHostCount', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'lower') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom})${var.no_healthy_instances_aggregation_function}
    B = data('UnHealthyHostCount', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'upper') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom})${var.no_healthy_instances_aggregation_function}
    signal = (A/ (A + B)).scale(100)${var.no_healthy_instances_transformation_function}.publish('signal')
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

resource "signalfx_detector" "elb_4xx" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ELB 4xx error rate"

  program_text = <<-EOF
    A = data('HTTPCode_ELB_4XX', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, rollup='sum', extrapolation='zero')${var.elb_4xx_aggregation_function}${var.elb_4xx_transformation_function}
    B = data('RequestCount', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, rollup='sum', extrapolation='zero')${var.elb_4xx_aggregation_function}${var.elb_4xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.elb_4xx_threshold_critical}), lasting='${var.elb_4xx_lasting_duration_seconds}s', at_least=${var.elb_4xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.elb_4xx_threshold_warning}), lasting='${var.elb_4xx_lasting_duration_seconds}s', at_least=${var.elb_4xx_at_least_percentage}) and when(signal <= ${var.elb_4xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.elb_4xx_threshold_warning}, lasting='${var.elb_4xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.elb_4xx_threshold_critical}, lasting='${var.elb_4xx_lasting_duration_seconds}s', at_least=${var.elb_4xx_at_least_percentage})), mode='paired').publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.elb_4xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.elb_4xx_disabled_critical, var.elb_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.elb_4xx_notifications_critical, var.elb_4xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.elb_4xx_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.elb_4xx_disabled_warning, var.elb_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.elb_4xx_notifications_warning, var.elb_4xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "elb_5xx" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ELB 5xx error rate"

  program_text = <<-EOF
    A = data('HTTPCode_ELB_5XX', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, rollup='sum', extrapolation='zero')${var.elb_5xx_aggregation_function}${var.elb_5xx_transformation_function}
    B = data('RequestCount', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, rollup='sum', extrapolation='zero')${var.elb_5xx_aggregation_function}${var.elb_5xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.elb_5xx_threshold_critical}), lasting='${var.elb_5xx_lasting_duration_seconds}s', at_least=${var.elb_5xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.elb_5xx_threshold_warning}), lasting='${var.elb_5xx_lasting_duration_seconds}s', at_least=${var.elb_5xx_at_least_percentage}) and when(signal <= ${var.elb_5xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.elb_5xx_threshold_warning}, lasting='${var.elb_5xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.elb_5xx_threshold_critical}, lasting='${var.elb_5xx_lasting_duration_seconds}s', at_least=${var.elb_5xx_at_least_percentage})), mode='paired').publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.elb_5xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.elb_5xx_disabled_critical, var.elb_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.elb_5xx_notifications_critical, var.elb_5xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.elb_5xx_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.elb_5xx_disabled_warning, var.elb_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.elb_5xx_notifications_warning, var.elb_5xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "backend_4xx" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ELB backend 4xx error rate"

  program_text = <<-EOF
    A = data('HTTPCode_Backend_4XX', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, rollup='sum', extrapolation='zero')${var.backend_4xx_aggregation_function}${var.backend_4xx_transformation_function}
    B = data('RequestCount', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, rollup='sum', extrapolation='zero')${var.backend_4xx_aggregation_function}${var.backend_4xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.backend_4xx_threshold_critical}), lasting='${var.backend_4xx_lasting_duration_seconds}s', at_least=${var.backend_4xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.backend_4xx_threshold_warning}), lasting='${var.backend_4xx_lasting_duration_seconds}s', at_least=${var.backend_4xx_at_least_percentage}) and when(signal <= ${var.backend_4xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.backend_4xx_threshold_warning}, lasting='${var.backend_4xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.backend_4xx_threshold_critical}, lasting='${var.backend_4xx_lasting_duration_seconds}s', at_least=${var.backend_4xx_at_least_percentage})), mode='paired').publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.backend_4xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_4xx_disabled_critical, var.backend_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.backend_4xx_notifications_critical, var.backend_4xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.backend_4xx_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.backend_4xx_disabled_warning, var.backend_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.backend_4xx_notifications_warning, var.backend_4xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "backend_5xx" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ELB backend 5xx error rate"

  program_text = <<-EOF
    A = data('HTTPCode_Backend_5XX', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and filter('LoadBalancerName', '*') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.backend_5xx_aggregation_function}${var.backend_5xx_transformation_function}
    B = data('RequestCount', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'sum') and filter('LoadBalancerName', '*') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.backend_5xx_aggregation_function}${var.backend_5xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.backend_5xx_threshold_critical}), lasting='${var.backend_5xx_lasting_duration_seconds}s', at_least=${var.backend_5xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.backend_5xx_threshold_warning}), lasting='${var.backend_5xx_lasting_duration_seconds}s', at_least=${var.backend_5xx_at_least_percentage}) and when(signal <= ${var.backend_5xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.backend_5xx_threshold_warning}, lasting='${var.backend_5xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.backend_5xx_threshold_critical}, lasting='${var.backend_5xx_lasting_duration_seconds}s', at_least=${var.backend_5xx_at_least_percentage})), mode='paired').publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.backend_5xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_5xx_disabled_critical, var.backend_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.backend_5xx_notifications_critical, var.backend_5xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.backend_5xx_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.backend_5xx_disabled_warning, var.backend_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.backend_5xx_notifications_warning, var.backend_5xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "backend_latency" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ELB backend latency"

  program_text = <<-EOF
    signal = data('Latency', filter=filter('namespace', 'AWS/ELB') and filter('stat', 'mean') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='average')${var.backend_latency_aggregation_function}${var.backend_latency_transformation_function}.publish('signal')
    detect(when(signal > threshold(${var.backend_latency_threshold_critical}), lasting='${var.backend_latency_lasting_duration_seconds}s', at_least=${var.backend_latency_at_least_percentage})).publish('CRIT')
    detect((when(signal > threshold(${var.backend_latency_threshold_warning}), lasting='${var.backend_latency_lasting_duration_seconds}s', at_least=${var.backend_latency_at_least_percentage}) and when(signal <= ${var.backend_latency_threshold_critical})), off=(when(signal <= ${var.backend_latency_threshold_warning}, lasting='${var.backend_latency_lasting_duration_seconds / 2}s') or when(signal >= ${var.backend_latency_threshold_critical}, lasting='${var.backend_latency_lasting_duration_seconds}s', at_least=${var.backend_latency_at_least_percentage})), mode='paired').publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.backend_latency_threshold_critical}s"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_latency_disabled_critical, var.backend_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.backend_latency_notifications_critical, var.backend_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.backend_latency_threshold_warning}s"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.backend_latency_disabled_warning, var.backend_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.backend_latency_notifications_warning, var.backend_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}
