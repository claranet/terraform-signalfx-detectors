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
  default     = true
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "10m"
}

# execution_delay detector

variable "execution_delay_notifications" {
  description = "Notification recipients list per severity overridden for execution_delay detector"
  type        = map(list(string))
  default     = {}
}

variable "execution_delay_aggregation_function" {
  description = "Aggregation function and group by for execution_delay detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "execution_delay_transformation_function" {
  description = "Transformation function for execution_delay detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "execution_delay_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "execution_delay_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "execution_delay_disabled" {
  description = "Disable all alerting rules for execution_delay detector"
  type        = bool
  default     = true
}

variable "execution_delay_threshold_major" {
  description = "Major threshold for execution_delay detector"
  type        = number
  default     = 1
}

variable "execution_delay_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1d"
}

variable "execution_delay_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# last_execution_state detector

variable "last_execution_state_notifications" {
  description = "Notification recipients list per severity overridden for last_execution_state detector"
  type        = map(list(string))
  default     = {}
}

variable "last_execution_state_aggregation_function" {
  description = "Aggregation function and group by for last_execution_state detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "last_execution_state_transformation_function" {
  description = "Transformation function for last_execution_state detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "last_execution_state_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "last_execution_state_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "last_execution_state_disabled" {
  description = "Disable all alerting rules for last_execution_state detector"
  type        = bool
  default     = null
}

variable "last_execution_state_threshold_major" {
  description = "Major threshold for last_execution_state detector"
  type        = number
  default     = 0
}

variable "last_execution_state_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "last_execution_state_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
