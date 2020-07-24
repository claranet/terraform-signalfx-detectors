resource "signalfx_detector" "heartbeat" {
    name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Key Vault heartbeat"

    program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.KeyVault/vaults') and filter('primary_aggregation_type', 'true')
        signal = data('SaturationShoebox', filter=base_filter and ${module.filter-tags.filter_custom})
        not_reporting.detector(stream=signal, resource_identifier=['azure_resource_name'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "api_result" {
    name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Key Vault API result rate"

    program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.KeyVault/vaults') and filter('primary_aggregation_type', 'true')
        A = data('ServiceApiResult', extrapolation="zero", filter=base_filter and filter('statuscode', '200') and ${module.filter-tags.filter_custom})${var.api_result_aggregation_function}
        B = data('ServiceApiResult', extrapolation="zero", filter=base_filter and ${module.filter-tags.filter_custom})${var.api_result_aggregation_function}
        signal = ((A/B)*100).fill(100).${var.api_result_transformation_function}(over='${var.api_result_transformation_window}')
        detect(when(signal < ${var.api_result_threshold_critical})).publish('CRIT')
        detect(when(signal < ${var.api_result_threshold_warning}) and when(signal >= ${var.api_result_threshold_critical})).publish('WARN')
    EOF

    rule {
        description           = "is too low < ${var.api_result_threshold_critical}%"
        severity              = "Critical"
        detect_label          = "CRIT"
        disabled              = coalesce(var.api_result_disabled_critical, var.api_result_disabled, var.detectors_disabled)
        notifications         = coalescelist(var.api_result_notifications_critical, var.api_result_notifications, var.notifications)
        parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    }

    rule {
        description           = "is too low < ${var.api_result_threshold_warning}%"
        severity              = "Warning"
        detect_label          = "WARN"
        disabled              = coalesce(var.api_result_disabled_warning, var.api_result_disabled, var.detectors_disabled)
        notifications         = coalescelist(var.api_result_notifications_warning, var.api_result_notifications, var.notifications)
        parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    }
}

resource "signalfx_detector" "api_latency" {
    name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Key Vault API latency"

    program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.KeyVault/vaults') and filter('primary_aggregation_type', 'true')
        signal = data('ServiceApiLatency', extrapolation="zero", filter=base_filter and not filter('activityname', 'secretlist') and ${module.filter-tags.filter_custom})${var.api_latency_aggregation_function}.${var.api_latency_transformation_function}(over='${var.api_latency_transformation_window}')
        detect(when(signal > ${var.api_latency_threshold_critical})).publish('CRIT')
        detect(when(signal > ${var.api_latency_threshold_warning}) and when(signal <= ${var.api_latency_threshold_critical})).publish('WARN')
    EOF

    rule {
        description           = "is too high > ${var.api_latency_threshold_critical}ms"
        severity              = "Critical"
        detect_label          = "CRIT"
        disabled              = coalesce(var.api_latency_disabled_critical, var.api_latency_disabled, var.detectors_disabled)
        notifications         = coalescelist(var.api_latency_notifications_critical, var.api_latency_notifications, var.notifications)
        parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    }

    rule {
        description           = "is too high > ${var.api_latency_threshold_warning}ms"
        severity              = "Warning"
        detect_label          = "WARN"
        disabled              = coalesce(var.api_latency_disabled_warning, var.api_latency_disabled, var.detectors_disabled)
        notifications         = coalescelist(var.api_latency_notifications_warning, var.api_latency_notifications, var.notifications)
        parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    }
}
