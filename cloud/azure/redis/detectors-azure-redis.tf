resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Redis heartbeat"

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.Cache/Redis') and filter('primary_aggregation_type', 'true')
        signal = data('usedmemory', filter=base_filter and ${module.filter-tags.filter_custom}).publish('signal')
        not_reporting.detector(stream=signal, resource_identifier=['shardid'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "evictedkeys" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Redis evicted keys"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Cache/Redis') and filter('primary_aggregation_type', 'true')
        signal = data('evictedkeys', filter=base_filter and ${module.filter-tags.filter_custom})${var.evictedkeys_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.evictedkeys_threshold_critical}), lasting="${var.evictedkeys_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.evictedkeys_threshold_warning}), lasting="${var.evictedkeys_timer}") and when(signal <= ${var.evictedkeys_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "are too high > ${var.evictedkeys_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.evictedkeys_disabled_critical, var.evictedkeys_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.evictedkeys_notifications_critical, var.evictedkeys_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too high > ${var.evictedkeys_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.evictedkeys_disabled_warning, var.evictedkeys_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.evictedkeys_notifications_warning, var.evictedkeys_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "percent_processor_time" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Redis processor time"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Cache/Redis') and filter('primary_aggregation_type', 'true')
        signal = data('percentProcessorTime', filter=base_filter and ${module.filter-tags.filter_custom})${var.percent_processor_time_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.percent_processor_time_threshold_critical}), lasting="${var.percent_processor_time_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.percent_processor_time_threshold_warning}), lasting="${var.percent_processor_time_timer}") and when(signal <= ${var.percent_processor_time_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.percent_processor_time_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.percent_processor_time_disabled_critical, var.percent_processor_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.percent_processor_time_notifications_critical, var.percent_processor_time_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.percent_processor_time_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.percent_processor_time_disabled_warning, var.percent_processor_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.percent_processor_time_notifications_warning, var.percent_processor_time_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "load" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Redis load"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Cache/Redis') and filter('primary_aggregation_type', 'true')
        signal = data('serverLoad', filter=base_filter and ${module.filter-tags.filter_custom})${var.load_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.load_threshold_critical}), lasting="${var.load_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.load_threshold_warning}), lasting="${var.load_timer}") and when(signal <= ${var.load_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.load_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.load_disabled_critical, var.load_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.load_notifications_critical, var.load_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.load_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.load_disabled_warning, var.load_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.load_notifications_warning, var.load_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
