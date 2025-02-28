# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['VpnId'])"
}

variable "heartbeat_transformation_function" {
  description = "Transformation function for heartbeat detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "heartbeat_max_delay" {
  description = "Enforce max delay for heartbeat detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
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
  description = "Timeframe for heartbeat detector (i.e. \"25m\")."
  type        = string
  default     = "25m"
}

# vpn_status detector

variable "vpn_status_notifications" {
  description = "Notification recipients list per severity overridden for vpn_status detector"
  type        = map(list(string))
  default     = {}
}

variable "vpn_status_aggregation_function" {
  description = "Aggregation function and group by for vpn_status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "vpn_status_transformation_function" {
  description = "Transformation function for vpn_status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "vpn_status_max_delay" {
  description = "Enforce max delay for vpn_status detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "vpn_status_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "vpn_status_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "vpn_status_disabled" {
  description = "Disable all alerting rules for vpn_status detector"
  type        = bool
  default     = null
}

variable "vpn_status_threshold_critical" {
  description = "Critical threshold for vpn_status detector"
  type        = number
  default     = 0.5 
}

variable "vpn_status_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "vpn_status_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}

variable "vpn_status_threshold_major" {
  description = "Major threshold for vpn_status detector"
  type        = number
  default     = 1
}

variable "vpn_status_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "vpn_status_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
