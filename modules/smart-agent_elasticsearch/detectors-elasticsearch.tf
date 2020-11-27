resource "signalfx_detector" "heartbeat" {
  name      = format("%s %s", local.detector_name_prefix, "ElasticSearch heartbeat")
  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('elasticsearch.cluster.number-of-nodes', filter=filter('plugin', 'elasticsearch') and ${local.not_running_vm_filters} and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "cluster_status" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch cluster status")

  program_text = <<-EOF
    signal = data('elasticsearch.cluster.status', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom})${var.cluster_status_aggregation_function}${var.cluster_status_transformation_function}.publish('signal')
    detect(when(signal == 1)).publish('MAJOR')
    detect(when(signal == 2)).publish('CRIT')
EOF

  rule {
    description           = "is red"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cluster_status_disabled_critical, var.cluster_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cluster_status_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is yellow"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cluster_status_disabled_major, var.cluster_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cluster_status_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "cluster_initializing_shards" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch cluster initializing shards")

  program_text = <<-EOF
    signal = data('elasticsearch.cluster.initializing-shards', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, rollup='average')${var.cluster_initializing_shards_aggregation_function}${var.cluster_initializing_shards_transformation_function}.publish('signal')
    detect(when(signal > ${var.cluster_initializing_shards_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.cluster_initializing_shards_threshold_major}) and when(signal <= ${var.cluster_initializing_shards_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cluster_initializing_shards_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cluster_initializing_shards_disabled_critical, var.cluster_initializing_shards_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cluster_initializing_shards_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.cluster_initializing_shards_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cluster_initializing_shards_disabled_major, var.cluster_initializing_shards_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cluster_initializing_shards_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "cluster_relocating_shards" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch cluster relocating shards")

  program_text = <<-EOF
    signal = data('elasticsearch.cluster.relocating-shards', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, rollup='average')${var.cluster_relocating_shards_aggregation_function}${var.cluster_relocating_shards_transformation_function}.publish('signal')
    detect(when(signal > ${var.cluster_relocating_shards_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.cluster_relocating_shards_threshold_major}) and when(signal <= ${var.cluster_relocating_shards_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cluster_relocating_shards_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cluster_relocating_shards_disabled_critical, var.cluster_relocating_shards_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cluster_relocating_shards_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.cluster_relocating_shards_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cluster_relocating_shards_disabled_major, var.cluster_relocating_shards_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cluster_relocating_shards_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "cluster_unassigned_shards" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch Cluster unassigned shards")

  program_text = <<-EOF
    signal = data('elasticsearch.cluster.unassigned-shards', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, rollup='average')${var.cluster_unassigned_shards_aggregation_function}${var.cluster_unassigned_shards_transformation_function}.publish('signal')
    detect(when(signal > ${var.cluster_unassigned_shards_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.cluster_unassigned_shards_threshold_major}) and when(signal <= ${var.cluster_unassigned_shards_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "are too high > ${var.cluster_unassigned_shards_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cluster_unassigned_shards_disabled_critical, var.cluster_unassigned_shards_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cluster_unassigned_shards_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "are too high > ${var.cluster_unassigned_shards_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cluster_unassigned_shards_disabled_major, var.cluster_unassigned_shards_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cluster_unassigned_shards_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "pending_tasks" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch Pending tasks")

  program_text = <<-EOF
    signal = data('elasticsearch.cluster.pending-tasks', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, rollup='average')${var.pending_tasks_aggregation_function}${var.pending_tasks_transformation_function}.publish('signal')
    detect(when(signal > ${var.pending_tasks_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.pending_tasks_threshold_major}) and when(signal <= ${var.pending_tasks_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "are too high > ${var.pending_tasks_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.pending_tasks_disabled_critical, var.pending_tasks_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.pending_tasks_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "are too high > ${var.pending_tasks_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.pending_tasks_disabled_major, var.pending_tasks_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.pending_tasks_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "cpu_usage" {
  name = format("%s %s", local.detector_name_prefix, "Elasticsearch CPU usage")

  program_text = <<-EOF
    signal = data('elasticsearch.process.cpu.percent', filter=filter('plugin', 'elasticsearch') and filter('node_name', '*') and ${module.filter-tags.filter_custom}, rollup='average')${var.cpu_usage_aggregation_function}${var.cpu_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_usage_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_usage_threshold_major}) and when(signal <= ${var.cpu_usage_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_usage_disabled_critical, var.cpu_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_usage_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.cpu_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_usage_disabled_major, var.cpu_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_usage_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "file_descriptors" {
  name = format("%s %s", local.detector_name_prefix, "Elasticsearch file descriptors usage")

  program_text = <<-EOF
    A = data('elasticsearch.process.open_file_descriptors', filter=filter('plugin', 'elasticsearch') and filter('node_name', '*') and ${module.filter-tags.filter_custom}, rollup='average')${var.file_descriptors_aggregation_function}${var.file_descriptors_transformation_function}
    B = data('elasticsearch.process.max_file_descriptors', filter=filter('plugin', 'elasticsearch') and filter('node_name', '*') and ${module.filter-tags.filter_custom}, rollup='average')${var.file_descriptors_aggregation_function}${var.file_descriptors_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.file_descriptors_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.file_descriptors_threshold_major}) and when(signal <= ${var.file_descriptors_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.file_descriptors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.file_descriptors_disabled_critical, var.file_descriptors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.file_descriptors_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.file_descriptors_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.file_descriptors_disabled_major, var.file_descriptors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.file_descriptors_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "jvm_heap_memory_usage" {
  name = format("%s %s", local.detector_name_prefix, "Elasticsearch JVM heap memory usage")

  program_text = <<-EOF
    signal = data('elasticsearch.jvm.mem.heap-used-percent', filter=filter('plugin', 'elasticsearch') and filter('node_name', '*') and ${module.filter-tags.filter_custom}, rollup='average')${var.jvm_heap_memory_usage_aggregation_function}${var.jvm_heap_memory_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.jvm_heap_memory_usage_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.jvm_heap_memory_usage_threshold_major}) and when(signal <= ${var.jvm_heap_memory_usage_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.jvm_heap_memory_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.jvm_heap_memory_usage_disabled_critical, var.jvm_heap_memory_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jvm_heap_memory_usage_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.jvm_heap_memory_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.jvm_heap_memory_usage_disabled_major, var.jvm_heap_memory_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jvm_heap_memory_usage_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "jvm_memory_young_usage" {
  name = format("%s %s", local.detector_name_prefix, "Elasticsearch JVM memory young usage")

  program_text = <<-EOF
    A = data('elasticsearch.jvm.mem.pools.young.used_in_bytes', filter=filter('plugin', 'elasticsearch') and filter('node_name', '*') and ${module.filter-tags.filter_custom}, rollup='average')${var.jvm_memory_young_usage_aggregation_function}${var.jvm_memory_young_usage_transformation_function}
    B = data('elasticsearch.jvm.mem.pools.young.max_in_bytes', filter=filter('plugin', 'elasticsearch') and filter('node_name', '*') and ${module.filter-tags.filter_custom}, rollup='average')${var.jvm_memory_young_usage_aggregation_function}${var.jvm_memory_young_usage_transformation_function}
    signal = (A/B).fill(0).scale(100).publish('signal')
    detect(when(signal > ${var.jvm_memory_young_usage_threshold_major})).publish('MAJOR')
    detect(when(signal > ${var.jvm_memory_young_usage_threshold_minor}) and when(signal <= ${var.jvm_memory_young_usage_threshold_major})).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.jvm_memory_young_usage_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.jvm_memory_young_usage_disabled_major, var.jvm_memory_young_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jvm_memory_young_usage_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.jvm_memory_young_usage_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.jvm_memory_young_usage_disabled_minor, var.jvm_memory_young_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jvm_memory_young_usage_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "jvm_memory_old_usage" {
  name = format("%s %s", local.detector_name_prefix, "Elasticsearch JVM memory old usage")

  program_text = <<-EOF
    A = data('elasticsearch.jvm.mem.pools.old.used_in_bytes', filter=filter('plugin', 'elasticsearch') and filter('node_name', '*') and ${module.filter-tags.filter_custom}, rollup='average')${var.jvm_memory_old_usage_aggregation_function}${var.jvm_memory_old_usage_transformation_function}
    B = data('elasticsearch.jvm.mem.pools.old.max_in_bytes', filter=filter('plugin', 'elasticsearch') and filter('node_name', '*') and ${module.filter-tags.filter_custom}, rollup='average')${var.jvm_memory_old_usage_aggregation_function}${var.jvm_memory_old_usage_transformation_function}
    signal = (A/B).fill(0).scale(100).publish('signal')
    detect(when(signal > ${var.jvm_memory_old_usage_threshold_major})).publish('MAJOR')
    detect(when(signal > ${var.jvm_memory_old_usage_threshold_minor}) and when(signal <= ${var.jvm_memory_old_usage_threshold_major})).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.jvm_memory_old_usage_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.jvm_memory_old_usage_disabled_major, var.jvm_memory_old_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jvm_memory_old_usage_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.jvm_memory_old_usage_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.jvm_memory_old_usage_disabled_minor, var.jvm_memory_old_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jvm_memory_old_usage_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "jvm_gc_old_collection_latency" {
  name = format("%s %s", local.detector_name_prefix, "Elasticsearch old-generation garbage collections latency")

  program_text = <<-EOF
    A = data('elasticsearch.jvm.gc.old-time', filter=filter('plugin', 'elasticsearch') and filter('node_name', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.jvm_gc_old_collection_latency_aggregation_function}${var.jvm_gc_old_collection_latency_transformation_function}
    B = data('elasticsearch.jvm.gc.old-count', filter=filter('plugin', 'elasticsearch') and filter('node_name', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.jvm_gc_old_collection_latency_aggregation_function}${var.jvm_gc_old_collection_latency_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal > ${var.jvm_gc_old_collection_latency_threshold_major})).publish('MAJOR')
    detect(when(signal > ${var.jvm_gc_old_collection_latency_threshold_minor}) and when(signal <= ${var.jvm_gc_old_collection_latency_threshold_major})).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.jvm_gc_old_collection_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.jvm_gc_old_collection_latency_disabled_major, var.jvm_gc_old_collection_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jvm_gc_old_collection_latency_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.jvm_gc_old_collection_latency_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.jvm_gc_old_collection_latency_disabled_minor, var.jvm_gc_old_collection_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jvm_gc_old_collection_latency_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "jvm_gc_young_collection_latency" {
  name = format("%s %s", local.detector_name_prefix, "Elasticsearch young-generation garbage collections latency")

  program_text = <<-EOF
    A = data('elasticsearch.jvm.gc.time', filter=filter('plugin', 'elasticsearch') and filter('node_name', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.jvm_gc_young_collection_latency_aggregation_function}${var.jvm_gc_young_collection_latency_transformation_function}
    B = data('elasticsearch.jvm.gc.count', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.jvm_gc_young_collection_latency_aggregation_function}${var.jvm_gc_young_collection_latency_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal > ${var.jvm_gc_young_collection_latency_threshold_major})).publish('MAJOR')
    detect(when(signal > ${var.jvm_gc_young_collection_latency_threshold_minor}) and when(signal <= ${var.jvm_gc_young_collection_latency_threshold_major})).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.jvm_gc_young_collection_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.jvm_gc_young_collection_latency_disabled_major, var.jvm_gc_young_collection_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jvm_gc_young_collection_latency_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.jvm_gc_young_collection_latency_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.jvm_gc_young_collection_latency_disabled_minor, var.jvm_gc_young_collection_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jvm_gc_young_collection_latency_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "indexing_latency" {
  name = format("%s %s", local.detector_name_prefix, "Elasticsearch indexing latency")

  program_text = <<-EOF
    A = data('elasticsearch.indices.indexing.index-time', filter=filter('plugin', 'elasticsearch') and filter('node_name', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.indexing_latency_aggregation_function}${var.indexing_latency_transformation_function}
    B = data('elasticsearch.indices.indexing.index-total', filter=filter('plugin', 'elasticsearch') and filter('node_name', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.indexing_latency_aggregation_function}${var.indexing_latency_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal > ${var.indexing_latency_threshold_major})).publish('MAJOR')
    detect(when(signal > ${var.indexing_latency_threshold_minor}) and when(signal <= ${var.indexing_latency_threshold_major})).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.indexing_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.indexing_latency_disabled_major, var.indexing_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.indexing_latency_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.indexing_latency_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.indexing_latency_disabled_minor, var.indexing_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.indexing_latency_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "flush_latency" {
  name = format("%s %s", local.detector_name_prefix, "Elasticsearch index flushing to disk latency")

  program_text = <<-EOF
    A = data('elasticsearch.indices.flush.total-time', filter=filter('plugin', 'elasticsearch') and filter('node_name', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.flush_latency_aggregation_function}${var.flush_latency_transformation_function}
    B = data('elasticsearch.indices.flush.total', filter=filter('plugin', 'elasticsearch') and filter('node_name', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.flush_latency_aggregation_function}${var.flush_latency_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal > ${var.flush_latency_threshold_major})).publish('MAJOR')
    detect(when(signal > ${var.flush_latency_threshold_minor}) and when(signal <= ${var.flush_latency_threshold_major})).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.flush_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.flush_latency_disabled_major, var.flush_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.flush_latency_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.flush_latency_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.flush_latency_disabled_minor, var.flush_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.flush_latency_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "search_latency" {
  name = format("%s %s", local.detector_name_prefix, "Elasticsearch search query latency")

  program_text = <<-EOF
    A = data('elasticsearch.indices.search.query-time', filter=filter('plugin', 'elasticsearch') and filter('node_name', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.search_latency_aggregation_function}${var.search_latency_transformation_function}
    B = data('elasticsearch.indices.search.query-total', filter=filter('plugin', 'elasticsearch') and filter('node_name', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.search_latency_aggregation_function}${var.search_latency_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal > ${var.search_latency_threshold_major})).publish('MAJOR')
    detect(when(signal > ${var.search_latency_threshold_minor}) and when(signal <= ${var.search_latency_threshold_major})).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.search_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.search_latency_disabled_major, var.search_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.search_latency_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.search_latency_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.search_latency_disabled_minor, var.search_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.search_latency_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "fetch_latency" {
  name = format("%s %s", local.detector_name_prefix, "Elasticsearch search fetch latency")

  program_text = <<-EOF
    A = data('elasticsearch.indices.search.fetch-time', filter=filter('plugin', 'elasticsearch') and filter('node_name', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.fetch_latency_aggregation_function}${var.fetch_latency_transformation_function}
    B = data('elasticsearch.indices.search.fetch-total', filter=filter('plugin', 'elasticsearch') and filter('node_name', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta')${var.fetch_latency_aggregation_function}${var.fetch_latency_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal > ${var.fetch_latency_threshold_major})).publish('MAJOR')
    detect(when(signal > ${var.fetch_latency_threshold_minor}) and when(signal <= ${var.fetch_latency_threshold_major})).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.fetch_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.fetch_latency_disabled_major, var.fetch_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.fetch_latency_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.fetch_latency_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.fetch_latency_disabled_minor, var.fetch_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.fetch_latency_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "field_data_evictions_change" {
  name = format("%s %s", local.detector_name_prefix, "Elasticsearch fielddata cache evictions rate of change")

  program_text = <<-EOF
    signal = data('elasticsearch.indices.fielddata.evictions', filter=filter('plugin', 'elasticsearch') and filter('node_name', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='delta').rateofchange()${var.field_data_evictions_change_aggregation_function}${var.field_data_evictions_change_transformation_function}.publish('signal')
    detect(when(signal > ${var.field_data_evictions_change_threshold_major})).publish('MAJOR')
    detect(when(signal > ${var.field_data_evictions_change_threshold_minor}) and when(signal <= ${var.field_data_evictions_change_threshold_major})).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.field_data_evictions_change_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.field_data_evictions_change_disabled_major, var.field_data_evictions_change_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.field_data_evictions_change_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.field_data_evictions_change_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.field_data_evictions_change_disabled_minor, var.field_data_evictions_change_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.field_data_evictions_change_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "task_time_in_queue_change" {
  name = format("%s %s", local.detector_name_prefix, "Elasticsearch max time spent by task in queue rate of change")

  program_text = <<-EOF
    signal = data('elasticsearch.cluster.task-max-wait-time', filter=filter('plugin', 'elasticsearch') and ${module.filter-tags.filter_custom}, rollup='average').rateofchange()${var.task_time_in_queue_change_aggregation_function}${var.task_time_in_queue_change_transformation_function}.publish('signal')
    detect(when(signal > ${var.task_time_in_queue_change_threshold_major})).publish('MAJOR')
    detect(when(signal > ${var.task_time_in_queue_change_threshold_minor}) and when(signal <= ${var.task_time_in_queue_change_threshold_major})).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.task_time_in_queue_change_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.task_time_in_queue_change_disabled_major, var.task_time_in_queue_change_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.task_time_in_queue_change_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.task_time_in_queue_change_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.task_time_in_queue_change_disabled_minor, var.task_time_in_queue_change_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.task_time_in_queue_change_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

