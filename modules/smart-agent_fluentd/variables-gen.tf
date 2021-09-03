# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['host'])"
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

# buffer detector

variable "buffer_notifications" {
  description = "Notification recipients list per severity overridden for buffer detector"
  type        = map(list(string))
  default     = {}
}

variable "buffer_aggregation_function" {
  description = "Aggregation function and group by for buffer detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['host'])"
}

variable "buffer_transformation_function" {
  description = "Transformation function for buffer detector (i.e. \".mean(over='10m')\")"
  type        = string
  default     = ".max(over='10min')"
}

variable "buffer_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "buffer_disabled" {
  description = "Disable all alerting rules for buffer detector"
  type        = bool
  default     = null
}

variable "buffer_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "buffer_threshold" {
  description = "Major threshold for up detector"
  type        = number
  default     = 1
}

variable "buffer_auto_resolve_after" {
  description = "Auto resolve the alert if there are no DATA after some time (i.e. \"5m\")"
  type        = string
  default     = "5m"
}
