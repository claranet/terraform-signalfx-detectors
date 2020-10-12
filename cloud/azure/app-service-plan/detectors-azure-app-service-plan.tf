resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure App Service Plan heartbeat")

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.Web/serverFarms') and filter('primary_aggregation_type', 'true')
        signal = data('CpuPercentage', filter=base_filter and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "cpu_percentage" {
  name = format("%s %s", local.detector_name_prefix, "Azure App Service Plan CPU percentage")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Web/serverFarms') and filter('primary_aggregation_type', 'true')
        signal = data('CpuPercentage', filter=base_filter and ${module.filter-tags.filter_custom})${var.cpu_percentage_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.cpu_percentage_threshold_critical}), lasting="${var.cpu_percentage_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.cpu_percentage_threshold_major}), lasting="${var.cpu_percentage_timer}") and when(signal <= ${var.cpu_percentage_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.cpu_percentage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_percentage_disabled_critical, var.cpu_percentage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_percentage_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.cpu_percentage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_percentage_disabled_major, var.cpu_percentage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_percentage_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "memory_percentage" {
  name = format("%s %s", local.detector_name_prefix, "Azure App Service Plan memory percentage")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Web/serverFarms') and filter('primary_aggregation_type', 'true')
        signal = data('MemoryPercentage', filter=base_filter and ${module.filter-tags.filter_custom})${var.memory_percentage_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.memory_percentage_threshold_critical}), lasting="${var.memory_percentage_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.memory_percentage_threshold_major}), lasting="${var.memory_percentage_timer}") and when(signal <= ${var.memory_percentage_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.memory_percentage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_percentage_disabled_critical, var.memory_percentage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_percentage_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.memory_percentage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_percentage_disabled_major, var.memory_percentage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_percentage_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}
