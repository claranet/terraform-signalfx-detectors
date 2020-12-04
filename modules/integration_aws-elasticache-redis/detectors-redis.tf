resource "signalfx_detector" "cache_hits" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache redis cache hit ratio")

  program_text = <<-EOF
    A = data('CacheHits', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.cache_hits_aggregation_function}${var.cache_hits_transformation_function}
    B = data('CacheMisses', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'mean') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.cache_hits_aggregation_function}${var.cache_hits_transformation_function}
    signal = (A / (A+B)).fill(value=1).scale(100).publish('signal')
    detect(when(signal < threshold(${var.cache_hits_threshold_critical}), lasting='${var.cache_hits_lasting_duration_seconds}s', at_least=${var.cache_hits_at_least_percentage})).publish('CRIT')
    detect((when(signal < threshold(${var.cache_hits_threshold_major}), lasting='${var.cache_hits_lasting_duration_seconds}s', at_least=${var.cache_hits_at_least_percentage}) and when(signal >= ${var.cache_hits_threshold_critical})), off=(when(signal >= ${var.cache_hits_threshold_major}, lasting='${var.cache_hits_lasting_duration_seconds / 2}s') or when(signal <= ${var.cache_hits_threshold_critical}, lasting='${var.cache_hits_lasting_duration_seconds}s', at_least=${var.cache_hits_at_least_percentage})), mode='paired').publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.cache_hits_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cache_hits_disabled_critical, var.cache_hits_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cache_hits_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too low < ${var.cache_hits_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cache_hits_disabled_major, var.cache_hits_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cache_hits_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "cpu_high" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache redis CPU")

  program_text = <<-EOF
    signal = data('EngineCPUUtilization', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'upper') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.cpu_high_aggregation_function}${var.cpu_high_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_high_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_high_threshold_major}) and when(signal <= ${var.cpu_high_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_high_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_high_disabled_critical, var.cpu_high_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_high_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.cpu_high_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_high_disabled_major, var.cpu_high_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_high_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "replication_lag" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache redis replication lag")

  program_text = <<-EOF
    signal = data('ReplicationLag', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'upper') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.replication_lag_aggregation_function}${var.replication_lag_transformation_function}.publish('signal')
    detect(when(signal > ${var.replication_lag_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.replication_lag_threshold_major}) and when(signal <= ${var.replication_lag_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.replication_lag_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.replication_lag_disabled_critical, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.replication_lag_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.replication_lag_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.replication_lag_disabled_major, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.replication_lag_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "commands" {
  name = format("%s %s", local.detector_name_prefix, "AWS ElastiCache redis commands")

  program_text = <<-EOF
    A = data('GetTypeCmds', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'lower') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.commands_aggregation_function}${var.commands_transformation_function}
    B = data('SetTypeCmds', filter=filter('namespace', 'AWS/ElastiCache') and filter('stat', 'lower') and filter('CacheNodeId', '*') and ${module.filter-tags.filter_custom})${var.commands_aggregation_function}${var.commands_transformation_function}
    signal = (A + B).publish('signal')
    detect(when(signal <= ${var.commands_threshold_critical})).publish('CRIT')
    detect(when(signal <= ${var.commands_threshold_major}) and when(signal > ${var.commands_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "are too low <= ${var.commands_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.commands_disabled_critical, var.commands_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.commands_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "are too low <= ${var.commands_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.commands_disabled_major, var.commands_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.commands_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

