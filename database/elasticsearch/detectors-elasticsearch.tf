resource "signalfx_detector" "heartbeat" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ElasticSearch heartbeat"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('elasticsearch.cluster.status', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}).publish('signal')
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

resource "signalfx_detector" "cluster_status_not_green" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ElasticSearch cluster status not green"

	program_text = <<-EOF
		signal = data('elasticsearch.cluster.status', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom})${var.cluster_status_not_green_aggregation_function}.${var.cluster_status_not_green_transformation_function}(over='${var.cluster_status_not_green_transformation_window}').publish('signal')
		detect(when(signal >= ${var.cluster_status_not_green_threshold_critical})).publish('CRIT')
		detect(when(signal >= ${var.cluster_status_not_green_threshold_warning}) and when(signal < ${var.cluster_status_not_green_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is above critical capacity >= ${var.cluster_status_not_green_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.cluster_status_not_green_disabled_critical, var.cluster_status_not_green_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.cluster_status_not_green_notifications_critical, var.cluster_status_not_green_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is above nominal capacity >= ${var.cluster_status_not_green_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.cluster_status_not_green_disabled_warning, var.cluster_status_not_green_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.cluster_status_not_green_notifications_warning, var.cluster_status_not_green_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "cluster_initializing_shards" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ElasticSearch cluster initializing shards"

	program_text = <<-EOF
		signal = data('elasticsearch.cluster.initializing-shards', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom})${var.cluster_initializing_shards_aggregation_function}.${var.cluster_initializing_shards_transformation_function}(over='${var.cluster_initializing_shards_transformation_window}').publish('signal')
		detect(when(signal > ${var.cluster_initializing_shards_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.cluster_initializing_shards_threshold_warning}) and when(signal < ${var.cluster_initializing_shards_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.cluster_initializing_shards_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.cluster_initializing_shards_disabled_critical, var.cluster_initializing_shards_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.cluster_initializing_shards_notifications_critical, var.cluster_initializing_shards_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.cluster_initializing_shards_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.cluster_initializing_shards_disabled_warning, var.cluster_initializing_shards_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.cluster_initializing_shards_notifications_warning, var.cluster_initializing_shards_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "cluster_relocating_shards" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ElasticSearch cluster relocating shards"

	program_text = <<-EOF
		signal = data('elasticsearch.cluster.relocating-shards', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom})${var.cluster_relocating_shards_aggregation_function}.${var.cluster_relocating_shards_transformation_function}(over='${var.cluster_relocating_shards_transformation_window}').publish('signal')
		detect(when(signal > ${var.cluster_relocating_shards_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.cluster_relocating_shards_threshold_warning}) and when(signal < ${var.cluster_relocating_shards_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.cluster_relocating_shards_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.cluster_relocating_shards_disabled_critical, var.cluster_relocating_shards_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.cluster_relocating_shards_notifications_critical, var.cluster_relocating_shards_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.cluster_relocating_shards_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.cluster_relocating_shards_disabled_warning, var.cluster_relocating_shards_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.cluster_relocating_shards_notifications_warning, var.cluster_relocating_shards_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "cluster_unassigned_shards" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ElasticSearch Cluster unassigned shards"

	program_text = <<-EOF
		signal = data('gauge.cluster.unassigned-shards', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom})${var.cluster_unassigned_shards_aggregation_function}.${var.cluster_unassigned_shards_transformation_function}(over='${var.cluster_unassigned_shards_transformation_window}').publish('signal')
		detect(when(signal > ${var.cluster_unassigned_shards_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.cluster_unassigned_shards_threshold_warning}) and when(signal < ${var.cluster_unassigned_shards_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.cluster_unassigned_shards_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.cluster_unassigned_shards_disabled_critical, var.cluster_unassigned_shards_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.cluster_unassigned_shards_notifications_critical, var.cluster_unassigned_shards_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.cluster_unassigned_shards_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.cluster_unassigned_shards_disabled_warning, var.cluster_unassigned_shards_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.cluster_unassigned_shards_notifications_warning, var.cluster_unassigned_shards_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "jvm_heap_memory_usage" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch JVM heap memory usage"

	program_text = <<-EOF
		signal = data('elasticsearch.jvm.mem.heap-used', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}){var.jvm_heap_memory_usage_aggregation_function}.${var.jvm_heap_memory_usage_transformation_function}(over='${var.jvm_heap_memory_usage_transformation_window}').publish('signal')
		detect(when(signal > ${var.jvm_heap_memory_usage_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.jvm_heap_memory_usage_threshold_warning}) and when(signal < ${var.jvm_heap_memory_usage_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.jvm_heap_memory_usage_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.jvm_heap_memory_usage_disabled_critical, var.jvm_heap_memory_usage_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.jvm_heap_memory_usage_notifications_critical, var.jvm_heap_memory_usage_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
 		description           = "is too high > ${var.jvm_heap_memory_usage_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.jvm_heap_memory_usage_disabled_warning, var.jvm_heap_memory_usage_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.jvm_heap_memory_usage_notifications_warning, var.jvm_heap_memory_usage_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "jvm_memory_young_usage" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch JVM memory young usage"

	program_text = <<-EOF
		A = data('elasticsearch.jvm.mem.pools.young.used_in_bytes', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom})${var.jvm_memory_young_usage_aggregation_function}
		B = data('elasticsearch.jvm.mem.pools.young.max_in_bytes', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom})${var.jvm_memory_young_usage_aggregation_function}
		signal = (A/B).scale(100).${var.jvm_memory_young_usage_transformation_function}(over='${var.jvm_memory_young_usage_transformation_window}').publish('signal')
		detect(when(signal > ${var.jvm_memory_young_usage_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.jvm_memory_young_usage_threshold_warning}) and when(signal < ${var.jvm_memory_young_usage_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.jvm_memory_young_usage_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.jvm_memory_young_usage_disabled_critical, var.jvm_memory_young_usage_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.jvm_memory_young_usage_notifications_critical, var.jvm_memory_young_usage_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.jvm_memory_young_usage_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.jvm_memory_young_usage_disabled_warning, var.jvm_memory_young_usage_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.jvm_memory_young_usage_notifications_warning, var.jvm_memory_young_usage_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "jvm_memory_old_usage" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch JVM memory old usage"

	program_text = <<-EOF
		A = data('elasticsearch.jvm.mem.pools.old.used_in_bytes', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom})${var.jvm_memory_old_usage_aggregation_function}
		B = data('elasticsearch.jvm.mem.pools.old.max_in_bytes', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom})${var.jvm_memory_old_usage_aggregation_function}
		signal = (A/B).scale(100).${var.jvm_memory_old_usage_transformation_function}(over='${var.jvm_memory_old_usage_transformation_window}').publish('signal')
		detect(when(signal > ${var.jvm_memory_old_usage_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.jvm_memory_old_usage_threshold_warning}) and when(signal < ${var.jvm_memory_old_usage_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.jvm_memory_old_usage_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.jvm_memory_old_usage_disabled_critical, var.jvm_memory_old_usage_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.jvm_memory_old_usage_notifications_critical, var.jvm_memory_old_usage_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.jvm_memory_old_usage_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.jvm_memory_old_usage_disabled_warning, var.jvm_memory_old_usage_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.jvm_memory_old_usage_notifications_warning, var.jvm_memory_old_usage_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "jvm_gc_old_collection_latency" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch average old-generation garbage collections latency"

	program_text = <<-EOF
		from signalfx.detectors.aperiodic import aperiodic
		A = data('elasticsearch.jvm.gc.old-time', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}).delta()${var.jvm_gc_old_collection_latency_aggregation_function}
		B = data('elasticsearch.jvm.gc.count', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}).delta()${var.jvm_gc_old_collection_latency_aggregation_function}
		signal = (A/B).scale(1000).${var.jvm_gc_old_collection_latency_transformation_function}(over='${var.jvm_gc_old_collection_latency_transformation_window}').publish('signal')
		aperiodic.above_or_below_detector(signal, ${var.jvm_gc_old_collection_latency_threshold_critical}, 'above', lasting('${var.jvm_gc_old_collection_latency_aperiodic_duration}', ${var.jvm_gc_old_collection_latency_aperiodic_percentage})).publish('CRIT')
		aperiodic.above_or_below_detector(signal, ${var.jvm_gc_old_collection_latency_threshold_warning}, 'above', lasting('${var.jvm_gc_old_collection_latency_aperiodic_duration}', ${var.jvm_gc_old_collection_latency_aperiodic_percentage})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.jvm_gc_old_collection_latency_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.jvm_gc_old_collection_latency_disabled_critical, var.jvm_gc_old_collection_latency_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.jvm_gc_old_collection_latency_notifications_critical, var.jvm_gc_old_collection_latency_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.jvm_gc_old_collection_latency_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.jvm_gc_old_collection_latency_disabled_warning, var.jvm_gc_old_collection_latency_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.jvm_gc_old_collection_latency_notifications_warning, var.jvm_gc_old_collection_latency_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "jvm_gc_young_collection_latency" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch average young-generation garbage collections latency"

	program_text = <<-EOF
		from signalfx.detectors.aperiodic import aperiodic
		A = data('elasticsearch.jvm.gc.time', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}).delta()${var.jvm_gc_young_collection_latency_aggregation_function}
		B = data('elasticsearch.jvm.gc.count', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}).delta()${var.jvm_gc_young_collection_latency_aggregation_function}
		signal = (A/B).scale(1000).${var.jvm_gc_young_collection_latency_transformation_function}(over='${var.jvm_gc_young_collection_latency_transformation_window}').publish('signal')
		aperiodic.above_or_below_detector(signal, ${var.jvm_gc_young_collection_latency_threshold_critical}, 'above', lasting('${var.jvm_gc_young_collection_latency_aperiodic_duration}', ${var.jvm_gc_young_collection_latency_aperiodic_percentage})).publish('CRIT')
		aperiodic.above_or_below_detector(signal, ${var.jvm_gc_young_collection_latency_threshold_warning}, 'above', lasting('${var.jvm_gc_young_collection_latency_aperiodic_duration}', ${var.jvm_gc_young_collection_latency_aperiodic_percentage})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.jvm_gc_young_collection_latency_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.jvm_gc_young_collection_latency_disabled_critical, var.jvm_gc_young_collection_latency_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.jvm_gc_young_collection_latency_notifications_critical, var.jvm_gc_young_collection_latency_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.jvm_gc_young_collection_latency_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.jvm_gc_young_collection_latency_disabled_warning, var.jvm_gc_young_collection_latency_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.jvm_gc_young_collection_latency_notifications_warning, var.jvm_gc_young_collection_latency_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "indexing_latency" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch average indexing latency by document"

	program_text = <<-EOF
		from signalfx.detectors.aperiodic import aperiodic
		A = data('elasticsearch.indices.indexing.index-time', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}).delta()${var.indexing_latency_aggregation_function}
		B = data('elasticsearch.indices.indexing.index-total', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}).delta()${var.indexing_latency_aggregation_function}
		signal = (A/B).scale(1000).${var.indexing_latency_transformation_function}(over='${var.indexing_latency_transformation_window}').publish('signal')
		aperiodic.above_or_below_detector(signal, ${var.indexing_latency_threshold_critical}, 'above', lasting('${var.indexing_latency_aperiodic_duration}', ${var.indexing_latency_aperiodic_percentage})).publish('CRIT')
		aperiodic.above_or_below_detector(signal, ${var.indexing_latency_threshold_warning}, 'above', lasting('${var.indexing_latency_aperiodic_duration}', ${var.indexing_latency_aperiodic_percentage})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.indexing_latency_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.indexing_latency_disabled_critical, var.indexing_latency_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.indexing_latency_notifications_critical, var.indexing_latency_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.indexing_latency_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.indexing_latency_disabled_warning, var.indexing_latency_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.indexing_latency_notifications_warning, var.indexing_latency_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "flush_latency" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch average index flushing to disk latency"

	program_text = <<-EOF
		from signalfx.detectors.aperiodic import aperiodic
		A = data('elasticsearch.indices.flush.total-time', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}).delta()${var.flush_latency_aggregation_function}
		B = data('elasticsearch.indices.flush.total', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}).delta()${var.flush_latency_aggregation_function}
		signal = (A/B).scale(1000).${var.flush_latency_transformation_function}(over='${var.flush_latency_transformation_window}').publish('signal')
		aperiodic.above_or_below_detector(signal, ${var.flush_latency_threshold_critical}, 'above', lasting('${var.flush_latency_aperiodic_duration}', ${var.flush_latency_aperiodic_percentage})).publish('CRIT')
		aperiodic.above_or_below_detector(signal, ${var.flush_latency_threshold_warning}, 'above', lasting('${var.flush_latency_aperiodic_duration}', ${var.flush_latency_aperiodic_percentage})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.flush_latency_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.flush_latency_disabled_critical, var.flush_latency_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.flush_latency_notifications_critical, var.flush_latency_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.flush_latency_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.flush_latency_disabled_warning, var.flush_latency_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.flush_latency_notifications_warning, var.flush_latency_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "search_query_latency" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch average search query latency"

	program_text = <<-EOF
		from signalfx.detectors.aperiodic import aperiodic
		A = data('elasticsearch.indices.search.query-time', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}).delta()${var.search_query_latency_aggregation_function}
		B = data('elasticsearch.indices.search.query-total', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}).delta()${var.search_query_latency_aggregation_function}
		signal = (A/B).scale(1000).${var.search_query_latency_transformation_function}(over='${var.search_query_latency_transformation_window}').publish('signal')
		aperiodic.above_or_below_detector(signal, ${var.search_query_latency_threshold_critical}, 'above', lasting('${var.search_query_latency_aperiodic_duration}', ${var.search_query_latency_aperiodic_percentage})).publish('CRIT')
		aperiodic.above_or_below_detector(signal, ${var.search_query_latency_threshold_warning}, 'above', lasting('${var.search_query_latency_aperiodic_duration}', ${var.search_query_latency_aperiodic_percentage})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.search_query_latency_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.search_query_latency_disabled_critical, var.search_query_latency_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.search_query_latency_notifications_critical, var.search_query_latency_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.search_query_latency_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.search_query_latency_disabled_warning, var.search_query_latency_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.search_query_latency_notifications_warning, var.search_query_latency_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "fetch_latency" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch average search fetch latency"

	program_text = <<-EOF
		A = data('counter.indices.search.fetch-time', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}).delta()${var.fetch_latency_aggregation_function}
		B = data('counter.indices.search.fetch-total', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}).delta()${var.fetch_latency_aggregation_function}
		signal = (A/B).scale(1000).${var.fetch_latency_transformation_function}(over='${var.fetch_latency_transformation_window}').publish('signal')
		aperiodic.above_or_below_detector(signal, ${var.fetch_latency_threshold_critical}, 'above', lasting('${var.fetch_latency_aperiodic_duration}', ${var.fetch_latency_aperiodic_percentage})).publish('CRIT')
		aperiodic.above_or_below_detector(signal, ${var.fetch_latency_threshold_warning}, 'above', lasting('${var.fetch_latency_aperiodic_duration}', ${var.fetch_latency_aperiodic_percentage})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.fetch_latency_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.fetch_latency_disabled_critical, var.fetch_latency_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.fetch_latency_notifications_critical, var.fetch_latency_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.fetch_latency_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.fetch_latency_disabled_warning, var.fetch_latency_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.fetch_latency_notifications_warning, var.fetch_latency_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}
}

resource "signalfx_detector" "search_query_change" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch change alert on the number of currently active queries"

	program_text = <<-EOF
		signal = data('elasticsearch.indices.search.query-current', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}).rateofchange()${var.search_query_change_aggregation_function}.${var.search_query_change_transformation_function}(over='${var.search_query_change_transformation_window}').publish('signal')
		detect(when(signal >= ${var.search_query_change_threshold_critical})).publish('CRIT')
		detect(when(signal >= ${var.search_query_change_threshold_warning}) and when(signal < ${var.search_query_change_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high >= ${var.search_query_change_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.search_query_change_disabled_critical, var.search_query_change_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.search_query_change_notifications_critical, var.search_query_change_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high >= ${var.search_query_change_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.search_query_change_disabled_warning, var.search_query_change_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.search_query_change_notifications_warning, var.search_query_change_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "fetch_change" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch change on the number of search fetches currently running"

	program_text = <<-EOF
		signal = data('elasticsearch.indices.search.fetch-current', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}).rateofchange()${var.fetch_change_aggregation_function}.${var.fetch_change_transformation_function}(over='${var.fetch_change_transformation_window}').publish('signal')
		detect(when(signal >= ${var.fetch_change_threshold_critical})).publish('CRIT')
		detect(when(signal >= ${var.fetch_change_threshold_warning}) and when(signal < ${var.fetch_change_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high >= ${var.fetch_change_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.fetch_change_disabled_critical, var.fetch_change_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.fetch_change_notifications_critical, var.fetch_change_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high >= ${var.fetch_change_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.fetch_change_disabled_warning, var.fetch_change_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.fetch_change_notifications_warning, var.fetch_change_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "field_data_evictions_change" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch change alert on the total number of evictions from the fielddata cache"

	program_text = <<-EOF
		signal = data('elasticsearch.indices.fielddata.evictions', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}).rateofchange()${var.field_data_evictions_change_aggregation_function}.${var.field_data_evictions_change_transformation_function}(over='${var.field_data_evictions_change_transformation_window}').publish('signal')
		detect(when(signal > ${var.field_data_evictions_change_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.field_data_evictions_change_threshold_warning}) and when(signal < ${var.field_data_evictions_change_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.field_data_evictions_change_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.field_data_evictions_change_disabled_critical, var.field_data_evictions_change_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.field_data_evictions_change_notifications_critical, var.field_data_evictions_change_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.field_data_evictions_change_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.field_data_evictions_change_disabled_warning, var.field_data_evictions_change_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.field_data_evictions_change_notifications_warning, var.field_data_evictions_change_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "query_cache_evictions_change" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch change alert on the number of query cache evictions"

	program_text = <<-EOF
		signal = data('elasticsearch.indices.query-cache.evictions', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}).rateofchange()${var.query_cache_evictions_change_aggregation_function}.${var.query_cache_evictions_change_transformation_function}(over='${var.query_cache_evictions_change_transformation_window}').publish('signal')
		detect(when(signal > ${var.query_cache_evictions_change_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.query_cache_evictions_change_threshold_warning}) and when(signal < ${var.query_cache_evictions_change_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.query_cache_evictions_change_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.query_cache_evictions_change_disabled_critical, var.query_cache_evictions_change_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.query_cache_evictions_change_notifications_critical, var.query_cache_evictions_change_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.query_cache_evictions_change_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.query_cache_evictions_change_disabled_warning, var.query_cache_evictions_change_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.query_cache_evictions_change_notifications_warning, var.query_cache_evictions_change_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "request_cache_evictions_change" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch change alert on the number of request cache evictions"

	program_text = <<-EOF
		signal = data('elasticsearch.indices.request-cache.evictions', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}).rateofchange()${var.request_cache_evictions_change_aggregation_function}.${var.request_cache_evictions_change_transformation_function}(over='${var.request_cache_evictions_change_transformation_window}').publish('signal')
		detect(when(signal > ${var.request_cache_evictions_change_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.request_cache_evictions_change_threshold_warning}) and when(signal < ${var.request_cache_evictions_change_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.request_cache_evictions_change_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.request_cache_evictions_change_disabled_critical, var.request_cache_evictions_change_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.request_cache_evictions_change_notifications_critical, var.request_cache_evictions_change_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.request_cache_evictions_change_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.request_cache_evictions_change_disabled_warning, var.request_cache_evictions_change_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.request_cache_evictions_change_notifications_warning, var.request_cache_evictions_change_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}

resource "signalfx_detector" "task_time_in_queue_change" {
	name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch change alert on the average time spent by tasks in the queue"

	program_text = <<-EOF
		signal = data('elasticsearch.cluster.task-max-wait-time', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}).rateofchange()${var.task_time_in_queue_change_aggregation_function}.${var.task_time_in_queue_change_transformation_function}(over='${var.task_time_in_queue_change_transformation_window}').publish('signal')
		detect(when(signal > ${var.task_time_in_queue_change_threshold_critical})).publish('CRIT')
		detect(when(signal > ${var.task_time_in_queue_change_threshold_warning}) and when(signal < ${var.task_time_in_queue_change_threshold_critical})).publish('WARN')
	EOF

	rule {
		description           = "is too high > ${var.task_time_in_queue_change_threshold_critical}"
		severity              = "Critical"
		detect_label          = "CRIT"
		disabled              = coalesce(var.task_time_in_queue_change_disabled_critical, var.task_time_in_queue_change_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.task_time_in_queue_change_notifications_critical, var.task_time_in_queue_change_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

	rule {
		description           = "is too high > ${var.task_time_in_queue_change_threshold_warning}"
		severity              = "Warning"
		detect_label          = "WARN"
		disabled              = coalesce(var.task_time_in_queue_change_disabled_warning, var.task_time_in_queue_change_disabled, var.detectors_disabled)
		notifications         = coalescelist(var.task_time_in_queue_change_notifications_warning, var.task_time_in_queue_change_notifications, var.notifications)
		parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
	}

}
