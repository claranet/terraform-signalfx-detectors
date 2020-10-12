resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure Virtual Machine heartbeat")

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.Compute/virtualMachines') and filter('primary_aggregation_type', 'true') and ${local.not_running_vm_filters_azure}
        signal = data('Percentage CPU', filter=base_filter and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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
  name = format("%s %s", local.detector_name_prefix, "Azure Virtual Machine CPU usage")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Compute/virtualMachines') and filter('primary_aggregation_type', 'true') and ${local.not_running_vm_filters_azure}
        signal = data('Percentage CPU', filter=base_filter and ${module.filter-tags.filter_custom})${var.cpu_usage_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "credit_cpu" {
  name = format("%s %s", local.detector_name_prefix, "Azure Virtual Machine remaining CPU credit")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Compute/virtualMachines') and filter('primary_aggregation_type', 'true') and ${local.not_running_vm_filters_azure}
        A = data('CPU Credits Remaining', filter=base_filter and ${module.filter-tags.filter_custom})${var.credit_cpu_aggregation_function}
        B = data('CPU Credits Consumed', filter=base_filter and ${module.filter-tags.filter_custom})${var.credit_cpu_aggregation_function}
        signal = ((A/(A+B))*100).fill(100).${var.credit_cpu_transformation_function}(over='${var.credit_cpu_timer}').publish('signal')
        detect(when(signal < threshold(${var.credit_cpu_threshold_critical}), lasting="${var.credit_cpu_timer}")).publish('CRIT')
        detect(when(signal < threshold(${var.credit_cpu_threshold_major}), lasting="${var.credit_cpu_timer}") and when(signal >= ${var.credit_cpu_threshold_critical})).publish('MAJOR')
    EOF

  rule {
    description           = "is too low < ${var.credit_cpu_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.credit_cpu_disabled_critical, var.credit_cpu_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.credit_cpu_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too low < ${var.credit_cpu_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.credit_cpu_disabled_major, var.credit_cpu_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.credit_cpu_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}
