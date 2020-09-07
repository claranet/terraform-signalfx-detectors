resource "signalfx_detector" "heartbeat" {
  name      = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Apache heartbeat"
  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('apache_connections', filter=(not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}')) and (not filter('gcp_status', '{Code=3, Name=STOPPING}', '{Code=4, Name=TERMINATED}')) and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stopped', 'PowerState/deallocating', 'PowerState/deallocated')) and ${module.filter-tags.filter_custom}).publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "apache_workers" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Apache busy workers"

  program_text = <<-EOF
    A = data('apache_connections', ${module.filter-tags.filter_custom})${var.apache_workers_aggregation_function}${var.apache_workers_transformation_function}
    B = data('apache_idle_workers', ${module.filter-tags.filter_custom})${var.apache_workers_aggregation_function}${var.apache_workers_transformation_function}
    signal = ((A / (A+B)).scale(100)).publish('signal')
    detect(when(signal > ${var.apache_workers_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.apache_workers_threshold_warning}) and when(signal <= ${var.apache_workers_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "are too high > ${var.apache_workers_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.apache_workers_disabled_critical, var.apache_workers_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.apache_workers_notifications_critical, var.apache_workers_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too high > ${var.apache_workers_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.apache_workers_disabled_warning, var.apache_workers_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.apache_workers_notifications_warning, var.apache_workers_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

