# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['FrontendIPAddress', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
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

# healthprobe detector

variable "healthprobe_notifications" {
  description = "Notification recipients list per severity overridden for healthprobe detector"
  type        = map(list(string))
  default     = {}
}

variable "healthprobe_aggregation_function" {
  description = "Aggregation function and group by for healthprobe detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['BackendIPAddress', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "healthprobe_transformation_function" {
  description = "Transformation function for healthprobe detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "healthprobe_max_delay" {
  description = "Enforce max delay for healthprobe detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "healthprobe_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "healthprobe_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "healthprobe_disabled" {
  description = "Disable all alerting rules for healthprobe detector"
  type        = bool
  default     = null
}

variable "healthprobe_disabled_critical" {
  description = "Disable critical alerting rule for healthprobe detector"
  type        = bool
  default     = null
}

variable "healthprobe_disabled_major" {
  description = "Disable major alerting rule for healthprobe detector"
  type        = bool
  default     = null
}

variable "healthprobe_threshold_critical" {
  description = "Critical threshold for healthprobe detector in %"
  type        = number
  default     = 100
}

variable "healthprobe_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "healthprobe_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "healthprobe_threshold_major" {
  description = "Major threshold for healthprobe detector in %"
  type        = number
  default     = 50
}

variable "healthprobe_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "healthprobe_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
