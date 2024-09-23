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
  default     = true
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
# tunnel_status detector

variable "tunnel_status_notifications" {
  description = "Notification recipients list per severity overridden for tunnel_status detector"
  type        = map(list(string))
  default     = {}
}

variable "tunnel_status_aggregation_function" {
  description = "Aggregation function and group by for tunnel_status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_group', 'azure_resource_name', 'remote_ip'])"
}

variable "tunnel_status_transformation_function" {
  description = "Transformation function for tunnel_status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "tunnel_status_max_delay" {
  description = "Enforce max delay for tunnel_status detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "tunnel_status_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "tunnel_status_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "tunnel_status_disabled" {
  description = "Disable all alerting rules for tunnel_status detector"
  type        = bool
  default     = null
}

variable "tunnel_status_disabled_critical" {
  description = "Disable critical alerting rule for tunnel_status detector"
  type        = bool
  default     = null
}

variable "tunnel_status_disabled_major" {
  description = "Disable major alerting rule for tunnel_status detector"
  type        = bool
  default     = null
}

variable "tunnel_status_threshold_critical" {
  description = "Critical threshold for tunnel_status detector"
  type        = number
  default     = 0
}

variable "tunnel_status_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "20m"
}

variable "tunnel_status_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "tunnel_status_threshold_major" {
  description = "Major threshold for tunnel_status detector"
  type        = number
  default     = 0
}

variable "tunnel_status_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "tunnel_status_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
