# jmx thread count
resource "signalfx_detector" "jmx_thread_count" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] JMX Threads Count"

  program_text = <<-EOF
    signal = data('gauge.jvm.threads.count', filter=${module.filter-tags.filter_custom})${var.jmx_thread_count_aggregation_function}${var.jmx_thread_count_transformation_function}.publish('signal')
    detect(when(signal > ${var.jmx_thread_count_threshold_critical})).publish('critical')
    detect(when(signal > ${var.jmx_thread_count_threshold_warning}) and (signal < ${var.jmx_thread_count_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too low > ${var.jmx_thread_count_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.jmx_thread_count_disabled_warning, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jmx_thread_count_notifications_warning, "warning", []), var.notifications.warning)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
  rule {
    description           = "is too low > ${var.jmx_thread_count_threshold_critical}"
    severity              = "Critical"
    detect_label          = "critical"
    disabled              = coalesce(var.jmx_thread_count_disabled_critical, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jmx_thread_count_notifications_critical, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
}

# jmx heap size
resource "signalfx_detector" "jmx_memory_heap_usage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] JMX Memory Heap Usage"

  program_text = <<-EOF
    A = data('jmx_memory.used', filter=filter('plugin_instance', 'memory-heap') and ${module.filter-tags.filter_custom})${var.jmx_memory_heap_used_aggregation_function}${var.jmx_memory_heap_used_transformation_function}
    B = data('jmx_memory.max', filter=filter('plugin_instance', 'memory-heap') and ${module.filter-tags.filter_custom})${var.jmx_memory_heap_max_aggregation_function}${var.jmx_memory_heap_max_transformation_function}
    signal = (A/B).fill(0).scale(100).publish('signal')
    detect(when(signal > ${var.jmx_memory_heap_usage_threshold_critical})).publish('critical')
    detect(when(signal > ${var.jmx_memory_heap_usage_threshold_warning}) and (signal < ${var.jmx_memory_heap_usage_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.jmx_memory_heap_usage_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.jmx_memory_heap_usage_disabled_warning, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jmx_memory_heap_usage_notifications_warning, "warning", []), var.notifications.warning)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
  rule {
    description           = "is too high > ${var.jmx_memory_heap_usage_threshold_critical}"
    severity              = "Critical"
    detect_label          = "critical"
    disabled              = coalesce(var.jmx_memory_heap_usage_disabled_critical, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jmx_memory_heap_usage_notifications_critical, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
}

# jmx survivor space size
resource "signalfx_detector" "jmx_memory_survivor_space_usage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] JMX Memory Survivor Space Usage"

  program_text = <<-EOF
    A = data('jmx_memory.used', filter=filter('plugin_instance', 'memory_pool-G1 Survivor Space') and ${module.filter-tags.filter_custom})${var.jmx_memory_survivor_space_used_aggregation_function}${var.jmx_memory_survivor_space_used_transformation_function}
    B = data('jmx_memory.max', filter=filter('plugin_instance', 'memory_pool-G1 Survivor Space') and ${module.filter-tags.filter_custom})${var.jmx_memory_survivor_space_max_aggregation_function}${var.jmx_memory_survivor_space_max_transformation_function}
    signal = ((A/B).fill(0).scale(100)).publish('signal')
    detect(when(signal > ${var.jmx_memory_survivor_space_usage_threshold_critical})).publish('critical')
    detect(when(signal > ${var.jmx_memory_survivor_space_usage_threshold_warning}) and (signal < ${var.jmx_memory_survivor_space_usage_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.jmx_memory_survivor_space_usage_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.jmx_memory_survivor_space_usage_disabled_warning, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jmx_memory_survivor_space_usage_notifications_warning, "warning", []), var.notifications.warning)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
  rule {
    description           = "is too high > ${var.jmx_memory_survivor_space_usage_threshold_critical}"
    severity              = "Critical"
    detect_label          = "critical"
    disabled              = coalesce(var.jmx_memory_survivor_space_usage_disabled_critical, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jmx_memory_survivor_space_usage_notifications_critical, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
}

# jmx compressed class space size
resource "signalfx_detector" "jmx_memory_compressed_class_space_usage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] JMX Memory Compressed Class Space Usage"

  program_text = <<-EOF
    A = data('jmx_memory.used', filter=filter('plugin_instance', 'memory_pool-Compressed Class Space') and ${module.filter-tags.filter_custom})${var.jmx_memory_compressed_class_space_used_aggregation_function}${var.jmx_memory_compressed_class_space_used_transformation_function}
    B = data('jmx_memory.max', filter=filter('plugin_instance', 'memory_pool-Compressed Class Space') and ${module.filter-tags.filter_custom})${var.jmx_memory_compressed_class_space_max_aggregation_function}${var.jmx_memory_compressed_class_space_max_transformation_function}
    signal = ((A/B).fill(0).scale(100)).publish('signal')
    detect(when(signal > ${var.jmx_memory_compressed_class_space_usage_threshold_critical})).publish('critical')
    detect(when(signal > ${var.jmx_memory_compressed_class_space_usage_threshold_warning}) and (signal < ${var.jmx_memory_compressed_class_space_usage_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.jmx_memory_compressed_class_space_usage_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.jmx_memory_compressed_class_space_usage_disabled_warning, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jmx_memory_compressed_class_space_usage_notifications_warning, "critical", []), var.notifications.warning)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
  rule {
    description           = "is too high > ${var.jmx_memory_compressed_class_space_usage_threshold_critical}"
    severity              = "Critical"
    detect_label          = "critical"
    disabled              = coalesce(var.jmx_memory_compressed_class_space_usage_disabled_critical, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jmx_memory_compressed_class_space_usage_notifications_critical, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
}

# jmx g1 old gen
resource "signalfx_detector" "jmx_memory_g1_old_gen_space_usage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] JMX G1 Old Gen Space Usage"

  program_text = <<-EOF
    A = data('jmx_memory.used', filter=filter('plugin_instance', 'memory_pool-G1 Old Gen') and ${module.filter-tags.filter_custom})${var.jmx_memory_g1_old_gen_space_used_aggregation_function}${var.jmx_memory_g1_old_gen_space_used_transformation_function}
    B = data('jmx_memory.max', filter=filter('plugin_instance', 'memory_pool-G1 Old Gen') and ${module.filter-tags.filter_custom})${var.jmx_memory_g1_old_gen_space_max_aggregation_function}${var.jmx_memory_g1_old_gen_space_max_transformation_function}
    signal = ((A/B).fill(0).scale(100)).publish('signal')
    detect(when(signal > ${var.jmx_memory_g1_old_gen_space_usage_threshold_critical})).publish('critical')
    detect(when(signal > ${var.jmx_memory_g1_old_gen_space_usage_threshold_warning}) and (signal < ${var.jmx_memory_g1_old_gen_space_usage_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.jmx_memory_g1_old_gen_space_usage_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.jmx_memory_g1_old_gen_space_usage_disabled_warning, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jmx_memory_g1_old_gen_space_usage_notifications_warning, "warning", []), var.notifications.warning)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
  rule {
    description           = "is too high > ${var.jmx_memory_g1_old_gen_space_usage_threshold_critical}"
    severity              = "Critical"
    detect_label          = "critical"
    disabled              = coalesce(var.jmx_memory_g1_old_gen_space_usage_disabled_critical, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jmx_memory_g1_old_gen_space_usage_notifications_critical, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
}

# jmx geometry metaspace
resource "signalfx_detector" "jmx_memory_geometry_metaspace_space_usage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] JMX Memory Geometry Metaspace Space Usage"

  program_text = <<-EOF
    A = data('jmx_memory.used', filter=filter('plugin_instance', 'memory_pool-Metaspace') and ${module.filter-tags.filter_custom})${var.jmx_memory_geometry_metaspace_space_used_aggregation_function}${var.jmx_memory_geometry_metaspace_space_used_transformation_function}
    B = data('jmx_memory.max', filter=filter('plugin_instance', 'memory_pool-Metaspace') and ${module.filter-tags.filter_custom})${var.jmx_memory_geometry_metaspace_space_max_aggregation_function}${var.jmx_memory_geometry_metaspace_space_max_transformation_function}
    signal = ((A/B).fill(0).scale(100)).publish('signal')
    detect(when(signal > ${var.jmx_memory_geometry_metaspace_space_usage_threshold_critical})).publish('critical')
    detect(when(signal > ${var.jmx_memory_geometry_metaspace_space_usage_threshold_warning}) and (signal < ${var.jmx_memory_geometry_metaspace_space_usage_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.jmx_memory_geometry_metaspace_space_usage_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.jmx_memory_geometry_metaspace_space_usage_disabled_warning, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jmx_memory_geometry_metaspace_space_usage_notifications_warning, "warning", []), var.notifications.warning)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
  rule {
    description           = "is too high > ${var.jmx_memory_geometry_metaspace_space_usage_threshold_critical}"
    severity              = "Critical"
    detect_label          = "critical"
    disabled              = coalesce(var.jmx_memory_geometry_metaspace_space_usage_disabled_critical, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jmx_memory_geometry_metaspace_space_usage_notifications_critical, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
}

# jmx codecache usage
resource "signalfx_detector" "jmx_memory_codecache_space_usage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] JMX Memory CodeCache Space Usage"

  program_text = <<-EOF
    A = data('jmx_memory.used', filter=filter('plugin_instance', "memory_pool-CodeHeap 'profiled nmethods'") and ${module.filter-tags.filter_custom})${var.jmx_memory_codecache_space_used_aggregation_function}${var.jmx_memory_codecache_space_used_transformation_function}
    B = data('jmx_memory.max', filter=filter('plugin_instance', "memory_pool-CodeHeap 'non-profiled nmethods'") and ${module.filter-tags.filter_custom})${var.jmx_memory_codecache_space_max_aggregation_function}${var.jmx_memory_codecache_space_max_transformation_function}
    C = data('jmx_memory.used', filter=filter('plugin_instance', "memory_pool-CodeHeap 'non-profiled nmethods'") and ${module.filter-tags.filter_custom})${var.jmx_memory_codecache_space_used_aggregation_function}${var.jmx_memory_codecache_space_used_transformation_function}
    D = data('jmx_memory.used', filter=filter('plugin_instance', "memory_pool-CodeHeap 'profiled nmethods'") and ${module.filter-tags.filter_custom})${var.jmx_memory_codecache_space_used_aggregation_function}${var.jmx_memory_codecache_space_used_transformation_function}
    signal = (((A+C)/(B+D)).fill(0).scale(100)).publish('signal')
    detect(when(signal > ${var.jmx_memory_codecache_space_usage_threshold_critical})).publish('critical')
    detect(when(signal > ${var.jmx_memory_codecache_space_usage_threshold_warning}) and (signal < ${var.jmx_memory_codecache_space_usage_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.jmx_memory_codecache_space_usage_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.jmx_memory_codecache_space_usage_disabled_warning, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jmx_memory_codecache_space_usage_notifications_warning, "warning", []), var.notifications.warning)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
  rule {
    description           = "is too high > ${var.jmx_memory_codecache_space_usage_threshold_critical}"
    severity              = "Critical"
    detect_label          = "critical"
    disabled              = coalesce(var.jmx_memory_codecache_space_usage_disabled_critical, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jmx_memory_codecache_space_usage_notifications_critical, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
}

# jmx non heap size
resource "signalfx_detector" "jmx_memory_non_heap_usage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] JMX Memory Non Heap Usage"

  program_text = <<-EOF
    A = data('jmx_memory.used', filter=filter('plugin_instance', 'memory-nonheap') and ${module.filter-tags.filter_custom})${var.jmx_memory_non_heap_used_aggregation_function}${var.jmx_memory_non_heap_used_transformation_function}
    B = data('jmx_memory.max', filter=filter('plugin_instance', 'memory-nonheap') and ${module.filter-tags.filter_custom})${var.jmx_memory_non_heap_max_aggregation_function}${var.jmx_memory_non_heap_max_transformation_function}
    signal = ((A/B).fill(0).scale(100)).publish('signal')
    detect(when(signal > ${var.jmx_memory_non_heap_usage_threshold_critical})).publish('critical')
    detect(when(signal > ${var.jmx_memory_non_heap_usage_threshold_warning}) and (signal < ${var.jmx_memory_non_heap_usage_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.jmx_memory_non_heap_usage_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.jmx_memory_non_heap_usage_disabled_warning, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jmx_memory_non_heap_usage_notifications_warning, "warning", []), var.notifications.warning)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
  rule {
    description           = "is too high > ${var.jmx_memory_non_heap_usage_threshold_critical}"
    severity              = "Critical"
    detect_label          = "critical"
    disabled              = coalesce(var.jmx_memory_non_heap_usage_disabled_critical, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jmx_memory_non_heap_usage_notifications_critical, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
}
