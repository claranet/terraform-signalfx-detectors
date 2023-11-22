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

# backend_unhealthy_host_ratio detector

variable "backend_unhealthy_host_ratio_notifications" {
  description = "Notification recipients list per severity overridden for backend_unhealthy_host_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "backend_unhealthy_host_ratio_aggregation_function" {
  description = "Aggregation function and group by for backend_unhealthy_host_ratio detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['BackendIPAddress', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "backend_unhealthy_host_ratio_transformation_function" {
  description = "Transformation function for backend_unhealthy_host_ratio detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "backend_unhealthy_host_ratio_max_delay" {
  description = "Enforce max delay for backend_unhealthy_host_ratio detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "backend_unhealthy_host_ratio_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "backend_unhealthy_host_ratio_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "backend_unhealthy_host_ratio_disabled" {
  description = "Disable all alerting rules for backend_unhealthy_host_ratio detector"
  type        = bool
  default     = null
}

variable "backend_unhealthy_host_ratio_disabled_critical" {
  description = "Disable critical alerting rule for backend_unhealthy_host_ratio detector"
  type        = bool
  default     = null
}

variable "backend_unhealthy_host_ratio_disabled_major" {
  description = "Disable major alerting rule for backend_unhealthy_host_ratio detector"
  type        = bool
  default     = null
}

variable "backend_unhealthy_host_ratio_threshold_critical" {
  description = "Critical threshold for backend_unhealthy_host_ratio detector in %"
  type        = number
  default     = 50
}

variable "backend_unhealthy_host_ratio_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "backend_unhealthy_host_ratio_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "backend_unhealthy_host_ratio_threshold_major" {
  description = "Major threshold for backend_unhealthy_host_ratio detector in %"
  type        = number
  default     = 100
}

variable "backend_unhealthy_host_ratio_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "backend_unhealthy_host_ratio_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
