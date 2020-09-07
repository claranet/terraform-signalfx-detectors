resource "signalfx_detector" "heartbeat" {
  name      = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Redis heartbeat"
  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('bytes.used_memory', filter=filter('plugin', 'redis_info') and (not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}')) and (not filter('gcp_status', '{Code=3, Name=STOPPING}', '{Code=4, Name=TERMINATED}')) and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stoppped', 'PowerState/deallocating', 'PowerState/deallocated')) and ${module.filter-tags.filter_custom}).publish('signal')
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

resource "signalfx_detector" "evicted_keys" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Redis evicted keys rate of change"

  program_text = <<-EOF
    signal = data('counter.evicted_keys', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom}, rollup='delta').rateofchange()${var.evicted_keys_aggregation_function}${var.evicted_keys_transformation_function}.publish('signal')
    detect(when(signal > ${var.evicted_keys_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.evicted_keys_threshold_warning}) and when(signal <= ${var.evicted_keys_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "are too high > ${var.evicted_keys_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.evicted_keys_disabled_critical, var.evicted_keys_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.evicted_keys_notifications_critical, var.evicted_keys_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too high > ${var.evicted_keys_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.evicted_keys_disabled_warning, var.evicted_keys_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.evicted_keys_notifications_warning, var.evicted_keys_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "expirations" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Redis expired keys rate of change"

  program_text = <<-EOF
    signal = data('counter.expired_keys', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom}, rollup='delta').rateofchange()${var.expirations_aggregation_function}${var.expirations_transformation_function}.publish('signal')
    detect(when(signal > ${var.expirations_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.expirations_threshold_warning}) and when(signal <= ${var.expirations_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "are too high > ${var.expirations_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.expirations_disabled_critical, var.expirations_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.expirations_notifications_critical, var.expirations_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too high > ${var.expirations_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.expirations_disabled_warning, var.expirations_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.expirations_notifications_warning, var.expirations_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "blocked_clients" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Redis blocked client rate"

  program_text = <<-EOF
    A = data('gauge.blocked_clients', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom})${var.blocked_clients_aggregation_function}${var.blocked_clients_transformation_function}
    B = data('gauge.connected_clients', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom})${var.blocked_clients_aggregation_function}${var.blocked_clients_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.blocked_clients_threshold_major})).publish('MAJOR')
    detect(when(signal > ${var.blocked_clients_threshold_minor}) and when(signal <= ${var.blocked_clients_threshold_major})).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.blocked_clients_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.blocked_clients_disabled_major, var.blocked_clients_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.blocked_clients_notifications_major, var.blocked_clients_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.blocked_clients_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.blocked_clients_disabled_minor, var.blocked_clients_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.blocked_clients_notifications_minor, var.blocked_clients_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "keyspace_full" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Redis keyspace seems full"

  program_text = <<-EOF
    signal = data('gauge.db0_keys', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom}).rateofchange().abs()${var.keyspace_full_aggregation_function}${var.keyspace_full_transformation_function}.publish('signal')
    detect(when(signal == 0)).publish('WARN')
