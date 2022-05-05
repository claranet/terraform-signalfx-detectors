resource "signalfx_detector" "workloads_count" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes workloads count")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "records"
  }

  program_text = <<-EOF
    kubernetes_deployment_desired = data('kubernetes.deployment.desired', filter=not filter('kubernetes_namespace','ara') and not filter('kubernetes_namespace','bastions') and not filter('kubernetes_namespace','gitlab-runner') and not filter('kubernetes_namespace','logging') and not filter('kubernetes_namespace','monitoring') and not filter('kubernetes_namespace','ingress-nginx') and not filter('kubernetes_namespace','kube-system') and not filter('kubernetes_namespace','kubernetes-replicator') and ${module.filtering.signalflow})${var.workloads_count_aggregation_function}${var.workloads_count_transformation_function}
    kubernetes_daemon_set_desired = data('kubernetes.daemon_set.desired_scheduled', filter=not filter('kubernetes_namespace','ara') and not filter('kubernetes_namespace','bastions') and not filter('kubernetes_namespace','gitlab-runner') and not filter('kubernetes_namespace','logging') and not filter('kubernetes_namespace','monitoring') and not filter('kubernetes_namespace','ingress-nginx') and not filter('kubernetes_namespace','kube-system') and not filter('kubernetes_namespace','kubernetes-replicator') and ${module.filtering.signalflow})${var.workloads_count_aggregation_function}${var.workloads_count_transformation_function}
    kubernetes_replication_controller_desired = data('kubernetes.replication_controller.desired', filter=not filter('kubernetes_namespace','ara') and not filter('kubernetes_namespace','bastions') and not filter('kubernetes_namespace','gitlab-runner') and not filter('kubernetes_namespace','logging') and not filter('kubernetes_namespace','monitoring') and not filter('kubernetes_namespace','ingress-nginx') and not filter('kubernetes_namespace','kube-system') and not filter('kubernetes_namespace','kubernetes-replicator') and ${module.filtering.signalflow})${var.workloads_count_aggregation_function}${var.workloads_count_transformation_function}
    kubernetes_replica_set_desired = data('kubernetes.replica_set.desired', filter=not filter('kubernetes_namespace','ara') and not filter('kubernetes_namespace','bastions') and not filter('kubernetes_namespace','gitlab-runner') and not filter('kubernetes_namespace','logging') and not filter('kubernetes_namespace','monitoring') and not filter('kubernetes_namespace','ingress-nginx') and not filter('kubernetes_namespace','kube-system') and not filter('kubernetes_namespace','kubernetes-replicator') and ${module.filtering.signalflow})${var.workloads_count_aggregation_function}${var.workloads_count_transformation_function}
    kubernetes_statefulset_desired = data('kubernetes.stateful_set.desired', filter=not filter('kubernetes_namespace','ara') and not filter('kubernetes_namespace','bastions') and not filter('kubernetes_namespace','gitlab-runner') and not filter('kubernetes_namespace','logging') and not filter('kubernetes_namespace','monitoring') and not filter('kubernetes_namespace','ingress-nginx') and not filter('kubernetes_namespace','kube-system') and not filter('kubernetes_namespace','kubernetes-replicator') and ${module.filtering.signalflow})${var.workloads_count_aggregation_function}${var.workloads_count_transformation_function}
    signal = (kubernetes_deployment_desired+kubernetes_daemon_set_desired+kubernetes_replication_controller_desired+kubernetes_replica_set_desired+kubernetes_statefulset_desired).publish('signal')
    detect(when(signal > ${var.workloads_count_threshold_minor}, lasting=%{if var.workloads_count_lasting_duration_minor == null}None%{else}'${var.workloads_count_lasting_duration_minor}'%{endif}, at_least=${var.workloads_count_at_least_percentage_minor})).publish('MINOR')
    detect(when(signal > ${var.workloads_count_threshold_warning}, lasting=%{if var.workloads_count_lasting_duration_warning == null}None%{else}'${var.workloads_count_lasting_duration_warning}'%{endif}, at_least=${var.workloads_count_at_least_percentage_warning}) and (not when(signal > ${var.workloads_count_threshold_minor}, lasting=%{if var.workloads_count_lasting_duration_minor == null}None%{else}'${var.workloads_count_lasting_duration_minor}'%{endif}, at_least=${var.workloads_count_at_least_percentage_minor}))).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.workloads_count_threshold_minor}records"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.workloads_count_disabled_minor, var.workloads_count_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.workloads_count_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.workloads_count_runbook_url, var.runbook_url), "")
    tip                   = var.workloads_count_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.workloads_count_threshold_warning}records"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.workloads_count_disabled_warning, var.workloads_count_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.workloads_count_notifications, "warning", []), var.notifications.warning), null)
    runbook_url           = try(coalesce(var.workloads_count_runbook_url, var.runbook_url), "")
    tip                   = var.workloads_count_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.workloads_count_max_delay
}

