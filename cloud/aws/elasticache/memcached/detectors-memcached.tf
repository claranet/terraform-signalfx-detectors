resource "signalfx_detector" "get_hits" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ElastiCache memcached hit ratio"

  program_text = <<-EOF
		from signalfx.detectors.aperiodic import aperiodic
		A = data('GetHits', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.get_hits_aggregation_function}
		B = data('GetMisses', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.get_hits_aggregation_function}
		signal = (A/(A+B)).scale(100).${var.get_hits_transformation_function}(over='${var.get_hits_transformation_window}').publish('signal')
		aperiodic.above_or_below_detector(signal, ${var.get_hits_threshold_critical}, 'below', lasting('${var.get_hits_aperiodic_duration}', ${var.get_hits_aperiodic_percentage})).publish('CRIT')
		aperiodic.range_detector(signal, ${var.get_hits_threshold_warning}, ${var.get_hits_threshold_critical}, 'within_range', lasting('${var.get_hits_aperiodic_duration}', ${var.get_hits_aperiodic_percentage}), upper_strict=${var.get_hits_aperiodic_upper_strict}).publish('WARN')
	EOF

  rule {
    description           = "is too low < ${var.get_hits_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.get_hits_disabled_critical, var.get_hits_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.get_hits_notifications_critical, var.get_hits_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too low < ${var.get_hits_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.get_hits_disabled_warning, var.get_hits_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.get_hits_notifications_warning, var.get_hits_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "cpu_high" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ElastiCache memcached CPU"

  program_text = <<-EOF
		signal = data('CPUUtilization', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.cpu_high_aggregation_function}.${var.cpu_high_transformation_function}(over='${var.cpu_high_transformation_window}').publish('signal')
		detect(when(signal > ${var.cpu_high_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.cpu_high_threshold_warning}) and when(signal <= ${var.cpu_high_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.cpu_high_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_high_disabled_critical, var.cpu_high_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.cpu_high_notifications_critical, var.cpu_high_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.cpu_high_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.cpu_high_disabled_warning, var.cpu_high_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.cpu_high_notifications_warning, var.cpu_high_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}
