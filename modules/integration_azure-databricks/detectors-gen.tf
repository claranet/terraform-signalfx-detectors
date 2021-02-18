resource "signalfx_detector" "spark_jvm_heap_usage" {
  name = format("%s %s", local.detector_name_prefix, "Azure Databricks spark jvm heap usage")

  authorized_writer_teams = var.authorized_writer_teams

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('area', 'heap')
    jvm_memory_bytes_max = data('jvm_memory_bytes_max', filter=base_filtering and ${module.filter-tags.filter_custom})${var.spark_jvm_heap_usage_aggregation_function}${var.spark_jvm_heap_usage_transformation_function}
    jvm_memory_bytes_used = data('jvm_memory_bytes_used', filter=base_filtering and ${module.filter-tags.filter_custom})${var.spark_jvm_heap_usage_aggregation_function}${var.spark_jvm_heap_usage_transformation_function}
    signal = (jvm_memory_bytes_used/jvm_memory_bytes_max).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.spark_jvm_heap_usage_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.spark_jvm_heap_usage_threshold_major}) and when(signal <= ${var.spark_jvm_heap_usage_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.spark_jvm_heap_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.spark_jvm_heap_usage_disabled_critical, var.spark_jvm_heap_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.spark_jvm_heap_usage_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.spark_jvm_heap_usage_runbook_url, var.runbook_url), "")
    tip                   = var.spark_jvm_heap_usage_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.spark_jvm_heap_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.spark_jvm_heap_usage_disabled_major, var.spark_jvm_heap_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.spark_jvm_heap_usage_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.spark_jvm_heap_usage_runbook_url, var.runbook_url), "")
    tip                   = var.spark_jvm_heap_usage_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "spark_jvm_heap_old_usage" {
  name = format("%s %s", local.detector_name_prefix, "Azure Databricks spark jvm heap old usage")

  authorized_writer_teams = var.authorized_writer_teams

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('pool', 'PS Old Gen')
    jvm_memory_pool_bytes_max = data('jvm_memory_pool_bytes_max', filter=base_filtering and ${module.filter-tags.filter_custom})${var.spark_jvm_heap_old_usage_aggregation_function}${var.spark_jvm_heap_old_usage_transformation_function}
    jvm_memory_pool_bytes_used = data('jvm_memory_pool_bytes_used', filter=base_filtering and ${module.filter-tags.filter_custom})${var.spark_jvm_heap_old_usage_aggregation_function}${var.spark_jvm_heap_old_usage_transformation_function}
    signal = (jvm_memory_pool_bytes_used/jvm_memory_pool_bytes_max).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.spark_jvm_heap_old_usage_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.spark_jvm_heap_old_usage_threshold_major}) and when(signal <= ${var.spark_jvm_heap_old_usage_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.spark_jvm_heap_old_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.spark_jvm_heap_old_usage_disabled_critical, var.spark_jvm_heap_old_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.spark_jvm_heap_old_usage_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.spark_jvm_heap_old_usage_runbook_url, var.runbook_url), "")
    tip                   = var.spark_jvm_heap_old_usage_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.spark_jvm_heap_old_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.spark_jvm_heap_old_usage_disabled_major, var.spark_jvm_heap_old_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.spark_jvm_heap_old_usage_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.spark_jvm_heap_old_usage_runbook_url, var.runbook_url), "")
    tip                   = var.spark_jvm_heap_old_usage_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

