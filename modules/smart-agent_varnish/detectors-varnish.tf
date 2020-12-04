resource "signalfx_detector" "heartbeat" {
  name      = format("%s %s", local.detector_name_prefix, "Varnish heartbeat")
  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('varnish.threads', filter=${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "backend_failed" {
  name = format("%s %s", local.detector_name_prefix, "Varnish backend Failed")

  program_text = <<-EOF
    signal = data('varnish.backend_fail', filter=filter('plugin', 'telegraf/varnish') and ${module.filter-tags.filter_custom})${var.backend_failed_aggregation_function}${var.backend_failed_transformation_function}.publish('signal')
    detect(when(signal > ${var.backend_failed_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "are too high > ${var.backend_failed_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_failed_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.backend_failed_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "threads_number" {
  name = format("%s %s", local.detector_name_prefix, "Varnish threads number")

  program_text = <<-EOF
    signal = data('varnish.threads', filter=filter('plugin', 'telegraf/varnish') and ${module.filter-tags.filter_custom})${var.threads_number_aggregation_function}${var.threads_number_transformation_function}.publish('signal')
    detect(when(signal < ${var.threads_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "are too low < ${var.threads_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.threads_number_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.threads_number_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "session_dropped" {
  name = format("%s %s", local.detector_name_prefix, "Varnish session dropped")

  program_text = <<-EOF
    signal = data('varnish.sess_dropped', filter=filter('plugin', 'telegraf/varnish') and ${module.filter-tags.filter_custom})${var.session_dropped_aggregation_function}${var.session_dropped_transformation_function}.publish('signal')
    detect(when(signal > ${var.session_dropped_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "are too high > ${var.session_dropped_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.session_dropped_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.session_dropped_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "cache_hit_rate" {
  name = format("%s %s", local.detector_name_prefix, "Varnish hit rate")

  program_text = <<-EOF
    A = data('varnish.cache_hit', filter=filter('plugin', 'telegraf/varnish') and ${module.filter-tags.filter_custom})${var.cache_hit_rate_aggregation_function}${var.cache_hit_rate_transformation_function}.publish('A')
    B = data('varnish.cache_miss', filter=filter('plugin', 'telegraf/varnish') and ${module.filter-tags.filter_custom})${var.cache_hit_rate_aggregation_function}${var.cache_hit_rate_transformation_function}.publish('B')
    signal = ((A/(A+B)).fill(0).scale(100)).publish('signal')
    detect(when(signal < ${var.cache_hit_rate_threshold_minor})).publish('MINOR')
    detect(when(signal < ${var.cache_hit_rate_threshold_major}) and (signal > ${var.cache_hit_rate_threshold_minor})).publish('MAJOR')
EOF

  rule {
    description           = "is too low > ${var.cache_hit_rate_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cache_hit_rate_disabled_major, var.cache_hit_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cache_hit_rate_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
  rule {
    description           = "is too low > ${var.cache_hit_rate_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.cache_hit_rate_disabled_minor, var.cache_hit_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cache_hit_rate_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

# memory used
resource "signalfx_detector" "memory_usage" {
  name = format("%s %s", local.detector_name_prefix, "Varnish memory usage")

  program_text = <<-EOF
    A = data('varnish.s0.g_bytes', filter=filter('plugin', 'telegraf/varnish') and ${module.filter-tags.filter_custom})${var.memory_usage_aggregation_function}${var.memory_usage_transformation_function}
    B = data('varnish.s0.g_space', filter=filter('plugin', 'telegraf/varnish') and ${module.filter-tags.filter_custom})${var.memory_usage_aggregation_function}${var.memory_usage_transformation_function}
    signal = (A / (A+B)).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.memory_usage_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.memory_usage_threshold_major}) and (signal < ${var.memory_usage_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too low > ${var.memory_usage_threshold_major}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_usage_disabled_critical, var.memory_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_usage_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
  rule {
    description           = "is too low > ${var.memory_usage_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_usage_disabled_major, var.memory_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_usage_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

