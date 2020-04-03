resource "signalfx_detector" "heartbeat" {
 	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Redis heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('RequestCount', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom})
		not_reporting.detector(stream=signal, resource_identifier=['host'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "evicted_keys" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Redis evicted keys"

	program_text = <<-EOF
		signal = data('counter.evicted_keys', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom})${var.evicted_keys_aggregation_function}.${var.evicted_keys_transformation_function}(over='${var.evicted_keys_transformation_window}').publish('signal')
		detect(when(signal > ${var.evicted_keys_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.evicted_keys_threshold_warning}) and when(signal < ${var.evicted_keys_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.evicted_keys_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.evicted_keys_disabled_critical, var.evicted_keys_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.evicted_keys_notifications_critical, var.evicted_keys_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.evicted_keys_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.evicted_keys_disabled_warning, var.evicted_keys_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.evicted_keys_notifications_warning, var.evicted_keys_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "expirations" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Redis expired keys"

	program_text = <<-EOF
		signal = data('counter.expired_keys', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom})${var.expirations_aggregation_function}.${var.expirations_transformation_function}(over='${var.expirations_transformation_window}').publish('signal')
		detect(when(signal > ${var.expirations_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.expirations_threshold_warning}) and when(signal < ${var.expirations_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.expirations_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.expirations_disabled_critical, var.expirations_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.expirations_notifications_critical, var.expirations_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.expirations_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.expirations_disabled_warning, var.expirations_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.expirations_notifications_warning, var.expirations_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "blocked_clients" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Redis blocked clients"

	program_text = <<-EOF
		A = data('gauge.blocked_clients', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom})${var.blocked_clients_aggregation_function}
		B = data('gauge.connected_clients', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom})${var.blocked_clients_aggregation_function}
		signal = ((A/B)*100).${var.blocked_clients_transformation_function}(over='${var.blocked_clients_transformation_window}').publish('signal')
		detect(when(signal > 30)).publish('CRIT')
	EOF

	rule {
		description           = "is too high > ${var.blocked_clients_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.blocked_clients_disabled_critical, var.blocked_clients_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.blocked_clients_notifications_critical, var.blocked_clients_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.blocked_clients_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.blocked_clients_disabled_warning, var.blocked_clients_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.blocked_clients_notifications_warning, var.blocked_clients_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "keyspace_full" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Redis keyspace"

	program_text = <<-EOF
		signal = data('gauge.db0_keys', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom})${var.keyspace_full_aggregation_function}.delta().abs().${var.keyspace_full_transformation_function}(over='${var.keyspace_full_transformation_window}').publish('signal')
		detect(when(signal > ${var.keyspace_full_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.keyspace_full_threshold_warning}) and when(signal < ${var.keyspace_full_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.keyspace_full_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.keyspace_full_disabled_critical, var.keyspace_full_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.keyspace_full_notifications_critical, var.keyspace_full_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.keyspace_full_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.keyspace_full_disabled_warning, var.keyspace_full_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.keyspace_full_notifications_warning, var.keyspace_full_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "memory_used" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Redis memory used"

	program_text = <<-EOF
		A = data('bytes.used_memory', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom})${var.memory_used_aggregation_function}
		B = data('bytes.used_memory_peak', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom})${var.memory_used_aggregation_function}
		signal = ((A/B)*100).${var.memory_used_transformation_function}(over='${var.memory_used_transformation_window}').publish('signal')
		detect(when(signal > ${var.memory_used_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.memory_used_threshold_warning}) and when(signal < ${var.memory_used_threshold_critical})).publish('WARN')
	EOF

rule {
		description           = "is too high > ${var.memory_used_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.memory_used_disabled_critical, var.memory_used_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.memory_used_notifications_critical, var.memory_used_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.memory_used_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.memory_used_disabled_warning, var.memory_used_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.memory_used_notifications_warning, var.memory_used_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "memory_frag" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Redis memory fragmented"

	program_text = <<-EOF
		A = data('gauge.mem_fragmentation_ratio', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom})${var.memory_frag_aggregation_function}
		signal = (A*100).${var.memory_frag_transformation_function}(over='${var.memory_frag_transformation_window}').publish('signal')
		detect(when(signal > ${var.memory_frag_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.memory_frag_threshold_warning}) and when(signal < ${var.memory_frag_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.memory_frag_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.memory_frag_disabled_critical, var.memory_frag_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.memory_frag_notifications_critical, var.memory_frag_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.memory_frag_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.memory_frag_disabled_warning, var.memory_frag_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.memory_frag_notifications_warning, var.memory_frag_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "rejected_connections" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Redis rejected connections"

	program_text = <<-EOF
		signal = data('counter.rejected_connections', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom})${var.rejected_connections_aggregation_function}.${var.rejected_connections_transformation_function}(over='${var.rejected_connections_transformation_window}').publish('signal')
		detect(when(signal > ${var.rejected_connections_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.rejected_connections_threshold_warning}) and when(signal < ${var.rejected_connections_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.rejected_connections_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.rejected_connections_disabled_critical, var.rejected_connections_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.rejected_connections_notifications_critical, var.rejected_connections_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.rejected_connections_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.rejected_connections_disabled_warning, var.rejected_connections_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.rejected_connections_notifications_warning, var.rejected_connections_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "hitrate" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Redis hitrate"

	program_text = <<-EOF
		A = data('derive.keyspace_hits', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom})${var.hitrate_aggregation_function}
		B = data('derive.keyspace_misses', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom})${var.hitrate_aggregation_function}
		signal = ((A/(A+B))*100).${var.hitrate_transformation_function}(over='${var.hitrate_transformation_window}').publish('signal')
		detect(when(signal < ${var.hitrate_threshold_critical})).publish('CRIT')
		detect(when(signal < ${var.hitrate_threshold_warning}) and when(signal > ${var.hitrate_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too low < ${var.hitrate_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.hitrate_disabled_critical, var.hitrate_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.hitrate_notifications_critical, var.hitrate_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too low < ${var.hitrate_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.hitrate_disabled_warning, var.hitrate_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.hitrate_notifications_warning, var.hitrate_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}
