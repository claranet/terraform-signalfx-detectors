resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS VPN heartbeat"

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('TunnelDataIn', filter=filter('stat', 'mean') and filter('namespace', 'AWS/VPN') and (not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}')) and ${module.filter-tags.filter_custom}).publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=['TunnelIpAddress'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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

resource "signalfx_detector" "VPN_status" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS VPN tunnel state"

  program_text = <<-EOF
    signal = data('TunnelState', filter=filter('namespace', 'AWS/VPN') and filter('stat', 'lower') and ${module.filter-tags.filter_custom})${var.vpn_status_aggregation_function}.${var.vpn_status_transformation_function}(over='${var.vpn_status_transformation_window}').publish('signal')
    detect(when(signal < ${var.vpn_status_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "is reporting a state other than up"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.vpn_status_disabled_critical, var.vpn_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.vpn_status_notifications_critical, var.vpn_status_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

}
