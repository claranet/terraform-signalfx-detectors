resource "signalfx_detector" "heartbeat" {
  name      = format("%s %s", local.detector_name_prefix, "Apache Solr heartbeat")
  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('counter.solr.http_requests', filter=${local.not_running_vm_filters} and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "errors" {
  name = format("%s %s", local.detector_name_prefix, "Apache Solr errors count")

  program_text = <<-EOF
    signal = data('counter.solr.zookeeper_errors', filter=${module.filter-tags.filter_custom})${var.errors_aggregation_function}${var.errors_transformation_function}.publish('signal')
    detect(when(signal >= ${var.errors_threshold_critical})).publish('CRIT')
    detect(when(signal >= ${var.errors_threshold_major}) and when(signal <= ${var.errors_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.errors_disabled_critical, var.errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.errors_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high >= ${var.errors_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.errors_disabled_major, var.errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.errors_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "searcher_warmup_time" {
  name = format("%s %s", local.detector_name_prefix, "Apache Solr searcher warmup time")

  program_text = <<-EOF
    signal = data('gauge.solr.searcher_warmup', filter=${module.filter-tags.filter_custom})${var.searcher_warmup_time_aggregation_function}${var.searcher_warmup_time_transformation_function}.publish('signal')
    detect(when(signal >= ${var.searcher_warmup_time_threshold_critical})).publish('CRIT')
    detect(when(signal >= ${var.searcher_warmup_time_threshold_major}) and when(signal <= ${var.searcher_warmup_time_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.searcher_warmup_time_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.searcher_warmup_time_disabled_critical, var.searcher_warmup_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.searcher_warmup_time_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high >= ${var.searcher_warmup_time_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.searcher_warmup_time_disabled_major, var.searcher_warmup_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.searcher_warmup_time_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

