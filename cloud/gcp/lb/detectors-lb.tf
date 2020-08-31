resource "signalfx_detector" "error_rate_4xx" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] GCP Load Balancer 4xx error rate"

  program_text = <<-EOF
    A = data('https/request_count', filter=filter('service', 'loadbalancing') and filter('response_code_class', '400')  and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.error_rate_4xx_aggregation_function}${var.error_rate_4xx_transformation_function}
    B = data('https/request_count', filter=filter('service', 'loadbalancing') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.error_rate_4xx_aggregation_function}${var.error_rate_4xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.error_rate_4xx_threshold_critical}), lasting='${var.error_rate_4xx_lasting_duration_seconds}s', at_least=${var.error_rate_4xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.error_rate_4xx_threshold_warning}), lasting='${var.error_rate_4xx_lasting_duration_seconds}s', at_least=${var.error_rate_4xx_at_least_percentage}) and when(signal <= ${var.error_rate_4xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.error_rate_4xx_threshold_warning}, lasting='${var.error_rate_4xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.error_rate_4xx_threshold_critical}, lasting='${var.error_rate_4xx_lasting_duration_seconds}s', at_least=${var.error_rate_4xx_at_least_percentage})), mode='paired').publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.error_rate_4xx_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.error_rate_4xx_disabled_critical, var.error_rate_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.error_rate_4xx_notifications_critical, var.error_rate_4xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.error_rate_4xx_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.error_rate_4xx_disabled_warning, var.error_rate_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.error_rate_4xx_notifications_warning, var.error_rate_4xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "error_rate_5xx" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] GCP Load Balancer 5xx error rate"

  program_text = <<-EOF
    A = data('https/request_count', filter=filter('service', 'loadbalancing') and filter('response_code_class', '400')  and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.error_rate_5xx_aggregation_function}${var.error_rate_5xx_transformation_function}
    B = data('https/request_count', filter=filter('service', 'loadbalancing') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.error_rate_5xx_aggregation_function}${var.error_rate_5xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.error_rate_5xx_threshold_critical}), lasting='${var.error_rate_5xx_lasting_duration_seconds}s', at_least=${var.error_rate_5xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.error_rate_5xx_threshold_warning}), lasting='${var.error_rate_5xx_lasting_duration_seconds}s', at_least=${var.error_rate_5xx_at_least_percentage}) and when(signal <= ${var.error_rate_5xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.error_rate_5xx_threshold_warning}, lasting='${var.error_rate_5xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.error_rate_5xx_threshold_critical}, lasting='${var.error_rate_5xx_lasting_duration_seconds}s', at_least=${var.error_rate_5xx_at_least_percentage})), mode='paired').publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.error_rate_5xx_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.error_rate_5xx_disabled_critical, var.error_rate_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.error_rate_5xx_notifications_critical, var.error_rate_5xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.error_rate_5xx_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.error_rate_5xx_disabled_warning, var.error_rate_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.error_rate_5xx_notifications_warning, var.error_rate_5xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "backend_latency_service" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] GCP Load Balancer backend latency by service"

  program_text = <<-EOF
    signal = data('https/backend_latencies', filter=filter('service', 'loadbalancing') and filter('backend_target_type', 'BACKEND_SERVICE') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='average')${var.backend_latency_service_aggregation_function}${var.backend_latency_service_transformation_function}.publish('signal')
    detect(when(signal > threshold(${var.backend_latency_service_threshold_critical}), lasting='${var.backend_latency_service_lasting_duration_seconds}s', at_least=${var.backend_latency_service_at_least_percentage})).publish('CRIT')
    detect((when(signal > threshold(${var.backend_latency_service_threshold_warning}), lasting='${var.backend_latency_service_lasting_duration_seconds}s', at_least=${var.backend_latency_service_at_least_percentage}) and when(signal <= ${var.backend_latency_service_threshold_critical})), off=(when(signal <= ${var.backend_latency_service_threshold_warning}, lasting='${var.backend_latency_service_lasting_duration_seconds / 2}s') or when(signal >= ${var.backend_latency_service_threshold_critical}, lasting='${var.backend_latency_service_lasting_duration_seconds}s', at_least=${var.backend_latency_service_at_least_percentage})), mode='paired').publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.backend_latency_service_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_latency_service_disabled_critical, var.backend_latency_service_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.backend_latency_service_notifications_critical, var.backend_latency_service_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.backend_latency_service_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.backend_latency_service_disabled_warning, var.backend_latency_service_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.backend_latency_service_notifications_warning, var.backend_latency_service_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "backend_latency_bucket" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] GCP Load Balancer backend latency by bucket"

  program_text = <<-EOF
    signal = data('https/backend_latencies', filter=filter('service', 'loadbalancing') and filter('backend_target_type', 'BACKEND_BUCKET') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='average')${var.backend_latency_bucket_aggregation_function}${var.backend_latency_bucket_transformation_function}.publish('signal')
    detect(when(signal > threshold(${var.backend_latency_bucket_threshold_critical}), lasting='${var.backend_latency_bucket_lasting_duration_seconds}s', at_least=${var.backend_latency_bucket_at_least_percentage})).publish('CRIT')
    detect((when(signal > threshold(${var.backend_latency_bucket_threshold_warning}), lasting='${var.backend_latency_bucket_lasting_duration_seconds}s', at_least=${var.backend_latency_bucket_at_least_percentage}) and when(signal <= ${var.backend_latency_bucket_threshold_critical})), off=(when(signal <= ${var.backend_latency_bucket_threshold_warning}, lasting='${var.backend_latency_bucket_lasting_duration_seconds / 2}s') or when(signal >= ${var.backend_latency_bucket_threshold_critical}, lasting='${var.backend_latency_bucket_lasting_duration_seconds}s', at_least=${var.backend_latency_bucket_at_least_percentage})), mode='paired').publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.backend_latency_bucket_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_latency_bucket_disabled_critical, var.backend_latency_bucket_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.backend_latency_bucket_notifications_critical, var.backend_latency_bucket_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.backend_latency_bucket_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.backend_latency_bucket_disabled_warning, var.backend_latency_bucket_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.backend_latency_bucket_notifications_warning, var.backend_latency_bucket_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "request_count" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] GCP Load Balancer request count"

  program_text = <<-EOF
    signal = data('https/request_count', filter=filter('service', 'loadbalancing') and ${module.filter-tags.filter_custom}, extrapolation='last_value', rollup='sum')${var.request_count_aggregation_function}${var.request_count_transformation_function}.rateofchange().publish('signal')
    detect(when(signal > threshold(${var.request_count_threshold_warning}))).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.request_count_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.request_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.request_count_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

