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

# Kubernetes workload detectors specific

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

# Replica_available detectors

variable "replica_available_disabled" {
  description = "Disable all alerting rules for replica_available detector"
  type        = bool
  default     = null
}

variable "replica_available_disabled_critical" {
  description = "Disable critical alerting rule for replica_available detector"
  type        = bool
  default     = null
}

variable "replica_available_disabled_warning" {
  description = "Disable warning alerting rule for replica_available detector"
  type        = bool
  default     = null
}

variable "replica_available_notifications" {
  description = "Notification recipients list for every alerting rules of replica_available detector"
  type        = list
  default     = []
}

variable "replica_available_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of replica_available detector"
  type        = list
  default     = []
}

variable "replica_available_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of replica_available detector"
  type        = list
  default     = []
}

variable "replica_available_aggregation_function" {
  description = "Aggregation function and group by for replica_available detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['kubernetes_namespace'])"
}

variable "replica_available_transformation_function" {
  description = "Transformation function for replica_available detector (mean, min, max)"
  type        = string
  default     = "max"
}

variable "replica_available_transformation_window" {
  description = "Transformation window for replica_available detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "replica_available_threshold_critical" {
  description = "Critical threshold for replica_available detector"
  type        = number
  default     = 0
}

variable "replica_available_threshold_warning" {
  description = "Warning threshold for replica_available detector"
  type        = number
  default     = 0
}

variable "replica_available_threshold_number_requests" {
  description = "Number threshold for replica_available detector"
  type        = number
  default     = 1
}

# Replica_ready detectors

variable "replica_ready_disabled" {
  description = "Disable all alerting rules for replica_ready detector"
  type        = bool
  default     = null
}

variable "replica_ready_disabled_critical" {
  description = "Disable critical alerting rule for replica_ready detector"
  type        = bool
  default     = null
}

variable "replica_ready_disabled_warning" {
  description = "Disable warning alerting rule for replica_ready detector"
  type        = bool
  default     = null
}

variable "replica_ready_notifications" {
  description = "Notification recipients list for every alerting rules of replica_ready detector"
  type        = list
  default     = []
}

variable "replica_ready_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of replica_ready detector"
  type        = list
  default     = []
}

variable "replica_ready_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of replica_ready detector"
  type        = list
  default     = []
}

variable "replica_ready_aggregation_function" {
  description = "Aggregation function and group by for replica_ready detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['kubernetes_namespace'])"
}

variable "replica_ready_transformation_function" {
  description = "Transformation function for replica_ready detector (mean, min, max)"
  type        = string
  default     = "max"
}

variable "replica_ready_transformation_window" {
  description = "Transformation window for replica_ready detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "replica_ready_threshold_critical" {
  description = "Critical threshold for replica_ready detector"
  type        = number
  default     = 0
}

variable "replica_ready_threshold_warning" {
  description = "Warning threshold for replica_ready detector"
  type        = number
  default     = 0
}

variable "replica_ready_threshold_number_requests" {
  description = "Number threshold for replica_ready detector"
  type        = number
  default     = 1
}
