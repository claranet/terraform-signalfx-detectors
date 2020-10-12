resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure Redis heartbeat")

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.Cache/Redis') and filter('primary_aggregation_type', 'true')
        signal = data('usedmemory', filter=base_filter and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "evictedkeys" {
  name = format("%s %s", local.detector_name_prefix, "Azure Redis evicted keys")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Cache/Redis') and filter('primary_aggregation_type', 'true')
        signal = data('evictedkeys', filter=base_filter and ${module.filter-tags.filter_custom})${var.evictedkeys_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.evictedkeys_threshold_critical}), lasting="${var.evictedkeys_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.evictedkeys_threshold_major}), lasting="${var.evictedkeys_timer}") and when(signal <= ${var.evictedkeys_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "are too high > ${var.evictedkeys_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.evictedkeys_disabled_critical, var.evictedkeys_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.evictedkeys_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "are too high > ${var.evictedkeys_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.evictedkeys_disabled_major, var.evictedkeys_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.evictedkeys_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "percent_processor_time" {
  name = format("%s %s", local.detector_name_prefix, "Azure Redis processor time")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Cache/Redis') and filter('primary_aggregation_type', 'true')
        signal = data('percentProcessorTime', filter=base_filter and ${module.filter-tags.filter_custom})${var.percent_processor_time_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.percent_processor_time_threshold_critical}), lasting="${var.percent_processor_time_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.percent_processor_time_threshold_major}), lasting="${var.percent_processor_time_timer}") and when(signal <= ${var.percent_processor_time_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.percent_processor_time_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.percent_processor_time_disabled_critical, var.percent_processor_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.percent_processor_time_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.percent_processor_time_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.percent_processor_time_disabled_major, var.percent_processor_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.percent_processor_time_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "load" {
  name = format("%s %s", local.detector_name_prefix, "Azure Redis load")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Cache/Redis') and filter('primary_aggregation_type', 'true')
        signal = data('serverLoad', filter=base_filter and ${module.filter-tags.filter_custom})${var.load_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.load_threshold_critical}), lasting="${var.load_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.load_threshold_major}), lasting="${var.load_timer}") and when(signal <= ${var.load_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too high > ${var.load_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.load_disabled_critical, var.load_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.load_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.load_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.load_disabled_major, var.load_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.load_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}
