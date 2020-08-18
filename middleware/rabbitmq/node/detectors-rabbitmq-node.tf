resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] RabbitMQ  heartbeat"

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('gauge.node.uptime', filter=(not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}')) and (not filter('gcp_status', '{Code=3, Name=STOPPING}', '{Code=4, Name=TERMINATED}')) and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stopped', 'PowerState/deallocating', 'PowerState/deallocated')) and filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom}).publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=['host'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "file_descriptors" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] RabbitMQ Node file descriptors usage"

  program_text = <<-EOF
        A = data('gauge.node.fd_used', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.file_descriptors_aggregation_function}
        B = data('gauge.node.fd_total', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.file_descriptors_aggregation_function}
        signal = (A/B).scale(100).${var.file_descriptors_transformation_function}(over='${var.file_descriptors_transformation_window}').publish('signal')
        detect(when(signal > ${var.file_descriptors_threshold_critical})).publish('CRIT')
        detect(when(signal > ${var.file_descriptors_threshold_warning}) and when(signal <= ${var.file_descriptors_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.file_descriptors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.file_descriptors_disabled_critical, var.file_descriptors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_descriptors_notifications_critical, var.file_descriptors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.file_descriptors_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.file_descriptors_disabled_warning, var.file_descriptors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.file_descriptors_notifications_warning, var.file_descriptors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "processes" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] RabbitMQ Node process usage"

  program_text = <<-EOF
        A = data('gauge.node.proc_used', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.processes_aggregation_function}
        B = data('gauge.node.proc_total', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.processes_aggregation_function}
        signal = (A/B).scale(100).${var.processes_transformation_function}(over='${var.processes_transformation_window}').publish('signal')
        detect(when(signal > ${var.processes_threshold_critical})).publish('CRIT')
        detect(when(signal > ${var.processes_threshold_warning}) and when(signal <= ${var.processes_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.processes_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.processes_disabled_critical, var.processes_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.processes_notifications_critical, var.processes_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.processes_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.processes_disabled_warning, var.processes_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.processes_notifications_warning, var.processes_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "sockets" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] RabbitMQ Node sockets usage"

  program_text = <<-EOF
        A = data('gauge.node.sockets_used', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.sockets_aggregation_function}
        B = data('gauge.node.sockets_total', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.sockets_aggregation_function}
        signal = (A/B).scale(100).${var.sockets_transformation_function}(over='${var.sockets_transformation_window}').publish('signal')
        detect(when(signal > ${var.sockets_threshold_critical})).publish('CRIT')
        detect(when(signal > ${var.sockets_threshold_warning}) and when(signal < ${var.sockets_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.sockets_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.sockets_disabled_critical, var.sockets_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.sockets_notifications_critical, var.sockets_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.sockets_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.sockets_disabled_warning, var.sockets_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.sockets_notifications_warning, var.sockets_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "vm_memory" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] RabbitMQ Node vm_memory usage"

  program_text = <<-EOF
        A = data('gauge.node.mem_used', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.vm_memory_aggregation_function}
        B = data('gauge.node.mem_limit', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom})${var.vm_memory_aggregation_function}
        signal = (A/B).scale(100).${var.vm_memory_transformation_function}(over='${var.vm_memory_transformation_window}').publish('signal')
        detect(when(signal > ${var.vm_memory_threshold_critical})).publish('CRIT')
        detect(when(signal > ${var.vm_memory_threshold_warning}) and when(signal < ${var.vm_memory_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is approaching the limit"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.vm_memory_disabled_critical, var.vm_memory_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.vm_memory_notifications_critical, var.vm_memory_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is approaching the limit"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.vm_memory_disabled_warning, var.vm_memory_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.vm_memory_notifications_warning, var.vm_memory_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
