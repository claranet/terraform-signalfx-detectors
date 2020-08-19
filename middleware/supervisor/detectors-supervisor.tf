resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Supervisor heartbeat"

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('supervisor.state', filter=(not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}')) and (not filter('gcp_status', '{Code=3, Name=STOPPING}', '{Code=4, Name=TERMINATED}')) and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stopped', 'PowerState/deallocating', 'PowerState/deallocated')) and ${module.filter-tags.filter_custom}).publish('signal')
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

resource "signalfx_detector" "process_state" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Supervisor process"

  program_text = <<-EOF
    signal = data('supervisor.state', filter=${module.filter-tags.filter_custom})${var.process_state_aggregation_function}.${var.process_state_transformation_function}(over='${var.process_state_transformation_window}').publish('signal')
    detect(when(signal > ${var.process_state_threshold_critical})).publish('CRIT')
    detect(when(signal < ${var.process_state_threshold_warning})).publish('WARN')
EOF

  rule {
    description           = "is not running (and not stopped)"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.process_state_disabled_critical, var.process_state_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.process_state_notifications_critical, var.process_state_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is stopped"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.process_state_disabled_warning, var.process_state_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.process_state_notifications_warning, var.process_state_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

