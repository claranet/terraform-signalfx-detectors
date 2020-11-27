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

# error_rate detector

variable "error_rate_disabled" {
  description = "Disable all alerting rules for error_rate detector"
  type        = bool
  default     = null
}

variable "error_rate_disabled_critical" {
  description = "Disable critical alerting rule for error_rate detector"
  type        = bool
  default     = null
}

variable "error_rate_disabled_major" {
  description = "Disable major alerting rule for error_rate detector"
  type        = bool
  default     = null
}

variable "error_rate_notifications" {
  description = "Notification recipients list per severity overridden for error_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "error_rate_aggregation_function" {
  description = "Aggregation function and group by for error_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "error_rate_transformation_function" {
  description = "Transformation function for error_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "error_rate_threshold_critical" {
  description = "Critical threshold for error_rate detector"
  type        = number
  default     = 5
}

variable "error_rate_threshold_major" {
  description = "Major threshold for error_rate detector"
  type        = number
  default     = 1
}

# apdex detector

variable "apdex_disabled" {
  description = "Disable all alerting rules for apdex detector"
  type        = bool
  default     = null
}

variable "apdex_disabled_critical" {
  description = "Disable critical alerting rule for apdex detector"
  type        = bool
  default     = null
}

variable "apdex_disabled_major" {
  description = "Disable major alerting rule for apdex detector"
  type        = bool
  default     = null
}

variable "apdex_notifications" {
  description = "Notification recipients list per severity overridden for apdex detector"
  type        = map(list(string))
  default     = {}
}

variable "apdex_aggregation_function" {
  description = "Aggregation function and group by for apdex detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "apdex_transformation_function" {
  description = "Transformation function for apdex detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "apdex_threshold_critical" {
  description = "Critical threshold for apdex detector"
  type        = number
  default     = 0.25
}

variable "apdex_threshold_major" {
  description = "Major threshold for apdex detector"
  type        = number
  default     = 0.5
}

