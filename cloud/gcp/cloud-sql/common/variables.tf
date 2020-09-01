# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

variable "gcp_project_id" {
  description = "GCP project id used for default filtering while lables are not synced"
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

# GCP Cloud SQL detectors specific

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

# CPU_utilization detectors

variable "cpu_utilization_disabled" {
  description = "Disable all alerting rules for cpu_utilization detector"
  type        = bool
  default     = null
}

variable "cpu_utilization_disabled_critical" {
  description = "Disable critical alerting rule for cpu_utilization detector"
  type        = bool
  default     = null
}

variable "cpu_utilization_disabled_warning" {
  description = "Disable warning alerting rule for cpu_utilization detector"
  type        = bool
  default     = null
}

variable "cpu_utilization_notifications" {
  description = "Notification recipients list for every alerting rules of cpu_utilization detector"
  type        = list
  default     = []
}

variable "cpu_utilization_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of cpu_utilization detector"
  type        = list
  default     = []
}

variable "cpu_utilization_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of cpu_utilization detector"
  type        = list
  default     = []
}

variable "cpu_utilization_aggregation_function" {
  description = "Aggregation function and group by for cpu_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_utilization_transformation_function" {
  description = "Transformation function for cpu_utilization detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='30m')"
}

variable "cpu_utilization_threshold_critical" {
  description = "Critical threshold for cpu_utilization detector"
  type        = number
  default     = 95
}

variable "cpu_utilization_threshold_warning" {
  description = "Warning threshold for cpu_utilization detector"
  type        = number
  default     = 80
}

# Disk_utilization detectors

variable "disk_utilization_disabled" {
  description = "Disable all alerting rules for disk_utilization detector"
  type        = bool
  default     = null
}

variable "disk_utilization_disabled_critical" {
  description = "Disable critical alerting rule for disk_utilization detector"
  type        = bool
  default     = null
}

variable "disk_utilization_disabled_warning" {
  description = "Disable warning alerting rule for disk_utilization detector"
  type        = bool
  default     = null
}

variable "disk_utilization_notifications" {
  description = "Notification recipients list for every alerting rules of disk_utilization detector"
  type        = list
  default     = []
}

variable "disk_utilization_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of disk_utilization detector"
  type        = list
  default     = []
}

variable "disk_utilization_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of disk_utilization detector"
  type        = list
  default     = []
}

variable "disk_utilization_aggregation_function" {
  description = "Aggregation function and group by for disk_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "disk_utilization_transformation_function" {
  description = "Transformation function for disk_utilization detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='10m')"
}

variable "disk_utilization_threshold_critical" {
  description = "Critical threshold for disk_utilization detector"
  type        = number
  default     = 95
}

variable "disk_utilization_threshold_warning" {
  description = "Warning threshold for disk_utilization detector"
  type        = number
  default     = 86
}

# Disk_utilization_forecast detectors

variable "disk_utilization_forecast_disabled" {
  description = "Disable all alerting rules for disk_utilization_forecast detector"
  type        = bool
  default     = true
}

variable "disk_utilization_forecast_maximum_capacity" {
  description = "When to consider disk full, defined as fractional decimal"
  type        = number
  default     = 0.95
}

variable "disk_utilization_forecast_hours_till_full" {
  description = "How many hours before disk is projected to be full do you want to be alerted"
  type        = number
  default     = 72
}

variable "disk_utilization_forecast_fire_lasting_time" {
  description = "Time condition must be true to fire"
  type        = string
  default     = "30m"
}

variable "disk_utilization_forecast_fire_lasting_time_percent" {
  description = "Percent of fire lasting time the conditon must be true.  Expressed as decimal"
  type        = number
  default     = 0.9
}

variable "disk_utilization_forecast_clear_hours_remaining" {
  description = "With how many hours left till disk is full can the alert clear"
  type        = number
  default     = 96
}

variable "disk_utilization_forecast_clear_lasting_time" {
  description = "Time clear condition must be true to clear"
  type        = string
  default     = "30m"
}

variable "disk_utilization_forecast_clear_lasting_time_percent" {
  description = "Percent of clear lasting time the conditon must be true.  Expressed as decimal"
  type        = number
  default     = 0.9
}

variable "disk_utilization_forecast_use_ewma" {
  description = "Use Double EWMA"
  type        = string
  default     = "True"
}

variable "disk_utilization_forecast_notifications" {
  description = "Notification recipients list for every alerting rules of disk_utilization_forecast detector"
  type        = list
  default     = []
}

# Memory_utilization detectors

variable "memory_utilization_disabled" {
  description = "Disable all alerting rules for memory_utilization detector"
  type        = bool
  default     = null
}

variable "memory_utilization_disabled_critical" {
  description = "Disable critical alerting rule for memory_utilization detector"
  type        = bool
  default     = null
}

variable "memory_utilization_disabled_warning" {
  description = "Disable warning alerting rule for memory_utilization detector"
  type        = bool
  default     = null
}

variable "memory_utilization_notifications" {
  description = "Notification recipients list for every alerting rules of memory_utilization detector"
  type        = list
  default     = []
}

variable "memory_utilization_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of memory_utilization detector"
  type        = list
  default     = []
}

variable "memory_utilization_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of memory_utilization detector"
  type        = list
  default     = []
}

variable "memory_utilization_aggregation_function" {
  description = "Aggregation function and group by for memory_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_utilization_transformation_function" {
  description = "Transformation function for memory_utilization detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='15m')"
}

variable "memory_utilization_threshold_critical" {
  description = "Critical threshold for memory_utilization detector"
  type        = number
  default     = 95
}

variable "memory_utilization_threshold_warning" {
  description = "Warning threshold for memory_utilization detector"
  type        = number
  default     = 90
}

# Memory_utilization_forecast detectors

variable "memory_utilization_forecast_disabled" {
  description = "Disable all alerting rules for memory_utilization_forecast detector"
  type        = bool
  default     = true
}

variable "memory_utilization_forecast_maximum_capacity" {
  description = "When to consider memory full, defined as a fractional decimal"
  type        = number
  default     = 0.95
}

variable "memory_utilization_forecast_hours_till_full" {
  description = "How many hours before memory is projected to be full do you want to be alerted"
  type        = number
  default     = 72
}

variable "memory_utilization_forecast_fire_lasting_time" {
  description = "Time condition must be true to fire"
  type        = string
  default     = "30m"
}

variable "memory_utilization_forecast_fire_lasting_time_percent" {
  description = "Percent of fire lasting time the conditon must be true.  Expressed as decimal"
  type        = number
  default     = 0.9
}

variable "memory_utilization_forecast_clear_hours_remaining" {
  description = "With how many hours left till memory is full can the alert clear"
  type        = number
  default     = 96
}

variable "memory_utilization_forecast_clear_lasting_time" {
  description = "Time clear condition must be true to clear"
  type        = string
  default     = "30m"
}

variable "memory_utilization_forecast_clear_lasting_time_percent" {
  description = "Percent of clear lasting time the conditon must be true.  Expressed as decimal"
  type        = number
  default     = 0.9
}

variable "memory_utilization_forecast_use_ewma" {
  description = "Use Double EWMA"
  type        = string
  default     = "True"
}

variable "memory_utilization_forecast_notifications" {
  description = "Notification recipients list for every alerting rules of memory_utilization_forecast detector"
  type        = list
  default     = []
}

