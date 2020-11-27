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

# Apache_workers detector

variable "apache_workers_disabled" {
  description = "Disable all alerting rules for apache_workers detector"
  type        = bool
  default     = null
}

variable "apache_workers_disabled_critical" {
  description = "Disable critical alerting rule for apache_workers detector"
  type        = bool
  default     = null
}

variable "apache_workers_disabled_major" {
  description = "Disable major alerting rule for apache_workers detector"
  type        = bool
  default     = null
}

variable "apache_workers_notifications" {
  description = "Notification recipients list per severity overridden for apache_workers detector"
  type        = map(list(string))
  default     = {}
}

variable "apache_workers_aggregation_function" {
  description = "Aggregation function and group by for apache_workers detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "apache_workers_transformation_function" {
  description = "Transformation function for apache_workers detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='10m')"
}

variable "apache_workers_threshold_critical" {
  description = "Critical threshold for apache_workers detector"
  type        = number
  default     = 90
}

variable "apache_workers_threshold_major" {
  description = "Major threshold for apache_workers detector"
  type        = number
  default     = 80
}

