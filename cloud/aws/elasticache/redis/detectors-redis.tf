resource "signalfx_detector" "cache_hits" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ElastiCache redis cache hit ratio"

	program_text = <<-EOF
		A = data('CacheHits', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.cache_hits_aggregation_function}
		B = data('CacheMisses', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.cache_hits_aggregation_function}
		signal = (A/(A+B)).scale(100).${var.cache_hits_transformation_function}(over='${var.cache_hits_transformation_window}').publish('signal')
		detect(when(signal < ${var.cache_hits_threshold_critical})).publish('CRIT')
		detect(when(signal < ${var.cache_hits_threshold_warning}) and when(signal > ${var.cache_hits_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too low < ${var.cache_hits_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.cache_hits_disabled_critical, var.cache_hits_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.cache_hits_notifications_critical, var.cache_hits_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too low < ${var.cache_hits_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.cache_hits_disabled_warning, var.cache_hits_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.cache_hits_notifications_warning, var.cache_hits_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "cpu_high" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ElastiCache redis CPU"

	program_text = <<-EOF
		signal = data('EngineCPUUtilization', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'upper') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.cpu_high_aggregation_function}.${var.cpu_high_transformation_function}(over='${var.cpu_high_transformation_window}').publish('signal')
		detect(when(signal > ${var.cpu_high_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.cpu_high_threshold_warning}) and when(signal < ${var.cpu_high_threshold_critical})).publish('WARN')
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

resource "signalfx_detector" "replication_lag" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ElastiCache redis replication lag"

	program_text = <<-EOF
		signal = data('ReplicationLag', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'upper') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.replication_lag_aggregation_function}.${var.replication_lag_transformation_function}(over='${var.replication_lag_transformation_window}').publish('signal')
		detect(when(signal > ${var.replication_lag_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.replication_lag_threshold_warning}) and when(signal < ${var.replication_lag_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.replication_lag_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.replication_lag_disabled_critical, var.replication_lag_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.replication_lag_notifications_critical, var.replication_lag_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.replication_lag_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.replication_lag_disabled_warning, var.replication_lag_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.replication_lag_notifications_warning, var.replication_lag_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "commands" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS ElastiCache redis commands"

	program_text = <<-EOF
		A = data('GetTypeCmds', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'lower') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.commands_aggregation_function}
		B = data('SetTypeCmds', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'lower') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.commands_aggregation_function}
		signal = (A + B).${var.commands_transformation_function}(over='${var.commands_transformation_window}').publish('signal')
		detect(when(signal <= ${var.commands_threshold_critical})).publish('CRIT')
		detect(when(signal <= ${var.commands_threshold_warning}) and when(signal >= ${var.commands_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "are too low <= ${var.commands_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.commands_disabled_critical, var.commands_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.commands_notifications_critical, var.commands_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "are too low <= ${var.commands_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.commands_disabled_warning, var.commands_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.commands_notifications_warning, var.commands_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}
