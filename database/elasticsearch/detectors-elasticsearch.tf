resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ElasticSearch heartbeat"

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('elasticsearch.cluster.number-of-nodes', filter=filter('plugin', 'elasticsearch') and (not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}')) and (not filter('gcp_status', '{Code=3, Name=STOPPING}', '{Code=4, Name=TERMINATED}')) and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stoppped', 'PowerState/deallocating', 'PowerState/deallocated')) and ${module.filter-tags.filter_custom}).publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "cluster_status" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ElasticSearch cluster status"

  program_text = <<-EOF
    signal = data('elasticsearch.cluster.status', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, rollup='average')${var.cluster_status_aggregation_function}${var.cluster_status_transformation_function}.publish('signal')
    detect(when(signal == 1)).publish('CRIT')
    detect(when(signal == 2)).publish('WARN')
EOF

  rule {
    description           = "is red"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cluster_status_disabled_critical, var.cluster_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.cluster_status_notifications_critical, var.cluster_status_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is yellow"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.cluster_status_disabled_warning, var.cluster_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.cluster_status_notifications_warning, var.cluster_status_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "cluster_initializing_shards" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ElasticSearch cluster initializing shards"

  program_text = <<-EOF
    signal = data('elasticsearch.cluster.initializing-shards', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, rollup='average')${var.cluster_initializing_shards_aggregation_function}${var.cluster_initializing_shards_transformation_function}.publish('signal')
    detect(when(signal > ${var.cluster_initializing_shards_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.cluster_initializing_shards_threshold_warning}) and when(signal <= ${var.cluster_initializing_shards_threshold_critical})).publish('WARN')
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
    signal = data('elasticsearch.cluster.relocating-shards', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, rollup='average')${var.cluster_relocating_shards_aggregation_function}${var.cluster_relocating_shards_transformation_function}.publish('signal')
    detect(when(signal > ${var.cluster_relocating_shards_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.cluster_relocating_shards_threshold_warning}) and when(signal <= ${var.cluster_relocating_shards_threshold_critical})).publish('WARN')
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
    signal = data('elasticsearch.cluster.unassigned-shards', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, rollup='average')${var.cluster_unassigned_shards_aggregation_function}${var.cluster_unassigned_shards_transformation_function}.publish('signal')
    detect(when(signal > ${var.cluster_unassigned_shards_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.cluster_unassigned_shards_threshold_warning}) and when(signal <= ${var.cluster_unassigned_shards_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "are too high > ${var.cluster_unassigned_shards_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cluster_unassigned_shards_disabled_critical, var.cluster_unassigned_shards_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.cluster_unassigned_shards_notifications_critical, var.cluster_unassigned_shards_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too high > ${var.cluster_unassigned_shards_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.cluster_unassigned_shards_disabled_warning, var.cluster_unassigned_shards_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.cluster_unassigned_shards_notifications_warning, var.cluster_unassigned_shards_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "pending_tasks" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] ElasticSearch Pending tasks"

  program_text = <<-EOF
    signal = data('elasticsearch.cluster.pending-tasks', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, rollup='average')${var.pending_tasks_aggregation_function}${var.pending_tasks_transformation_function}.publish('signal')
    detect(when(signal > ${var.pending_tasks_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.pending_tasks_threshold_warning}) and when(signal <= ${var.pending_tasks_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "are too high > ${var.pending_tasks_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.pending_tasks_disabled_critical, var.pending_tasks_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.pending_tasks_notifications_critical, var.pending_tasks_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too high > ${var.pending_tasks_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.pending_tasks_disabled_warning, var.pending_tasks_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.pending_tasks_notifications_warning, var.pending_tasks_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "cpu_usage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch CPU usage"

  program_text = <<-EOF
    signal = data('elasticsearch.process.cpu.percent', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, rollup='average')${var.cpu_usage_aggregation_function}${var.cpu_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_usage_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_usage_threshold_warning}) and when(signal <= ${var.cpu_usage_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.cpu_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_usage_disabled_critical, var.cpu_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.cpu_usage_notifications_critical, var.cpu_usage_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.cpu_usage_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.cpu_usage_disabled_warning, var.cpu_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.cpu_usage_notifications_warning, var.cpu_usage_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "file_descriptors" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch file descriptors usage"

  program_text = <<-EOF
    A = data('elasticsearch.process.open_file_descriptors', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, rollup='average')${var.file_descriptors_aggregation_function}${var.file_descriptors_transformation_function}
    B = data('elasticsearch.process.max_file_descriptors', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, rollup='average')${var.file_descriptors_aggregation_function}${var.file_descriptors_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.file_descriptors_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.file_descriptors_threshold_warning}) and when(signal <= ${var.file_descriptors_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.file_descriptors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.file_descriptors_disabled_critical, var.file_descriptors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_descriptors_notifications_critical, var.file_descriptors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.file_descriptors_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.file_descriptors_disabled_warning, var.file_descriptors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_descriptors_notifications_warning, var.file_descriptors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "jvm_heap_memory_usage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch JVM heap memory usage"

  program_text = <<-EOF
    signal = data('elasticsearch.jvm.mem.heap-used-percent', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, rollup='average')${var.jvm_heap_memory_usage_aggregation_function}${var.jvm_heap_memory_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.jvm_heap_memory_usage_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.jvm_heap_memory_usage_threshold_warning}) and when(signal <= ${var.jvm_heap_memory_usage_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.jvm_heap_memory_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.jvm_heap_memory_usage_disabled_critical, var.jvm_heap_memory_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.jvm_heap_memory_usage_notifications_critical, var.jvm_heap_memory_usage_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.jvm_heap_memory_usage_threshold_warning}%"
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
    A = data('elasticsearch.jvm.mem.pools.young.used_in_bytes', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, rollup='average')${var.jvm_memory_young_usage_aggregation_function}${var.jvm_memory_young_usage_transformation_function}
    B = data('elasticsearch.jvm.mem.pools.young.max_in_bytes', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, rollup='average')${var.jvm_memory_young_usage_aggregation_function}${var.jvm_memory_young_usage_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.jvm_memory_young_usage_threshold_warning})).publish('WARN')
    detect(when(signal > ${var.jvm_memory_young_usage_threshold_major}) and when(signal <= ${var.jvm_memory_young_usage_threshold_warning})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.jvm_memory_young_usage_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.jvm_memory_young_usage_disabled_warning, var.jvm_memory_young_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.jvm_memory_young_usage_notifications_warning, var.jvm_memory_young_usage_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.jvm_memory_young_usage_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.jvm_memory_young_usage_disabled_major, var.jvm_memory_young_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.jvm_memory_young_usage_notifications_major, var.jvm_memory_young_usage_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "jvm_memory_old_usage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch JVM memory old usage"

  program_text = <<-EOF
    A = data('elasticsearch.jvm.mem.pools.old.used_in_bytes', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, rollup='average')${var.jvm_memory_old_usage_aggregation_function}${var.jvm_memory_old_usage_transformation_function}
    B = data('elasticsearch.jvm.mem.pools.old.max_in_bytes', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, rollup='average')${var.jvm_memory_old_usage_aggregation_function}${var.jvm_memory_old_usage_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.jvm_memory_old_usage_threshold_warning})).publish('WARN')
    detect(when(signal > ${var.jvm_memory_old_usage_threshold_major}) and when(signal <= ${var.jvm_memory_old_usage_threshold_warning})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.jvm_memory_old_usage_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.jvm_memory_old_usage_disabled_warning, var.jvm_memory_old_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.jvm_memory_old_usage_notifications_warning, var.jvm_memory_old_usage_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.jvm_memory_old_usage_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.jvm_memory_old_usage_disabled_major, var.jvm_memory_old_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.jvm_memory_old_usage_notifications_major, var.jvm_memory_old_usage_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "jvm_gc_old_collection_latency" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch old-generation garbage collections latency"

  program_text = <<-EOF
    A = data('elasticsearch.jvm.gc.old-time', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.jvm_gc_old_collection_latency_aggregation_function}${var.jvm_gc_old_collection_latency_transformation_function}
    B = data('elasticsearch.jvm.gc.count', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.jvm_gc_old_collection_latency_aggregation_function}${var.jvm_gc_old_collection_latency_transformation_function}
    signal = (A/B).fill(0).scale(1000).publish('signal')
    detect(when(signal > ${var.jvm_gc_old_collection_latency_threshold_warning})).publish('WARN')
    detect(when(signal > ${var.jvm_gc_old_collection_latency_threshold_major}) and when(signal <= ${var.jvm_gc_old_collection_latency_threshold_warning})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.jvm_gc_old_collection_latency_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.jvm_gc_old_collection_latency_disabled_warning, var.jvm_gc_old_collection_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.jvm_gc_old_collection_latency_notifications_warning, var.jvm_gc_old_collection_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.jvm_gc_old_collection_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.jvm_gc_old_collection_latency_disabled_major, var.jvm_gc_old_collection_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.jvm_gc_old_collection_latency_notifications_major, var.jvm_gc_old_collection_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "jvm_gc_young_collection_latency" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch young-generation garbage collections latency"

  program_text = <<-EOF
    A = data('elasticsearch.jvm.gc.time', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.jvm_gc_young_collection_latency_aggregation_function}${var.jvm_gc_young_collection_latency_transformation_function}
    B = data('elasticsearch.jvm.gc.count', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.jvm_gc_young_collection_latency_aggregation_function}${var.jvm_gc_young_collection_latency_transformation_function}
    signal = (A/B).fill(0).scale(1000).publish('signal')
    detect(when(signal > ${var.jvm_gc_young_collection_latency_threshold_warning})).publish('WARN')
    detect(when(signal > ${var.jvm_gc_young_collection_latency_threshold_major}) and when(signal <= ${var.jvm_gc_young_collection_latency_threshold_warning})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.jvm_gc_young_collection_latency_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.jvm_gc_young_collection_latency_disabled_warning, var.jvm_gc_young_collection_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.jvm_gc_young_collection_latency_notifications_warning, var.jvm_gc_young_collection_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.jvm_gc_young_collection_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.jvm_gc_young_collection_latency_disabled_major, var.jvm_gc_young_collection_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.jvm_gc_young_collection_latency_notifications_major, var.jvm_gc_young_collection_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "indexing_latency" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch indexing latency"

  program_text = <<-EOF
    A = data('elasticsearch.indices.indexing.index-time', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.indexing_latency_aggregation_function}${var.indexing_latency_transformation_function}
    B = data('elasticsearch.indices.indexing.index-total', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.indexing_latency_aggregation_function}${var.indexing_latency_transformation_function}
    signal = (A/B).fill(0).scale(1000).publish('signal')
    detect(when(signal > ${var.indexing_latency_threshold_warning})).publish('WARN')
    detect(when(signal > ${var.indexing_latency_threshold_major}) and when(signal <= ${var.indexing_latency_threshold_warning})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.indexing_latency_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.indexing_latency_disabled_warning, var.indexing_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.indexing_latency_notifications_warning, var.indexing_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.indexing_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.indexing_latency_disabled_major, var.indexing_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.indexing_latency_notifications_major, var.indexing_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "flush_latency" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch index flushing to disk latency"

  program_text = <<-EOF
    A = data('elasticsearch.indices.flush.total-time', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.flush_latency_aggregation_function}${var.flush_latency_transformation_function}
    B = data('elasticsearch.indices.flush.total', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.flush_latency_aggregation_function}${var.flush_latency_transformation_function}
    signal = (A/B).fill(0).scale(1000).publish('signal')
    detect(when(signal > ${var.flush_latency_threshold_warning})).publish('WARN')
    detect(when(signal > ${var.flush_latency_threshold_major}) and when(signal <= ${var.flush_latency_threshold_warning})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.flush_latency_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.flush_latency_disabled_warning, var.flush_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.flush_latency_notifications_warning, var.flush_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.flush_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.flush_latency_disabled_major, var.flush_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.flush_latency_notifications_major, var.flush_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "search_latency" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch search query latency"

  program_text = <<-EOF
    A = data('elasticsearch.indices.search.query-time', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.search_latency_aggregation_function}${var.search_latency_transformation_function}
    B = data('elasticsearch.indices.search.query-total', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.search_latency_aggregation_function}${var.search_latency_transformation_function}
    signal = (A/B).fill(0).scale(1000).publish('signal')
    detect(when(signal > ${var.search_latency_threshold_warning})).publish('WARN')
    detect(when(signal > ${var.search_latency_threshold_major}) and when(signal <= ${var.search_latency_threshold_warning})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.search_latency_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.search_latency_disabled_warning, var.search_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.search_latency_notifications_warning, var.search_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.search_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.search_latency_disabled_major, var.search_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.search_latency_notifications_major, var.search_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "fetch_latency" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch search fetch latency"

  program_text = <<-EOF
    A = data('elasticsearch.indices.search.fetch-time', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.fetch_latency_aggregation_function}${var.fetch_latency_transformation_function}
    B = data('elasticsearch.indices.search.fetch-total', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.fetch_latency_aggregation_function}${var.fetch_latency_transformation_function}
    signal = (A/B).fill(0).scale(1000).publish('signal')
    detect(when(signal > ${var.fetch_latency_threshold_warning})).publish('WARN')
    detect(when(signal > ${var.fetch_latency_threshold_major}) and when(signal <= ${var.fetch_latency_threshold_warning})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.fetch_latency_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.fetch_latency_disabled_warning, var.fetch_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.fetch_latency_notifications_warning, var.fetch_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.fetch_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.fetch_latency_disabled_major, var.fetch_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.fetch_latency_notifications_major, var.fetch_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "field_data_evictions_change" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch fielddata cache evictions rate of change"

  program_text = <<-EOF
    signal = data('elasticsearch.indices.fielddata.evictions', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta').rateofchange()${var.field_data_evictions_change_aggregation_function}${var.field_data_evictions_change_transformation_function}.publish('signal')
    detect(when(signal > ${var.field_data_evictions_change_threshold_warning})).publish('WARN')
    detect(when(signal > ${var.field_data_evictions_change_threshold_major}) and when(signal <= ${var.field_data_evictions_change_threshold_warning})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.field_data_evictions_change_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.field_data_evictions_change_disabled_warning, var.field_data_evictions_change_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.field_data_evictions_change_notifications_warning, var.field_data_evictions_change_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.field_data_evictions_change_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.field_data_evictions_change_disabled_major, var.field_data_evictions_change_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.field_data_evictions_change_notifications_major, var.field_data_evictions_change_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "query_cache_evictions_change" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch query cache evictions rate of change"

  program_text = <<-EOF
    signal = data('elasticsearch.indices.query-cache.evictions', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta').rateofchange()${var.query_cache_evictions_change_aggregation_function}${var.query_cache_evictions_change_transformation_function}.publish('signal')
    detect(when(signal > ${var.query_cache_evictions_change_threshold_warning})).publish('WARN')
    detect(when(signal > ${var.query_cache_evictions_change_threshold_major}) and when(signal <= ${var.query_cache_evictions_change_threshold_warning})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.query_cache_evictions_change_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.query_cache_evictions_change_disabled_warning, var.query_cache_evictions_change_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.query_cache_evictions_change_notifications_warning, var.query_cache_evictions_change_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.query_cache_evictions_change_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.query_cache_evictions_change_disabled_major, var.query_cache_evictions_change_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.query_cache_evictions_change_notifications_major, var.query_cache_evictions_change_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "request_cache_evictions_change" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch request cache evictions rate of change"

  program_text = <<-EOF
    signal = data('elasticsearch.indices.request-cache.evictions', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta').rateofchange()${var.request_cache_evictions_change_aggregation_function}${var.request_cache_evictions_change_transformation_function}
    detect(when(signal > ${var.request_cache_evictions_change_threshold_warning})).publish('WARN')
    detect(when(signal > ${var.request_cache_evictions_change_threshold_major}) and when(signal <= ${var.request_cache_evictions_change_threshold_warning})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.request_cache_evictions_change_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.request_cache_evictions_change_disabled_warning, var.request_cache_evictions_change_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.request_cache_evictions_change_notifications_warning, var.request_cache_evictions_change_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.request_cache_evictions_change_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.request_cache_evictions_change_disabled_major, var.request_cache_evictions_change_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.request_cache_evictions_change_notifications_major, var.request_cache_evictions_change_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "task_time_in_queue_change" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Elasticsearch max time spent by task in queue rate of change"

  program_text = <<-EOF
    signal = data('elasticsearch.cluster.task-max-wait-time', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, rollup='average').rateofchange()${var.task_time_in_queue_change_aggregation_function}${var.task_time_in_queue_change_transformation_function}.publish('signal')
    detect(when(signal > ${var.task_time_in_queue_change_threshold_warning})).publish('WARN')
    detect(when(signal > ${var.task_time_in_queue_change_threshold_major}) and when(signal <= ${var.task_time_in_queue_change_threshold_warning})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.task_time_in_queue_change_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.task_time_in_queue_change_disabled_warning, var.task_time_in_queue_change_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.task_time_in_queue_change_notifications_warning, var.task_time_in_queue_change_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.task_time_in_queue_change_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.task_time_in_queue_change_disabled_major, var.task_time_in_queue_change_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.task_time_in_queue_change_notifications_major, var.task_time_in_queue_change_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}
