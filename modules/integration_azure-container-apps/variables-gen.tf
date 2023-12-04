# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_id'])"
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

# restarts detector

variable "restarts_notifications" {
  description = "Notification recipients list per severity overridden for restarts detector"
  type        = map(list(string))
  default     = {}
}

variable "restarts_aggregation_function" {
  description = "Aggregation function and group by for restarts detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['podname'])"
}

variable "restarts_transformation_function" {
  description = "Transformation function for restarts detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".sum(over='15m')"
}

variable "restarts_max_delay" {
  description = "Enforce max delay for restarts detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "restarts_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "restarts_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "restarts_disabled" {
  description = "Disable all alerting rules for restarts detector"
  type        = bool
  default     = null
}

variable "restarts_threshold_warning" {
  description = "Warning threshold for restarts detector"
  type        = number
  default     = 15
}

variable "restarts_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "restarts_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# replicas detector

variable "replicas_notifications" {
  description = "Notification recipients list per severity overridden for replicas detector"
  type        = map(list(string))
  default     = {}
}

variable "replicas_transformation_function" {
  description = "Transformation function for replicas detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "replicas_max_delay" {
  description = "Enforce max delay for replicas detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "replicas_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "replicas_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "replicas_disabled" {
  description = "Disable all alerting rules for replicas detector"
  type        = bool
  default     = null
}

variable "replicas_threshold_info" {
  description = "Info threshold for replicas detector"
  type        = number
  default     = 5
}

variable "replicas_lasting_duration_info" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "replicas_at_least_percentage_info" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
