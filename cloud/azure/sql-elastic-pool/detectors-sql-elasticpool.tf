resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure SQL Elastic Pool heartbeat")

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.Sql/servers/elasticpools') and filter('primary_aggregation_type', 'true')
        signal = data('cpu_percent', filter=base_filter and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "cpu" {
  name = format("%s %s", local.detector_name_prefix, "Azure SQL Elastic Pool CPU")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Sql/servers/elasticpools') and filter('primary_aggregation_type', 'true')
        signal = data('cpu_percent', filter=base_filter and ${module.filter-tags.filter_custom})${var.cpu_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.cpu_threshold_critical}), lasting="${var.cpu_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.cpu_threshold_major}), lasting="${var.cpu_timer}") and when(signal <= ${var.cpu_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.cpu_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_disabled_critical, var.cpu_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.cpu_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_disabled_major, var.cpu_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "free_space" {
  name = format("%s %s", local.detector_name_prefix, "Azure SQL Elastic Pool disk usage")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Sql/servers/elasticpools') and filter('primary_aggregation_type', 'true')
        signal = data('storage_percent', filter=base_filter and ${module.filter-tags.filter_custom})${var.free_space_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.free_space_threshold_critical}), lasting="${var.free_space_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.free_space_threshold_major}), lasting="${var.free_space_timer}") and when(signal <= ${var.free_space_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.free_space_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.free_space_disabled_critical, var.free_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.free_space_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.free_space_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.free_space_disabled_major, var.free_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.free_space_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "dtu_consumption" {
  name = format("%s %s", local.detector_name_prefix, "Azure SQL Elastic Pool DTU consumption")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Sql/servers/elasticpools') and filter('primary_aggregation_type', 'true')
        signal = data('dtu_consumption_percent', filter=base_filter and ${module.filter-tags.filter_custom})${var.dtu_consumption_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.dtu_consumption_threshold_critical}), lasting="${var.dtu_consumption_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.dtu_consumption_threshold_major}), lasting="${var.dtu_consumption_timer}") and when(signal <= ${var.dtu_consumption_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.dtu_consumption_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.dtu_consumption_disabled_critical, var.dtu_consumption_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.dtu_consumption_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.dtu_consumption_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.dtu_consumption_disabled_major, var.dtu_consumption_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.dtu_consumption_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}
