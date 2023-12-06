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

# totalflowcount detector

variable "totalflowcount_notifications" {
  description = "Notification recipients list per severity overridden for totalflowcount detector"
  type        = map(list(string))
  default     = {}
}

variable "totalflowcount_aggregation_function" {
  description = "Aggregation function and group by for totalflowcount detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "totalflowcount_transformation_function" {
  description = "Transformation function for totalflowcount detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "totalflowcount_max_delay" {
  description = "Enforce max delay for totalflowcount detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "totalflowcount_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "totalflowcount_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "totalflowcount_disabled" {
  description = "Disable all alerting rules for totalflowcount detector"
  type        = bool
  default     = null
}

variable "totalflowcount_threshold_critical" {
  description = "Critical threshold for totalflowcount detector"
  type        = number
  default     = 0
}

variable "totalflowcount_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "totalflowcount_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# tunnelstatus detector

variable "tunnelstatus_notifications" {
  description = "Notification recipients list per severity overridden for tunnelstatus detector"
  type        = map(list(string))
  default     = {}
}

variable "tunnelstatus_aggregation_function" {
  description = "Aggregation function and group by for tunnelstatus detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_group', 'azure_resource_name', 'remote_ip'])"
}

variable "tunnelstatus_transformation_function" {
  description = "Transformation function for tunnelstatus detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".fill()"
}

variable "tunnelstatus_max_delay" {
  description = "Enforce max delay for tunnelstatus detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "tunnelstatus_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "tunnelstatus_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "tunnelstatus_disabled" {
  description = "Disable all alerting rules for tunnelstatus detector"
  type        = bool
  default     = null
}

variable "tunnelstatus_threshold_critical" {
  description = "Critical threshold for tunnelstatus detector"
  type        = number
  default     = 0
}

variable "tunnelstatus_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "20m"
}

variable "tunnelstatus_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
