# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Notification recipients list for every detectors"
  type        = list
}

variable "prefixes" {
  description = "Prefixes list to prepend between brackets on every monitors names before environment"
  type        = list
  default     = []
}

variable "filter_custom_includes" {
  description = "List of tags to include when custom filtering is used"
  type        = list
  default     = []
}

variable "filter_custom_excludes" {
  description = "List of tags to exclude when custom filtering is used"
  type        = list
  default     = []
}

variable "detectors_disabled" {
  description = "Disable all detectors in this module"
  type        = bool
  default     = false
}

# Kubernetes Node detectors specific

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_notifications" {
  description = "Notification recipients list for every alerting rules of heartbeat detector"
  type        = list
  default     = []
}

variable "heartbeat_timeframe" {
  description = "Timeframe for system not reporting detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

# node_ready detectors

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

variable "node_ready_disabled_warning" {
  description = "Disable warning alerting rule for node_ready detector"
  type        = bool
  default     = null
}

variable "node_ready_notifications" {
  description = "Notification recipients list for every alerting rules of node_ready detector"
  type        = list
  default     = []
}

variable "node_ready_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 3600
}

variable "node_ready_notifications_major" {
  description = "Notification recipients list for major alerting rule of node_ready detector"
  type        = list
  default     = []
}

variable "node_ready_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of node_ready detector"
  type        = list
  default     = []
}

variable "node_ready_aggregation_function" {
  description = "Aggregation function and group by for node_ready detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "node_ready_transformation_function" {
  description = "Transformation function for node_ready detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ""
}

# Pod_phase_status detectors

variable "pod_phase_status_disabled" {
  description = "Disable all alerting rules for pod_phase_status detector"
  type        = bool
  default     = null
}

variable "pod_phase_status_notifications" {
  description = "Notification recipients list for every alerting rules of pod_phase_status detector"
  type        = list
  default     = []
}

variable "pod_phase_status_aggregation_function" {
  description = "Aggregation function and group by for pod_phase_status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "pod_phase_status_transformation_function" {
  description = "Transformation function for pod_phase_status detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ""
}

variable "pod_phase_status_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 1800
}

# Terminated detectors

variable "terminated_disabled" {
  description = "Disable all alerting rules for terminated detector"
  type        = bool
  default     = null
}

variable "terminated_notifications" {
  description = "Notification recipients list for every alerting rules of terminated detector"
  type        = list
  default     = []
}

variable "terminated_aggregation_function" {
  description = "Aggregation function and group by for terminated detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_cluster', 'kubernetes_namespace', 'kubernetes_pod_name'])"
}

variable "terminated_transformation_function" {
  description = "Transformation function for terminated detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ""
}

variable "terminated_threshold_warning" {
  description = "Warning threshold for terminated detector"
  type        = number
  default     = 0
}

variable "terminated_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 600
}

# oom_killed detectors

variable "oom_killed_disabled" {
  description = "Disable all alerting rules for oom_killed detector"
  type        = bool
  default     = null
}

variable "oom_killed_notifications" {
  description = "Notification recipients list for every alerting rules of oom_killed detector"
  type        = list
  default     = []
}

variable "oom_killed_aggregation_function" {
  description = "Aggregation function and group by for oom_killed detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "oom_killed_transformation_function" {
  description = "Transformation function for oom_killed detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ""
}

variable "oom_killed_threshold_warning" {
  description = "Warning threshold for oom_killed detector"
  type        = number
  default     = 0
}

# deployment_crashloopbackoff detectors

variable "deployment_crashloopbackoff_disabled" {
  description = "Disable all alerting rules for deployment_crashloopbackoff detector"
  type        = bool
  default     = null
}

variable "deployment_crashloopbackoff_notifications" {
  description = "Notification recipients list for every alerting rules of deployment_crashloopbackoff detector"
  type        = list
  default     = []
}

variable "deployment_crashloopbackoff_aggregation_function" {
  description = "Aggregation function and group by for deployment_crashloopbackoff detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_cluster', 'kubernetes_namespace', 'deployment'])"
}

variable "deployment_crashloopbackoff_transformation_function" {
  description = "Transformation function for deployment_crashloopbackoff detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".sum(over='15m')"
}

variable "deployment_crashloopbackoff_threshold_warning" {
  description = "Warning threshold for deployment_crashloopbackoff detector"
  type        = number
  default     = 0
}

# daemonset_crashloopbackoff detectors

variable "daemonset_crashloopbackoff_disabled" {
  description = "Disable all alerting rules for daemonset_crashloopbackoff detector"
  type        = bool
  default     = null
}

variable "daemonset_crashloopbackoff_notifications" {
  description = "Notification recipients list for every alerting rules of daemonset_crashloopbackoff detector"
  type        = list
  default     = []
}

variable "daemonset_crashloopbackoff_aggregation_function" {
  description = "Aggregation function and group by for daemonset_crashloopbackoff detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_cluster', 'kubernetes_namespace', 'daemonSet'])"
}

