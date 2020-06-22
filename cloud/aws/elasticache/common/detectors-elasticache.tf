resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ElastiCache heartbeat"

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('CPUUtilization', filter=filter('stat', 'mean') and filter('namespace', 'AWS/ElastiCache') and (not filter('CacheNodeId', '*')) and (not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}')) and ${module.filter-tags.filter_custom}).publish('signal')
		not_reporting.detector(stream=signal, resource_identifier=['CacheClusterId'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "evictions" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ElastiCache evictions"

  program_text = <<-EOF
		signal = data('Evictions', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.evictions_aggregation_function}.${var.evictions_transformation_function}(over='${var.evictions_transformation_window}').publish('signal')
		detect(when(signal > ${var.evictions_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.evictions_threshold_warning}) and when(signal <= ${var.evictions_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.evictions_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.evictions_disabled_critical, var.evictions_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.evictions_notifications_critical, var.evictions_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.evictions_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.evictions_disabled_warning, var.evictions_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.evictions_notifications_warning, var.evictions_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "max_connection" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ElastiCache connections over max allowed"

  program_text = <<-EOF
		signal = data('CurrConnections', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'upper') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.max_connection_aggregation_function}.${var.max_connection_transformation_function}(over='${var.max_connection_transformation_window}').publish('signal')
		detect(when(signal > ${var.max_connection_threshold_critical})).publish('CRIT')
	EOF

  rule {
    description           = "is too high > ${var.max_connection_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.max_connection_disabled_critical, var.max_connection_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.max_connection_notifications_critical, var.max_connection_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "no_connection" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ElastiCache current connections"

  program_text = <<-EOF
		signal = data('CurrConnections', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'lower') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.no_connection_aggregation_function}.${var.no_connection_transformation_function}(over='${var.no_connection_transformation_window}').publish('signal')
		detect(when(signal <= ${var.no_connection_threshold_critical})).publish('CRIT')
	EOF

  rule {
    description           = "are too low <= ${var.no_connection_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.no_connection_disabled_critical, var.no_connection_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.no_connection_notifications_critical, var.no_connection_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "swap" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ElastiCache swap"

  program_text = <<-EOF
		signal = data('SwapUsage', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'upper') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.swap_aggregation_function}.${var.swap_transformation_function}(over='${var.swap_transformation_window}').publish('signal')
		detect(when(signal > ${var.swap_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.swap_threshold_warning}) and when(signal <= ${var.swap_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = "is too high > ${var.swap_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.swap_disabled_critical, var.swap_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.swap_notifications_critical, var.swap_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.swap_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.swap_disabled_warning, var.swap_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.swap_notifications_warning, var.swap_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "free_memory" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ElastiCache freeable memory"

  program_text = <<-EOF
		signal = data('FreeableMemory', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'lower') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom}).rateofchange()${var.free_memory_aggregation_function}.${var.free_memory_transformation_function}(over='${var.free_memory_transformation_window}').publish('signal')
		detect(when(signal < ${var.free_memory_threshold_critical})).publish('CRIT')
		detect(when(signal < ${var.free_memory_threshold_warning}) and when(signal >= ${var.free_memory_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = "is too low < ${var.free_memory_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.free_memory_disabled_critical, var.free_memory_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.free_memory_notifications_critical, var.free_memory_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too low < ${var.free_memory_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.free_memory_disabled_warning, var.free_memory_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.free_memory_notifications_warning, var.free_memory_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "evictions_growing" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ElastiCache evictions changing rate grows"

  program_text = <<-EOF
		A = data('Evictions', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom}).rateofchange().${var.evictions_growing_transformation_function}(over='${var.evictions_growing_transformation_window}')
		signal = (A*100).publish('signal')
		detect(when(signal > ${var.evictions_growing_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.evictions_growing_threshold_warning}) and when(signal <= ${var.evictions_growing_threshold_critical})).publish('WARN')
	EOF

  rule {
    description           = "too fast > ${var.evictions_growing_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.evictions_growing_disabled_critical, var.evictions_growing_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.evictions_growing_notifications_critical, var.evictions_growing_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "too fast > ${var.evictions_growing_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.evictions_growing_disabled_warning, var.evictions_growing_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.evictions_growing_notifications_warning, var.evictions_growing_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}
