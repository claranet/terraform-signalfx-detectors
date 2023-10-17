# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
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

# response_time detector

variable "response_time_notifications" {
  description = "Notification recipients list per severity overridden for response_time detector"
  type        = map(list(string))
  default     = {}
}

variable "response_time_aggregation_function" {
  description = "Aggregation function and group by for response_time detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "response_time_transformation_function" {
  description = "Transformation function for response_time detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".fill(value=None)"
}

variable "response_time_max_delay" {
  description = "Enforce max delay for response_time detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "response_time_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "response_time_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "response_time_disabled" {
  description = "Disable all alerting rules for response_time detector"
  type        = bool
  default     = null
}

variable "response_time_disabled_critical" {
  description = "Disable critical alerting rule for response_time detector"
  type        = bool
  default     = null
}

variable "response_time_disabled_major" {
  description = "Disable major alerting rule for response_time detector"
  type        = bool
  default     = null
}

variable "response_time_threshold_critical" {
  description = "Critical threshold for response_time detector in s"
  type        = number
  default     = 10
}

variable "response_time_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "response_time_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "response_time_threshold_major" {
  description = "Major threshold for response_time detector in s"
  type        = number
  default     = 5
}

variable "response_time_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "response_time_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# http_5xx_error_rate detector

variable "http_5xx_error_rate_notifications" {
  description = "Notification recipients list per severity overridden for http_5xx_error_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "http_5xx_error_rate_aggregation_function" {
  description = "Aggregation function and group by for http_5xx_error_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "http_5xx_error_rate_transformation_function" {
  description = "Transformation function for http_5xx_error_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "http_5xx_error_rate_max_delay" {
  description = "Enforce max delay for http_5xx_error_rate detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "http_5xx_error_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "http_5xx_error_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "http_5xx_error_rate_disabled" {
  description = "Disable all alerting rules for http_5xx_error_rate detector"
  type        = bool
  default     = null
}

variable "http_5xx_error_rate_disabled_major" {
  description = "Disable major alerting rule for http_5xx_error_rate detector"
  type        = bool
  default     = null
}

variable "http_5xx_error_rate_disabled_minor" {
  description = "Disable minor alerting rule for http_5xx_error_rate detector"
  type        = bool
  default     = null
}

variable "http_5xx_error_rate_threshold_major" {
  description = "Major threshold for http_5xx_error_rate detector in %"
  type        = number
  default     = 90
}

variable "http_5xx_error_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "http_5xx_error_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "http_5xx_error_rate_threshold_minor" {
  description = "Minor threshold for http_5xx_error_rate detector in %"
  type        = number
  default     = 50
}

variable "http_5xx_error_rate_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "http_5xx_error_rate_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# http_4xx_error_rate detector

variable "http_4xx_error_rate_notifications" {
  description = "Notification recipients list per severity overridden for http_4xx_error_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "http_4xx_error_rate_aggregation_function" {
  description = "Aggregation function and group by for http_4xx_error_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "http_4xx_error_rate_transformation_function" {
  description = "Transformation function for http_4xx_error_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "http_4xx_error_rate_max_delay" {
  description = "Enforce max delay for http_4xx_error_rate detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "http_4xx_error_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "http_4xx_error_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "http_4xx_error_rate_disabled" {
  description = "Disable all alerting rules for http_4xx_error_rate detector"
  type        = bool
  default     = null
}

variable "http_4xx_error_rate_disabled_major" {
  description = "Disable major alerting rule for http_4xx_error_rate detector"
  type        = bool
  default     = null
}

variable "http_4xx_error_rate_disabled_minor" {
  description = "Disable minor alerting rule for http_4xx_error_rate detector"
  type        = bool
  default     = null
}

variable "http_4xx_error_rate_threshold_major" {
  description = "Major threshold for http_4xx_error_rate detector in %"
  type        = number
  default     = 99
}

variable "http_4xx_error_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "http_4xx_error_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "http_4xx_error_rate_threshold_minor" {
  description = "Minor threshold for http_4xx_error_rate detector in %"
  type        = number
  default     = 95
}

variable "http_4xx_error_rate_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "http_4xx_error_rate_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# http_success_status_rate detector

variable "http_success_status_rate_notifications" {
  description = "Notification recipients list per severity overridden for http_success_status_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "http_success_status_rate_aggregation_function" {
  description = "Aggregation function and group by for http_success_status_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "http_success_status_rate_transformation_function" {
  description = "Transformation function for http_success_status_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "http_success_status_rate_max_delay" {
  description = "Enforce max delay for http_success_status_rate detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "http_success_status_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "http_success_status_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "http_success_status_rate_disabled" {
  description = "Disable all alerting rules for http_success_status_rate detector"
  type        = bool
  default     = null
}

variable "http_success_status_rate_disabled_major" {
  description = "Disable major alerting rule for http_success_status_rate detector"
  type        = bool
  default     = null
}

variable "http_success_status_rate_disabled_minor" {
  description = "Disable minor alerting rule for http_success_status_rate detector"
  type        = bool
  default     = null
}

variable "http_success_status_rate_threshold_major" {
  description = "Major threshold for http_success_status_rate detector in %"
  type        = number
  default     = 10
}

variable "http_success_status_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "http_success_status_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "http_success_status_rate_threshold_minor" {
  description = "Minor threshold for http_success_status_rate detector in %"
  type        = number
  default     = 30
}

variable "http_success_status_rate_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "http_success_status_rate_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