variable "daemonset_crashloopbackoff_transformation_function" {
  description = "Transformation function for daemonset_crashloopbackoff detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".sum(over='15m')"
}

variable "daemonset_crashloopbackoff_threshold_warning" {
  description = "Warning threshold for daemonset_crashloopbackoff detector"
  type        = number
  default     = 0
}

# job_failed detectors

variable "job_failed_disabled" {
  description = "Disable all alerting rules for job_failed detector"
  type        = bool
  default     = null
}

variable "job_failed_notifications" {
  description = "Notification recipients list for every alerting rules of job_failed detector"
  type        = list
  default     = []
}

variable "job_failed_aggregation_function" {
  description = "Aggregation function and group by for job_failed detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "job_failed_transformation_function" {
  description = "Transformation function for job_failed detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ""
}

variable "job_failed_threshold_warning" {
  description = "Warning threshold for job_failed detector"
  type        = number
  default     = 0
}

variable "job_failed_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 60
}

# daemonset_scheduled detectors

variable "daemonset_scheduled_disabled" {
  description = "Disable all alerting rules for daemonset_scheduled detector"
  type        = bool
  default     = null
}

variable "daemonset_scheduled_notifications" {
  description = "Notification recipients list for every alerting rules of daemonset_scheduled detector"
  type        = list
  default     = []
}

variable "daemonset_scheduled_aggregation_function" {
  description = "Aggregation function and group by for daemonset_scheduled detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "daemonset_scheduled_transformation_function" {
  description = "Transformation function for daemonset_scheduled detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ""
}

variable "daemonset_scheduled_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

# daemonset_ready detectors

variable "daemonset_ready_disabled" {
  description = "Disable all alerting rules for daemonset_ready detector"
  type        = bool
  default     = null
}

variable "daemonset_ready_notifications" {
  description = "Notification recipients list for every alerting rules of daemonset_ready detector"
  type        = list
  default     = []
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
  description = "Transformation function for daemonset_ready detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ""
}

variable "daemonset_ready_threshold_critical" {
  description = "Critical threshold for daemonset_ready detector"
  type        = number
  default     = 100
}

# daemonset_misscheduled detectors

variable "daemonset_misscheduled_disabled" {
  description = "Disable all alerting rules for daemonset_misscheduled detector"
  type        = bool
  default     = null
}

variable "daemonset_misscheduled_notifications" {
  description = "Notification recipients list for every alerting rules of daemonset_misscheduled detector"
  type        = list
  default     = []
}

variable "daemonset_misscheduled_aggregation_function" {
  description = "Aggregation function and group by for daemonset_misscheduled detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "daemonset_misscheduled_transformation_function" {
  description = "Transformation function for daemonset_misscheduled detector (i.e. \".mean(over='5m')\"))"
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

# deployment_available detectors

variable "deployment_available_disabled" {
  description = "Disable all alerting rules for deployment_available detector"
  type        = bool
  default     = null
}

variable "deployment_available_notifications" {
  description = "Notification recipients list for every alerting rules of deployment_available detector"
  type        = list
  default     = []
}

variable "deployment_available_aggregation_function" {
  description = "Aggregation function and group by for deployment_available detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "deployment_available_transformation_function" {
  description = "Transformation function for deployment_available detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ""
}

variable "deployment_available_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

# replicaset_available detectors

variable "replicaset_available_disabled" {
  description = "Disable all alerting rules for replicaset_available detector"
  type        = bool
  default     = null
}

variable "replicaset_available_notifications" {
  description = "Notification recipients list for every alerting rules of replicaset_available detector"
  type        = list
  default     = []
}

variable "replicaset_available_aggregation_function" {
  description = "Aggregation function and group by for replicaset_available detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "replicaset_available_transformation_function" {
  description = "Transformation function for replicaset_available detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ""
}

variable "replicaset_available_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

# replication_controller_available detectors

variable "replication_controller_available_disabled" {
  description = "Disable all alerting rules for replication_controller_available detector"
  type        = bool
  default     = null
}

variable "replication_controller_available_notifications" {
  description = "Notification recipients list for every alerting rules of replication_controller_available detector"
  type        = list
  default     = []
}

variable "replication_controller_available_aggregation_function" {
  description = "Aggregation function and group by for replication_controller_available detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "replication_controller_available_transformation_function" {
  description = "Transformation function for replication_controller_available detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ""
}

variable "replication_controller_available_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

# satefulset_ready detectors

variable "satefulset_ready_disabled" {
  description = "Disable all alerting rules for satefulset_ready detector"
  type        = bool
  default     = null
}

variable "satefulset_ready_notifications" {
  description = "Notification recipients list for every alerting rules of satefulset_ready detector"
  type        = list
  default     = []
}

variable "satefulset_ready_aggregation_function" {
  description = "Aggregation function and group by for satefulset_ready detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "satefulset_ready_transformation_function" {
  description = "Transformation function for satefulset_ready detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ""
}

variable "satefulset_ready_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

