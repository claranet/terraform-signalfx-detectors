# Module specific

# Heartbeat detector

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

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "10m"
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

# treatment_limit detector

variable "treatment_limit_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "treatment_limit_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "treatment_limit_disabled" {
  description = "Disable all alerting rules for treatment limit detector"
  type        = bool
  default     = null
}

variable "treatment_limit_disabled_critical" {
  description = "Disable critical alerting rule for treatment limit detector"
  type        = bool
  default     = null
}

variable "treatment_limit_disabled_major" {
  description = "Disable major alerting rule for treatment limit detector"
  type        = bool
  default     = null
}

variable "treatment_limit_notifications" {
  description = "Notification recipients list per severity overridden for treatment limit detector"
  type        = map(list(string))
  default     = {}
}

variable "treatment_limit_aggregation_function" {
  description = "Aggregation function and group by for treatment limit detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "treatment_limit_transformation_function" {
  description = "Transformation function for treatment limit detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "treatment_limit_threshold_critical" {
  description = "Critical threshold for treatment limit detector"
  type        = number
  default     = 20
}

variable "treatment_limit_threshold_major" {
  description = "Major threshold for treatment limit detector"
  type        = number
  default     = 0
}

