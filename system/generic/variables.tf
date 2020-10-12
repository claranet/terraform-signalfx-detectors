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
  default     = ""
}

# cpu detector

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

variable "cpu_disabled_major" {
  description = "Disable major alerting rule for cpu detector"
  type        = bool
  default     = null
}

variable "cpu_notifications" {
  description = "Notification recipients list per severity overridden for cpu detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_aggregation_function" {
  description = "Aggregation function and group by for cpu detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_transformation_function" {
  description = "Transformation function for cpu detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1h')"
}

variable "cpu_threshold_critical" {
  description = "Critical threshold for cpu detector"
  type        = number
  default     = 90
}

variable "cpu_threshold_major" {
  description = "Major threshold for cpu detector"
  type        = number
  default     = 85
}

# load detector

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

variable "load_disabled_major" {
  description = "Disable major alerting rule for load detector"
  type        = bool
  default     = null
}

variable "load_notifications" {
  description = "Notification recipients list per severity overridden for load detector"
  type        = map(list(string))
  default     = {}
}

variable "load_aggregation_function" {
  description = "Aggregation function and group by for load detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "load_transformation_function" {
  description = "Transformation function for load detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "load_threshold_critical" {
  description = "Critical threshold for load detector"
  type        = number
  default     = 2.5
}

variable "load_threshold_major" {
  description = "Major threshold for load detector"
  type        = number
  default     = 2
}

# disk_space detector

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

variable "disk_space_disabled_major" {
  description = "Disable major alerting rule for disk space detector"
  type        = bool
  default     = null
}

variable "disk_space_notifications" {
  description = "Notification recipients list per severity overridden for disk space detector"
  type        = map(list(string))
  default     = {}
}

variable "disk_space_aggregation_function" {
  description = "Aggregation function and group by for disk space detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "disk_space_transformation_function" {
  description = "Transformation function for disk space detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "disk_space_threshold_critical" {
  description = "Critical threshold for disk space detector"
  type        = number
  default     = 90
}

variable "disk_space_threshold_major" {
  description = "Major threshold for disk space detector"
  type        = number
  default     = 80
}

# disk_inodes detector

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

variable "disk_inodes_disabled_major" {
  description = "Disable major alerting rule for dsik_inodes detector"
  type        = bool
  default     = null
}

variable "disk_inodes_notifications" {
  description = "Notification recipients list per severity overridden for disk inodes detector"
  type        = map(list(string))
  default     = {}
}

variable "disk_inodes_aggregation_function" {
  description = "Aggregation function and group by for disk inodes detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "disk_inodes_transformation_function" {
  description = "Transformation function for disk inodes detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "disk_inodes_threshold_critical" {
  description = "Critical threshold for disk inodes detector"
  type        = number
  default     = 95
}

variable "disk_inodes_threshold_major" {
  description = "Major threshold for disk inodes detector"
  type        = number
  default     = 90
}

# disk_running_out detector

variable "disk_running_out_disabled" {
  description = "Disable all alerting rules for disk running out detector"
  type        = bool
  default     = true
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
  type        = string
  default     = "False"
}

variable "disk_running_out_notifications" {
  description = "Notification recipients list per severity overridden for disk running out detector"
  type        = map(list(string))
  default     = {}
}

# memory detector

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

variable "memory_disabled_major" {
  description = "Disable major alerting rule for memory detector"
  type        = bool
  default     = null
}

variable "memory_notifications" {
  description = "Notification recipients list per severity overridden for memory detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_aggregation_function" {
  description = "Aggregation function and group by for memory detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_transformation_function" {
  description = "Transformation function for memory detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "memory_threshold_critical" {
  description = "Critical threshold for memory detector"
  type        = number
  default     = 95
}

variable "memory_threshold_major" {
  description = "Major threshold for memory detector"
  type        = number
  default     = 90
}

