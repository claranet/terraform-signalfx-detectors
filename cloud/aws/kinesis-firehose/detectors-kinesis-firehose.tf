resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS Kinesis heartbeat"

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('IncomingBytes', filter=filter('stat', 'mean') and filter('namespace', 'AWS/Kinesis') and (not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}')) and ${module.filter-tags.filter_custom}).publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=['StreamName'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "incoming_records" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS Kinesis incoming records"

  program_text = <<-EOF
    signal = data('IncomingRecords', filter=filter('namespace', 'AWS/Kinesis') and filter('stat', 'lower') and (not filter('ShardId', '*')) and ${module.filter-tags.filter_custom})${var.incoming_records_aggregation_function}.${var.incoming_records_transformation_function}(over='${var.incoming_records_transformation_window}').publish('signal')
    detect(when(signal <= ${var.incoming_records_threshold_critical})).publish('CRIT')
    detect(when(signal <= ${var.incoming_records_threshold_warning}) and when(signal > ${var.incoming_records_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "are too low <= ${var.incoming_records_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.incoming_records_disabled_critical, var.incoming_records_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.incoming_records_notifications_critical, var.incoming_records_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too low <= ${var.incoming_records_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.incoming_records_disabled_warning, var.incoming_records_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.incoming_records_notifications_warning, var.incoming_records_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}
