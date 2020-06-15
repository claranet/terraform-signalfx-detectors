resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] RabbitMQ  heartbeat"

  program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('gauge.node.uptime', filter=filter('aws_state', 'running') and filter('gcp_status', '*RUNNING}') and filter('azure_power_state', 'PowerState/running') and filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom}).publish('signal')
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
    description           = "is approaching the watermark"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.vm_memory_disabled_critical, var.vm_memory_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.vm_memory_notifications_critical, var.vm_memory_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is approaching the watermark"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.vm_memory_disabled_warning, var.vm_memory_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.vm_memory_notifications_warning, var.vm_memory_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "messages_ready" {
  for_each = var.messages_ready_thresholds
  name     = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] RabbitMQ Queue messages ready ${each.key}"

  program_text = <<-EOF
        signal = data('gauge.queue.messages_ready', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom} and ${each.value.filter})${var.messages_ready_aggregation_function}.${var.messages_ready_transformation_function}(over='${var.messages_ready_transformation_window}').publish('signal')
        detect(when(signal > ${each.value.threshold_critical})).publish('CRIT')
        detect(when(signal > ${each.value.threshold_warning})).publish('WARN')
  EOF

  rule {
    description           = "is too high"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.messages_ready_disabled_critical, var.messages_ready_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.messages_ready_notifications_critical, var.messages_ready_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.messages_ready_disabled_warning, var.messages_ready_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.messages_ready_notifications_warning, var.messages_ready_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "messages_unacknowledged" {
  for_each = var.messages_unacknowledged_thresholds
  name     = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] RabbitMQ Queue messages unacknowledged ${each.key}"

  program_text = <<-EOF
        signal = data('gauge.queue.messages_unacknowledged', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom} and ${each.value.filter})${var.messages_unacknowledged_aggregation_function}.${var.messages_unacknowledged_transformation_function}(over='${var.messages_unacknowledged_transformation_window}').publish('signal')
        detect(when(signal > ${each.value.threshold_critical})).publish('CRIT')
        detect(when(signal > ${each.value.threshold_warning})).publish('WARN')
  EOF

  rule {
    description           = "is too high"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.messages_unacknowledged_disabled_critical, var.messages_unacknowledged_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.messages_unacknowledged_notifications_critical, var.messages_unacknowledged_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.messages_unacknowledged_disabled_warning, var.messages_unacknowledged_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.messages_unacknowledged_notifications_warning, var.messages_unacknowledged_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "messages_ack_rate" {
  for_each = var.messages_ack_rate_thresholds
  name     = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] RabbitMQ Queue messages ack rate ${each.key}"

  program_text = <<-EOF
        rate = data('counter.queue.message_stats.ack', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom} and ${each.value.filter})${var.messages_ack_rate_aggregation_function}.publish('rate')
        msg = data('gauge.queue.messages', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom} and ${each.value.filter})${var.messages_ack_rate_aggregation_function}.publish('msg', enable=False)
        detect((when((rate >= 0) and (rate <= threshold(${each.value.threshold_critical}) and (msg > 0)), lasting='${var.messages_ack_rate_duration}'))).publish('CRIT')
        detect((when((rate >= ${each.value.threshold_critical}) and (rate <= threshold(${each.value.threshold_warning}) and (msg > 0)), lasting='${var.messages_ack_rate_duration}'))).publish('WARN')
  EOF

  rule {
    description           = format("is too low < %s and there are ready or unack messages", each.value.threshold_critical)
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.messages_ack_rate_disabled_critical, var.messages_ack_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.messages_ack_rate_notifications_critical, var.messages_ack_rate_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = format("is too low < %s and there are ready or unack messages", each.value.threshold_warning)
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.messages_ack_rate_disabled_warning, var.messages_ack_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.messages_ack_rate_notifications_warning, var.messages_ack_rate_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "consumer_utilisation" {
  for_each = var.consumer_utilisation_thresholds
  name     = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] RabbitMQ Queue consumer utilisation ${each.key}"

  program_text = <<-EOF
        util = data('gauge.queue.consumer_utilisation', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom} and ${each.value.filter})${var.consumer_utilisation_aggregation_function}.publish('util')
        msg = data('gauge.queue.messages', filter=filter('plugin', 'rabbitmq') and ${module.filter-tags.filter_custom} and ${each.value.filter})${var.consumer_utilisation_aggregation_function}.publish('msg')
        detect((when((util < threshold(${each.value.threshold_critical}) and (msg > 0)), lasting='${var.consumer_utilisation_duration}'))).publish('CRIT')
        detect((when((util < threshold(${each.value.threshold_warning}) and (msg > 0)), lasting='${var.consumer_utilisation_duration}'))).publish('WARN')
  EOF

  rule {
    description           = "is too low < ${each.value.threshold_critical}, consumers seems too slow"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.consumer_utilisation_disabled_critical, var.consumer_utilisation_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.consumer_utilisation_notifications_critical, var.consumer_utilisation_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too low < ${each.value.threshold_warning}, consumers seems too slow"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.consumer_utilisation_disabled_warning, var.consumer_utilisation_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.consumer_utilisation_notifications_warning, var.consumer_utilisation_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
