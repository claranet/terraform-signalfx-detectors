# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['kubernetes_cluster'])"
}

variable "heartbeat_max_delay" {
  description = "Enforce max delay for heartbeat detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "heartbeat_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "heartbeat_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_exclude_not_running_vm" {
  description = "Don’t send alerts if associated VM is stopped or stopping (metadata provided by cloud provider integration). Can be useful for ephemeral infrastructure (such as auto scaling groups) as VM will be stopped and started regularly. Note that timeframe must be at least 25 minutes for the metadata to be available to the detector."
  type        = bool
  default     = true
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"25m\"). Must be at least \"25m\" if \"heartbeat_exclude_not_running_vm\" is true"
  type        = string
  default     = "25m"
}

# hpa_capacity detector

variable "hpa_capacity_notifications" {
  description = "Notification recipients list per severity overridden for hpa_capacity detector"
  type        = map(list(string))
  default     = {}
}

variable "hpa_capacity_aggregation_function" {
  description = "Aggregation function and group by for hpa_capacity detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "hpa_capacity_transformation_function" {
  description = "Transformation function for hpa_capacity detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "hpa_capacity_max_delay" {
  description = "Enforce max delay for hpa_capacity detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "hpa_capacity_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    hpa ask to scale for too long, the maximum number of desired Pods has been hit or there is a lack of resources
EOF
}

variable "hpa_capacity_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "hpa_capacity_disabled" {
  description = "Disable all alerting rules for hpa_capacity detector"
  type        = bool
  default     = null
}

variable "hpa_capacity_threshold_major" {
  description = "Major threshold for hpa_capacity detector"
  type        = number
  default     = 0
}

variable "hpa_capacity_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "hpa_capacity_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# node_ready detector

variable "node_ready_notifications" {
  description = "Notification recipients list per severity overridden for node_ready detector"
  type        = map(list(string))
  default     = {}
}

variable "node_ready_aggregation_function" {
  description = "Aggregation function and group by for node_ready detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "node_ready_transformation_function" {
  description = "Transformation function for node_ready detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "node_ready_max_delay" {
  description = "Enforce max delay for node_ready detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "node_ready_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "node_ready_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "node_ready_disabled" {
  description = "Disable all alerting rules for node_ready detector"
  type        = bool
  default     = null
}

variable "node_ready_disabled_major" {
  description = "Disable major alerting rule for node_ready detector"
  type        = bool
  default     = null
}

variable "node_ready_disabled_minor" {
  description = "Disable minor alerting rule for node_ready detector"
  type        = bool
  default     = null
}

variable "node_ready_threshold_major" {
  description = "Major threshold for node_ready detector"
  type        = number
  default     = 0
}

variable "node_ready_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1h"
}

variable "node_ready_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "node_ready_threshold_minor" {
  description = "Minor threshold for node_ready detector"
  type        = number
  default     = -1
}

variable "node_ready_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "20m"
}

variable "node_ready_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# pod_phase_status detector

variable "pod_phase_status_notifications" {
  description = "Notification recipients list per severity overridden for pod_phase_status detector"
  type        = map(list(string))
  default     = {}
}

variable "pod_phase_status_aggregation_function" {
  description = "Aggregation function and group by for pod_phase_status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "pod_phase_status_transformation_function" {
  description = "Transformation function for pod_phase_status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "pod_phase_status_max_delay" {
  description = "Enforce max delay for pod_phase_status detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "pod_phase_status_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "pod_phase_status_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "pod_phase_status_disabled" {
  description = "Disable all alerting rules for pod_phase_status detector"
  type        = bool
  default     = null
}

variable "pod_phase_status_disabled_warning" {
  description = "Disable warning alerting rule for pod_phase_status detector"
  type        = bool
  default     = null
}

variable "pod_phase_status_disabled_minor" {
  description = "Disable minor alerting rule for pod_phase_status detector"
  type        = bool
  default     = null
}