EOF

  rule {
    description           = "because number of keys saturates"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.keyspace_full_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.keyspace_full_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "memory_used_max" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Redis memory used over max memory (if configured)"

  program_text = <<-EOF
    A = data('bytes.used_memory', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom})${var.memory_used_max_aggregation_function}${var.memory_used_max_transformation_function}
    B = data('bytes.maxmemory', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom})${var.memory_used_max_aggregation_function}${var.memory_used_max_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.memory_used_max_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.memory_used_max_threshold_warning}) and when(signal <= ${var.memory_used_max_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.memory_used_max_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_used_max_disabled_critical, var.memory_used_max_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.memory_used_max_notifications_critical, var.memory_used_max_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.memory_used_max_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.memory_used_max_disabled_warning, var.memory_used_max_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.memory_used_max_notifications_warning, var.memory_used_max_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "memory_used_total" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Redis memory used over total system memory"

  program_text = <<-EOF
    A = data('bytes.used_memory', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom})${var.memory_used_total_aggregation_function}${var.memory_used_total_transformation_function}
    B = data('bytes.total_system_memory', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom})${var.memory_used_total_aggregation_function}${var.memory_used_total_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.memory_used_total_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.memory_used_total_threshold_warning}) and when(signal <= ${var.memory_used_total_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.memory_used_total_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_used_total_disabled_critical, var.memory_used_total_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.memory_used_total_notifications_critical, var.memory_used_total_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.memory_used_total_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.memory_used_total_disabled_warning, var.memory_used_total_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.memory_used_total_notifications_warning, var.memory_used_total_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "memory_frag_high" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Redis memory fragmentation ratio (excessive fragmentation)"

  program_text = <<-EOF
    A = data('bytes.used_memory_rss', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom}, rollup='average')${var.memory_frag_high_aggregation_function}${var.memory_frag_high_transformation_function}
    B = data('bytes.used_memory', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom}, rollup='average')${var.memory_frag_high_aggregation_function}${var.memory_frag_high_transformation_function}
    signal = (A/B).publish('signal')
    detect(when(signal > ${var.memory_frag_high_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.memory_frag_high_threshold_warning}) and when(signal <= ${var.memory_frag_high_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.memory_frag_high_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_frag_high_disabled_critical, var.memory_frag_high_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.memory_frag_high_notifications_critical, var.memory_frag_high_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.memory_frag_high_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.memory_frag_high_disabled_warning, var.memory_frag_high_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.memory_frag_high_notifications_warning, var.memory_frag_high_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "memory_frag_low" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Redis memory fragmentation ratio (missing memory)"

  program_text = <<-EOF
    A = data('bytes.used_memory_rss', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom}, rollup='average')${var.memory_frag_low_aggregation_function}${var.memory_frag_low_transformation_function}
    B = data('bytes.used_memory', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom}, rollup='average')${var.memory_frag_low_aggregation_function}${var.memory_frag_low_transformation_function}
    signal = (A/B).publish('signal')
    detect(when(signal < ${var.memory_frag_low_threshold_critical})).publish('CRIT')
    detect(when(signal < ${var.memory_frag_low_threshold_warning}) and when(signal >= ${var.memory_frag_low_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too low < ${var.memory_frag_low_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_frag_low_disabled_critical, var.memory_frag_low_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.memory_frag_low_notifications_critical, var.memory_frag_low_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too low < ${var.memory_frag_low_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.memory_frag_low_disabled_warning, var.memory_frag_low_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.memory_frag_low_notifications_warning, var.memory_frag_low_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "rejected_connections" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Redis rejected connections (maxclient reached)"

  program_text = <<-EOF
    signal = data('counter.rejected_connections', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom}, rollup='delta').${var.rejected_connections_aggregation_function}${var.rejected_connections_transformation_function}.publish('signal')
    detect(when(signal > ${var.rejected_connections_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.rejected_connections_threshold_warning}) and when(signal <= ${var.rejected_connections_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "are too high > ${var.rejected_connections_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.rejected_connections_disabled_critical, var.rejected_connections_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.rejected_connections_notifications_critical, var.rejected_connections_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too high > ${var.rejected_connections_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.rejected_connections_disabled_warning, var.rejected_connections_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.rejected_connections_notifications_warning, var.rejected_connections_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "hitrate" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Redis hitrate"

  program_text = <<-EOF
    A = data('derive.keyspace_hits', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom}, rollup='delta')${var.hitrate_aggregation_function}${var.hitrate_transformation_function}
    B = data('derive.keyspace_misses', filter=filter('plugin', 'redis_info') and ${module.filter-tags.filter_custom}, rollup='delta')${var.hitrate_aggregation_function}${var.hitrate_transformation_function}
    signal = (A / (A+B)).scale(100).publish('signal')
    detect(when(signal < ${var.hitrate_threshold_critical})).publish('CRIT')
    detect(when(signal < ${var.hitrate_threshold_warning}) and when(signal >= ${var.hitrate_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too low < ${var.hitrate_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.hitrate_disabled_critical, var.hitrate_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.hitrate_notifications_critical, var.hitrate_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too low < ${var.hitrate_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.hitrate_disabled_warning, var.hitrate_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.hitrate_notifications_warning, var.hitrate_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

