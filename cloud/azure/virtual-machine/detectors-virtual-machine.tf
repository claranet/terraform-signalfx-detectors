resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Virtual Machine heartbeat"

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.Compute/virtualMachines') and filter('primary_aggregation_type', 'true') and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stopped', 'PowerState/deallocating', 'PowerState/deallocated'))
        signal = data('Percentage CPU', filter=base_filter and ${module.filter-tags.filter_custom}).publish('signal')
        not_reporting.detector(stream=signal, resource_identifier=['azure_resource_id'], duration='${var.heartbeat_timeframe}').publish('CRIT')
    EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "cpu_usage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Virtual Machine CPU usage"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Compute/virtualMachines') and filter('primary_aggregation_type', 'true') and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stopped', 'PowerState/deallocating', 'PowerState/deallocated'))
        signal = data('Percentage CPU', filter=base_filter and ${module.filter-tags.filter_custom})${var.cpu_usage_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.cpu_usage_threshold_critical}), lasting="${var.cpu_usage_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.cpu_usage_threshold_warning}), lasting="${var.cpu_usage_timer}") and when(signal <= ${var.cpu_usage_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.cpu_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_usage_disabled_critical, var.cpu_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_usage_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.cpu_usage_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.cpu_usage_disabled_warning, var.cpu_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_usage_notifications, "warning", []), var.notifications.warning)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "credit_cpu" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Virtual Machine remaining CPU credit"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Compute/virtualMachines') and filter('primary_aggregation_type', 'true') and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stopped', 'PowerState/deallocating', 'PowerState/deallocated'))
        A = data('CPU Credits Remaining', filter=base_filter and ${module.filter-tags.filter_custom})${var.credit_cpu_aggregation_function}
        B = data('CPU Credits Consumed', filter=base_filter and ${module.filter-tags.filter_custom})${var.credit_cpu_aggregation_function}
        signal = ((A/(A+B))*100).fill(100).${var.credit_cpu_transformation_function}(over='${var.credit_cpu_timer}').publish('signal')
        detect(when(signal < threshold(${var.credit_cpu_threshold_critical}), lasting="${var.credit_cpu_timer}")).publish('CRIT')
        detect(when(signal < threshold(${var.credit_cpu_threshold_warning}), lasting="${var.credit_cpu_timer}") and when(signal >= ${var.credit_cpu_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too low < ${var.credit_cpu_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.credit_cpu_disabled_critical, var.credit_cpu_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.credit_cpu_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too low < ${var.credit_cpu_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.credit_cpu_disabled_warning, var.credit_cpu_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.credit_cpu_notifications, "warning", []), var.notifications.warning)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