variable "pod_phase_status_disabled_major" {
  description = "Disable major alerting rule for pod_phase_status detector"
  type        = bool
  default     = null
}

variable "pod_phase_status_threshold_warning" {
  description = "Warning threshold for pod_phase_status detector"
  type        = number
  default     = 2
}

variable "pod_phase_status_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "30m"
}

variable "pod_phase_status_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "pod_phase_status_threshold_minor" {
  description = "Minor threshold for pod_phase_status detector"
  type        = number
  default     = 4
}

variable "pod_phase_status_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "pod_phase_status_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "pod_phase_status_threshold_major" {
  description = "Major threshold for pod_phase_status detector"
  type        = number
  default     = 3
}

variable "pod_phase_status_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "pod_phase_status_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# terminated detector

variable "terminated_notifications" {
  description = "Notification recipients list per severity overridden for terminated detector"
  type        = map(list(string))
  default     = {}
}

variable "terminated_aggregation_function" {
  description = "Aggregation function and group by for terminated detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_cluster', 'kubernetes_namespace', 'kubernetes_pod_name'])"
}

variable "terminated_transformation_function" {
  description = "Transformation function for terminated detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "terminated_max_delay" {
  description = "Enforce max delay for terminated detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "terminated_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "terminated_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "terminated_disabled" {
  description = "Disable all alerting rules for terminated detector"
  type        = bool
  default     = null
}

variable "terminated_threshold_major" {
  description = "Major threshold for terminated detector"
  type        = number
  default     = 0
}

variable "terminated_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "terminated_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# oom_killed detector

variable "oom_killed_notifications" {
  description = "Notification recipients list per severity overridden for oom_killed detector"
  type        = map(list(string))
  default     = {}
}

variable "oom_killed_aggregation_function" {
  description = "Aggregation function and group by for oom_killed detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "oom_killed_transformation_function" {
  description = "Transformation function for oom_killed detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "oom_killed_max_delay" {
  description = "Enforce max delay for oom_killed detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "oom_killed_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "oom_killed_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "oom_killed_disabled" {
  description = "Disable all alerting rules for oom_killed detector"
  type        = bool
  default     = null
}

variable "oom_killed_threshold_major" {
  description = "Major threshold for oom_killed detector"
  type        = number
  default     = 0
}

variable "oom_killed_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1m"
}

variable "oom_killed_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# deployment_crashloopbackoff detector

variable "deployment_crashloopbackoff_notifications" {
  description = "Notification recipients list per severity overridden for deployment_crashloopbackoff detector"
  type        = map(list(string))
  default     = {}
}

variable "deployment_crashloopbackoff_aggregation_function" {
  description = "Aggregation function and group by for deployment_crashloopbackoff detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_cluster', 'kubernetes_namespace', 'deployment'])"
}

variable "deployment_crashloopbackoff_transformation_function" {
  description = "Transformation function for deployment_crashloopbackoff detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".sum(over='15m')"
}

variable "deployment_crashloopbackoff_max_delay" {
  description = "Enforce max delay for deployment_crashloopbackoff detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "deployment_crashloopbackoff_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "deployment_crashloopbackoff_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "deployment_crashloopbackoff_disabled" {
  description = "Disable all alerting rules for deployment_crashloopbackoff detector"
  type        = bool
  default     = null
}

variable "deployment_crashloopbackoff_threshold_major" {
  description = "Major threshold for deployment_crashloopbackoff detector"
  type        = number
  default     = 0
}

variable "deployment_crashloopbackoff_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "deployment_crashloopbackoff_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# daemonset_crashloopbackoff detector

variable "daemonset_crashloopbackoff_notifications" {
  description = "Notification recipients list per severity overridden for daemonset_crashloopbackoff detector"
  type        = map(list(string))
  default     = {}
}

variable "daemonset_crashloopbackoff_aggregation_function" {
  description = "Aggregation function and group by for daemonset_crashloopbackoff detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_cluster', 'kubernetes_namespace', 'daemonSet'])"
}

