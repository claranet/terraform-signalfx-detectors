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

# AWS RDS detectors specific

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

# CPU_90_15min detectors

variable "cpu_90_15min_disabled" {
  description = "Disable all alerting rules for cpu_90_15min detector"
  type        = bool
  default     = null
}

variable "cpu_90_15min_disabled_critical" {
  description = "Disable critical alerting rule for cpu_90_15min detector"
  type        = bool
  default     = null
}

variable "cpu_90_15min_disabled_warning" {
  description = "Disable warning alerting rule for cpu_90_15min detector"
  type        = bool
  default     = null
}

variable "cpu_90_15min_notifications" {
  description = "Notification recipients list for every alerting rules of cpu_90_15min detector"
  type        = list
  default     = []
}

variable "cpu_90_15min_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of cpu_90_15min detector"
  type        = list
  default     = []
}

variable "cpu_90_15min_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of cpu_90_15min detector"
  type        = list
  default     = []
}

variable "cpu_90_15min_aggregation_function" {
  description = "Aggregation function and group by for cpu_90_15min detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['aws_region'])"
}

variable "cpu_90_15min_transformation_function" {
  description = "Transformation function for cpu_90_15min detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "cpu_90_15min_transformation_window" {
  description = "Transformation window for cpu_90_15min detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "cpu_90_15min_threshold_critical" {
  description = "Critical threshold for cpu_90_15min detector"
  type        = number
  default     = 90
}

variable "cpu_90_15min_threshold_warning" {
  description = "Warning threshold for cpu_90_15min detector"
  type        = number
  default     = 80
}

# Free_space_low detectors

variable "free_space_low_disabled" {
  description = "Disable all alerting rules for free_space_low detector"
  type        = bool
  default     = null
}

variable "free_space_low_disabled_critical" {
  description = "Disable critical alerting rule for free_space_low detector"
  type        = bool
  default     = null
}

variable "free_space_low_disabled_warning" {
  description = "Disable warning alerting rule for free_space_low detector"
  type        = bool
  default     = null
}

variable "free_space_low_notifications" {
  description = "Notification recipients list for every alerting rules of free_space_low detector"
  type        = list
  default     = []
}

variable "free_space_low_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of free_space_low detector"
  type        = list
  default     = []
}

variable "free_space_low_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of free_space_low detector"
  type        = list
  default     = []
}

variable "free_space_low_aggregation_function" {
  description = "Aggregation function and group by for free_space_low detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['aws_region'])"
}

variable "free_space_low_transformation_function" {
  description = "Transformation function for free_space_low detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "free_space_low_transformation_window" {
  description = "Transformation window for free_space_low detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "free_space_low_threshold_critical" {
  description = "Critical threshold for free_space_low detector"
  type        = number
  default     = 10
}

variable "free_space_low_threshold_warning" {
  description = "Warning threshold for free_space_low detector"
  type        = number
  default     = 20
}

# Replica_lag detectors

variable "replica_lag_disabled" {
  description = "Disable all alerting rules for replica_lag detector"
  type        = bool
  default     = null
}

variable "replica_lag_disabled_critical" {
  description = "Disable critical alerting rule for replica_lag detector"
  type        = bool
  default     = null
}

variable "replica_lag_disabled_warning" {
  description = "Disable warning alerting rule for replica_lag detector"
  type        = bool
  default     = null
}

variable "replica_lag_notifications" {
  description = "Notification recipients list for every alerting rules of replica_lag detector"
  type        = list
  default     = []
}

variable "replica_lag_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of replica_lag detector"
  type        = list
  default     = []
}

variable "replica_lag_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of replica_lag detector"
  type        = list
  default     = []
}

variable "replica_lag_aggregation_function" {
  description = "Aggregation function and group by for replica_lag detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['aws_region'])"
}

variable "replica_lag_transformation_function" {
  description = "Transformation function for replica_lag detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "replica_lag_transformation_window" {
  description = "Transformation window for replica_lag detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "replica_lag_threshold_critical" {
  description = "Critical threshold for replica_lag detector"
  type        = number
  default     = 300
}

variable "replica_lag_threshold_warning" {
  description = "Warning threshold for replica_lag detector"
  type        = number
  default     = 200
}
