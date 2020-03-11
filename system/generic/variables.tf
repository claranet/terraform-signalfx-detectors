# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx Module specific

variable "notifications" {
  description = "Notification recipients list (i.e. \"Email,my@mail.com;PagerDuty,credentialId\")"
  type        = list
}

variable "prefixes" {
  description = "Prefixes list to prepend between brackets on every monitors names before environment"
  type        = list
  default     = []
}

variable "filter_defaults" {
  description = "Default string to use as default filtering which follows tagging convention"
  type        = string
  default     = "filter('env', '${var.environment}') and filter('claranet_monitored', 'true')"
}

variable "filter_custom_includes" {
  description = "Filters list to include when using custom filtering"
  type        = list
  default     = []
}

variable "filter_custom_excludes" {
  description = "Filters list to exclude when using custom filtering"
  type        = list
  default     = []
}

variable "detectors_disabled" {
  description = "Disable all detectors in this module"
  type        = bool
  default     = false
}

# System generic specific

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

#####

variable "cpu_disabled" {
  description = "Disable all alerting rules for cpu detector"
  type        = bool
  default     = null
}

variable "cpu_disabled_critical" {
  description = "Disable critical alerting rule for cpu detector"
  type        = bool
  default     = null
}

variable "cpu_disabled_warning" {
  description = "Disable warning alerting rule for cpu detector"
  type        = bool
  default     = null
}

variable "cpu_notifications" {
  description = "Notification recipients list for every alerting rules of cpu detector"
  type        = list
  default     = []
}

variable "cpu_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of cpu detector"
  type        = list
  default     = []
}

variable "cpu_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of cpu detector"
  type        = list
  default     = []
}

variable "cpu_aggregation_function" {
  description = "Aggregation function and group by for cpu detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "cpu_transformation_function" {
  description = "Transformation function for cpu detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "cpu_transformation_window" {
  description = "Transformation window for cpu detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "1h"
}

variable "cpu_threshold_critical" {
  description = "Critical threshold for cpu detector"
  type        = number
  default     = 90
}

variable "cpu_threshold_warning" {
  description = "Warning threshold for cpu detector"
  type        = number
  default     = 85
}

#####

variable "load_disabled" {
  description = "Disable all alerting rules for load detector"
  type        = bool
  default     = null
}

variable "load_disabled_critical" {
  description = "Disable critical alerting rule for load detector"
  type        = bool
  default     = null
}

variable "load_disabled_warning" {
  description = "Disable warning alerting rule for load detector"
  type        = bool
  default     = null
}

variable "load_notifications" {
  description = "Notification recipients list for every alerting rules of load detector"
  type        = list
  default     = []
}

variable "load_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of load detector"
  type        = list
  default     = []
}

variable "load_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of load detector"
  type        = list
  default     = []
}

variable "load_aggregation_function" {
  description = "Aggregation function and group by for load detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "load_transformation_function" {
  description = "Transformation function for load detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "load_transformation_window" {
  description = "Transformation window for load detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "30m"
}

variable "load_threshold_critical" {
  description = "Critical threshold for load detector"
  type        = number
  default     = 2.5
}

variable "load_threshold_warning" {
  description = "Warning threshold for load detector"
  type        = number
  default     = 2
}

#####

variable "disk_space_disabled" {
  description = "Disable all alerting rules for disk space detector"
  type        = bool
  default     = null
}

variable "disk_space_disabled_critical" {
  description = "Disable critical alerting rule for disk space detector"
  type        = bool
  default     = null
}

variable "disk_space_disabled_warning" {
  description = "Disable warning alerting rule for disk space detector"
  type        = bool
  default     = null
}

variable "disk_space_notifications" {
  description = "Notification recipients list for every alerting rules of disk space detector"
  type        = list
  default     = []
}

variable "disk_space_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of disk space detector"
  type        = list
  default     = []
}

variable "disk_space_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of disk space detector"
  type        = list
  default     = []
}

variable "disk_space_aggregation_function" {
  description = "Aggregation function and group by for disk space detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "disk_space_transformation_function" {
  description = "Transformation function for disk space detector (mean, min, max)"
  type        = string
  default     = "max"
}

