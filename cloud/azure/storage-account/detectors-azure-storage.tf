resource "signalfx_detector" "blob_requests_error" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Blob Storage error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/blobServices') and filter('primary_aggregation_type', 'true') and not filter('apiname', 'GetBlobProperties', 'CreateContainer') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and not filter('responsetype', 'Success'))${var.blob_requests_error_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.blob_requests_error_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.blob_requests_error_threshold_critical}), lasting="${var.blob_requests_error_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.blob_requests_error_threshold_warning}), lasting="${var.blob_requests_error_timer}") and when(signal <= ${var.blob_requests_error_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.blob_requests_error_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.blob_requests_error_disabled_critical, var.blob_requests_error_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.blob_requests_error_notifications_critical, var.blob_requests_error_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.blob_requests_error_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.blob_requests_error_disabled_warning, var.blob_requests_error_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.blob_requests_error_notifications_warning, var.blob_requests_error_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "file_requests_error" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage File service error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and not filter('responsetype', 'Success'))${var.file_requests_error_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.file_requests_error_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.file_requests_error_threshold_critical}), lasting="${var.file_requests_error_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.file_requests_error_threshold_warning}), lasting="${var.file_requests_error_timer}") and when(signal <= ${var.file_requests_error_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.file_requests_error_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.file_requests_error_disabled_critical, var.file_requests_error_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_requests_error_notifications_critical, var.file_requests_error_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.file_requests_error_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.file_requests_error_disabled_warning, var.file_requests_error_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_requests_error_notifications_warning, var.file_requests_error_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "queue_requests_error" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Queue error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/queueServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and not filter('responsetype', 'Success'))${var.queue_requests_error_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.queue_requests_error_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.queue_requests_error_threshold_critical}), lasting="${var.queue_requests_error_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.queue_requests_error_threshold_warning}), lasting="${var.queue_requests_error_timer}") and when(signal <= ${var.queue_requests_error_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.queue_requests_error_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.queue_requests_error_disabled_critical, var.queue_requests_error_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.queue_requests_error_notifications_critical, var.queue_requests_error_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.queue_requests_error_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.queue_requests_error_disabled_warning, var.queue_requests_error_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.queue_requests_error_notifications_warning, var.queue_requests_error_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "table_requests_error" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Table error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/tableServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and not filter('responsetype', 'Success'))${var.table_requests_error_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.table_requests_error_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.table_requests_error_threshold_critical}), lasting="${var.table_requests_error_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.table_requests_error_threshold_warning}), lasting="${var.table_requests_error_timer}") and when(signal <= ${var.table_requests_error_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.table_requests_error_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.table_requests_error_disabled_critical, var.table_requests_error_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.table_requests_error_notifications_critical, var.table_requests_error_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.table_requests_error_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.table_requests_error_disabled_warning, var.table_requests_error_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.table_requests_error_notifications_warning, var.table_requests_error_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "blob_latency" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Blob latency"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/blobServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        signal = data('SuccessE2ELatency', extrapolation='zero', filter=base_filter)${var.blob_latency_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.blob_latency_threshold_critical}), lasting="${var.blob_latency_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.blob_latency_threshold_warning}), lasting="${var.blob_latency_timer}") and when(signal <= ${var.blob_latency_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.blob_latency_threshold_critical}ms"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.blob_latency_disabled_critical, var.blob_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.blob_latency_notifications_critical, var.blob_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.blob_latency_threshold_warning}ms"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.blob_latency_disabled_warning, var.blob_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.blob_latency_notifications_warning, var.blob_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "file_latency" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage File latency"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        signal = data('SuccessE2ELatency', extrapolation='zero', filter=base_filter)${var.file_latency_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.file_latency_threshold_critical}), lasting="${var.file_latency_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.file_latency_threshold_warning}), lasting="${var.file_latency_timer}") and when(signal <= ${var.file_latency_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.file_latency_threshold_critical}ms"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.file_latency_disabled_critical, var.file_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_latency_notifications_critical, var.file_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.file_latency_threshold_warning}ms"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.file_latency_disabled_warning, var.file_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_latency_notifications_warning, var.file_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "queue_latency" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Queue latency"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/queueServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        signal = data('SuccessE2ELatency', extrapolation='zero', filter=base_filter)${var.queue_latency_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.queue_latency_threshold_critical}), lasting="${var.queue_latency_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.queue_latency_threshold_warning}), lasting="${var.queue_latency_timer}") and when(signal <= ${var.queue_latency_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.queue_latency_threshold_critical}ms"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.queue_latency_disabled_critical, var.queue_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.queue_latency_notifications_critical, var.queue_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.queue_latency_threshold_warning}ms"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.queue_latency_disabled_warning, var.queue_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.queue_latency_notifications_warning, var.queue_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "table_latency" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Table latency"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/tableServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        signal = data('SuccessE2ELatency', extrapolation='zero', filter=base_filter)${var.table_latency_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.table_latency_threshold_critical}), lasting="${var.table_latency_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.table_latency_threshold_warning}), lasting="${var.table_latency_timer}") and when(signal <= ${var.table_latency_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.table_latency_threshold_critical}ms"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.table_latency_disabled_critical, var.table_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.table_latency_notifications_critical, var.table_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.table_latency_threshold_warning}ms"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.table_latency_disabled_warning, var.table_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.table_latency_notifications_warning, var.table_latency_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "blob_timeout_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Blob timeout error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/blobServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'ServerTimeoutError'))${var.blob_timeout_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.blob_timeout_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.blob_timeout_error_requests_threshold_critical}), lasting="${var.blob_timeout_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.blob_timeout_error_requests_threshold_warning}), lasting="${var.blob_timeout_error_requests_timer}") and when(signal <= ${var.blob_timeout_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.blob_timeout_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.blob_timeout_error_requests_disabled_critical, var.blob_timeout_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.blob_timeout_error_requests_notifications_critical, var.blob_timeout_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.blob_timeout_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.blob_timeout_error_requests_disabled_warning, var.blob_timeout_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.blob_timeout_error_requests_notifications_warning, var.blob_timeout_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "file_timeout_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage File timeout error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'ServerTimeoutError'))${var.file_timeout_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.file_timeout_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.file_timeout_error_requests_threshold_critical}), lasting="${var.file_timeout_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.file_timeout_error_requests_threshold_warning}), lasting="${var.file_timeout_error_requests_timer}") and when(signal <= ${var.file_timeout_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.file_timeout_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.file_timeout_error_requests_disabled_critical, var.file_timeout_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_timeout_error_requests_notifications_critical, var.file_timeout_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.file_timeout_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.file_timeout_error_requests_disabled_warning, var.file_timeout_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_timeout_error_requests_notifications_warning, var.file_timeout_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "queue_timeout_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Queue timeout error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/queueServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'ServerTimeoutError'))${var.queue_timeout_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.queue_timeout_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.queue_timeout_error_requests_threshold_critical}), lasting="${var.queue_timeout_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.queue_timeout_error_requests_threshold_warning}), lasting="${var.queue_timeout_error_requests_timer}") and when(signal <= ${var.queue_timeout_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.queue_timeout_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.queue_timeout_error_requests_disabled_critical, var.queue_timeout_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.queue_timeout_error_requests_notifications_critical, var.queue_timeout_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.queue_timeout_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.queue_timeout_error_requests_disabled_warning, var.queue_timeout_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.queue_timeout_error_requests_notifications_warning, var.queue_timeout_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "table_timeout_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Table timeout error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/tableServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'ServerTimeoutError'))${var.table_timeout_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.table_timeout_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.table_timeout_error_requests_threshold_critical}), lasting="${var.table_timeout_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.table_timeout_error_requests_threshold_warning}), lasting="${var.table_timeout_error_requests_timer}") and when(signal <= ${var.table_timeout_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.table_timeout_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.table_timeout_error_requests_disabled_critical, var.table_timeout_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.table_timeout_error_requests_notifications_critical, var.table_timeout_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.table_timeout_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.table_timeout_error_requests_disabled_warning, var.table_timeout_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.table_timeout_error_requests_notifications_warning, var.table_timeout_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "blob_network_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Blob network error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/blobServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'NetworkError'))${var.blob_network_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.blob_network_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.blob_network_error_requests_threshold_critical}), lasting="${var.blob_network_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.blob_network_error_requests_threshold_warning}), lasting="${var.blob_network_error_requests_timer}") and when(signal <= ${var.blob_network_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.blob_network_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.blob_network_error_requests_disabled_critical, var.blob_network_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.blob_network_error_requests_notifications_critical, var.blob_network_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.blob_network_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.blob_network_error_requests_disabled_warning, var.blob_network_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.blob_network_error_requests_notifications_warning, var.blob_network_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "file_network_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage File network error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'NetworkError'))${var.file_network_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.file_network_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.file_network_error_requests_threshold_critical}), lasting="${var.file_network_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.file_network_error_requests_threshold_warning}), lasting="${var.file_network_error_requests_timer}") and when(signal <= ${var.file_network_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.file_network_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.file_network_error_requests_disabled_critical, var.file_network_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_network_error_requests_notifications_critical, var.file_network_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.file_network_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.file_network_error_requests_disabled_warning, var.file_network_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_network_error_requests_notifications_warning, var.file_network_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "queue_network_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Queue network error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/queueServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'NetworkError'))${var.queue_network_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.queue_network_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.queue_network_error_requests_threshold_critical}), lasting="${var.queue_network_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.queue_network_error_requests_threshold_warning}), lasting="${var.queue_network_error_requests_timer}") and when(signal <= ${var.queue_network_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.queue_network_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.queue_network_error_requests_disabled_critical, var.queue_network_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.queue_network_error_requests_notifications_critical, var.queue_network_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.queue_network_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.queue_network_error_requests_disabled_warning, var.queue_network_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.queue_network_error_requests_notifications_warning, var.queue_network_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "table_network_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Table network error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/tableServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'NetworkError'))${var.table_network_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.table_network_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.table_network_error_requests_threshold_critical}), lasting="${var.table_network_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.table_network_error_requests_threshold_warning}), lasting="${var.table_network_error_requests_timer}") and when(signal <= ${var.table_network_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.table_network_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.table_network_error_requests_disabled_critical, var.table_network_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.table_network_error_requests_notifications_critical, var.table_network_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.table_network_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.table_network_error_requests_disabled_warning, var.table_network_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.table_network_error_requests_notifications_warning, var.table_network_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "blob_busy_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Blob busy error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/blobServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'ServerBusyError'))${var.blob_busy_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.blob_busy_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.blob_busy_error_requests_threshold_critical}), lasting="${var.blob_busy_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.blob_busy_error_requests_threshold_warning}), lasting="${var.blob_busy_error_requests_timer}") and when(signal <= ${var.blob_busy_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.blob_busy_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.blob_busy_error_requests_disabled_critical, var.blob_busy_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.blob_busy_error_requests_notifications_critical, var.blob_busy_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.blob_busy_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.blob_busy_error_requests_disabled_warning, var.blob_busy_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.blob_busy_error_requests_notifications_warning, var.blob_busy_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "file_busy_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage File busy error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'ServerBusyError'))${var.file_busy_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.file_busy_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.file_busy_error_requests_threshold_critical}), lasting="${var.file_busy_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.file_busy_error_requests_threshold_warning}), lasting="${var.file_busy_error_requests_timer}") and when(signal <= ${var.file_busy_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.file_busy_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.file_busy_error_requests_disabled_critical, var.file_busy_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_busy_error_requests_notifications_critical, var.file_busy_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.file_busy_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.file_busy_error_requests_disabled_warning, var.file_busy_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_busy_error_requests_notifications_warning, var.file_busy_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "queue_busy_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Queue busy error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/queueServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'ServerBusyError'))${var.queue_busy_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.queue_busy_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.queue_busy_error_requests_threshold_critical}), lasting="${var.queue_busy_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.queue_busy_error_requests_threshold_warning}), lasting="${var.queue_busy_error_requests_timer}") and when(signal <= ${var.queue_busy_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.queue_busy_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.queue_busy_error_requests_disabled_critical, var.queue_busy_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.queue_busy_error_requests_notifications_critical, var.queue_busy_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.queue_busy_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.queue_busy_error_requests_disabled_warning, var.queue_busy_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.queue_busy_error_requests_notifications_warning, var.queue_busy_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "table_busy_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Table busy error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/tableServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'ServerBusyError'))${var.table_busy_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.table_busy_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.table_busy_error_requests_threshold_critical}), lasting="${var.table_busy_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.table_busy_error_requests_threshold_warning}), lasting="${var.table_busy_error_requests_timer}") and when(signal <= ${var.table_busy_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.table_busy_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.table_busy_error_requests_disabled_critical, var.table_busy_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.table_busy_error_requests_notifications_critical, var.table_busy_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.table_busy_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.table_busy_error_requests_disabled_warning, var.table_busy_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.table_busy_error_requests_notifications_warning, var.table_busy_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "blob_server_other_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Blob server other error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/blobServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'ServerOtherError'))${var.blob_server_other_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.blob_server_other_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.blob_server_other_error_requests_threshold_critical}), lasting="${var.blob_server_other_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.blob_server_other_error_requests_threshold_warning}), lasting="${var.blob_server_other_error_requests_timer}") and when(signal <= ${var.blob_server_other_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.blob_server_other_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.blob_server_other_error_requests_disabled_critical, var.blob_server_other_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.blob_server_other_error_requests_notifications_critical, var.blob_server_other_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.blob_server_other_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.blob_server_other_error_requests_disabled_warning, var.blob_server_other_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.blob_server_other_error_requests_notifications_warning, var.blob_server_other_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "file_server_other_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage File server other error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'ServerOtherError'))${var.file_server_other_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.file_server_other_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.file_server_other_error_requests_threshold_critical}), lasting="${var.file_server_other_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.file_server_other_error_requests_threshold_warning}), lasting="${var.file_server_other_error_requests_timer}") and when(signal <= ${var.file_server_other_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.file_server_other_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.file_server_other_error_requests_disabled_critical, var.file_server_other_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_server_other_error_requests_notifications_critical, var.file_server_other_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.file_server_other_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.file_server_other_error_requests_disabled_warning, var.file_server_other_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_server_other_error_requests_notifications_warning, var.file_server_other_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "queue_server_other_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Queue server other error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/queueServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'ServerOtherError'))${var.queue_server_other_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.queue_server_other_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.queue_server_other_error_requests_threshold_critical}), lasting="${var.queue_server_other_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.queue_server_other_error_requests_threshold_warning}), lasting="${var.queue_server_other_error_requests_timer}") and when(signal <= ${var.queue_server_other_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.queue_server_other_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.queue_server_other_error_requests_disabled_critical, var.queue_server_other_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.queue_server_other_error_requests_notifications_critical, var.queue_server_other_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.queue_server_other_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.queue_server_other_error_requests_disabled_warning, var.queue_server_other_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.queue_server_other_error_requests_notifications_warning, var.queue_server_other_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "table_server_other_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Table server other error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/tableServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'ServerOtherError'))${var.table_server_other_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.table_server_other_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.table_server_other_error_requests_threshold_critical}), lasting="${var.table_server_other_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.table_server_other_error_requests_threshold_warning}), lasting="${var.table_server_other_error_requests_timer}") and when(signal <= ${var.table_server_other_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.table_server_other_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.table_server_other_error_requests_disabled_critical, var.table_server_other_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.table_server_other_error_requests_notifications_critical, var.table_server_other_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.table_server_other_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.table_server_other_error_requests_disabled_warning, var.table_server_other_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.table_server_other_error_requests_notifications_warning, var.table_server_other_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "blob_client_other_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Blob client other error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/blobServices') and filter('primary_aggregation_type', 'true') and  not filter('apiname', 'GetBlobProperties', 'CreateContainer') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'ClientOtherError'))${var.blob_client_other_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.blob_client_other_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.blob_client_other_error_requests_threshold_critical}), lasting="${var.blob_client_other_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.blob_client_other_error_requests_threshold_warning}), lasting="${var.blob_client_other_error_requests_timer}") and when(signal <= ${var.blob_client_other_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.blob_client_other_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.blob_client_other_error_requests_disabled_critical, var.blob_client_other_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.blob_client_other_error_requests_notifications_critical, var.blob_client_other_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.blob_client_other_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.blob_client_other_error_requests_disabled_warning, var.blob_client_other_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.blob_client_other_error_requests_notifications_warning, var.blob_client_other_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "file_client_other_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage File client other error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'ClientOtherError'))${var.file_client_other_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.file_client_other_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.file_client_other_error_requests_threshold_critical}), lasting="${var.file_client_other_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.file_client_other_error_requests_threshold_warning}), lasting="${var.file_client_other_error_requests_timer}") and when(signal <= ${var.file_client_other_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.file_client_other_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.file_client_other_error_requests_disabled_critical, var.file_client_other_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_client_other_error_requests_notifications_critical, var.file_client_other_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.file_client_other_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.file_client_other_error_requests_disabled_warning, var.file_client_other_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_client_other_error_requests_notifications_warning, var.file_client_other_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "queue_client_other_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Queue client other error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/queueServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'ClientOtherError'))${var.queue_client_other_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.queue_client_other_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.queue_client_other_error_requests_threshold_critical}), lasting="${var.queue_client_other_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.queue_client_other_error_requests_threshold_warning}), lasting="${var.queue_client_other_error_requests_timer}") and when(signal <= ${var.queue_client_other_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.queue_client_other_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.queue_client_other_error_requests_disabled_critical, var.queue_client_other_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.queue_client_other_error_requests_notifications_critical, var.queue_client_other_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.queue_client_other_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.queue_client_other_error_requests_disabled_warning, var.queue_client_other_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.queue_client_other_error_requests_notifications_warning, var.queue_client_other_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "table_client_other_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Table client other error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/tableServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'ClientOtherError'))${var.table_client_other_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.table_client_other_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.table_client_other_error_requests_threshold_critical}), lasting="${var.table_client_other_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.table_client_other_error_requests_threshold_warning}), lasting="${var.table_client_other_error_requests_timer}") and when(signal <= ${var.table_client_other_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.table_client_other_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.table_client_other_error_requests_disabled_critical, var.table_client_other_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.table_client_other_error_requests_notifications_critical, var.table_client_other_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.table_client_other_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.table_client_other_error_requests_disabled_warning, var.table_client_other_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.table_client_other_error_requests_notifications_warning, var.table_client_other_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "blob_authorization_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Blob authorization error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/blobServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'AuthorizationError'))${var.blob_authorization_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.blob_authorization_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.blob_authorization_error_requests_threshold_critical}), lasting="${var.blob_authorization_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.blob_authorization_error_requests_threshold_warning}), lasting="${var.blob_authorization_error_requests_timer}") and when(signal <= ${var.blob_authorization_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.blob_authorization_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.blob_authorization_error_requests_disabled_critical, var.blob_authorization_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.blob_authorization_error_requests_notifications_critical, var.blob_authorization_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.blob_authorization_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.blob_authorization_error_requests_disabled_warning, var.blob_authorization_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.blob_authorization_error_requests_notifications_warning, var.blob_authorization_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "file_authorization_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage File authorization error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'AuthorizationError'))${var.file_authorization_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.file_authorization_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.file_authorization_error_requests_threshold_critical}), lasting="${var.file_authorization_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.file_authorization_error_requests_threshold_warning}), lasting="${var.file_authorization_error_requests_timer}") and when(signal <= ${var.file_authorization_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.file_authorization_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.file_authorization_error_requests_disabled_critical, var.file_authorization_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_authorization_error_requests_notifications_critical, var.file_authorization_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.file_authorization_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.file_authorization_error_requests_disabled_warning, var.file_authorization_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_authorization_error_requests_notifications_warning, var.file_authorization_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "queue_authorization_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Queue authorization error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/queueServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'AuthorizationError'))${var.queue_authorization_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.queue_authorization_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.queue_authorization_error_requests_threshold_critical}), lasting="${var.queue_authorization_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.queue_authorization_error_requests_threshold_warning}), lasting="${var.queue_authorization_error_requests_timer}") and when(signal <= ${var.queue_authorization_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.queue_authorization_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.queue_authorization_error_requests_disabled_critical, var.queue_authorization_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.queue_authorization_error_requests_notifications_critical, var.queue_authorization_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.queue_authorization_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.queue_authorization_error_requests_disabled_warning, var.queue_authorization_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.queue_authorization_error_requests_notifications_warning, var.queue_authorization_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "table_authorization_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Table authorization error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/tableServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'AuthorizationError'))${var.table_authorization_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.table_authorization_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.table_authorization_error_requests_threshold_critical}), lasting="${var.table_authorization_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.table_authorization_error_requests_threshold_warning}), lasting="${var.table_authorization_error_requests_timer}") and when(signal <= ${var.table_authorization_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.table_authorization_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.table_authorization_error_requests_disabled_critical, var.table_authorization_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.table_authorization_error_requests_notifications_critical, var.table_authorization_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.table_authorization_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.table_authorization_error_requests_disabled_warning, var.table_authorization_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.table_authorization_error_requests_notifications_warning, var.table_authorization_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "blob_throttling_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Blob throttling error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/blobServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'ClientAccountBandwidthThrottlingError', 'ClientAccountRequestThrottlingError', 'ClientThrottlingError'))${var.blob_throttling_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.blob_throttling_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.blob_throttling_error_requests_threshold_critical}), lasting="${var.blob_throttling_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.blob_throttling_error_requests_threshold_warning}), lasting="${var.blob_throttling_error_requests_timer}") and when(signal <= ${var.blob_throttling_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.blob_throttling_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.blob_throttling_error_requests_disabled_critical, var.blob_throttling_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.blob_throttling_error_requests_notifications_critical, var.blob_throttling_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.blob_throttling_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.blob_throttling_error_requests_disabled_warning, var.blob_throttling_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.blob_throttling_error_requests_notifications_warning, var.blob_throttling_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "file_throttling_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage File throttling error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'ClientAccountBandwidthThrottlingError', 'ClientAccountRequestThrottlingError', 'ClientThrottlingError'))${var.file_throttling_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.file_throttling_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.file_throttling_error_requests_threshold_critical}), lasting="${var.file_throttling_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.file_throttling_error_requests_threshold_warning}), lasting="${var.file_throttling_error_requests_timer}") and when(signal <= ${var.file_throttling_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.file_throttling_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.file_throttling_error_requests_disabled_critical, var.file_throttling_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_throttling_error_requests_notifications_critical, var.file_throttling_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.file_throttling_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.file_throttling_error_requests_disabled_warning, var.file_throttling_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_throttling_error_requests_notifications_warning, var.file_throttling_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "queue_throttling_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Queue throttling error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/queueServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'ClientAccountBandwidthThrottlingError', 'ClientAccountRequestThrottlingError', 'ClientThrottlingError'))${var.queue_throttling_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.queue_throttling_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.queue_throttling_error_requests_threshold_critical}), lasting="${var.queue_throttling_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.queue_throttling_error_requests_threshold_warning}), lasting="${var.queue_throttling_error_requests_timer}") and when(signal <= ${var.queue_throttling_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.queue_throttling_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.queue_throttling_error_requests_disabled_critical, var.queue_throttling_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.queue_throttling_error_requests_notifications_critical, var.queue_throttling_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.queue_throttling_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.queue_throttling_error_requests_disabled_warning, var.queue_throttling_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.queue_throttling_error_requests_notifications_warning, var.queue_throttling_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

resource "signalfx_detector" "table_throttling_error_requests" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure Storage Table throttling error rate"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts/tableServices') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}
        A = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter and filter('responsetype', 'ClientAccountBandwidthThrottlingError', 'ClientAccountRequestThrottlingError', 'ClientThrottlingError'))${var.table_throttling_error_requests_aggregation_function}
        B = data('Transactions', extrapolation='zero', rollup='sum', filter=base_filter)${var.table_throttling_error_requests_aggregation_function}
        signal = (A/B).scale(100).fill(0).publish('signal')
        detect(when(signal > threshold(${var.table_throttling_error_requests_threshold_critical}), lasting="${var.table_throttling_error_requests_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.table_throttling_error_requests_threshold_warning}), lasting="${var.table_throttling_error_requests_timer}") and when(signal <= ${var.table_throttling_error_requests_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.table_throttling_error_requests_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.table_throttling_error_requests_disabled_critical, var.table_throttling_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.table_throttling_error_requests_notifications_critical, var.table_throttling_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.table_throttling_error_requests_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.table_throttling_error_requests_disabled_warning, var.table_throttling_error_requests_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.table_throttling_error_requests_notifications_warning, var.table_throttling_error_requests_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}