variable "daemonset_crashloopbackoff_transformation_function" {
  description = "Transformation function for daemonset_crashloopbackoff detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".sum(over='15m')"
}

variable "daemonset_crashloopbackoff_max_delay" {
  description = "Enforce max delay for daemonset_crashloopbackoff detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "daemonset_crashloopbackoff_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "daemonset_crashloopbackoff_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "daemonset_crashloopbackoff_disabled" {
  description = "Disable all alerting rules for daemonset_crashloopbackoff detector"
  type        = bool
  default     = null
}

variable "daemonset_crashloopbackoff_threshold_major" {
  description = "Major threshold for daemonset_crashloopbackoff detector"
  type        = number
  default     = 0
}

variable "daemonset_crashloopbackoff_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "daemonset_crashloopbackoff_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# job_failed detector

variable "job_failed_notifications" {
  description = "Notification recipients list per severity overridden for job_failed detector"
  type        = map(list(string))
  default     = {}
}

variable "job_failed_aggregation_function" {
  description = "Aggregation function and group by for job_failed detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "job_failed_transformation_function" {
  description = "Transformation function for job_failed detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "job_failed_max_delay" {
  description = "Enforce max delay for job_failed detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "job_failed_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "job_failed_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "job_failed_disabled" {
  description = "Disable all alerting rules for job_failed detector"
  type        = bool
  default     = null
}

variable "job_failed_threshold_major" {
  description = "Major threshold for job_failed detector"
  type        = number
  default     = 0
}

variable "job_failed_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1m"
}

variable "job_failed_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# daemonset_scheduled detector

variable "daemonset_scheduled_notifications" {
  description = "Notification recipients list per severity overridden for daemonset_scheduled detector"
  type        = map(list(string))
  default     = {}
}

variable "daemonset_scheduled_aggregation_function" {
  description = "Aggregation function and group by for daemonset_scheduled detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "daemonset_scheduled_transformation_function" {
  description = "Transformation function for daemonset_scheduled detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "daemonset_scheduled_max_delay" {
  description = "Enforce max delay for daemonset_scheduled detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "daemonset_scheduled_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "daemonset_scheduled_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "daemonset_scheduled_disabled" {
  description = "Disable all alerting rules for daemonset_scheduled detector"
  type        = bool
  default     = null
}

variable "daemonset_scheduled_threshold_critical" {
  description = "Critical threshold for daemonset_scheduled detector"
  type        = number
  default     = 0
}

variable "daemonset_scheduled_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "daemonset_scheduled_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# daemonset_ready detector

variable "daemonset_ready_notifications" {
  description = "Notification recipients list per severity overridden for daemonset_ready detector"
  type        = map(list(string))
  default     = {}
}

variable "daemonset_ready_aggregation_function" {
  description = "Aggregation function and group by for daemonset_ready detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "daemonset_ready_transformation_function" {
  description = "Transformation function for daemonset_ready detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "daemonset_ready_max_delay" {
  description = "Enforce max delay for daemonset_ready detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "daemonset_ready_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "daemonset_ready_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "daemonset_ready_disabled" {
  description = "Disable all alerting rules for daemonset_ready detector"
  type        = bool
  default     = null
}

variable "daemonset_ready_threshold_critical" {
  description = "Critical threshold for daemonset_ready detector"
  type        = number
  default     = 100
}

variable "daemonset_ready_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "daemonset_ready_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# daemonset_misscheduled detector

variable "daemonset_misscheduled_notifications" {
  description = "Notification recipients list per severity overridden for daemonset_misscheduled detector"
  type        = map(list(string))
  default     = {}
}

