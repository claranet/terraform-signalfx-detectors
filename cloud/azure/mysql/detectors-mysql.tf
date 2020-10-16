resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure MySQL heartbeat")

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.DBforMySQL/servers') and filter('primary_aggregation_type', 'true')
        signal = data('active_connections', filter=base_filter and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "cpu_usage" {
  name = format("%s %s", local.detector_name_prefix, "Azure MySQL CPU usage")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.DBforMySQL/servers') and filter('primary_aggregation_type', 'true')
        signal = data('cpu_percent', filter=base_filter and ${module.filter-tags.filter_custom})${var.cpu_usage_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.cpu_usage_threshold_critical}), lasting="${var.cpu_usage_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.cpu_usage_threshold_major}), lasting="${var.cpu_usage_timer}") and when(signal <= ${var.cpu_usage_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.cpu_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_usage_disabled_critical, var.cpu_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_usage_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.cpu_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_usage_disabled_major, var.cpu_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_usage_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "free_storage" {
  name = format("%s %s", local.detector_name_prefix, "Azure MySQL storage usage")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.DBforMySQL/servers') and filter('primary_aggregation_type', 'true')
        signal = data('storage_percent', filter=base_filter and ${module.filter-tags.filter_custom})${var.storage_usage_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.storage_usage_threshold_critical}), lasting="${var.storage_usage_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.storage_usage_threshold_major}), lasting="${var.storage_usage_timer}") and when(signal <= ${var.storage_usage_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.storage_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.storage_usage_disabled_critical, var.storage_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.storage_usage_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.storage_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.storage_usage_disabled_major, var.storage_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.storage_usage_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "io_consumption" {
  name = format("%s %s", local.detector_name_prefix, "Azure MySQL IO consumption")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.DBforMySQL/servers') and filter('primary_aggregation_type', 'true')
        signal = data('io_consumption_percent', filter=base_filter and ${module.filter-tags.filter_custom})${var.io_consumption_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.io_consumption_threshold_critical}), lasting="${var.io_consumption_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.io_consumption_threshold_major}), lasting="${var.io_consumption_timer}") and when(signal <= ${var.io_consumption_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.io_consumption_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.io_consumption_disabled_critical, var.io_consumption_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.io_consumption_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.io_consumption_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.io_consumption_disabled_major, var.io_consumption_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.io_consumption_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "memory_usage" {
  name = format("%s %s", local.detector_name_prefix, "Azure MySQL memory usage")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.DBforMySQL/servers') and filter('primary_aggregation_type', 'true')
        signal = data('memory_percent', filter=base_filter and ${module.filter-tags.filter_custom})${var.memory_usage_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.memory_usage_threshold_critical}), lasting="${var.memory_usage_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.memory_usage_threshold_major}), lasting="${var.memory_usage_timer}") and when(signal <= ${var.memory_usage_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.memory_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_usage_disabled_critical, var.memory_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_usage_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.memory_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_usage_disabled_major, var.memory_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_usage_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "replication_lag" {
  name = format("%s %s", local.detector_name_prefix, "Azure MySQL replication lag")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.DBforMySQL/servers') and filter('primary_aggregation_type', 'true')
        signal = data('seconds_behind_master', filter=base_filter and ${module.filter-tags.filter_custom})${var.replication_lag_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.replication_lag_threshold_critical}), lasting="${var.replication_lag_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.replication_lag_threshold_major}), lasting="${var.replication_lag_timer}") and when(signal <= ${var.replication_lag_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.replication_lag_threshold_critical}s"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.replication_lag_disabled_critical, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.replication_lag_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.replication_lag_threshold_major}s"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.replication_lag_disabled_major, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.replication_lag_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}
