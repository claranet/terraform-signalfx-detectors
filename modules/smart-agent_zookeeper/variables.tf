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

# zookeeper_health detector

variable "zookeeper_health_disabled" {
  description = "Disable all alerting rules for zookeeper_health detector"
  type        = bool
  default     = null
}

variable "zookeeper_health_disabled_critical" {
  description = "Disable critical alerting rule for zookeeper_health detector"
  type        = bool
  default     = null
}

variable "zookeeper_health_notifications" {
  description = "Notification recipients list per severity overridden for zookeeper_health detector"
  type        = map(list(string))
  default     = {}
}

variable "zookeeper_health_aggregation_function" {
  description = "Aggregation function and group by for zookeeper_health detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "zookeeper_health_transformation_function" {
  description = "Transformation function for zookeeper_health detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='5m')"
}

# zookeeper_latency detector

variable "zookeeper_latency_disabled" {
  description = "Disable all alerting rules for zookeeper_latency detector"
  type        = bool
  default     = null
}

variable "zookeeper_latency_disabled_critical" {
  description = "Disable critical alerting rule for zookeeper_latency detector"
  type        = bool
  default     = null
}

variable "zookeeper_latency_disabled_major" {
  description = "Disable major alerting rule for zookeeper_latency detector"
  type        = bool
  default     = null
}

variable "zookeeper_latency_notifications" {
  description = "Notification recipients list per severity overridden for zookeeper_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "zookeeper_latency_aggregation_function" {
  description = "Aggregation function and group by for zookeeper_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "zookeeper_latency_transformation_function" {
  description = "Transformation function for zookeeper_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='5m')"
}

variable "zookeeper_latency_threshold_critical" {
  description = "Critical threshold for zookeeper_latency detector"
  type        = number
  default     = 300000
}

variable "zookeeper_latency_threshold_major" {
  description = "Major threshold for zookeeper_latency detector"
  type        = number
  default     = 250000
}

# file_descriptors detector

variable "file_descriptors_disabled" {
  description = "Disable all alerting rules for file_descriptors detector"
  type        = bool
  default     = null
}

variable "file_descriptors_disabled_critical" {
  description = "Disable critical alerting rule for file_descriptors detector"
  type        = bool
  default     = null
}

variable "file_descriptors_disabled_major" {
  description = "Disable major alerting rule for file_descriptors detector"
  type        = bool
  default     = null
}

variable "file_descriptors_notifications" {
  description = "Notification recipients list per severity overridden for file_descriptors detector"
  type        = map(list(string))
  default     = {}
}

variable "file_descriptors_aggregation_function" {
  description = "Aggregation function and group by for file_descriptors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "file_descriptors_transformation_function" {
  description = "Transformation function for file_descriptors detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='15m')"
}

variable "file_descriptors_threshold_critical" {
  description = "Critical threshold for file_descriptors detector"
  type        = number
  default     = 95
}

variable "file_descriptors_threshold_major" {
  description = "Major threshold for file_descriptors detector"
  type        = number
  default     = 90
}

