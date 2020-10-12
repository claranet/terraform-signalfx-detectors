# Monitoring Api Gateway latency
resource "signalfx_detector" "latency" {
  name = format("%s %s", local.detector_name_prefix, "AWS ApiGateway latency")

  program_text = <<-EOF
    signal = data('Latency', filter=filter('namespace', 'AWS/ApiGateway') and filter('stat', 'sum') and (not filter('Stage', '*')) and (not filter('Method', '*')) and (not filter('Resource', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='average')${var.latency_aggregation_function}${var.latency_transformation_function}.publish('signal')
    detect(when(signal > threshold(${var.latency_threshold_critical}), lasting='${var.latency_lasting_duration_seconds}s', at_least=${var.latency_at_least_percentage})).publish('CRIT')
    detect((when(signal > threshold(${var.latency_threshold_major}), lasting='${var.latency_lasting_duration_seconds}s', at_least=${var.latency_at_least_percentage}) and when(signal <= ${var.latency_threshold_critical})), off=(when(signal <= ${var.latency_threshold_major}, lasting='${var.latency_lasting_duration_seconds / 2}s') or when(signal >= ${var.latency_threshold_critical}, lasting='${var.latency_lasting_duration_seconds}s', at_least=${var.latency_at_least_percentage})), mode='paired').publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.latency_threshold_critical}ms"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.latency_disabled_critical, var.latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.latency_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.latency_threshold_major}ms"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.latency_disabled_major, var.latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.latency_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

# Monitoring API Gateway 5xx errors percent
resource "signalfx_detector" "http_5xx" {
  name = format("%s %s", local.detector_name_prefix, "AWS ApiGateway HTTP 5xx error rate")

  program_text = <<-EOF
    A = data('${var.is_v2 ? "5xx" : "5XXError"}', filter=filter('namespace', 'AWS/ApiGateway') and filter('stat', 'sum') and (not filter('Stage', '*')) and (not filter('Method', '*')) and (not filter('Resource', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.http_5xx_aggregation_function}${var.http_5xx_transformation_function}
    B = data('Count', filter=filter('namespace', 'AWS/ApiGateway') and filter('stat', 'sum') and (not filter('Stage', '*')) and (not filter('Method', '*')) and (not filter('Resource', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.http_5xx_aggregation_function}${var.http_5xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.http_5xx_threshold_critical}), lasting='${var.http_5xx_lasting_duration_seconds}s', at_least=${var.http_5xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.http_5xx_threshold_major}), lasting='${var.http_5xx_lasting_duration_seconds}s', at_least=${var.http_5xx_at_least_percentage}) and when(signal <= ${var.http_5xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.http_5xx_threshold_major}, lasting='${var.http_5xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.http_5xx_threshold_critical}, lasting='${var.http_5xx_lasting_duration_seconds}s', at_least=${var.http_5xx_at_least_percentage})), mode='paired').publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.http_5xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_5xx_disabled_critical, var.http_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_5xx_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.http_5xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_5xx_disabled_major, var.http_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_5xx_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

# Monitoring API Gateway 4xx errors percent
resource "signalfx_detector" "http_4xx" {
  name = format("%s %s", local.detector_name_prefix, "AWS ApiGateway HTTP 4xx error rate")

  program_text = <<-EOF
    A = data('${var.is_v2 ? "4xx" : "4XXError"}', filter=filter('namespace', 'AWS/ApiGateway') and filter('stat', 'sum') and (not filter('Stage', '*')) and (not filter('Method', '*')) and (not filter('Resource', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.http_4xx_aggregation_function}${var.http_4xx_transformation_function}
    B = data('Count', filter=filter('namespace', 'AWS/ApiGateway') and filter('stat', 'sum') and (not filter('Stage', '*')) and (not filter('Method', '*')) and (not filter('Resource', '*')) and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.http_4xx_aggregation_function}${var.http_4xx_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.http_4xx_threshold_critical}), lasting='${var.http_4xx_lasting_duration_seconds}s', at_least=${var.http_4xx_at_least_percentage}) and when(B > ${var.minimum_traffic})).publish('CRIT')
    detect((when(signal > threshold(${var.http_4xx_threshold_major}), lasting='${var.http_4xx_lasting_duration_seconds}s', at_least=${var.http_4xx_at_least_percentage}) and when(signal <= ${var.http_4xx_threshold_critical}) and when(B > ${var.minimum_traffic})), off=(when(signal <= ${var.http_4xx_threshold_major}, lasting='${var.http_4xx_lasting_duration_seconds / 2}s') or when(signal >= ${var.http_4xx_threshold_critical}, lasting='${var.http_4xx_lasting_duration_seconds}s', at_least=${var.http_4xx_at_least_percentage})), mode='paired').publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.http_4xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_4xx_disabled_critical, var.http_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_4xx_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.http_4xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_4xx_disabled_major, var.http_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_4xx_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

