resource "signalfx_detector" "hosts_limit" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Organization usage hosts limit"

  program_text = <<-EOF
    signal = data('${"sf.org.${var.is_parent ? "child." : ""}numResourcesMonitored"}', filter=filter('resourceType', 'host'))${local.aggregation_function}${var.hosts_limit_transformation_function}.publish('signal')
    limit = data('${"sf.org.${var.is_parent ? "child." : ""}subscription.hosts"}')${local.aggregation_function}${var.hosts_limit_transformation_function}
    detect(when(signal > threshold(limit))).publish('WARN')
EOF

  rule {
    description           = "is exceeded"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.hosts_limit_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.hosts_limit_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}} > {{inputs.limit.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
    runbook_url           = var.runbook_url
    tip                   = <<-EOF
      To avoid overbilling, limits are set per organization and per resources type.
EOF
  }
}

resource "signalfx_detector" "containers_limit" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Organization usage containers limit"

  program_text = <<-EOF
    signal = data('${"sf.org.${var.is_parent ? "child." : ""}numResourcesMonitored"}', filter=filter('resourceType', 'container'))${local.aggregation_function}${var.containers_limit_transformation_function}.publish('signal')
    limit = data('${"sf.org.${var.is_parent ? "child." : ""}subscription.containers"}')${local.aggregation_function}${var.containers_limit_transformation_function}
    detect(when(signal > threshold(limit))).publish('WARN')
EOF

  rule {
    description           = "is exceeded"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.containers_limit_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.containers_limit_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}} > {{inputs.limit.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
    runbook_url           = var.runbook_url
    tip                   = <<-EOF
      To avoid overbilling, limits are set per organization and per resources type.
EOF
  }
}

resource "signalfx_detector" "custom_metrics_limit" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Organization usage custom metrics limit"

  program_text = <<-EOF
    signal = data('${"sf.org.${var.is_parent ? "child." : ""}numCustomMetrics"}')${local.aggregation_function}${var.custom_metrics_limit_transformation_function}.publish('signal')
    limit = data('${"sf.org.${var.is_parent ? "child." : ""}subscription.customMetrics"}')${local.aggregation_function}${var.custom_metrics_limit_transformation_function}
    detect(when(signal > threshold(limit))).publish('WARN')
EOF

  rule {
    description           = "is exceeded"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.custom_metrics_limit_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.custom_metrics_limit_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}} > {{inputs.limit.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
    runbook_url           = var.runbook_url
    tip                   = <<-EOF
      To avoid overbilling, limits are set per organization and per resources type.
EOF
  }
}

resource "signalfx_detector" "containers_ratio" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Organization usage containers ratio per host included"

  program_text = <<-EOF
    containers = data('${"sf.org.${var.is_parent ? "child." : ""}numResourcesMonitored"}', filter=filter('resourceType', 'container'))${local.aggregation_function}${var.containers_ratio_transformation_function}
    hosts = data('${"sf.org.${var.is_parent ? "child." : ""}numResourcesMonitored"}', filter=filter('resourceType', 'host'))${local.aggregation_function}${var.containers_ratio_transformation_function}
    signal = (containers / (hosts*${var.multiplier}0)).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.containers_ratio_threshold_warning}))).publish('WARN')
EOF

  rule {
    description           = "is exceeded > ${var.containers_ratio_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.containers_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.containers_ratio_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
    runbook_url           = var.runbook_url
    tip                   = <<-EOF
      Enterprise plan includes ${var.multiplier}0 containers per host.
      Exceeding this will be paid as extra.
      Current billing will be increased by this ratio.
EOF
  }
}

resource "signalfx_detector" "custom_metrics_ratio" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Organization usage custom metrics ratio per host included"

  program_text = <<-EOF
    custom_metrics = data('${"sf.org.${var.is_parent ? "child." : ""}numCustomMetrics"}')${local.aggregation_function}${var.custom_metrics_ratio_transformation_function}
    hosts = data('${"sf.org.${var.is_parent ? "child." : ""}numResourcesMonitored"}', filter=filter('resourceType', 'host'))${local.aggregation_function}${var.custom_metrics_ratio_transformation_function}
    signal = (custom_metrics / (hosts*${var.multiplier}00)).scale(100).fill(value=0).publish('signal')
    detect(when(signal > threshold(${var.custom_metrics_ratio_threshold_warning}))).publish('WARN')
EOF

  rule {
    description           = "is exceeded > ${var.custom_metrics_ratio_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.custom_metrics_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.custom_metrics_ratio_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
    parameterized_body    = local.parameterized_body
    runbook_url           = var.runbook_url
    tip                   = <<-EOF
      Enterprise plan includes ${var.multiplier}00 custom metrics per host.
      Exceeding this will be paid as extra.
      Current billing will be increased by this ratio.
EOF
  }
}

