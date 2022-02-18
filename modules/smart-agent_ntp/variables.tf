# Module specific

# Heartbeat detector

variable "heartbeat_max_delay" {
  description = "Enforce max delay for heartbeat detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = 900
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

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "12h"
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

# ntp detector

variable "ntp_max_delay" {
  description = "Enforce max delay for ntp detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "ntp_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "ntp_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "ntp_disabled" {
  description = "Disable all alerting rules for ntp detector"
  type        = bool
  default     = null
}

variable "ntp_notifications" {
  description = "Notification recipients list per severity overridden for ntp detector"
  type        = map(list(string))
  default     = {}
}

variable "ntp_aggregation_function" {
  description = "Aggregation function and group by for ntp detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "ntp_transformation_function" {
  description = "Transformation function for ntp detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "ntp_threshold_major" {
  description = "Major threshold for ntp detector"
  type        = number
  default     = 1500
}

