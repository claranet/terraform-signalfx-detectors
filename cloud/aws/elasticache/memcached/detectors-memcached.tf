resource "signalfx_detector" "hit_ratio" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ElastiCache memcached hit ratio"

  program_text = <<-EOF
    A = data('GetHits', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.hit_ratio_aggregation_function}${var.hit_ratio_transformation_function}
    B = data('GetMisses', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.hit_ratio_aggregation_function}${var.hit_ratio_transformation_function}
    signal = (A/(A+B)).fill(value=1).scale(100).publish('signal')
    detect(when(signal < threshold(${var.hit_ratio_threshold_critical}), lasting='${var.hit_ratio_lasting_duration_seconds}s', at_least=${var.hit_ratio_at_least_percentage})).publish('CRIT')
    detect((when(signal < threshold(${var.hit_ratio_threshold_warning}), lasting='${var.hit_ratio_lasting_duration_seconds}s', at_least=${var.hit_ratio_at_least_percentage}) and when(signal >= ${var.hit_ratio_threshold_critical})), off=(when(signal >= ${var.hit_ratio_threshold_warning}, lasting='${var.hit_ratio_lasting_duration_seconds / 2}s') or when(signal <= ${var.hit_ratio_threshold_critical}, lasting='${var.hit_ratio_lasting_duration_seconds}s', at_least=${var.hit_ratio_at_least_percentage})), mode='paired').publish('WARN')
EOF

  rule {
    description           = "is too low < ${var.hit_ratio_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.hit_ratio_disabled_critical, var.hit_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.hit_ratio_notifications_critical, var.hit_ratio_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too low < ${var.hit_ratio_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.hit_ratio_disabled_warning, var.hit_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.hit_ratio_notifications_warning, var.hit_ratio_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "cpu" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ElastiCache memcached CPU"

  program_text = <<-EOF
    signal = data('CPUUtilization', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.cpu_aggregation_function}.${var.cpu_transformation_function}(over='${var.cpu_transformation_window}').publish('signal')
    detect(when(signal > ${var.cpu_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_threshold_warning}) and when(signal <= ${var.cpu_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.cpu_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_disabled_critical, var.cpu_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.cpu_notifications_critical, var.cpu_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.cpu_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.cpu_disabled_warning, var.cpu_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.cpu_notifications_warning, var.cpu_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}
