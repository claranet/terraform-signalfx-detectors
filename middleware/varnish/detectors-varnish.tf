# failed backend in varnish detection
resource "signalfx_detector" "varnish_backend_failed" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Varnish Backend Failed"

  program_text = <<-EOF
    signal = data('varnish.backend_fail', filter=filter('plugin', 'telegraf/varnish') and ${module.filter-tags.filter_custom})${var.varnish_backend_failed_aggregation_function}${var.varnish_backend_failed_transformation_function}.publish('signal')
    detect(when(signal > ${var.varnish_backend_failed_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "are too high > ${var.varnish_backend_failed_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.varnish_backend_failed_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.varnish_backend_failed_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }
}

# varnish threads
resource "signalfx_detector" "varnish_threads_number" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Varnish Threads Number"

  program_text = <<-EOF
    signal = data('varnish.threads', filter=filter('plugin', 'telegraf/varnish') and ${module.filter-tags.filter_custom})${var.varnish_threads_number_aggregation_function}${var.varnish_threads_number_transformation_function}.publish('signal')
    detect(when(signal < ${var.varnish_threads_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "are too low < ${var.varnish_threads_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.varnish_threads_number_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.varnish_threads_number_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }
}

# session dropped in varnish detection
resource "signalfx_detector" "varnish_session_dropped" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Varnish Session Dropped"

  program_text = <<-EOF
    signal = data('varnish.sess_dropped', filter=filter('plugin', 'telegraf/varnish') and ${module.filter-tags.filter_custom})${var.varnish_session_dropped_aggregation_function}${var.varnish_session_dropped_transformation_function}.publish('signal')
    detect(when(signal > ${var.varnish_session_dropped_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "are too high > ${var.varnish_session_dropped_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.varnish_session_dropped_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.varnish_session_dropped_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }
}

# session dropped in varnish detection
resource "signalfx_detector" "varnish_cache_hit_rate" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Varnish Hit Rate"

  program_text = <<-EOF
    A = data('varnish.cache_hit', filter=filter('plugin', 'telegraf/varnish') and ${module.filter-tags.filter_custom})${var.varnish_cache_hit_rate_aggregation_function}${var.varnish_cache_hit_rate_transformation_function}.publish('A')
    B = data('varnish.cache_miss', filter=filter('plugin', 'telegraf/varnish') and ${module.filter-tags.filter_custom})${var.varnish_cache_hit_rate_aggregation_function}${var.varnish_cache_hit_rate_transformation_function}.publish('B')
    signal = ((A/(A+B)).fill(0).scale(100)).publish('signal')
    detect(when(signal < ${var.varnish_cache_hit_rate_threshold_minor})).publish('MINOR')
    detect(when(signal < ${var.varnish_cache_hit_rate_threshold_major}) and (signal > ${var.varnish_cache_hit_rate_threshold_minor})).publish('MAJOR')
EOF

  rule {
    description           = "is too low > ${var.varnish_cache_hit_rate_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.varnish_cache_hit_rate_disabled_major, var.varnish_cache_hit_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.varnish_cache_hit_rate_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }
  rule {
    description           = "is too low > ${var.varnish_cache_hit_rate_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.varnish_cache_hit_rate_disabled_minor, var.varnish_cache_hit_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.varnish_cache_hit_rate_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }
}

# memory used
resource "signalfx_detector" "varnish_memory_usage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Varnish Memory Usage"

  program_text = <<-EOF
    A = data('varnish.s0.g_bytes', filter=filter('plugin', 'telegraf/varnish') and ${module.filter-tags.filter_custom})${var.varnish_memory_usage_aggregation_function}${var.varnish_memory_usage_transformation_function}
    B = data('varnish.s0.g_space', filter=filter('plugin', 'telegraf/varnish') and ${module.filter-tags.filter_custom})${var.varnish_memory_usage_aggregation_function}${var.varnish_memory_usage_transformation_function}
    signal = (A / (A+B)).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.varnish_memory_usage_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.varnish_memory_usage_threshold_major}) and (signal < ${var.varnish_memory_usage_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too low > ${var.varnish_memory_usage_threshold_major}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.varnish_memory_usage_disabled_critical, var.varnish_memory_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.varnish_memory_usage_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }
  rule {
    description           = "is too low > ${var.varnish_memory_usage_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.varnish_memory_usage_disabled_major, var.varnish_memory_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.varnish_memory_usage_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }
}

