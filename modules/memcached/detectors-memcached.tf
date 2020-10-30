resource "signalfx_detector" "heartbeat" {
  name      = format("%s %s", local.detector_name_prefix, "Memcached heartbeat")
  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('memcached_items.current', filter=${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "memcached_max_conn" {
  name = format("%s %s", local.detector_name_prefix, "Memcached max conn")

  program_text = <<-EOF
    signal = data('total_events.listen_disabled', filter=${module.filter-tags.filter_custom}, rollup='delta')${var.memcached_max_conn_aggregation_function}${var.memcached_max_conn_transformation_function}.publish('signal')
    detect(when(signal > ${var.memcached_max_conn_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.memcached_max_conn_threshold_major}) and when(signal < ${var.memcached_max_conn_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "has been reached >= ${var.memcached_max_conn_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memcached_max_conn_disabled_critical, var.memcached_max_conn_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memcached_max_conn_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "has been reached >= ${var.memcached_max_conn_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memcached_max_conn_disabled_major, var.memcached_max_conn_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memcached_max_conn_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}
