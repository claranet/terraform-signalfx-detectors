resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Apache Solr heartbeat"

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('counter.solr.http_requests', filter=(not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}')) and (not filter('gcp_status', '{Code=3, Name=STOPPING}', '{Code=4, Name=TERMINATED}')) and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stoppped', 'PowerState/deallocating', 'PowerState/deallocated')) and ${module.filter-tags.filter_custom}).publish('signal')
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

resource "signalfx_detector" "errors" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Apache Solr errors count"

  program_text = <<-EOF
    signal = data('counter.solr.zookeeper_errors', ${module.filter-tags.filter_custom})${var.errors_aggregation_function}${var.errors_transformation_function}.publish('signal')
    detect(when(signal >= ${var.errors_threshold_critical})).publish('CRIT')
    detect(when(signal >= ${var.errors_threshold_warning}) and when(signal <= ${var.errors_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high >= ${var.errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.errors_disabled_critical, var.errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.errors_notifications_critical, var.errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high >= ${var.errors_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.errors_disabled_warning, var.errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.errors_notifications_warning, var.errors_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "searcher_warmup_time" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Apache Solr searcher warmup time"

  program_text = <<-EOF
    signal = data('gauge.solr.searcher_warmup', ${module.filter-tags.filter_custom})${var.searcher_warmup_time_aggregation_function}${var.searcher_warmup_time_transformation_function}.publish('signal')
    detect(when(signal >= ${var.searcher_warmup_time_threshold_critical})).publish('CRIT')
    detect(when(signal >= ${var.searcher_warmup_time_threshold_warning}) and when(signal <= ${var.searcher_warmup_time_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high >= ${var.searcher_warmup_time_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.searcher_warmup_time_disabled_critical, var.searcher_warmup_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.searcher_warmup_time_notifications_critical, var.searcher_warmup_time_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high >= ${var.searcher_warmup_time_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.searcher_warmup_time_disabled_warning, var.searcher_warmup_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.searcher_warmup_time_notifications_warning, var.searcher_warmup_time_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

