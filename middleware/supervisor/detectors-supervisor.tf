resource "signalfx_detector" "heartbeat" {
  name      = format("%s %s", local.name_start, "Supervisor heartbeat")
  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('supervisor.state', filter=${local.heartbeat_filters} and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "process_state" {
  name = format("%s %s", local.name_start, "Supervisor process")

  program_text = <<-EOF
    signal = data('supervisor.state', filter=${module.filter-tags.filter_custom})${var.process_state_aggregation_function}${var.process_state_transformation_function}.publish('signal')
    detect(when(signal > ${var.process_state_threshold_critical})).publish('CRIT')
    detect(when(signal < ${var.process_state_threshold_major})).publish('MAJOR')
EOF

  rule {
    description           = "is not running (and not stopped)"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.process_state_disabled_critical, var.process_state_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.process_state_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.subject
    parameterized_body    = local.body
  }

  rule {
    description           = "is stopped"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.process_state_disabled_major, var.process_state_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.process_state_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.subject
    parameterized_body    = local.body
  }
}

