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
    notifications         = coalescelist(var.varnish_backend_failed_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
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
    notifications         = coalescelist(var.varnish_threads_number_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
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
    notifications         = coalescelist(var.varnish_session_dropped_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
}

# session dropped in varnish detection
resource "signalfx_detector" "varnish_cache_hit_rate" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Varnish Hit Rate"

  program_text = <<-EOF
    A = data('varnish.cache_hit', filter=filter('plugin', 'telegraf/varnish') and ${module.filter-tags.filter_custom})${var.varnish_cache_hit_rate_aggregation_function}${var.varnish_cache_hit_rate_transformation_function}.publish('A')
    B = data('varnish.cache_miss', filter=filter('plugin', 'telegraf/varnish') and ${module.filter-tags.filter_custom})${var.varnish_cache_hit_rate_aggregation_function}${var.varnish_cache_hit_rate_transformation_function}.publish('B')
    signal = ((A/(A+B)).fill(0).scale(100)).publish('signal')
    detect(when(signal < ${var.varnish_cache_hit_rate_threshold_major})).publish('MAJOR')
    detect(when(signal < ${var.varnish_cache_hit_rate_threshold_warning}) and (signal > ${var.varnish_cache_hit_rate_threshold_major})).publish('WARN')
EOF

  rule {
    description           = "is too low > ${var.varnish_cache_hit_rate_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.varnish_cache_hit_rate_disabled_warning, var.detectors_disabled)
    notifications         = coalescelist(var.varnish_cache_hit_rate_notifications_warning, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
  rule {
    description           = "is too low > ${var.varnish_cache_hit_rate_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.varnish_cache_hit_rate_disabled_major, var.detectors_disabled)
    notifications         = coalescelist(var.varnish_cache_hit_rate_notifications_major, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
}

# memory used
resource "signalfx_detector" "varnish_memory_usage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Varnish Memory Usage"

  program_text = <<-EOF
    A = data('varnish.s0.g_space', filter=filter('plugin', 'telegraf/varnish') and ${module.filter-tags.filter_custom})${var.varnish_memory_usage_aggregation_function}${var.varnish_memory_usage_transformation_function}.publish('A')
    B = data('varnish.s0.g_bytes', filter=filter('plugin', 'telegraf/varnish') and ${module.filter-tags.filter_custom})${var.varnish_memory_usage_aggregation_function}${var.varnish_memory_usage_transformation_function}.publish('B')
    signal = (A/(A+B)).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.varnish_memory_usage_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.varnish_memory_usage_threshold_warning}) and (signal < ${var.varnish_memory_usage_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too low > ${var.varnish_memory_usage_threshold_warning}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.varnish_memory_usage_disabled_critical, var.detectors_disabled)
    notifications         = coalescelist(var.varnish_memory_usage_notifications_critical, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
  rule {
    description           = "is too low > ${var.varnish_memory_usage_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.varnish_memory_usage_disabled_warning, var.detectors_disabled)
    notifications         = coalescelist(var.varnish_memory_usage_notifications_warning, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
}
