# Module specific

variable "gcp_project_id" {
  description = "GCP project id used for default filtering while lables are not synced"
  type        = string
}

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
  default     = ".mean(by=['database_id'])"
}

# CPU_utilization detector

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

variable "cpu_utilization_disabled_major" {
  description = "Disable major alerting rule for cpu_utilization detector"
  type        = bool
  default     = null
}

variable "cpu_utilization_notifications" {
  description = "Notification recipients list per severity overridden for cpu_utilization detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_utilization_aggregation_function" {
  description = "Aggregation function and group by for cpu_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_utilization_transformation_function" {
  description = "Transformation function for cpu_utilization detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "cpu_utilization_threshold_critical" {
  description = "Critical threshold for cpu_utilization detector"
  type        = number
  default     = 95
}

variable "cpu_utilization_threshold_major" {
  description = "Major threshold for cpu_utilization detector"
  type        = number
  default     = 80
}

# Disk_utilization detector

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

variable "disk_utilization_disabled_major" {
  description = "Disable major alerting rule for disk_utilization detector"
  type        = bool
  default     = null
}

variable "disk_utilization_notifications" {
  description = "Notification recipients list per severity overridden for disk_utilization detector"
  type        = map(list(string))
  default     = {}
}

variable "disk_utilization_aggregation_function" {
  description = "Aggregation function and group by for disk_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "disk_utilization_transformation_function" {
  description = "Transformation function for disk_utilization detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "disk_utilization_threshold_critical" {
  description = "Critical threshold for disk_utilization detector"
  type        = number
  default     = 95
}

variable "disk_utilization_threshold_major" {
  description = "Major threshold for disk_utilization detector"
  type        = number
  default     = 86
}

# Disk_utilization_forecast detector

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
  description = "Notification recipients list per severity overridden for disk_utilization_forecast detector"
  type        = map(list(string))
  default     = {}
}

# Memory_utilization detector

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

variable "memory_utilization_disabled_major" {
  description = "Disable major alerting rule for memory_utilization detector"
  type        = bool
  default     = null
}

variable "memory_utilization_notifications" {
  description = "Notification recipients list per severity overridden for memory_utilization detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_utilization_aggregation_function" {
  description = "Aggregation function and group by for memory_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_utilization_transformation_function" {
  description = "Transformation function for memory_utilization detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "memory_utilization_threshold_critical" {
  description = "Critical threshold for memory_utilization detector"
  type        = number
  default     = 95
}

variable "memory_utilization_threshold_major" {
  description = "Major threshold for memory_utilization detector"
  type        = number
  default     = 90
}

# Memory_utilization_forecast detector

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
  description = "Notification recipients list per severity overridden for memory_utilization_forecast detector"
  type        = map(list(string))
  default     = {}
}

