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

variable "heartbeat_transformation_function" {
  description = "Transformation function for heartbeat detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

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

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "10m"
}

# dbisdown detector

variable "dbisdown_notifications" {
  description = "Notification recipients list per severity overridden for dbisdown detector"
  type        = map(list(string))
  default     = {}
}

variable "dbisdown_aggregation_function" {
  description = "Aggregation function and group by for dbisdown detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "dbisdown_transformation_function" {
  description = "Transformation function for dbisdown detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='10m')"
}

variable "dbisdown_max_delay" {
  description = "Enforce max delay for dbisdown detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "dbisdown_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    oracle database is down, check status on server and logfile
EOF
}

variable "dbisdown_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "dbisdown_disabled" {
  description = "Disable all alerting rules for dbisdown detector"
  type        = bool
  default     = null
}

variable "dbisdown_threshold_critical" {
  description = "Critical threshold for dbisdown detector"
  type        = number
  default     = 1
}

variable "dbisdown_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "dbisdown_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
