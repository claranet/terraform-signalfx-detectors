resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('kubernetes.node_ready', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}', auto_resolve_after='${local.heartbeat_auto_resolve_after}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.heartbeat_runbook_url, var.runbook_url), "")
    tip                   = var.heartbeat_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject_novalue : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.heartbeat_max_delay
}

resource "signalfx_detector" "hpa_capacity" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes hpa scale exceeded capacity")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    max = data('kubernetes.hpa.spec.max_replicas', filter=${module.filtering.signalflow})${var.hpa_capacity_aggregation_function}${var.hpa_capacity_transformation_function}
    desired = data('kubernetes.hpa.status.desired_replicas', filter=${module.filtering.signalflow})${var.hpa_capacity_aggregation_function}${var.hpa_capacity_transformation_function}
    signal = (desired-max).publish('signal')
    detect(when(signal >= ${var.hpa_capacity_threshold_major}, lasting=%{if var.hpa_capacity_lasting_duration_major == null}None%{else}'${var.hpa_capacity_lasting_duration_major}'%{endif}, at_least=${var.hpa_capacity_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.hpa_capacity_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.hpa_capacity_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.hpa_capacity_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.hpa_capacity_runbook_url, var.runbook_url), "")
    tip                   = var.hpa_capacity_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.hpa_capacity_max_delay
}

resource "signalfx_detector" "node_ready" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes node status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    ready = data('kubernetes.node_ready', filter=${module.filtering.signalflow})${var.node_ready_aggregation_function}${var.node_ready_transformation_function}
    signal = (ready.fill(value=1)).publish('signal')
    detect(when(signal == ${var.node_ready_threshold_major}, lasting=%{if var.node_ready_lasting_duration_major == null}None%{else}'${var.node_ready_lasting_duration_major}'%{endif}, at_least=${var.node_ready_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal == ${var.node_ready_threshold_minor}, lasting=%{if var.node_ready_lasting_duration_minor == null}None%{else}'${var.node_ready_lasting_duration_minor}'%{endif}, at_least=${var.node_ready_at_least_percentage_minor})).publish('MINOR')
EOF

  rule {
    description           = "is not ready == ${var.node_ready_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.node_ready_disabled_major, var.node_ready_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.node_ready_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.node_ready_runbook_url, var.runbook_url), "")
    tip                   = var.node_ready_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is in unknown state == ${var.node_ready_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.node_ready_disabled_minor, var.node_ready_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.node_ready_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.node_ready_runbook_url, var.runbook_url), "")
    tip                   = var.node_ready_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.node_ready_max_delay
}

resource "signalfx_detector" "pod_phase_status" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes pod phase status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = (not filter('job', '*')) and (not filter('cronjob', '*'))
    signal = data('kubernetes.pod_phase', filter=base_filtering and ${module.filtering.signalflow})${var.pod_phase_status_aggregation_function}${var.pod_phase_status_transformation_function}.publish('signal')
    detect(when(signal < ${var.pod_phase_status_threshold_warning}, lasting=%{if var.pod_phase_status_lasting_duration_warning == null}None%{else}'${var.pod_phase_status_lasting_duration_warning}'%{endif}, at_least=${var.pod_phase_status_at_least_percentage_warning})).publish('WARN')
    detect(when(signal > ${var.pod_phase_status_threshold_minor}, lasting=%{if var.pod_phase_status_lasting_duration_minor == null}None%{else}'${var.pod_phase_status_lasting_duration_minor}'%{endif}, at_least=${var.pod_phase_status_at_least_percentage_minor})).publish('MINOR')
    detect(when(signal > ${var.pod_phase_status_threshold_major}, lasting=%{if var.pod_phase_status_lasting_duration_major == null}None%{else}'${var.pod_phase_status_lasting_duration_major}'%{endif}, at_least=${var.pod_phase_status_at_least_percentage_major}) and (not when(signal > ${var.pod_phase_status_threshold_minor}, lasting=%{if var.pod_phase_status_lasting_duration_minor == null}None%{else}'${var.pod_phase_status_lasting_duration_minor}'%{endif}, at_least=${var.pod_phase_status_at_least_percentage_minor}))).publish('MAJOR')
EOF

  rule {
    description           = "is pending for too long < ${var.pod_phase_status_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.pod_phase_status_disabled_warning, var.pod_phase_status_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.pod_phase_status_notifications, "warning", []), var.notifications.warning), null)
    runbook_url           = try(coalesce(var.pod_phase_status_runbook_url, var.runbook_url), "")
    tip                   = var.pod_phase_status_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is unknown > ${var.pod_phase_status_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.pod_phase_status_disabled_minor, var.pod_phase_status_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.pod_phase_status_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.pod_phase_status_runbook_url, var.runbook_url), "")
    tip                   = var.pod_phase_status_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is failed > ${var.pod_phase_status_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.pod_phase_status_disabled_major, var.pod_phase_status_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.pod_phase_status_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.pod_phase_status_runbook_url, var.runbook_url), "")
    tip                   = var.pod_phase_status_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.pod_phase_status_max_delay
}

