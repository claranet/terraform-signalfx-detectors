# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['logicalname', 'azure_resource_name', 'azure_resource_group_name'])"
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

# su_utilization detector

variable "su_utilization_notifications" {
  description = "Notification recipients list per severity overridden for su_utilization detector"
  type        = map(list(string))
  default     = {}
}

variable "su_utilization_aggregation_function" {
  description = "Aggregation function and group by for su_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "su_utilization_transformation_function" {
  description = "Transformation function for su_utilization detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "su_utilization_max_delay" {
  description = "Enforce max delay for su_utilization detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "su_utilization_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "su_utilization_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "su_utilization_disabled" {
  description = "Disable all alerting rules for su_utilization detector"
  type        = bool
  default     = null
}

variable "su_utilization_disabled_critical" {
  description = "Disable critical alerting rule for su_utilization detector"
  type        = bool
  default     = null
}

variable "su_utilization_disabled_major" {
  description = "Disable major alerting rule for su_utilization detector"
  type        = bool
  default     = null
}

variable "su_utilization_threshold_critical" {
  description = "Critical threshold for su_utilization detector"
  type        = number
  default     = 95
}

variable "su_utilization_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "su_utilization_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "su_utilization_threshold_major" {
  description = "Major threshold for su_utilization detector"
  type        = number
  default     = 80
}

variable "su_utilization_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "su_utilization_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# failed_function_requests detector

variable "failed_function_requests_notifications" {
  description = "Notification recipients list per severity overridden for failed_function_requests detector"
  type        = map(list(string))
  default     = {}
}

variable "failed_function_requests_aggregation_function" {
  description = "Aggregation function and group by for failed_function_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['logicalname', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "failed_function_requests_transformation_function" {
  description = "Transformation function for failed_function_requests detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "failed_function_requests_max_delay" {
  description = "Enforce max delay for failed_function_requests detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "failed_function_requests_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "failed_function_requests_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "failed_function_requests_disabled" {
  description = "Disable all alerting rules for failed_function_requests detector"
  type        = bool
  default     = null
}

variable "failed_function_requests_disabled_critical" {
  description = "Disable critical alerting rule for failed_function_requests detector"
  type        = bool
  default     = null
}

variable "failed_function_requests_disabled_major" {
  description = "Disable major alerting rule for failed_function_requests detector"
  type        = bool
  default     = null
}

variable "failed_function_requests_threshold_critical" {
  description = "Critical threshold for failed_function_requests detector"
  type        = number
  default     = 10
}

variable "failed_function_requests_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "failed_function_requests_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "failed_function_requests_threshold_major" {
  description = "Major threshold for failed_function_requests detector"
  type        = number
  default     = 0
}

variable "failed_function_requests_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "failed_function_requests_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# conversion_errors detector

variable "conversion_errors_notifications" {
  description = "Notification recipients list per severity overridden for conversion_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "conversion_errors_aggregation_function" {
  description = "Aggregation function and group by for conversion_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['logicalname', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "conversion_errors_transformation_function" {
  description = "Transformation function for conversion_errors detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "conversion_errors_max_delay" {
  description = "Enforce max delay for conversion_errors detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "conversion_errors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "conversion_errors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "conversion_errors_disabled" {
  description = "Disable all alerting rules for conversion_errors detector"
  type        = bool
  default     = null
}

variable "conversion_errors_disabled_critical" {
  description = "Disable critical alerting rule for conversion_errors detector"
  type        = bool
  default     = null
}

variable "conversion_errors_disabled_major" {
  description = "Disable major alerting rule for conversion_errors detector"
  type        = bool
  default     = null
}

variable "conversion_errors_threshold_critical" {
  description = "Critical threshold for conversion_errors detector"
  type        = number
  default     = 10
}

variable "conversion_errors_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "conversion_errors_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "conversion_errors_threshold_major" {
  description = "Major threshold for conversion_errors detector"
  type        = number
  default     = 0
}

variable "conversion_errors_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "conversion_errors_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# runtime_errors detector

variable "runtime_errors_notifications" {
  description = "Notification recipients list per severity overridden for runtime_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "runtime_errors_aggregation_function" {
  description = "Aggregation function and group by for runtime_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "runtime_errors_transformation_function" {
  description = "Transformation function for runtime_errors detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "runtime_errors_max_delay" {
  description = "Enforce max delay for runtime_errors detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "runtime_errors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "runtime_errors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "runtime_errors_disabled" {
  description = "Disable all alerting rules for runtime_errors detector"
  type        = bool
  default     = null
}

variable "runtime_errors_disabled_critical" {
  description = "Disable critical alerting rule for runtime_errors detector"
  type        = bool
  default     = null
}

variable "runtime_errors_disabled_major" {
  description = "Disable major alerting rule for runtime_errors detector"
  type        = bool
  default     = null
}

variable "runtime_errors_threshold_critical" {
  description = "Critical threshold for runtime_errors detector"
  type        = number
  default     = 10
}

variable "runtime_errors_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "runtime_errors_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "runtime_errors_threshold_major" {
  description = "Major threshold for runtime_errors detector"
  type        = number
  default     = 0
}

variable "runtime_errors_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "runtime_errors_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
