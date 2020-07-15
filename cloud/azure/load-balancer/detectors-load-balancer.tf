resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure loadbalancer heartbeat"

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        signal = data('ByteCount', filter=filter('resource_type', 'Microsoft.Network/loadBalancers') and filter('primary_aggregation_type', 'true') and ${module.filter-tags.filter_custom}).publish('signal')
        not_reporting.detector(stream=signal, resource_identifier=['FrontendIPAddress'], duration='${var.heartbeat_timeframe}').publish('CRIT')
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