resource "signalfx_detector" "terminated" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes pod terminated abnormally")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('container_status', 'terminated') and (not filter('container_status_reason', 'Completed'))
    signal = data('kubernetes.container_ready', filter=base_filtering and ${module.filtering.signalflow})${var.terminated_aggregation_function}${var.terminated_transformation_function}.publish('signal')
    detect(when(signal > ${var.terminated_threshold_major}, lasting=%{if var.terminated_lasting_duration_major == null}None%{else}'${var.terminated_lasting_duration_major}'%{endif}, at_least=${var.terminated_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.terminated_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.terminated_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.terminated_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.terminated_runbook_url, var.runbook_url), "")
    tip                   = var.terminated_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.terminated_max_delay
}

resource "signalfx_detector" "oom_killed" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes container killed by oom")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('container_status', 'terminated') and filter('container_status_reason', 'OOMKilled')
    killed = data('kubernetes.container_ready', filter=base_filtering and ${module.filtering.signalflow})${var.oom_killed_aggregation_function}${var.oom_killed_transformation_function}
    signal = (killed.count()).publish('signal')
    detect(when(signal > ${var.oom_killed_threshold_major}, lasting=%{if var.oom_killed_lasting_duration_major == null}None%{else}'${var.oom_killed_lasting_duration_major}'%{endif}, at_least=${var.oom_killed_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.oom_killed_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.oom_killed_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.oom_killed_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.oom_killed_runbook_url, var.runbook_url), "")
    tip                   = var.oom_killed_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.oom_killed_max_delay
}

resource "signalfx_detector" "deployment_crashloopbackoff" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes deployment in crashloopbackoff")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('container_status', 'waiting') and filter('deployment', '*') and filter('container_status_reason', 'CrashLoopBackOff')
    signal = data('kubernetes.container_restart_count', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.deployment_crashloopbackoff_aggregation_function}${var.deployment_crashloopbackoff_transformation_function}.publish('signal')
    detect(when(signal > ${var.deployment_crashloopbackoff_threshold_major}, lasting=%{if var.deployment_crashloopbackoff_lasting_duration_major == null}None%{else}'${var.deployment_crashloopbackoff_lasting_duration_major}'%{endif}, at_least=${var.deployment_crashloopbackoff_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.deployment_crashloopbackoff_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.deployment_crashloopbackoff_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.deployment_crashloopbackoff_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.deployment_crashloopbackoff_runbook_url, var.runbook_url), "")
    tip                   = var.deployment_crashloopbackoff_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.deployment_crashloopbackoff_max_delay
}

resource "signalfx_detector" "daemonset_crashloopbackoff" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes daemonset in crashloopbackoff")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('container_status', 'waiting') and filter('daemonSet', '*') and filter('container_status_reason', 'CrashLoopBackOff')
    signal = data('kubernetes.container_restart_count', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.daemonset_crashloopbackoff_aggregation_function}${var.daemonset_crashloopbackoff_transformation_function}.publish('signal')
    detect(when(signal > ${var.daemonset_crashloopbackoff_threshold_major}, lasting=%{if var.daemonset_crashloopbackoff_lasting_duration_major == null}None%{else}'${var.daemonset_crashloopbackoff_lasting_duration_major}'%{endif}, at_least=${var.daemonset_crashloopbackoff_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.daemonset_crashloopbackoff_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.daemonset_crashloopbackoff_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.daemonset_crashloopbackoff_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.daemonset_crashloopbackoff_runbook_url, var.runbook_url), "")
    tip                   = var.daemonset_crashloopbackoff_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.daemonset_crashloopbackoff_max_delay
}

resource "signalfx_detector" "job_failed" {
  name = format("%s %s", local.detector_name_prefix, "Kubernetes job from cronjob failed")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    completions = data('kubernetes.job.completions', filter=${module.filtering.signalflow}, extrapolation='zero')${var.job_failed_aggregation_function}${var.job_failed_transformation_function}
    active = data('kubernetes.job.active', filter=${module.filtering.signalflow}, extrapolation='zero')${var.job_failed_aggregation_function}${var.job_failed_transformation_function}
    succeeded = data('kubernetes.job.succeeded', filter=${module.filtering.signalflow}, rollup='max', extrapolation='zero')${var.job_failed_aggregation_function}${var.job_failed_transformation_function}
    signal = (completions-active-succeeded).publish('signal')
    detect(when(signal > ${var.job_failed_threshold_major}, lasting=%{if var.job_failed_lasting_duration_major == null}None%{else}'${var.job_failed_lasting_duration_major}'%{endif}, at_least=${var.job_failed_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.job_failed_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.job_failed_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.job_failed_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.job_failed_runbook_url, var.runbook_url), "")
    tip                   = var.job_failed_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.job_failed_max_delay
}

