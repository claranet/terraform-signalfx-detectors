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

# Kubernetes POD detectors specific

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

# Pod_phase_status detectors

variable "pod_phase_status_disabled" {
  description = "Disable all alerting rules for pod_phase_status detector"
  type        = bool
  default     = null
}

variable "pod_phase_status_disabled_critical" {
  description = "Disable critical alerting rule for pod_phase_status detector"
  type        = bool
  default     = null
}

variable "pod_phase_status_disabled_warning" {
  description = "Disable warning alerting rule for pod_phase_status detector"
  type        = bool
  default     = null
}

variable "pod_phase_status_notifications" {
  description = "Notification recipients list for every alerting rules of pod_phase_status detector"
  type        = list
  default     = []
}

variable "pod_phase_status_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of pod_phase_status detector"
  type        = list
  default     = []
}

variable "pod_phase_status_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of pod_phase_status detector"
  type        = list
  default     = []
}

variable "pod_phase_status_aggregation_function" {
  description = "Aggregation function and group by for pod_phase_status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_namespace', 'kubernetes_pod_name'])"
}

variable "pod_phase_status_transformation_function" {
  description = "Transformation function for pod_phase_status detector (mean, min, max)"
  type        = string
  default     = "max"
}

variable "pod_phase_status_transformation_window" {
  description = "Transformation window for pod_phase_status detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "pod_phase_status_aperiodic_duration" {
  description = "Duration for the pod_phase_status block"
  type        = string
  default     = "10m"
}

variable "pod_phase_status_aperiodic_percentage" {
  description = "Percentage for the pod_phase_status block"
  type        = number
  default     = 0.9
}

variable "pod_phase_status_clear_duration" {
  description = "Duration for the pod_phase_status clear condition"
  type        = string
  default     = "15m"
}

# Error detectors

variable "error_disabled" {
  description = "Disable all alerting rules for error detector"
  type        = bool
  default     = null
}

variable "error_disabled_critical" {
  description = "Disable critical alerting rule for error detector"
  type        = bool
  default     = null
}

variable "error_disabled_warning" {
  description = "Disable warning alerting rule for error detector"
  type        = bool
  default     = null
}

variable "error_notifications" {
  description = "Notification recipients list for every alerting rules of error detector"
  type        = list
  default     = []
}

variable "error_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of error detector"
  type        = list
  default     = []
}

variable "error_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of error detector"
  type        = list
  default     = []
}

variable "error_aggregation_function" {
  description = "Aggregation function and group by for error detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_namespace', 'kubernetes_pod_name', 'container_status_reason'])"
}

variable "error_transformation_function" {
  description = "Transformation function for error detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "error_transformation_window" {
  description = "Transformation window for error detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "error_threshold_critical" {
  description = "Critical threshold for error detector"
  type        = number
  default     = 0.5
}

variable "error_threshold_warning" {
  description = "Warning threshold for error detector"
  type        = number
  default     = 0
}

# Terminated detectors

variable "terminated_disabled" {
  description = "Disable all alerting rules for terminated detector"
  type        = bool
  default     = null
}

variable "terminated_disabled_critical" {
  description = "Disable critical alerting rule for terminated detector"
  type        = bool
  default     = null
}

variable "terminated_disabled_warning" {
  description = "Disable warning alerting rule for terminated detector"
  type        = bool
  default     = null
}

variable "terminated_notifications" {
  description = "Notification recipients list for every alerting rules of terminated detector"
  type        = list
  default     = []
}

variable "terminated_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of terminated detector"
  type        = list
  default     = []
}

variable "terminated_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of terminated detector"
  type        = list
  default     = []
}

variable "terminated_aggregation_function" {
  description = "Aggregation function and group by for terminated detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_namespace', 'kubernetes_pod_name', 'container_status_reason'])"
}

variable "terminated_transformation_function" {
  description = "Transformation function for terminated detector (mean, min, max)"
  type        = string
  default     = "sum"
}

variable "terminated_transformation_window" {
  description = "Transformation window for terminated detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "10m"
}

variable "terminated_threshold_critical" {
  description = "Critical threshold for terminated detector"
  type        = number
  default     = 0.5
}

variable "terminated_threshold_warning" {
  description = "Warning threshold for terminated detector"
  type        = number
  default     = 0
}
