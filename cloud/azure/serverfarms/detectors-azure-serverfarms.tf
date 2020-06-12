resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Server Farm heartbeat"

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.Web/serverFarms') and filter('primary_aggregation_type', 'true')
        signal = data('CpuPercentage', filter=base_filter and ${module.filter-tags.filter_custom})
        not_reporting.detector(stream=signal, resource_identifier=['azure_resource_name', 'azure_resource_group_name', 'azure_region'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "cpu_percentage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Server Farm CPU percentage"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Web/serverFarms') and filter('primary_aggregation_type', 'true')
        signal = data('CpuPercentage', filter=base_filter and ${module.filter-tags.filter_custom})${var.cpu_percentage_aggregation_function}.${var.cpu_percentage_transformation_function}(over='${var.cpu_percentage_transformation_window}')
        detect(when(signal > ${var.cpu_percentage_threshold_critical})).publish('CRIT')
        detect(when(signal > ${var.cpu_percentage_threshold_warning}) and when(signal <= ${var.cpu_percentage_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.cpu_percentage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_percentage_disabled_critical, var.cpu_percentage_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.cpu_percentage_notifications_critical, var.cpu_percentage_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.cpu_percentage_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.cpu_percentage_disabled_warning, var.cpu_percentage_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.cpu_percentage_notifications_warning, var.cpu_percentage_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "memory_percentage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Server Farm memory percentage"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Web/serverFarms') and filter('primary_aggregation_type', 'true')
        signal = data('MemoryPercentage', filter=base_filter and ${module.filter-tags.filter_custom})${var.memory_percentage_aggregation_function}.${var.memory_percentage_transformation_function}(over='${var.memory_percentage_transformation_window}')
        detect(when(signal > ${var.memory_percentage_threshold_critical})).publish('CRIT')
        detect(when(signal > ${var.memory_percentage_threshold_warning}) and when(signal <= ${var.memory_percentage_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.memory_percentage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_percentage_disabled_critical, var.memory_percentage_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.memory_percentage_notifications_critical, var.memory_percentage_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.memory_percentage_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.memory_percentage_disabled_warning, var.memory_percentage_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.memory_percentage_notifications_warning, var.memory_percentage_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
