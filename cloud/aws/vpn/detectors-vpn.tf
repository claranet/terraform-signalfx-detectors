resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS VPN heartbeat")

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('TunnelState', filter=filter('stat', 'mean') and filter('namespace', 'AWS/VPN') and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "VPN_status" {
  name = format("%s %s", local.detector_name_prefix, "AWS VPN tunnel state")

  program_text = <<-EOF
    signal = data('TunnelState', filter=filter('namespace', 'AWS/VPN') and filter('stat', 'mean') and filter('VpnId', '*') and ${module.filter-tags.filter_custom})${var.vpn_status_aggregation_function}${var.vpn_status_transformation_function}.publish('signal')
    detect(when(signal < ${var.vpn_status_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "is reporting a state other than up"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.vpn_status_disabled_critical, var.vpn_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.vpn_status_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

