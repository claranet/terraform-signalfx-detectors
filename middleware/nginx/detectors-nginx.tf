resource "signalfx_detector" "heartbeat" {
  name      = format("%s %s", local.name_prefix, "Nginx heartbeat")
  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('nginx_connections.reading', filter=${local.heartbeat_filters} and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.subject_novalue
    parameterized_body    = local.body
  }
}

resource "signalfx_detector" "dropped_connections" {
  name = format("%s %s", local.name_prefix, "Nginx dropped connections")

  program_text = <<-EOF
    signal = data('connections.failed', filter=${module.filter-tags.filter_custom})${var.dropped_connections_aggregation_function}${var.dropped_connections_transformation_function}.publish('signal')
    detect(when(signal > ${var.dropped_connections_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.dropped_connections_threshold_major}) and when(signal <= ${var.dropped_connections_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.dropped_connections_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.dropped_connections_disabled_critical, var.dropped_connections_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.dropped_connections_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.subject
    parameterized_body    = local.body
  }

  rule {
    description           = "is too high > ${var.dropped_connections_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.dropped_connections_disabled_major, var.dropped_connections_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.dropped_connections_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.subject
    parameterized_body    = local.body
  }
}

