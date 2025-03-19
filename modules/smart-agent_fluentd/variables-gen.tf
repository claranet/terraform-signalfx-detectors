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
  default     = ".min(over='10min')"
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
  default     = 10
}

variable "buffer_lasting_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "buffer_auto_resolve_seconds" {
  description = "Alert duration after NO DATA (in seconds)"
  type        = number
  default     = 60
}

