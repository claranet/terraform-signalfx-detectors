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

# Dns_query_time detector

variable "dns_query_time_disabled" {
  description = "Disable all alerting rules for dns_query_time detector"
  type        = bool
  default     = null
}

variable "dns_query_time_disabled_critical" {
  description = "Disable critical alerting rule for dns_query_time detector"
  type        = bool
  default     = null
}

variable "dns_query_time_disabled_major" {
  description = "Disable major alerting rule for dns_query_time detector"
  type        = bool
  default     = null
}

variable "dns_query_time_notifications" {
  description = "Notification recipients list per severity overridden for dns_query_time detector"
  type        = map(list(string))
  default     = {}
}

variable "dns_query_time_aggregation_function" {
  description = "Aggregation function and group by for dns_query_time detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "dns_query_time_transformation_function" {
  description = "Transformation function for dns_query_time detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='15m')"
}

variable "dns_query_time_threshold_critical" {
  description = "Critical threshold for dns_query_time detector"
  type        = number
  default     = 1000
}

variable "dns_query_time_threshold_major" {
  description = "Major threshold for dns_query_time detector"
  type        = number
  default     = 500
}

# Dns_result_code detector

variable "dns_result_code_disabled" {
  description = "Disable all alerting rules for dns_result_code detector"
  type        = bool
  default     = null
}

variable "dns_result_code_disabled_critical" {
  description = "Disable critical alerting rule for dns_result_code detector"
  type        = bool
  default     = null
}

variable "dns_result_code_notifications" {
  description = "Notification recipients list per severity overridden for dns_result_code detector"
  type        = map(list(string))
  default     = {}
}

variable "dns_result_code_aggregation_function" {
  description = "Aggregation function and group by for dns_result_code detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "dns_result_code_transformation_function" {
  description = "Transformation function for dns_result_code detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

