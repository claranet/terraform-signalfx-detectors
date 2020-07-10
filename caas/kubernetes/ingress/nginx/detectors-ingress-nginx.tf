resource "signalfx_detector" "nginx_ingress_too_many_5xx" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Nginx Ingress 5xx errors"

  program_text = <<-EOF
		from signalfx.detectors.aperiodic import conditions
		A = data('nginx_ingress_controller_requests', filter=filter('status', '5*') and ${module.filter-tags.filter_custom})${var.nginx_ingress_too_many_5xx_aggregation_function}
		B = data('nginx_ingress_controller_requests', ${module.filter-tags.filter_custom})${var.nginx_ingress_too_many_5xx_aggregation_function}
		signal = ((A/B)*100).${var.nginx_ingress_too_many_5xx_transformation_function}(over='${var.nginx_ingress_too_many_5xx_transformation_window}').publish('signal')
		ON_Condition_CRIT = conditions.generic_condition(signal, ${var.nginx_ingress_too_many_5xx_threshold_critical}, ${var.nginx_ingress_too_many_5xx_threshold_critical}, 'above', lasting('${var.nginx_ingress_too_many_5xx_aperiodic_duration}', ${var.nginx_ingress_too_many_5xx_aperiodic_percentage}), 'observed')
		ON_Condition_WARN = conditions.generic_condition(signal, ${var.nginx_ingress_too_many_5xx_threshold_warning}, ${var.nginx_ingress_too_many_5xx_threshold_critical}, 'within_range', lasting('${var.nginx_ingress_too_many_5xx_aperiodic_duration}', ${var.nginx_ingress_too_many_5xx_aperiodic_percentage}), 'observed', strict_2=False)
		detect(ON_Condition_CRIT, off=when(signal is None, '${var.nginx_ingress_too_many_5xx_clear_duration}')).publish('CRIT')
		detect(ON_Condition_WARN, off=when(signal is None, '${var.nginx_ingress_too_many_5xx_clear_duration}')).publish('WARN')
EOF

  rule {
    description           = "are too high > ${var.nginx_ingress_too_many_5xx_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.nginx_ingress_too_many_5xx_disabled_critical, var.nginx_ingress_too_many_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.nginx_ingress_too_many_5xx_notifications_critical, var.nginx_ingress_too_many_5xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too high > ${var.nginx_ingress_too_many_5xx_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.nginx_ingress_too_many_5xx_disabled_warning, var.nginx_ingress_too_many_5xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.nginx_ingress_too_many_5xx_notifications_warning, var.nginx_ingress_too_many_5xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "nginx_ingress_too_many_4xx" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Nginx Ingress 4xx errors"

  program_text = <<-EOF
		from signalfx.detectors.aperiodic import conditions
		A = data('nginx_ingress_controller_requests', filter=filter('status', '4*') and ${module.filter-tags.filter_custom})${var.nginx_ingress_too_many_4xx_aggregation_function}
		B = data('nginx_ingress_controller_requests', ${module.filter-tags.filter_custom})${var.nginx_ingress_too_many_4xx_aggregation_function}
		signal = ((A/B)*100).${var.nginx_ingress_too_many_4xx_transformation_function}(over='${var.nginx_ingress_too_many_4xx_transformation_window}').publish('signal')
		ON_Condition_CRIT = conditions.generic_condition(signal, ${var.nginx_ingress_too_many_4xx_threshold_critical}, ${var.nginx_ingress_too_many_4xx_threshold_critical}, 'above', lasting('${var.nginx_ingress_too_many_4xx_aperiodic_duration}', ${var.nginx_ingress_too_many_4xx_aperiodic_percentage}), 'observed')
		ON_Condition_WARN = conditions.generic_condition(signal, ${var.nginx_ingress_too_many_4xx_threshold_warning}, ${var.nginx_ingress_too_many_4xx_threshold_critical}, 'within_range', lasting('${var.nginx_ingress_too_many_4xx_aperiodic_duration}', ${var.nginx_ingress_too_many_4xx_aperiodic_percentage}), 'observed', strict_2=False)
		detect(ON_Condition_CRIT, off=when(signal is None, '${var.nginx_ingress_too_many_4xx_clear_duration}')).publish('CRIT')
		detect(ON_Condition_WARN, off=when(signal is None, '${var.nginx_ingress_too_many_4xx_clear_duration}')).publish('WARN')
EOF

  rule {
    description           = "are too high > ${var.nginx_ingress_too_many_4xx_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.nginx_ingress_too_many_4xx_disabled_critical, var.nginx_ingress_too_many_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.nginx_ingress_too_many_4xx_notifications_critical, var.nginx_ingress_too_many_4xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "are too high > ${var.nginx_ingress_too_many_4xx_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.nginx_ingress_too_many_4xx_disabled_warning, var.nginx_ingress_too_many_4xx_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.nginx_ingress_too_many_4xx_notifications_warning, var.nginx_ingress_too_many_4xx_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
