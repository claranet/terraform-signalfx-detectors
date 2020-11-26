# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

# postfix_queue_size detector

variable "postfix_queue_size_notifications" {
  description = "Notification recipients list per severity overridden for postfix_queue_size detector"
  type        = map(list(string))
  default     = {}
}

variable "postfix_queue_size_aggregation_function" {
  description = "Aggregation function and group by for postfix_queue_size detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "postfix_queue_size_transformation_function" {
  description = "Transformation function for postfix_queue_size detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "postfix_queue_size_disabled" {
  description = "Disable all alerting rules for postfix_queue_size detector"
  type        = bool
  default     = null
}

variable "postfix_queue_size_disabled_critical" {
  description = "Disable critical alerting rule for postfix_queue_size detector"
  type        = bool
  default     = null
}

variable "postfix_queue_size_disabled_major" {
  description = "Disable major alerting rule for postfix_queue_size detector"
  type        = bool
  default     = null
}

variable "postfix_queue_size_threshold_critical" {
  description = "Critical threshold for postfix_queue_size detector"
  type        = number
  default     = 2000
}

variable "postfix_queue_size_threshold_major" {
  description = "Major threshold for postfix_queue_size detector"
  type        = number
  default     = 1000
}

