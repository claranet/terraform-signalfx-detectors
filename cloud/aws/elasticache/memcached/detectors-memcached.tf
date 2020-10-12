resource "signalfx_detector" "hit_ratio" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache memcached hit ratio")

  program_text = <<-EOF
    A = data('GetHits', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.hit_ratio_aggregation_function}${var.hit_ratio_transformation_function}
    B = data('GetMisses', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.hit_ratio_aggregation_function}${var.hit_ratio_transformation_function}
    signal = (A / (A+B)).fill(value=1).scale(100).publish('signal')
    detect(when(signal < threshold(${var.hit_ratio_threshold_critical}), lasting='${var.hit_ratio_lasting_duration_seconds}s', at_least=${var.hit_ratio_at_least_percentage})).publish('CRIT')
    detect((when(signal < threshold(${var.hit_ratio_threshold_major}), lasting='${var.hit_ratio_lasting_duration_seconds}s', at_least=${var.hit_ratio_at_least_percentage}) and when(signal >= ${var.hit_ratio_threshold_critical})), off=(when(signal >= ${var.hit_ratio_threshold_major}, lasting='${var.hit_ratio_lasting_duration_seconds / 2}s') or when(signal <= ${var.hit_ratio_threshold_critical}, lasting='${var.hit_ratio_lasting_duration_seconds}s', at_least=${var.hit_ratio_at_least_percentage})), mode='paired').publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.hit_ratio_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.hit_ratio_disabled_critical, var.hit_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.hit_ratio_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too low < ${var.hit_ratio_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.hit_ratio_disabled_major, var.hit_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.hit_ratio_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "cpu" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache memcached CPU")

  program_text = <<-EOF
    signal = data('CPUUtilization', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.cpu_aggregation_function}${var.cpu_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_threshold_major}) and when(signal <= ${var.cpu_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_disabled_critical, var.cpu_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.cpu_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_disabled_major, var.cpu_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

