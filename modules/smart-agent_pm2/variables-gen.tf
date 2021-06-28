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

variable "heartbeat_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "heartbeat_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
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

# up detector

variable "up_notifications" {
  description = "Notification recipients list per severity overridden for up detector"
  type        = map(list(string))
  default     = {}
}

variable "up_aggregation_function" {
  description = "Aggregation function and group by for up detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "up_transformation_function" {
  description = "Transformation function for up detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5min')"
}

variable "up_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "up_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "up_disabled" {
  description = "Disable all alerting rules for up detector"
  type        = bool
  default     = null
}

variable "up_threshold_critical" {
  description = "Critical threshold for up detector"
  type        = number
  default     = 1
}

# restarts detector

variable "restarts_notifications" {
  description = "Notification recipients list per severity overridden for restarts detector"
  type        = map(list(string))
  default     = {}
}

variable "restarts_aggregation_function" {
  description = "Aggregation function and group by for restarts detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "restarts_transformation_function" {
  description = "Transformation function for restarts detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5min')"
}

variable "restarts_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "restarts_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "restarts_disabled" {
  description = "Disable all alerting rules for restarts detector"
  type        = bool
  default     = null
}

variable "restarts_disabled_critical" {
  description = "Disable critical alerting rule for restarts detector"
  type        = bool
  default     = null
}

variable "restarts_disabled_major" {
  description = "Disable major alerting rule for restarts detector"
  type        = bool
  default     = null
}

variable "restarts_threshold_critical" {
  description = "Critical threshold for restarts detector"
  type        = number
  default     = 5
}

variable "restarts_threshold_major" {
  description = "Major threshold for restarts detector"
  type        = number
  default     = 3
}