variable "disk_space_transformation_window" {
  description = "Transformation window for disk space detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "disk_space_threshold_critical" {
  description = "Critical threshold for disk space detector"
  type        = number
  default     = 90
}

variable "disk_space_threshold_warning" {
  description = "Warning threshold for disk space detector"
  type        = number
  default     = 80
}

#####

variable "disk_inodes_disabled" {
  description = "Disable all alerting rules for disk_inodes detector"
  type        = bool
  default     = null
}

variable "disk_inodes_disabled_critical" {
  description = "Disable critical alerting rule for disk_inodes detector"
  type        = bool
  default     = null
}

variable "disk_inodes_disabled_warning" {
  description = "Disable warning alerting rule for dsik_inodes detector"
  type        = bool
  default     = null
}

variable "disk_inodes_notifications" {
  description = "Notification recipients list for every alerting rules of disk_inodes detector"
  type        = list
  default     = []
}

variable "disk_inodes_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of disk_inodes detector"
  type        = list
  default     = []
}

variable "disk_inodes_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of disk_inodes detector"
  type        = list
  default     = []
}

variable "disk_inodes_aggregation_function" {
  description = "Aggregation function and group by for disk_inodes detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "disk_inodes_transformation_function" {
  description = "Transformation function for disk_inodes detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "disk_inodes_transformation_window" {
  description = "Transformation window for disk_inodes detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "disk_inodes_threshold_critical" {
  description = "Critical threshold for disk_inodes detector"
  type        = number
  default     = 95
}

variable "disk_inodes_threshold_warning" {
  description = "Warning threshold for disk_inodes detector"
  type        = number
  default     = 90
}

#####

variable "disk_running_out_disabled" {
  description = "Disable all alerting rules for disk running out detector"
  type        = bool
  default     = null
}

variable "disk_running_out_maximum_capacity" {
  description = "When to consider disk full, defined as a percentage"
  type        = number
  default     = 95
}

variable "disk_running_out_hours_till_full" {
  description = "How manuy hours before disk is projected to be full do you want to be alerted"
  type        = number
  default     = 72
}

variable "disk_running_out_fire_lasting_time" {
  description = "Time condition must be true to fire"
  type        = string
  default     = "30m"
}

variable "disk_running_out_fire_lasting_time_percent" {
  description = "Percent of fire lasting time the conditon must be true.  Expressed as decimal"
  type        = number
  default     = 0.9
}

variable "disk_running_out_clear_hours_remaining" {
  description = "With how many hours left till disk is full can the alert clear"
  type        = number
  default     = 96
}

variable "disk_running_out_clear_lasting_time" {
  description = "Time clear condition must be true to clear"
  type        = string
  default     = "30m"
}

variable "disk_running_out_clear_lasting_time_percent" {
  description = "Percent of clear lasting time the conditon must be true.  Expressed as decimal"
  type        = number
  default     = 0.9
}

variable "disk_running_out_use_ewma" {
  description = "Use Double EWMA"
  type        = bool
  default     = false
}

variable "disk_running_out_notifications" {
  description = "Notification recipients list for every alerting rules of disk running out detector"
  type        = list
  default     = []
}

#####

variable "memory_disabled" {
  description = "Disable all alerting rules for memory detector"
  type        = bool
  default     = null
}

variable "memory_disabled_critical" {
  description = "Disable critical alerting rule for memory detector"
  type        = bool
  default     = null
}

variable "memory_disabled_warning" {
  description = "Disable warning alerting rule for memory detector"
  type        = bool
  default     = null
}

variable "memory_notifications" {
  description = "Notification recipients list for every alerting rules of memory detector"
  type        = list
  default     = []
}

variable "memory_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of memory detector"
  type        = list
  default     = []
}

variable "memory_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of memory detector"
  type        = list
  default     = []
}

variable "memory_aggregation_function" {
  description = "Aggregation function and group by for memory detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "memory_transformation_function" {
  description = "Transformation function for memory detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "memory_transformation_window" {
  description = "Transformation window for memory detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "memory_threshold_critical" {
  description = "Critical threshold for memory detector"
  type        = number
  default     = 95
}

variable "memory_threshold_warning" {
  description = "Warning threshold for memory detector"
  type        = number
  default     = 90
}

