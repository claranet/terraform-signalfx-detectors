resource "signalfx_detector" "processes" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Processes aliveness"

  program_text = <<-EOF
        signal = data('ps_count.processes', filter=${module.filter-tags.filter_custom})${var.processes_aggregation_function}${var.processes_transformation_function}.publish('signal')
        detect(when(signal < 1)).publish('CRIT')
        detect(when(signal < ${var.processes_threshold_major}) and when (signal >= 1)).publish('MAJOR')
EOF

  rule {
    description           = "count is too low < 1"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.processes_disabled_critical, var.processes_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.processes_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }

  rule {
    description           = "count is too low < ${var.processes_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.processes_disabled_major, var.processes_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.processes_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
  }
}

