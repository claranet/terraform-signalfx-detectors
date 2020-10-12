resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS NLB heartbeat")

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('ConsumedLCUs', filter=filter('stat', 'mean') and filter('namespace', 'AWS/NetworkELB') and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "no_healthy_instances" {
  name = format("%s %s", local.detector_name_prefix, "AWS NLB healthy instances percentage")

  program_text = <<-EOF
    A = data('HealthyHostCount', filter=filter('namespace', 'AWS/NetworkELB') and filter('stat', 'lower') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom})${var.no_healthy_instances_aggregation_function}${var.no_healthy_instances_transformation_function}
    B = data('UnHealthyHostCount', filter=filter('namespace', 'AWS/NetworkELB') and filter('stat', 'upper') and (not filter('AvailabilityZone', '*')) and ${module.filter-tags.filter_custom})${var.no_healthy_instances_aggregation_function}${var.no_healthy_instances_transformation_function}
    signal = (A / (A+B)).scale(100).publish('signal')
    detect(when(signal < ${var.no_healthy_instances_threshold_critical})).publish('CRIT')
    detect(when(signal < ${var.no_healthy_instances_threshold_major}) and when(signal >= ${var.no_healthy_instances_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "has fallen below critical capacity < ${var.no_healthy_instances_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.no_healthy_instances_disabled_critical, var.no_healthy_instances_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.no_healthy_instances_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is below nominal capacity < ${var.no_healthy_instances_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.no_healthy_instances_disabled_major, var.no_healthy_instances_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.no_healthy_instances_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

