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
  default     = ".min(over='1h')"
}

variable "cpu_utilization_threshold_critical" {
  description = "Critical threshold for cpu_utilization detector"
  type        = number
  default     = 90
}

variable "cpu_utilization_threshold_major" {
  description = "Major threshold for cpu_utilization detector"
  type        = number
  default     = 85
}

# Disk_throttled_bps detector

variable "disk_throttled_bps_disabled" {
  description = "Disable all alerting rules for disk_throttled_bps detector"
  type        = bool
  default     = null
}

variable "disk_throttled_bps_disabled_critical" {
  description = "Disable critical alerting rule for disk_throttled_bps detector"
  type        = bool
  default     = null
}

variable "disk_throttled_bps_disabled_major" {
  description = "Disable major alerting rule for disk_throttled_bps detector"
  type        = bool
  default     = null
}

variable "disk_throttled_bps_notifications" {
  description = "Notification recipients list per severity overridden for disk_throttled_bps detector"
  type        = map(list(string))
  default     = {}
}

variable "disk_throttled_bps_aggregation_function" {
  description = "Aggregation function and group by for disk_throttled_bps detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "disk_throttled_bps_transformation_function" {
  description = "Transformation function for disk_throttled_bps detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "disk_throttled_bps_threshold_critical" {
  description = "Critical threshold for disk_throttled_bps detector"
  type        = number
  default     = 50
}

variable "disk_throttled_bps_threshold_major" {
  description = "Major threshold for disk_throttled_bps detector"
  type        = number
  default     = 30
}

# Disk_throttled_ops detector

variable "disk_throttled_ops_disabled" {
  description = "Disable all alerting rules for disk_throttled_ops detector"
  type        = bool
  default     = null
}

variable "disk_throttled_ops_disabled_critical" {
  description = "Disable critical alerting rule for disk_throttled_ops detector"
  type        = bool
  default     = null
}

variable "disk_throttled_ops_disabled_major" {
  description = "Disable major alerting rule for disk_throttled_ops detector"
  type        = bool
  default     = null
}

variable "disk_throttled_ops_notifications" {
  description = "Notification recipients list per severity overridden for disk_throttled_ops detector"
  type        = map(list(string))
  default     = {}
}

variable "disk_throttled_ops_aggregation_function" {
  description = "Aggregation function and group by for disk_throttled_ops detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "disk_throttled_ops_transformation_function" {
  description = "Transformation function for disk_throttled_ops detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "disk_throttled_ops_threshold_critical" {
  description = "Critical threshold for disk_throttled_ops detector"
  type        = number
  default     = 50
}

variable "disk_throttled_ops_threshold_major" {
  description = "Major threshold for disk_throttled_ops detector"
  type        = number
  default     = 30
}
