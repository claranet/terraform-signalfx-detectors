resource "signalfx_detector" "nginx_ingress_5xx" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes Ingress Nginx 5xx errors ratio"

  program_text = <<-EOF
    A = data('nginx_ingress_controller_requests', filter=filter('status', '5*') and ${module.filter-tags.filter_custom}, rollup='delta', extrapolation='zero')${var.ingress_5xx_aggregation_function}${var.ingress_5xx_transformation_function}
    B = data('nginx_ingress_controller_requests', ${module.filter-tags.filter_custom}, rollup='delta', extrapolation='zero')${var.ingress_5xx_aggregation_function}${var.ingress_5xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.ingress_5xx_threshold_critical}), lasting='${var.ingress_5xx_lasting_duration_seconds}s', at_least=${var.ingress_5xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.ingress_5xx_threshold_warning}), lasting='${var.ingress_5xx_lasting_duration_seconds}s', at_least=${var.ingress_5xx_at_least_percentage}) and when(signal <= ${var.ingress_5xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.ingress_5xx_threshold_warning}, lasting='${var.ingress_5xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.ingress_5xx_threshold_critical}, lasting='${var.ingress_5xx_lasting_duration_seconds}s', at_least=${var.ingress_5xx_at_least_percentage})), mode='paired').publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.ingress_5xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.ingress_5xx_disabled_critical, var.ingress_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.ingress_5xx_notifications_critical, var.ingress_5xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.ingress_5xx_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.ingress_5xx_disabled_warning, var.ingress_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.ingress_5xx_notifications_warning, var.ingress_5xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "nginx_ingress_4xx" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes Ingress Nginx 4xx errors ratio"

  program_text = <<-EOF
    A = data('nginx_ingress_controller_requests', filter=filter('status', '4*') and ${module.filter-tags.filter_custom}, rollup='delta', extrapolation='zero')${var.ingress_4xx_aggregation_function}${var.ingress_4xx_transformation_function}
    B = data('nginx_ingress_controller_requests', ${module.filter-tags.filter_custom}, rollup='delta', extrapolation='zero')${var.ingress_4xx_aggregation_function}${var.ingress_4xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.ingress_4xx_threshold_critical}), lasting='${var.ingress_4xx_lasting_duration_seconds}s', at_least=${var.ingress_4xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.ingress_4xx_threshold_warning}), lasting='${var.ingress_4xx_lasting_duration_seconds}s', at_least=${var.ingress_4xx_at_least_percentage}) and when(signal <= ${var.ingress_4xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.ingress_4xx_threshold_warning}, lasting='${var.ingress_4xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.ingress_4xx_threshold_critical}, lasting='${var.ingress_4xx_lasting_duration_seconds}s', at_least=${var.ingress_4xx_at_least_percentage})), mode='paired').publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.ingress_4xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.ingress_4xx_disabled_critical, var.ingress_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.ingress_4xx_notifications_critical, var.ingress_4xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.ingress_4xx_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.ingress_4xx_disabled_warning, var.ingress_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.ingress_4xx_notifications_warning, var.ingress_4xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "nginx_ingress_latency" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Kubernetes Ingress Nginx latency"

  program_text = <<-EOF
    signal = data('nginx_ingress_controller_ingress_upstream_latency_seconds', ${module.filter-tags.filter_custom}, rollup='delta', extrapolation='zero')${var.ingress_latency_aggregation_function}${var.ingress_latency_transformation_function}
    detect(when(signal > threshold(${var.ingress_latency_threshold_critical}), lasting='${var.ingress_latency_lasting_duration_seconds}s', at_least=${var.ingress_latency_at_least_percentage})).publish('CRIT')
    detect((when(signal > threshold(${var.ingress_latency_threshold_warning}), lasting='${var.ingress_latency_lasting_duration_seconds}s', at_least=${var.ingress_latency_at_least_percentage}) and when(signal <= ${var.ingress_latency_threshold_critical})), off=(when(signal <= ${var.ingress_latency_threshold_warning}, lasting='${var.ingress_latency_lasting_duration_seconds / 2}s') or when(signal >= ${var.ingress_latency_threshold_critical}, lasting='${var.ingress_latency_lasting_duration_seconds}s', at_least=${var.ingress_latency_at_least_percentage})), mode='paired').publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.ingress_latency_threshold_critical}s"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.ingress_latency_disabled_critical, var.ingress_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.ingress_latency_notifications_critical, var.ingress_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.ingress_latency_threshold_warning}s"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.ingress_latency_disabled_warning, var.ingress_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.ingress_latency_notifications_warning, var.ingress_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

