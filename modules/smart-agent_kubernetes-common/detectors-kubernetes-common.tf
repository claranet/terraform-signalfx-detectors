resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes node heartbeat")

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('kubernetes.node_ready', filter=${local.not_running_vm_filters} and ${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "node_ready" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes node status")

  program_text = <<-EOF
    signal = data('kubernetes.node_ready', filter=${module.filter-tags.filter_custom})${var.node_ready_aggregation_function}${var.node_ready_transformation_function}.fill(1).publish('signal')
    detect(when(signal == 0, lasting='${var.node_ready_lasting_duration_seconds}s')).publish('MAJOR')
    detect(when(signal == -1, lasting='${var.node_ready_lasting_duration_seconds / 2}s')).publish('MINOR')
EOF

  rule {
    description           = "is not ready"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.node_ready_disabled_major, var.node_ready_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.node_ready_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "in an unknown state"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.node_ready_disabled_minor, var.node_ready_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.node_ready_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "pod_phase_status" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes pod status phase")

  program_text = <<-EOF
    signal = data('kubernetes.pod_phase', filter=(not filter('job', '*')) and (not filter('cronjob', '*')) and ${module.filter-tags.filter_custom})${var.pod_phase_status_aggregation_function}${var.pod_phase_status_transformation_function}.fill(2).publish('signal')
    detect(when(signal < threshold(2), lasting='${var.pod_phase_status_lasting_duration_seconds}s') or when(signal > threshold(3), lasting='${var.pod_phase_status_lasting_duration_seconds}s')).publish('MAJOR')
EOF

  rule {
    description           = "is in a non-ready state for too long"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.pod_phase_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.pod_phase_status_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "terminated" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes pod terminated abnormally")

  program_text = <<-EOF
    signal = data('kubernetes.container_ready', filter=filter('container_status', 'terminated') and (not filter('container_status_reason', 'Completed')) and ${module.filter-tags.filter_custom})${var.terminated_aggregation_function}${var.terminated_transformation_function}.publish('signal')
    detect(when(signal > ${var.terminated_threshold_major}, lasting='${var.terminated_lasting_duration_seconds}s')).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.terminated_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.terminated_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.terminated_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "oom_killed" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes container killed by OOM")

  program_text = <<-EOF
    signal = data('kubernetes.container_ready', filter=filter('container_status', 'terminated') and filter('container_status_reason', 'OOMKilled') and ${module.filter-tags.filter_custom})${var.oom_killed_aggregation_function}${var.oom_killed_transformation_function}.count().publish('signal')
    detect(when(signal > ${var.oom_killed_threshold_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.oom_killed_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.oom_killed_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.oom_killed_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "deployment_crashloopbackoff" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes deployment in CrashLoopBackOff")

  program_text = <<-EOF
    signal = data('kubernetes.container_restart_count', filter=filter('container_status', 'waiting') and filter('deployment', '*') and filter('container_status_reason', 'CrashLoopBackOff') and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.deployment_crashloopbackoff_aggregation_function}${var.deployment_crashloopbackoff_transformation_function}.publish('signal')
    detect(when(signal > ${var.deployment_crashloopbackoff_threshold_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.deployment_crashloopbackoff_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.deployment_crashloopbackoff_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.deployment_crashloopbackoff_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "daemonset_crashloopbackoff" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes daemonset in CrashLoopBackOff")

  program_text = <<-EOF
    signal = data('kubernetes.container_restart_count', filter=filter('container_status', 'waiting') and filter('daemonSet', '*') and filter('container_status_reason', 'CrashLoopBackOff') and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.daemonset_crashloopbackoff_aggregation_function}${var.daemonset_crashloopbackoff_transformation_function}.publish('signal')
    detect(when(signal > ${var.daemonset_crashloopbackoff_threshold_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.daemonset_crashloopbackoff_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.daemonset_crashloopbackoff_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.daemonset_crashloopbackoff_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "job_failed" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes job from cronjob failed")

  program_text = <<-EOF
    A = data('kubernetes.job.completions', extrapolation='zero', filter=${module.filter-tags.filter_custom})${var.job_failed_aggregation_function}${var.job_failed_transformation_function}
    B = data('kubernetes.job.active', extrapolation='zero', filter=${module.filter-tags.filter_custom})${var.job_failed_aggregation_function}${var.job_failed_transformation_function}
    C = data('kubernetes.job.succeeded', extrapolation='zero', filter=${module.filter-tags.filter_custom}, rollup='max')${var.job_failed_aggregation_function}${var.job_failed_transformation_function}
    signal = (A-B-C).publish('signal')
    detect(when(signal > ${var.job_failed_threshold_major}, lasting='${var.job_failed_lasting_duration_seconds}s')).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.job_failed_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.job_failed_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.job_failed_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "daemonset_scheduled" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes daemonsets not scheduled")

  program_text = <<-EOF
    A = data('kubernetes.daemon_set.desired_scheduled', filter=${module.filter-tags.filter_custom})${var.daemonset_scheduled_aggregation_function}${var.daemonset_scheduled_transformation_function}
    B = data('kubernetes.daemon_set.current_scheduled', filter=${module.filter-tags.filter_custom})${var.daemonset_scheduled_aggregation_function}${var.daemonset_scheduled_transformation_function}
    signal = (A-B).publish('signal')
    detect(when(signal != 0, lasting='${var.daemonset_scheduled_lasting_duration_seconds}s')).publish('CRIT')
EOF

  rule {
    description           = "do not match daemonsets desired"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.daemonset_scheduled_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.daemonset_scheduled_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "daemonset_ready" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes daemonsets not ready")

  program_text = <<-EOF
    A = data('kubernetes.daemon_set.ready', filter=${module.filter-tags.filter_custom})${var.daemonset_ready_aggregation_function}${var.daemonset_ready_transformation_function}
    B = data('kubernetes.daemon_set.desired_scheduled', filter=${module.filter-tags.filter_custom})${var.daemonset_ready_aggregation_function}${var.daemonset_ready_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal < ${var.daemonset_ready_threshold_critical}, lasting='${var.daemonset_ready_lasting_duration_seconds}s')).publish('CRIT')
EOF

  rule {
    description           = "are too low < ${var.daemonset_ready_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.daemonset_ready_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.daemonset_ready_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "daemonset_misscheduled" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes daemonsets misscheduled")

  program_text = <<-EOF
    signal = data('kubernetes.daemon_set.misscheduled', filter=${module.filter-tags.filter_custom})${var.daemonset_misscheduled_aggregation_function}${var.daemonset_misscheduled_transformation_function}.publish('signal')
    detect(when(signal > ${var.daemonset_misscheduled_threshold_critical}, lasting='${var.daemonset_misscheduled_lasting_duration_seconds}s')).publish('CRIT')
EOF

  rule {
    description           = "are too high > ${var.daemonset_misscheduled_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.daemonset_misscheduled_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.daemonset_misscheduled_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "deployment_available" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes deployments available")

  program_text = <<-EOF
    A = data('kubernetes.deployment.desired', filter=${module.filter-tags.filter_custom})${var.deployment_available_aggregation_function}${var.deployment_available_transformation_function}
    B = data('kubernetes.deployment.available', filter=${module.filter-tags.filter_custom})${var.deployment_available_aggregation_function}${var.deployment_available_transformation_function}
    signal = (A-B).publish('signal')
    detect(when(signal != 0, lasting='${var.deployment_available_lasting_duration_seconds}s')).publish('CRIT')
EOF

  rule {
    description           = "do not match deployments desired"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.deployment_available_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.deployment_available_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "replicaset_available" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes replicasets available")

  program_text = <<-EOF
    A = data('kubernetes.replica_set.desired', filter=${module.filter-tags.filter_custom})${var.replicaset_available_aggregation_function}${var.replicaset_available_transformation_function}
    B = data('kubernetes.replica_set.available', filter=${module.filter-tags.filter_custom})${var.replicaset_available_aggregation_function}${var.replicaset_available_transformation_function}
    signal = (A-B).publish('signal')
    detect(when(signal != 0, lasting='${var.replicaset_available_lasting_duration_seconds}s')).publish('CRIT')
EOF

  rule {
    description           = "do not match replicasets desired"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.replicaset_available_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.replicaset_available_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "replication_controller_available" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes replication_controllers available")

  program_text = <<-EOF
    A = data('kubernetes.replication_controller.desired', filter=${module.filter-tags.filter_custom})${var.replication_controller_available_aggregation_function}${var.replication_controller_available_transformation_function}
    B = data('kubernetes.replication_controller.available', filter=${module.filter-tags.filter_custom})${var.replication_controller_available_aggregation_function}${var.replication_controller_available_transformation_function}
    signal = (A-B).publish('signal')
    detect(when(signal != 0, lasting='${var.replication_controller_available_lasting_duration_seconds}s')).publish('CRIT')
EOF

  rule {
    description           = "do not match replication_controllers desired"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.replication_controller_available_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.replication_controller_available_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "satefulset_ready" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes satefulsets ready")

  program_text = <<-EOF
    A = data('kubernetes.stateful_set.desired', filter=${module.filter-tags.filter_custom})${var.satefulset_ready_aggregation_function}${var.satefulset_ready_transformation_function}
    B = data('kubernetes.stateful_set.ready', filter=${module.filter-tags.filter_custom})${var.satefulset_ready_aggregation_function}${var.satefulset_ready_transformation_function}
    signal = (A-B).publish('signal')
    detect(when(signal != 0, lasting='${var.satefulset_ready_lasting_duration_seconds}s')).publish('CRIT')
EOF

  rule {
    description           = "do not match satefulsets desired"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.satefulset_ready_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.satefulset_ready_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

