resource "signalfx_detector" "heartbeat" {
  name      = format("%s %s", local.detector_name_prefix, "PostgreSQL heartbeat")
  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('postgres_database_size', filter=${local.not_running_vm_filters} and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "deadlocks" {
  name = format("%s %s", local.detector_name_prefix, "PostgreSQL deadlocks")

  program_text = <<-EOF
    signal = data('postgres_deadlocks', filter=${module.filter-tags.filter_custom}, rollup='delta')${var.deadlocks_aggregation_function}${var.deadlocks_transformation_function}.publish('signal')
    detect(when(signal > ${var.deadlocks_threshold_major})).publish('MAJOR')
    detect(when(signal > ${var.deadlocks_threshold_minor}) and when(signal <= ${var.deadlocks_threshold_major})).publish('MINOR')
EOF

  rule {
    description           = "are too high > ${var.deadlocks_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.deadlocks_disabled_major, var.deadlocks_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.deadlocks_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "are too high > ${var.deadlocks_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.deadlocks_disabled_minor, var.deadlocks_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.deadlocks_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "hit_ratio" {
  name = format("%s %s", local.detector_name_prefix, "PostgreSQL hit ratio")

  program_text = <<-EOF
    signal = data('postgres_block_hit_ratio', filter=(not filter('index', '*')) and (not filter('schemaname', '*')) and (not filter('type', '*')) and (not filter('table', '*')) and ${module.filter-tags.filter_custom}, rollup='average').scale(100)${var.hit_ratio_aggregation_function}${var.hit_ratio_transformation_function}.publish('signal')
    detect(when(signal < ${var.hit_ratio_threshold_minor})).publish('MINOR')
    detect(when(signal < ${var.hit_ratio_threshold_warning}) and when(signal >= ${var.hit_ratio_threshold_minor})).publish('WARN')
EOF

  rule {
    description           = "is too low < ${var.hit_ratio_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.hit_ratio_disabled_minor, var.hit_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.hit_ratio_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too low > ${var.hit_ratio_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.hit_ratio_disabled_warning, var.hit_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.hit_ratio_notifications, "warning", []), var.notifications.warning)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "rollbacks" {
  name = format("%s %s", local.detector_name_prefix, "PostgreSQL rollbacks ratio compared to commits")

  program_text = <<-EOF
    A = data('postgres_xact_rollbacks', filter=${module.filter-tags.filter_custom}, rollup='delta')${var.rollbacks_aggregation_function}${var.rollbacks_transformation_function}
    B = data('postgres_xact_commits', filter=${module.filter-tags.filter_custom}, rollup='delta')${var.rollbacks_aggregation_function}${var.rollbacks_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.rollbacks_threshold_major})).publish('MAJOR')
    detect(when(signal > ${var.rollbacks_threshold_minor}) and when(signal <= ${var.rollbacks_threshold_major})).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.rollbacks_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.rollbacks_disabled_major, var.rollbacks_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.rollbacks_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.rollbacks_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.rollbacks_disabled_minor, var.rollbacks_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.rollbacks_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "conflicts" {
  name = format("%s %s", local.detector_name_prefix, "PostgreSQL conflicts")

  program_text = <<-EOF
    signal = data('postgres_conflicts', filter=${module.filter-tags.filter_custom}, rollup='average')${var.conflicts_aggregation_function}${var.conflicts_transformation_function}.publish('signal')
    detect(when(signal > ${var.conflicts_threshold_major})).publish('MAJOR')
    detect(when(signal > ${var.conflicts_threshold_minor}) and when(signal <= ${var.conflicts_threshold_major})).publish('MINOR')
EOF

  rule {
    description           = "are too high > ${var.conflicts_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.conflicts_disabled_major, var.conflicts_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.conflicts_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "are too high > ${var.conflicts_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.conflicts_disabled_minor, var.conflicts_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.conflicts_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "max_connections" {
  name = format("%s %s", local.detector_name_prefix, "PostgreSQL number of connections compared to max")

  program_text = <<-EOF
    signal = data('postgres_pct_connections', filter=${module.filter-tags.filter_custom}, rollup='average').scale(100)${var.max_connections_aggregation_function}${var.max_connections_transformation_function}.publish('signal')
    detect(when(signal > ${var.max_connections_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.max_connections_threshold_major}) and when(signal <= ${var.max_connections_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.max_connections_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.max_connections_disabled_critical, var.max_connections_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.max_connections_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.max_connections_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.max_connections_disabled_major, var.max_connections_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.max_connections_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "replication_lag" {
  name = format("%s %s", local.detector_name_prefix, "PostgreSQL replication lag")

  program_text = <<-EOF
    signal = data('postgres_replication_lag', filter=${module.filter-tags.filter_custom}, rollup='average')${var.replication_lag_aggregation_function}${var.replication_lag_transformation_function}.publish('signal')
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

resource "signalfx_detector" "replication_state" {
  name = format("%s %s", local.detector_name_prefix, "PostgreSQL replication state")

  program_text = <<-EOF
    signal = data('postgres_replication_state', filter=${module.filter-tags.filter_custom}, rollup='average')${var.replication_state_aggregation_function}${var.replication_state_transformation_function}.publish('signal')
    detect(when(signal < 1)).publish('CRIT')
EOF

  rule {
    description           = "is not active on slot"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.replication_state_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.replication_state_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

