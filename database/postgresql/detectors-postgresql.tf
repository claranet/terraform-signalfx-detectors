resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] PostgreSQL heartbeat"

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('postgres_database_size', filter=(not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}')) and (not filter('gcp_status', '{Code=3, Name=STOPPING}', '{Code=4, Name=TERMINATED}')) and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stoppped', 'PowerState/deallocating', 'PowerState/deallocated')) and ${module.filter-tags.filter_custom}).publish('signal')
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

resource "signalfx_detector" "deadlocks" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] PostgreSQL deadlocks"

  program_text = <<-EOF
    signal = data('postgres_deadlocks', filter=${module.filter-tags.filter_custom}, rollup='delta')${var.deadlocks_aggregation_function}${var.deadlocks_transformation_function}.publish('signal')
    detect(when(signal > ${var.deadlocks_threshold_warning})).publish('WARN')
    detect(when(signal > ${var.deadlocks_threshold_major}) and when(signal <= ${var.deadlocks_threshold_warning})).publish('MAJOR')
EOF

  rule {
    description           = "are too high > ${var.deadlocks_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.deadlocks_disabled_warning, var.deadlocks_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.deadlocks_notifications_warning, var.deadlocks_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too high > ${var.deadlocks_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.deadlocks_disabled_major, var.deadlocks_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.deadlocks_notifications_major, var.deadlocks_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "hit_ratio" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] PostgreSQL hit ratio"

  program_text = <<-EOF
    signal = data('postgres_block_hit_ratio', filter=${module.filter-tags.filter_custom}, rollup='average').scale(100)${var.hit_ratio_aggregation_function}${var.hit_ratio_transformation_function}.publish('signal')
    detect(when(signal < ${var.hit_ratio_threshold_major})).publish('MAJOR')
    detect(when(signal < ${var.hit_ratio_threshold_minor}) and when(signal >= ${var.hit_ratio_threshold_major})).publish('MINOR')
EOF

  rule {
    description           = "is too low < ${var.hit_ratio_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.hit_ratio_disabled_major, var.hit_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.hit_ratio_notifications_major, var.hit_ratio_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too low > ${var.hit_ratio_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.hit_ratio_disabled_minor, var.hit_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.hit_ratio_notifications_minor, var.hit_ratio_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "rollbacks" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] PostgreSQL rollbacks ratio compared to commits"

  program_text = <<-EOF
    A = data('postgres_xact_rollbacks', filter=${module.filter-tags.filter_custom}, rollup='delta')${var.rollbacks_aggregation_function}${var.rollbacks_transformation_function}
    B = data('postgres_xact_commits', filter=${module.filter-tags.filter_custom}, rollup='delta')${var.rollbacks_aggregation_function}${var.rollbacks_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.rollbacks_threshold_warning})).publish('WARN')
    detect(when(signal > ${var.rollbacks_threshold_major}) and when(signal <= ${var.rollbacks_threshold_warning})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.rollbacks_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.rollbacks_disabled_warning, var.rollbacks_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.rollbacks_notifications_warning, var.rollbacks_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.rollbacks_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.rollbacks_disabled_major, var.rollbacks_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.rollbacks_notifications_major, var.rollbacks_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "conflicts" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] PostgreSQL conflicts"

  program_text = <<-EOF
    signal = data('postgres_conflicts', filter=${module.filter-tags.filter_custom}, rollup='average')${var.conflicts_aggregation_function}${var.conflicts_transformation_function}.publish('signal')
    detect(when(signal > ${var.conflicts_threshold_warning})).publish('WARN')
    detect(when(signal > ${var.conflicts_threshold_major}) and when(signal <= ${var.conflicts_threshold_warning})).publish('MAJOR')
EOF

  rule {
    description           = "are too high > ${var.conflicts_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.conflicts_disabled_warning, var.conflicts_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.conflicts_notifications_warning, var.conflicts_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too high > ${var.conflicts_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.conflicts_disabled_major, var.conflicts_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.conflicts_notifications_major, var.conflicts_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "max_connections" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] PostgreSQL number of connections compared to max"

  program_text = <<-EOF
    signal = data('postgres_pct_connections', filter=${module.filter-tags.filter_custom}, rollup='average').scale(100)${var.max_connections_aggregation_function}${var.max_connections_transformation_function}.publish('signal')
    detect(when(signal > ${var.max_connections_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.max_connections_threshold_warning}) and when(signal <= ${var.max_connections_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.max_connections_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.max_connections_disabled_critical, var.max_connections_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.max_connections_notifications_critical, var.max_connections_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.max_connections_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.max_connections_disabled_warning, var.max_connections_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.max_connections_notifications_warning, var.max_connections_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "replication_lag" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] PostgreSQL replication lag"

  program_text = <<-EOF
    signal = data('postgres_replication_lag', filter=${module.filter-tags.filter_custom}, rollup='average')${var.replication_lag_aggregation_function}${var.replication_lag_transformation_function}.publish('signal')
    detect(when(signal > ${var.replication_lag_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.replication_lag_threshold_warning}) and when(signal <= ${var.replication_lag_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.replication_lag_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.replication_lag_disabled_critical, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.replication_lag_notifications_critical, var.replication_lag_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.replication_lag_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.replication_lag_disabled_warning, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.replication_lag_notifications_warning, var.replication_lag_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "replication_state" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] PostgreSQL replication state"

  program_text = <<-EOF
    signal = data('postgres_replication_state', filter=${module.filter-tags.filter_custom}, rollup='average')${var.replication_state_aggregation_function}${var.replication_state_transformation_function}.publish('signal')
    detect(when(signal < 1)).publish('CRIT')
EOF

  rule {
    description           = "is not active on slot"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.replication_state_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.replication_state_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

