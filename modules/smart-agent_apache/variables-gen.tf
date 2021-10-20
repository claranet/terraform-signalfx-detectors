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
  default     = "10m"
}

# busy_workers detector

variable "busy_workers_notifications" {
  description = "Notification recipients list per severity overridden for busy_workers detector"
  type        = map(list(string))
  default     = {}
}

variable "busy_workers_aggregation_function" {
  description = "Aggregation function and group by for busy_workers detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "busy_workers_transformation_function" {
  description = "Transformation function for busy_workers detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='10m')"
}

variable "busy_workers_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "busy_workers_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "busy_workers_disabled" {
  description = "Disable all alerting rules for busy_workers detector"
  type        = bool
  default     = null
}

variable "busy_workers_disabled_critical" {
  description = "Disable critical alerting rule for busy_workers detector"
  type        = bool
  default     = null
}

variable "busy_workers_disabled_major" {
  description = "Disable major alerting rule for busy_workers detector"
  type        = bool
  default     = null
}

variable "busy_workers_threshold_critical" {
  description = "Critical threshold for busy_workers detector"
  type        = number
  default     = 90
}

variable "busy_workers_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "busy_workers_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "busy_workers_threshold_major" {
  description = "Major threshold for busy_workers detector"
  type        = number
  default     = 80
}

variable "busy_workers_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "busy_workers_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
