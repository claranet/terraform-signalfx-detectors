resource "signalfx_detector" "error_rate_4xx" {
  name = format("%s %s", local.detector_name_prefix, "GCP Load Balancer 4xx error rate")

  program_text = <<-EOF
    A = data('https/request_count', filter=filter('service', 'loadbalancing') and filter('response_code_class', '400')  and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.error_rate_4xx_aggregation_function}${var.error_rate_4xx_transformation_function}
    B = data('https/request_count', filter=filter('service', 'loadbalancing') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.error_rate_4xx_aggregation_function}${var.error_rate_4xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.error_rate_4xx_threshold_critical}), lasting='${var.error_rate_4xx_lasting_duration_seconds}s', at_least=${var.error_rate_4xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.error_rate_4xx_threshold_major}), lasting='${var.error_rate_4xx_lasting_duration_seconds}s', at_least=${var.error_rate_4xx_at_least_percentage}) and when(signal <= ${var.error_rate_4xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.error_rate_4xx_threshold_major}, lasting='${var.error_rate_4xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.error_rate_4xx_threshold_critical}, lasting='${var.error_rate_4xx_lasting_duration_seconds}s', at_least=${var.error_rate_4xx_at_least_percentage})), mode='paired').publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.error_rate_4xx_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.error_rate_4xx_disabled_critical, var.error_rate_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.error_rate_4xx_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.error_rate_4xx_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.error_rate_4xx_disabled_major, var.error_rate_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.error_rate_4xx_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "error_rate_5xx" {
  name = format("%s %s", local.detector_name_prefix, "GCP Load Balancer 5xx error rate")

  program_text = <<-EOF
    A = data('https/request_count', filter=filter('service', 'loadbalancing') and filter('response_code_class', '400')  and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.error_rate_5xx_aggregation_function}${var.error_rate_5xx_transformation_function}
    B = data('https/request_count', filter=filter('service', 'loadbalancing') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.error_rate_5xx_aggregation_function}${var.error_rate_5xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.error_rate_5xx_threshold_critical}), lasting='${var.error_rate_5xx_lasting_duration_seconds}s', at_least=${var.error_rate_5xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.error_rate_5xx_threshold_major}), lasting='${var.error_rate_5xx_lasting_duration_seconds}s', at_least=${var.error_rate_5xx_at_least_percentage}) and when(signal <= ${var.error_rate_5xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.error_rate_5xx_threshold_major}, lasting='${var.error_rate_5xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.error_rate_5xx_threshold_critical}, lasting='${var.error_rate_5xx_lasting_duration_seconds}s', at_least=${var.error_rate_5xx_at_least_percentage})), mode='paired').publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.error_rate_5xx_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.error_rate_5xx_disabled_critical, var.error_rate_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.error_rate_5xx_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.error_rate_5xx_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.error_rate_5xx_disabled_major, var.error_rate_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.error_rate_5xx_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "backend_latency_service" {
  name = format("%s %s", local.detector_name_prefix, "GCP Load Balancer backend latency by service")

  program_text = <<-EOF
    signal = data('https/backend_latencies', filter=filter('service', 'loadbalancing') and filter('backend_target_type', 'BACKEND_SERVICE') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='average')${var.backend_latency_service_aggregation_function}${var.backend_latency_service_transformation_function}.publish('signal')
    detect(when(signal > threshold(${var.backend_latency_service_threshold_critical}), lasting='${var.backend_latency_service_lasting_duration_seconds}s', at_least=${var.backend_latency_service_at_least_percentage})).publish('CRIT')
    detect((when(signal > threshold(${var.backend_latency_service_threshold_major}), lasting='${var.backend_latency_service_lasting_duration_seconds}s', at_least=${var.backend_latency_service_at_least_percentage}) and when(signal <= ${var.backend_latency_service_threshold_critical})), off=(when(signal <= ${var.backend_latency_service_threshold_major}, lasting='${var.backend_latency_service_lasting_duration_seconds / 2}s') or when(signal >= ${var.backend_latency_service_threshold_critical}, lasting='${var.backend_latency_service_lasting_duration_seconds}s', at_least=${var.backend_latency_service_at_least_percentage})), mode='paired').publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.backend_latency_service_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_latency_service_disabled_critical, var.backend_latency_service_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_latency_service_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.backend_latency_service_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.backend_latency_service_disabled_major, var.backend_latency_service_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_latency_service_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "backend_latency_bucket" {
  name = format("%s %s", local.detector_name_prefix, "GCP Load Balancer backend latency by bucket")

  program_text = <<-EOF
    signal = data('https/backend_latencies', filter=filter('service', 'loadbalancing') and filter('backend_target_type', 'BACKEND_BUCKET') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='average')${var.backend_latency_bucket_aggregation_function}${var.backend_latency_bucket_transformation_function}.publish('signal')
    detect(when(signal > threshold(${var.backend_latency_bucket_threshold_critical}), lasting='${var.backend_latency_bucket_lasting_duration_seconds}s', at_least=${var.backend_latency_bucket_at_least_percentage})).publish('CRIT')
    detect((when(signal > threshold(${var.backend_latency_bucket_threshold_major}), lasting='${var.backend_latency_bucket_lasting_duration_seconds}s', at_least=${var.backend_latency_bucket_at_least_percentage}) and when(signal <= ${var.backend_latency_bucket_threshold_critical})), off=(when(signal <= ${var.backend_latency_bucket_threshold_major}, lasting='${var.backend_latency_bucket_lasting_duration_seconds / 2}s') or when(signal >= ${var.backend_latency_bucket_threshold_critical}, lasting='${var.backend_latency_bucket_lasting_duration_seconds}s', at_least=${var.backend_latency_bucket_at_least_percentage})), mode='paired').publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.backend_latency_bucket_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_latency_bucket_disabled_critical, var.backend_latency_bucket_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_latency_bucket_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.backend_latency_bucket_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.backend_latency_bucket_disabled_major, var.backend_latency_bucket_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_latency_bucket_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "request_count" {
  name = format("%s %s", local.detector_name_prefix, "GCP Load Balancer request count")

  program_text = <<-EOF
    signal = data('https/request_count', filter=filter('service', 'loadbalancing') and ${module.filter-tags.filter_custom}, extrapolation='last_value', rollup='sum')${var.request_count_aggregation_function}${var.request_count_transformation_function}.rateofchange().publish('signal')
    detect(when(signal > threshold(${var.request_count_threshold_major}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.request_count_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.request_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.request_count_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

