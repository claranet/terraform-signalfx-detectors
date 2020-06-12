resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure cosmosdb heartbeat"

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        signal = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDB/databaseAccounts') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}).publish('signal')
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

resource "signalfx_detector" "db_4xx_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Cosmo DB 4xx request rate"

  program_text = <<-EOF
        from signalfx.detectors.aperiodic import aperiodic
        A = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '400') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.db_4xx_requests_aggregation_function}
        B = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '401') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.db_4xx_requests_aggregation_function}
        C = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '403') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.db_4xx_requests_aggregation_function}
        D = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '404') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.db_4xx_requests_aggregation_function}
        E = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '408') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.db_4xx_requests_aggregation_function}
        F = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '409') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.db_4xx_requests_aggregation_function}
        G = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '412') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.db_4xx_requests_aggregation_function}
        H = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '413') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.db_4xx_requests_aggregation_function}
        I = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '429') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.db_4xx_requests_aggregation_function}
        J = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '449') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.db_4xx_requests_aggregation_function}
        K = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.db_4xx_requests_aggregation_function}
        signal = (((A+B+C+D+E+F+G+H+I+J)/K)*100).${var.db_4xx_requests_transformation_function}(over='${var.db_4xx_requests_transformation_window}').publish('signal')
        aperiodic.above_or_below_detector(signal, ${var.db_4xx_requests_threshold_critical}, 'above', lasting('${var.db_4xx_requests_aperiodic_duration}', ${var.db_4xx_requests_aperiodic_percentage})).publish('CRIT')
        aperiodic.range_detector(signal, ${var.db_4xx_requests_threshold_warning}, ${var.db_4xx_requests_threshold_critical}, 'within_range', lasting('${var.db_4xx_requests_aperiodic_duration}', ${var.db_4xx_requests_aperiodic_percentage}), upper_strict=False).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.db_4xx_requests_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.db_4xx_requests_disabled_critical, var.db_4xx_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.db_4xx_requests_notifications_critical, var.db_4xx_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.db_4xx_requests_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.db_4xx_requests_disabled_warning, var.db_4xx_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.db_4xx_requests_notifications_warning, var.db_4xx_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "db_5xx_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Cosmo DB 5xx error rate"

  program_text = <<-EOF
        from signalfx.detectors.aperiodic import aperiodic
        A = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '500') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.db_5xx_requests_aggregation_function}
        B = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '503') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.db_5xx_requests_aggregation_function}
        C = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.db_5xx_requests_aggregation_function}
        signal = (((A+B)/C)*100).${var.db_5xx_requests_transformation_function}(over='${var.db_5xx_requests_transformation_window}').publish('signal')
        aperiodic.above_or_below_detector(signal, ${var.db_5xx_requests_threshold_critical}, 'above', lasting('${var.db_5xx_requests_aperiodic_duration}', ${var.db_5xx_requests_aperiodic_percentage})).publish('CRIT')
        aperiodic.range_detector(signal, ${var.db_5xx_requests_threshold_warning}, ${var.db_5xx_requests_threshold_critical}, 'within_range', lasting('${var.db_5xx_requests_aperiodic_duration}', ${var.db_5xx_requests_aperiodic_percentage}), upper_strict=False).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.db_5xx_requests_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.db_5xx_requests_disabled_critical, var.db_5xx_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.db_5xx_requests_notifications_critical, var.db_5xx_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.db_5xx_requests_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.db_5xx_requests_disabled_warning, var.db_5xx_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.db_5xx_requests_notifications_warning, var.db_5xx_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "scaling" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Cosmo DB too many requests error rate"

  program_text = <<-EOF
        from signalfx.detectors.aperiodic import aperiodic
        A = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('statuscode', '429') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.scaling_aggregation_function}
        B = data('TotalRequests', filter=filter('resource_type', 'Microsoft.DocumentDb/databaseAccounts') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom})${var.scaling_aggregation_function}
        signal = ((A/B)*100).${var.scaling_transformation_function}(over='${var.scaling_transformation_window}').publish('signal')
        aperiodic.above_or_below_detector(signal, ${var.scaling_threshold_critical}, 'above', lasting('${var.scaling_aperiodic_duration}', ${var.scaling_aperiodic_percentage})).publish('CRIT')
        aperiodic.range_detector(signal, ${var.scaling_threshold_warning}, ${var.scaling_threshold_critical}, 'within_range', lasting('${var.scaling_aperiodic_duration}', ${var.scaling_aperiodic_percentage}), upper_strict=False).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.scaling_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.scaling_disabled_critical, var.scaling_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.scaling_notifications_critical, var.scaling_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.scaling_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.scaling_disabled_warning, var.scaling_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.scaling_notifications_warning, var.scaling_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
