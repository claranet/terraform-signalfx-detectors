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

# errors detector

variable "errors_notifications" {
  description = "Notification recipients list per severity overridden for errors detector"
  type        = map(list(string))
  default     = {}
}

variable "errors_aggregation_function" {
  description = "Aggregation function and group by for errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "errors_transformation_function" {
  description = "Transformation function for errors detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "errors_max_delay" {
  description = "Enforce max delay for errors detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "errors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "errors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "errors_disabled" {
  description = "Disable all alerting rules for errors detector"
  type        = bool
  default     = null
}

variable "errors_disabled_critical" {
  description = "Disable critical alerting rule for errors detector"
  type        = bool
  default     = null
}

variable "errors_disabled_major" {
  description = "Disable major alerting rule for errors detector"
  type        = bool
  default     = null
}

variable "errors_threshold_critical" {
  description = "Critical threshold for errors detector"
  type        = number
  default     = 30
}

variable "errors_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "900s"
}

variable "errors_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "errors_threshold_major" {
  description = "Major threshold for errors detector"
  type        = number
  default     = 0
}

variable "errors_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "900s"
}

variable "errors_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# http_5xx_errors_rate detector

variable "http_5xx_errors_rate_notifications" {
  description = "Notification recipients list per severity overridden for http_5xx_errors_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "http_5xx_errors_rate_aggregation_function" {
  description = "Aggregation function and group by for http_5xx_errors_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "http_5xx_errors_rate_transformation_function" {
  description = "Transformation function for http_5xx_errors_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "http_5xx_errors_rate_max_delay" {
  description = "Enforce max delay for http_5xx_errors_rate detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "http_5xx_errors_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "http_5xx_errors_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "http_5xx_errors_rate_disabled" {
  description = "Disable all alerting rules for http_5xx_errors_rate detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_rate_disabled_critical" {
  description = "Disable critical alerting rule for http_5xx_errors_rate detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_rate_disabled_major" {
  description = "Disable major alerting rule for http_5xx_errors_rate detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_rate_threshold_critical" {
  description = "Critical threshold for http_5xx_errors_rate detector in %"
  type        = number
  default     = 20
}

variable "http_5xx_errors_rate_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "http_5xx_errors_rate_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "http_5xx_errors_rate_threshold_major" {
  description = "Major threshold for http_5xx_errors_rate detector in %"
  type        = number
  default     = 10
}

variable "http_5xx_errors_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "http_5xx_errors_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# high_connections_count detector

variable "high_connections_count_notifications" {
  description = "Notification recipients list per severity overridden for high_connections_count detector"
  type        = map(list(string))
  default     = {}
}

variable "high_connections_count_aggregation_function" {
  description = "Aggregation function and group by for high_connections_count detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "high_connections_count_transformation_function" {
  description = "Transformation function for high_connections_count detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "high_connections_count_max_delay" {
  description = "Enforce max delay for high_connections_count detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "high_connections_count_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "high_connections_count_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "high_connections_count_disabled" {
  description = "Disable all alerting rules for high_connections_count detector"
  type        = bool
  default     = null
}

variable "high_connections_count_disabled_critical" {
  description = "Disable critical alerting rule for high_connections_count detector"
  type        = bool
  default     = null
}

variable "high_connections_count_disabled_major" {
  description = "Disable major alerting rule for high_connections_count detector"
  type        = bool
  default     = null
}

variable "high_connections_count_threshold_critical" {
  description = "Critical threshold for high_connections_count detector"
  type        = number
  default     = 590
}

variable "high_connections_count_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "high_connections_count_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "high_connections_count_threshold_major" {
  description = "Major threshold for high_connections_count detector"
  type        = number
  default     = 550
}

variable "high_connections_count_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "high_connections_count_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# high_threads_count detector

variable "high_threads_count_notifications" {
  description = "Notification recipients list per severity overridden for high_threads_count detector"
  type        = map(list(string))
  default     = {}
}

variable "high_threads_count_aggregation_function" {
  description = "Aggregation function and group by for high_threads_count detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "high_threads_count_transformation_function" {
  description = "Transformation function for high_threads_count detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "high_threads_count_max_delay" {
  description = "Enforce max delay for high_threads_count detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "high_threads_count_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "high_threads_count_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "high_threads_count_disabled" {
  description = "Disable all alerting rules for high_threads_count detector"
  type        = bool
  default     = null
}

variable "high_threads_count_disabled_critical" {
  description = "Disable critical alerting rule for high_threads_count detector"
  type        = bool
  default     = null
}

variable "high_threads_count_disabled_major" {
  description = "Disable major alerting rule for high_threads_count detector"
  type        = bool
  default     = null
}

variable "high_threads_count_threshold_critical" {
  description = "Critical threshold for high_threads_count detector"
  type        = number
  default     = 510
}

variable "high_threads_count_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "high_threads_count_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "high_threads_count_threshold_major" {
  description = "Major threshold for high_threads_count detector"
  type        = number
  default     = 490
}

variable "high_threads_count_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "high_threads_count_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