variable "daemonset_misscheduled_aggregation_function" {
  description = "Aggregation function and group by for daemonset_misscheduled detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "daemonset_misscheduled_transformation_function" {
  description = "Transformation function for daemonset_misscheduled detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "daemonset_misscheduled_max_delay" {
  description = "Enforce max delay for daemonset_misscheduled detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "daemonset_misscheduled_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "daemonset_misscheduled_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "daemonset_misscheduled_disabled" {
  description = "Disable all alerting rules for daemonset_misscheduled detector"
  type        = bool
  default     = null
}

variable "daemonset_misscheduled_threshold_critical" {
  description = "Critical threshold for daemonset_misscheduled detector"
  type        = number
  default     = 0
}

variable "daemonset_misscheduled_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "daemonset_misscheduled_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# deployment_available detector

variable "deployment_available_notifications" {
  description = "Notification recipients list per severity overridden for deployment_available detector"
  type        = map(list(string))
  default     = {}
}

variable "deployment_available_aggregation_function" {
  description = "Aggregation function and group by for deployment_available detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "deployment_available_transformation_function" {
  description = "Transformation function for deployment_available detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "deployment_available_max_delay" {
  description = "Enforce max delay for deployment_available detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "deployment_available_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "deployment_available_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "deployment_available_disabled" {
  description = "Disable all alerting rules for deployment_available detector"
  type        = bool
  default     = null
}

variable "deployment_available_threshold_critical" {
  description = "Critical threshold for deployment_available detector"
  type        = number
  default     = 0
}

variable "deployment_available_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "deployment_available_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# replicaset_available detector

variable "replicaset_available_notifications" {
  description = "Notification recipients list per severity overridden for replicaset_available detector"
  type        = map(list(string))
  default     = {}
}

variable "replicaset_available_aggregation_function" {
  description = "Aggregation function and group by for replicaset_available detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "replicaset_available_transformation_function" {
  description = "Transformation function for replicaset_available detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "replicaset_available_max_delay" {
  description = "Enforce max delay for replicaset_available detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "replicaset_available_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "replicaset_available_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "replicaset_available_disabled" {
  description = "Disable all alerting rules for replicaset_available detector"
  type        = bool
  default     = null
}

variable "replicaset_available_threshold_critical" {
  description = "Critical threshold for replicaset_available detector"
  type        = number
  default     = 0
}

variable "replicaset_available_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "replicaset_available_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# replication_controller_available detector

variable "replication_controller_available_notifications" {
  description = "Notification recipients list per severity overridden for replication_controller_available detector"
  type        = map(list(string))
  default     = {}
}

variable "replication_controller_available_aggregation_function" {
  description = "Aggregation function and group by for replication_controller_available detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "replication_controller_available_transformation_function" {
  description = "Transformation function for replication_controller_available detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "replication_controller_available_max_delay" {
  description = "Enforce max delay for replication_controller_available detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "replication_controller_available_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "replication_controller_available_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "replication_controller_available_disabled" {
  description = "Disable all alerting rules for replication_controller_available detector"
  type        = bool
  default     = null
}

variable "replication_controller_available_threshold_critical" {
  description = "Critical threshold for replication_controller_available detector"
  type        = number
  default     = 0
}

variable "replication_controller_available_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "replication_controller_available_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# statefulset_ready detector

variable "statefulset_ready_notifications" {
  description = "Notification recipients list per severity overridden for statefulset_ready detector"
  type        = map(list(string))
  default     = {}
}

variable "statefulset_ready_aggregation_function" {
  description = "Aggregation function and group by for statefulset_ready detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "statefulset_ready_transformation_function" {
  description = "Transformation function for statefulset_ready detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "statefulset_ready_max_delay" {
  description = "Enforce max delay for statefulset_ready detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "statefulset_ready_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "statefulset_ready_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "statefulset_ready_disabled" {
  description = "Disable all alerting rules for statefulset_ready detector"
  type        = bool
  default     = null
}

variable "statefulset_ready_threshold_critical" {
  description = "Critical threshold for statefulset_ready detector"
  type        = number
  default     = 0
}

variable "statefulset_ready_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "statefulset_ready_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
