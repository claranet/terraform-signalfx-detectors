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
  default     = ".mean(by=['host'])"
}

# cpu detector

variable "cpu_disabled" {
  description = "Disable all alerting rules for cpu detector"
  type        = bool
  default     = false
}

variable "cpu_disabled_minor" {
  description = "Disable minor alerting rule for cpu detector"
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

variable "cpu_threshold_minor" {
  description = "minor threshold for cpu detector"
  type        = number
  default     = 50
}

variable "cpu_threshold_major" {
  description = "Major threshold for cpu detector"
  type        = number
  default     = 75
}

# throttling detector

variable "throttling_disabled" {
  description = "Disable all alerting rules for throttling detector"
  type        = bool
  default     = false
}

variable "throttling_disabled_minor" {
  description = "Disable minor alerting rule for throttling detector"
  type        = bool
  default     = null
}

variable "throttling_disabled_major" {
  description = "Disable major alerting rule for throttling detector"
  type        = bool
  default     = null
}

variable "throttling_notifications" {
  description = "Notification recipients list per severity overridden for throttling detector"
  type        = map(list(string))
  default     = {}
}

variable "throttling_aggregation_function" {
  description = "Aggregation function and group by for throttling detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "throttling_transformation_function" {
  description = "Transformation function for throttling detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "throttling_threshold_minor" {
  description = "minor threshold for throttling detector"
  type        = number
  default     = 1000 # = 1 millisecond in nanoseconds
}

variable "throttling_threshold_major" {
  description = "Major threshold for throttling detector"
  type        = number
  default     = 1000000000 # = 1 second in nanoseconds
}

# Memory detector

variable "memory_disabled" {
  description = "Disable all alerting rules for memory detector"
  type        = bool
  default     = false
}

variable "memory_disabled_minor" {
  description = "Disable minor alerting rule for memory detector"
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
  default     = ".min(over='15m')"
}

variable "memory_threshold_minor" {
  description = "minor threshold for memory detector"
  type        = number
  default     = 90
}

variable "memory_threshold_major" {
  description = "Major threshold for memory detector"
  type        = number
  default     = 95
}

