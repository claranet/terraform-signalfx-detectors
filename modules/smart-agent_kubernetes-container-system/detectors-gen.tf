resource "signalfx_detector" "container_cpu_usage" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes container cpu usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = not filter('kubernetes_namespace','ara') and not filter('kubernetes_namespace','bastions') and not filter('kubernetes_namespace','gitlab-runner') and not filter('kubernetes_namespace','logging') and not filter('kubernetes_namespace','monitoring') and not filter('kubernetes_namespace','ingress-nginx') and not filter('kubernetes_namespace','kube-system') and not filter('kubernetes_namespace','kubernetes-replicator')
    kubernetes_container_cpu_limit = data('kubernetes.container_cpu_limit', filter=base_filtering and ${module.filter-tags.filter_custom})${var.container_cpu_usage_aggregation_function}${var.container_cpu_usage_transformation_function}
    kubernetes_container_cpu_utilization = data('container_cpu_utilization', filter=base_filtering and ${module.filter-tags.filter_custom})${var.container_cpu_usage_aggregation_function}${var.container_cpu_usage_transformation_function}
    signal = (kubernetes_container_cpu_utilization/(kubernetes_container_cpu_limit)).scale(0.01).publish('signal')
    detect(when(signal > ${var.container_cpu_usage_threshold_minor})).publish('MINOR')
    detect(when(signal > ${var.container_cpu_usage_threshold_warning}) and when(signal <= ${var.container_cpu_usage_threshold_minor})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.container_cpu_usage_threshold_minor}%"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.container_cpu_usage_disabled_minor, var.container_cpu_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.container_cpu_usage_notifications, "minor", []), var.notifications.minor)
    runbook_url           = try(coalesce(var.container_cpu_usage_runbook_url, var.runbook_url), "")
    tip                   = var.container_cpu_usage_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.container_cpu_usage_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.container_cpu_usage_disabled_warning, var.container_cpu_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.container_cpu_usage_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.container_cpu_usage_runbook_url, var.runbook_url), "")
    tip                   = var.container_cpu_usage_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "container_mem_usage" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes container mem usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = not filter('kubernetes_namespace','ara') and not filter('kubernetes_namespace','bastions') and not filter('kubernetes_namespace','gitlab-runner') and not filter('kubernetes_namespace','logging') and not filter('kubernetes_namespace','monitoring') and not filter('kubernetes_namespace','ingress-nginx') and not filter('kubernetes_namespace','kube-system') and not filter('kubernetes_namespace','kubernetes-replicator')
    kubernetes_container_mem_limit = data('kubernetes.container_memory_limit', filter=base_filtering and ${module.filter-tags.filter_custom})${var.container_mem_usage_aggregation_function}${var.container_mem_usage_transformation_function}
    kubernetes_container_mem_utilization = data('container_memory_usage_bytes', filter=base_filtering and ${module.filter-tags.filter_custom})${var.container_mem_usage_aggregation_function}${var.container_mem_usage_transformation_function}
    signal = (kubernetes_container_mem_utilization/kubernetes_container_mem_limit).scale(100).publish('signal')
    detect(when(signal > ${var.container_mem_usage_threshold_minor})).publish('MINOR')
    detect(when(signal > ${var.container_mem_usage_threshold_warning}) and when(signal <= ${var.container_mem_usage_threshold_minor})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.container_mem_usage_threshold_minor}%"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.container_mem_usage_disabled_minor, var.container_mem_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.container_mem_usage_notifications, "minor", []), var.notifications.minor)
    runbook_url           = try(coalesce(var.container_mem_usage_runbook_url, var.runbook_url), "")
    tip                   = var.container_mem_usage_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.container_mem_usage_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.container_mem_usage_disabled_warning, var.container_mem_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.container_mem_usage_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.container_mem_usage_runbook_url, var.runbook_url), "")
    tip                   = var.container_mem_usage_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

