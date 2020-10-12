resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache heartbeat")

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('CPUUtilization', filter=filter('stat', 'mean') and filter('namespace', 'AWS/ElastiCache') and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "evictions" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache evictions")

  program_text = <<-EOF
    signal = data('Evictions', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.evictions_aggregation_function}${var.evictions_transformation_function}.publish('signal')
    detect(when(signal > ${var.evictions_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.evictions_threshold_major}) and when(signal <= ${var.evictions_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.evictions_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.evictions_disabled_critical, var.evictions_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.evictions_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.evictions_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.evictions_disabled_major, var.evictions_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.evictions_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "max_connection" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache connections over max allowed")

  program_text = <<-EOF
    signal = data('CurrConnections', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'upper') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.max_connection_aggregation_function}${var.max_connection_transformation_function}.publish('signal')
    detect(when(signal > ${var.max_connection_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.max_connection_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.max_connection_disabled_critical, var.max_connection_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.max_connection_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "no_connection" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache current connections")

  program_text = <<-EOF
    signal = data('CurrConnections', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'lower') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.no_connection_aggregation_function}${var.no_connection_transformation_function}.publish('signal')
    detect(when(signal <= ${var.no_connection_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "are too low <= ${var.no_connection_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.no_connection_disabled_critical, var.no_connection_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.no_connection_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "swap" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache swap")

  program_text = <<-EOF
    signal = data('SwapUsage', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'upper') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.swap_aggregation_function}${var.swap_transformation_function}.publish('signal')
    detect(when(signal > ${var.swap_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.swap_threshold_major}) and when(signal <= ${var.swap_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.swap_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.swap_disabled_critical, var.swap_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.swap_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.swap_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.swap_disabled_major, var.swap_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.swap_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "free_memory" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache freeable memory")

  program_text = <<-EOF
    signal = data('FreeableMemory', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'lower') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom}).rateofchange()${var.free_memory_aggregation_function}${var.free_memory_transformation_function}.publish('signal')
    detect(when(signal < ${var.free_memory_threshold_critical})).publish('CRIT')
    detect(when(signal < ${var.free_memory_threshold_major}) and when(signal >= ${var.free_memory_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.free_memory_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.free_memory_disabled_critical, var.free_memory_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.free_memory_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too low < ${var.free_memory_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.free_memory_disabled_major, var.free_memory_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.free_memory_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "evictions_growing" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache evictions changing rate grows")

  program_text = <<-EOF
    signal = data('Evictions', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.evictions_growing_aggregation_function}${var.evictions_growing_transformation_function}.rateofchange().scale(100).publish('signal')
    detect(when(signal > ${var.evictions_growing_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.evictions_growing_threshold_major}) and when(signal <= ${var.evictions_growing_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "too fast > ${var.evictions_growing_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.evictions_growing_disabled_critical, var.evictions_growing_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.evictions_growing_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "too fast > ${var.evictions_growing_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.evictions_growing_disabled_major, var.evictions_growing_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.evictions_growing_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

