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

# capacity detector

variable "capacity_notifications" {
  description = "Notification recipients list per severity overridden for capacity detector"
  type        = map(list(string))
  default     = {}
}

variable "capacity_aggregation_function" {
  description = "Aggregation function and group by for capacity detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "capacity_transformation_function" {
  description = "Transformation function for capacity detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "capacity_max_delay" {
  description = "Enforce max delay for capacity detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "capacity_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "capacity_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "capacity_disabled" {
  description = "Disable all alerting rules for capacity detector"
  type        = bool
  default     = null
}

variable "capacity_disabled_critical" {
  description = "Disable critical alerting rule for capacity detector"
  type        = bool
  default     = null
}

variable "capacity_disabled_major" {
  description = "Disable major alerting rule for capacity detector"
  type        = bool
  default     = null
}

variable "capacity_threshold_critical" {
  description = "Critical threshold for capacity detector in %"
  type        = number
  default     = 95
}

variable "capacity_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "capacity_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "capacity_threshold_major" {
  description = "Major threshold for capacity detector in %"
  type        = number
  default     = 90
}

variable "capacity_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "capacity_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# duration_of_gateway_request detector

variable "duration_of_gateway_request_notifications" {
  description = "Notification recipients list per severity overridden for duration_of_gateway_request detector"
  type        = map(list(string))
  default     = {}
}

variable "duration_of_gateway_request_aggregation_function" {
  description = "Aggregation function and group by for duration_of_gateway_request detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "duration_of_gateway_request_transformation_function" {
  description = "Transformation function for duration_of_gateway_request detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".scale(0.001)"
}

variable "duration_of_gateway_request_max_delay" {
  description = "Enforce max delay for duration_of_gateway_request detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "duration_of_gateway_request_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "duration_of_gateway_request_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "duration_of_gateway_request_disabled" {
  description = "Disable all alerting rules for duration_of_gateway_request detector"
  type        = bool
  default     = null
}

variable "duration_of_gateway_request_disabled_critical" {
  description = "Disable critical alerting rule for duration_of_gateway_request detector"
  type        = bool
  default     = null
}

variable "duration_of_gateway_request_disabled_major" {
  description = "Disable major alerting rule for duration_of_gateway_request detector"
  type        = bool
  default     = null
}

variable "duration_of_gateway_request_threshold_critical" {
  description = "Critical threshold for duration_of_gateway_request detector in s"
  type        = number
  default     = 1.5
}

variable "duration_of_gateway_request_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "duration_of_gateway_request_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "duration_of_gateway_request_threshold_major" {
  description = "Major threshold for duration_of_gateway_request detector in s"
  type        = number
  default     = 1
}

variable "duration_of_gateway_request_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "duration_of_gateway_request_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# duration_of_backend_request detector

variable "duration_of_backend_request_notifications" {
  description = "Notification recipients list per severity overridden for duration_of_backend_request detector"
  type        = map(list(string))
  default     = {}
}

variable "duration_of_backend_request_aggregation_function" {
  description = "Aggregation function and group by for duration_of_backend_request detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "duration_of_backend_request_transformation_function" {
  description = "Transformation function for duration_of_backend_request detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".scale(0.001)"
}

variable "duration_of_backend_request_max_delay" {
  description = "Enforce max delay for duration_of_backend_request detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "duration_of_backend_request_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "duration_of_backend_request_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "duration_of_backend_request_disabled" {
  description = "Disable all alerting rules for duration_of_backend_request detector"
  type        = bool
  default     = null
}

variable "duration_of_backend_request_disabled_critical" {
  description = "Disable critical alerting rule for duration_of_backend_request detector"
  type        = bool
  default     = null
}

variable "duration_of_backend_request_disabled_major" {
  description = "Disable major alerting rule for duration_of_backend_request detector"
  type        = bool
  default     = null
}

variable "duration_of_backend_request_threshold_critical" {
  description = "Critical threshold for duration_of_backend_request detector in s"
  type        = number
  default     = 1.5
}

variable "duration_of_backend_request_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "duration_of_backend_request_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "duration_of_backend_request_threshold_major" {
  description = "Major threshold for duration_of_backend_request detector in s"
  type        = number
  default     = 1
}

variable "duration_of_backend_request_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "duration_of_backend_request_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
