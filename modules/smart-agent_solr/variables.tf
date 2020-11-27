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

# errors detector

variable "errors_disabled" {
  description = "Disable all alerting rules for errors detector"
  type        = bool
  default     = null
}

variable "errors_disabled_critical" {
  description = "Disable critical alerting rule for errors detector"
  type        = bool
  default     = null
}

variable "errors_disabled_major" {
  description = "Disable major alerting rule for errors detector"
  type        = bool
  default     = null
}

variable "errors_notifications" {
  description = "Notification recipients list per severity overridden for errors detector"
  type        = map(list(string))
  default     = {}
}

variable "errors_aggregation_function" {
  description = "Aggregation function and group by for errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "errors_transformation_function" {
  description = "Transformation function for errors detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='5m')"
}

variable "errors_threshold_critical" {
  description = "Critical threshold for errors detector"
  type        = number
  default     = 5
}

variable "errors_threshold_major" {
  description = "Major threshold for errors detector"
  type        = number
  default     = 0
}

# Searcher_warmup_time detector

variable "searcher_warmup_time_disabled" {
  description = "Disable all alerting rules for searcher_warmup_time detector"
  type        = bool
  default     = null
}

variable "searcher_warmup_time_disabled_critical" {
  description = "Disable critical alerting rule for searcher_warmup_time detector"
  type        = bool
  default     = null
}

variable "searcher_warmup_time_disabled_major" {
  description = "Disable major alerting rule for searcher_warmup_time detector"
  type        = bool
  default     = null
}

variable "searcher_warmup_time_notifications" {
  description = "Notification recipients list per severity overridden for searcher_warmup_time detector"
  type        = map(list(string))
  default     = {}
}

variable "searcher_warmup_time_aggregation_function" {
  description = "Aggregation function and group by for searcher_warmup_time detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "searcher_warmup_time_transformation_function" {
  description = "Transformation function for searcher_warmup_time detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "searcher_warmup_time_threshold_critical" {
  description = "Critical threshold for searcher_warmup_time detector"
  type        = number
  default     = 5000
}

variable "searcher_warmup_time_threshold_major" {
  description = "Major threshold for searcher_warmup_time detector"
  type        = number
  default     = 2000
}

