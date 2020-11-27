# Module specific

# Heartbeat detector

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['kubernetes_cluster'])"
}

# node_ready detector

variable "node_ready_disabled" {
  description = "Disable all alerting rules for node_ready detector"
  type        = bool
  default     = null
}

variable "node_ready_disabled_minor" {
  description = "Disable minor alerting rule for node_ready detector"
  type        = bool
  default     = null
}

variable "node_ready_disabled_major" {
  description = "Disable major alerting rule for node_ready detector"
  type        = bool
  default     = null
}

variable "node_ready_notifications" {
  description = "Notification recipients list per severity overridden for node_ready detector"
  type        = map(list(string))
  default     = {}
}

variable "node_ready_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 3600
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

# Pod_phase_status detector

variable "pod_phase_status_disabled" {
  description = "Disable all alerting rules for pod_phase_status detector"
  type        = bool
  default     = null
}

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

variable "pod_phase_status_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 1800
}

# Terminated detector

variable "terminated_disabled" {
  description = "Disable all alerting rules for terminated detector"
  type        = bool
  default     = null
}

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

variable "terminated_threshold_major" {
  description = "Major threshold for terminated detector"
  type        = number
  default     = 0
}

variable "terminated_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 600
}

# oom_killed detector

variable "oom_killed_disabled" {
  description = "Disable all alerting rules for oom_killed detector"
  type        = bool
  default     = null
}

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

variable "oom_killed_threshold_major" {
  description = "Major threshold for oom_killed detector"
  type        = number
  default     = 0
}

# deployment_crashloopbackoff detector

variable "deployment_crashloopbackoff_disabled" {
  description = "Disable all alerting rules for deployment_crashloopbackoff detector"
  type        = bool
  default     = null
}

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

variable "deployment_crashloopbackoff_threshold_major" {
  description = "Major threshold for deployment_crashloopbackoff detector"
  type        = number
  default     = 0
}

# daemonset_crashloopbackoff detector

variable "daemonset_crashloopbackoff_disabled" {
  description = "Disable all alerting rules for daemonset_crashloopbackoff detector"
  type        = bool
  default     = null
}

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

variable "daemonset_crashloopbackoff_threshold_major" {
  description = "Major threshold for daemonset_crashloopbackoff detector"
  type        = number
  default     = 0
}

# job_failed detector

variable "job_failed_disabled" {
  description = "Disable all alerting rules for job_failed detector"
  type        = bool
  default     = null
}

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

variable "job_failed_threshold_major" {
  description = "Major threshold for job_failed detector"
  type        = number
  default     = 0
}

variable "job_failed_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 60
}

# daemonset_scheduled detector

variable "daemonset_scheduled_disabled" {
  description = "Disable all alerting rules for daemonset_scheduled detector"
  type        = bool
  default     = null
}

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

variable "daemonset_scheduled_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

# daemonset_ready detector

variable "daemonset_ready_disabled" {
  description = "Disable all alerting rules for daemonset_ready detector"
  type        = bool
  default     = null
}

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

variable "daemonset_ready_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "daemonset_ready_transformation_function" {
  description = "Transformation function for daemonset_ready detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "daemonset_ready_threshold_critical" {
  description = "Critical threshold for daemonset_ready detector"
  type        = number
  default     = 100
}

# daemonset_misscheduled detector

variable "daemonset_misscheduled_disabled" {
  description = "Disable all alerting rules for daemonset_misscheduled detector"
  type        = bool
  default     = null
}

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

variable "daemonset_misscheduled_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "daemonset_misscheduled_threshold_critical" {
  description = "Critical threshold for daemonset_misscheduled detector"
  type        = number
  default     = 0
}

# deployment_available detector

variable "deployment_available_disabled" {
  description = "Disable all alerting rules for deployment_available detector"
  type        = bool
  default     = null
}

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

variable "deployment_available_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

# replicaset_available detector

variable "replicaset_available_disabled" {
  description = "Disable all alerting rules for replicaset_available detector"
  type        = bool
  default     = null
}

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

variable "replicaset_available_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

# replication_controller_available detector

variable "replication_controller_available_disabled" {
  description = "Disable all alerting rules for replication_controller_available detector"
  type        = bool
  default     = null
}

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

variable "replication_controller_available_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

# satefulset_ready detector

variable "satefulset_ready_disabled" {
  description = "Disable all alerting rules for satefulset_ready detector"
  type        = bool
  default     = null
}

variable "satefulset_ready_notifications" {
  description = "Notification recipients list per severity overridden for satefulset_ready detector"
  type        = map(list(string))
  default     = {}
}

variable "satefulset_ready_aggregation_function" {
  description = "Aggregation function and group by for satefulset_ready detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "satefulset_ready_transformation_function" {
  description = "Transformation function for satefulset_ready detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "satefulset_ready_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

