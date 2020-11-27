resource "signalfx_detector" "jmx_memory_heap" {
  name = format("%s %s", local.detector_name_prefix, "JMX memory heap usage")

  program_text = <<-EOF
    A = data('jmx_memory.used', filter=filter('plugin_instance', 'memory-heap') and ${module.filter-tags.filter_custom})${var.memory_heap_aggregation_function}${var.memory_heap_transformation_function}
    B = data('jmx_memory.max', filter=filter('plugin_instance', 'memory-heap') and ${module.filter-tags.filter_custom})${var.memory_heap_aggregation_function}${var.memory_heap_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.memory_heap_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.memory_heap_threshold_major}) and (signal < ${var.memory_heap_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memory_heap_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_heap_disabled_major, var.memory_heap_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_heap_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
  rule {
    description           = "is too high > ${var.memory_heap_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_heap_disabled_critical, var.memory_heap_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_heap_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "jmx_old_gen" {
  name = format("%s %s", local.detector_name_prefix, "JMX GC old generation usage")

  program_text = <<-EOF
    A = data('jmx_memory.used', filter=filter('plugin_instance', 'memory_pool-G1 Old Gen') and ${module.filter-tags.filter_custom})${var.gc_old_gen_aggregation_function}${var.gc_old_gen_transformation_function}
    B = data('jmx_memory.max', filter=filter('plugin_instance', 'memory_pool-G1 Old Gen') and ${module.filter-tags.filter_custom})${var.gc_old_gen_aggregation_function}${var.gc_old_gen_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.gc_old_gen_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.gc_old_gen_threshold_major}) and (signal < ${var.gc_old_gen_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.gc_old_gen_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.gc_old_gen_disabled_major, var.gc_old_gen_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.gc_old_gen_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
  rule {
    description           = "is too high > ${var.gc_old_gen_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.gc_old_gen_disabled_critical, var.gc_old_gen_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.gc_old_gen_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

