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
  description = "Timeframe for heartbeat detector (i.e. \"25m\"). Must be at least \"25m\" if exclude_not_running_vm is true"
  type        = string
  default     = "25m"
}

# database_4xx_request_rate detector

variable "database_4xx_request_rate_notifications" {
  description = "Notification recipients list per severity overridden for database_4xx_request_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "database_4xx_request_rate_aggregation_function" {
  description = "Aggregation function and group by for database_4xx_request_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['databasename', 'collectionname', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "database_4xx_request_rate_transformation_function" {
  description = "Transformation function for database_4xx_request_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "database_4xx_request_rate_max_delay" {
  description = "Enforce max delay for database_4xx_request_rate detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "database_4xx_request_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "database_4xx_request_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "database_4xx_request_rate_disabled" {
  description = "Disable all alerting rules for database_4xx_request_rate detector"
  type        = bool
  default     = null
}

variable "database_4xx_request_rate_disabled_critical" {
  description = "Disable critical alerting rule for database_4xx_request_rate detector"
  type        = bool
  default     = null
}

variable "database_4xx_request_rate_disabled_major" {
  description = "Disable major alerting rule for database_4xx_request_rate detector"
  type        = bool
  default     = null
}

variable "database_4xx_request_rate_threshold_critical" {
  description = "Critical threshold for database_4xx_request_rate detector in %"
  type        = number
  default     = 80
}

variable "database_4xx_request_rate_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "database_4xx_request_rate_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "database_4xx_request_rate_threshold_major" {
  description = "Major threshold for database_4xx_request_rate detector in %"
  type        = number
  default     = 50
}

variable "database_4xx_request_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "database_4xx_request_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# database_5xx_request_rate detector

variable "database_5xx_request_rate_notifications" {
  description = "Notification recipients list per severity overridden for database_5xx_request_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "database_5xx_request_rate_aggregation_function" {
  description = "Aggregation function and group by for database_5xx_request_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['databasename', 'collectionname', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "database_5xx_request_rate_transformation_function" {
  description = "Transformation function for database_5xx_request_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "database_5xx_request_rate_max_delay" {
  description = "Enforce max delay for database_5xx_request_rate detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "database_5xx_request_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "database_5xx_request_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "database_5xx_request_rate_disabled" {
  description = "Disable all alerting rules for database_5xx_request_rate detector"
  type        = bool
  default     = null
}

variable "database_5xx_request_rate_disabled_critical" {
  description = "Disable critical alerting rule for database_5xx_request_rate detector"
  type        = bool
  default     = null
}

variable "database_5xx_request_rate_disabled_major" {
  description = "Disable major alerting rule for database_5xx_request_rate detector"
  type        = bool
  default     = null
}

variable "database_5xx_request_rate_threshold_critical" {
  description = "Critical threshold for database_5xx_request_rate detector in %"
  type        = number
  default     = 80
}

variable "database_5xx_request_rate_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "database_5xx_request_rate_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "database_5xx_request_rate_threshold_major" {
  description = "Major threshold for database_5xx_request_rate detector in %"
  type        = number
  default     = 50
}

variable "database_5xx_request_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "database_5xx_request_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# scaling detector

variable "scaling_notifications" {
  description = "Notification recipients list per severity overridden for scaling detector"
  type        = map(list(string))
  default     = {}
}

variable "scaling_aggregation_function" {
  description = "Aggregation function and group by for scaling detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['databasename', 'collectionname', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "scaling_transformation_function" {
  description = "Transformation function for scaling detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "scaling_max_delay" {
  description = "Enforce max delay for scaling detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "scaling_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "scaling_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "scaling_disabled" {
  description = "Disable all alerting rules for scaling detector"
  type        = bool
  default     = null
}

variable "scaling_disabled_critical" {
  description = "Disable critical alerting rule for scaling detector"
  type        = bool
  default     = null
}

variable "scaling_disabled_major" {
  description = "Disable major alerting rule for scaling detector"
  type        = bool
  default     = null
}

variable "scaling_threshold_critical" {
  description = "Critical threshold for scaling detector in %"
  type        = number
  default     = 10
}

variable "scaling_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "scaling_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "scaling_threshold_major" {
  description = "Major threshold for scaling detector in %"
  type        = number
  default     = 5
}

variable "scaling_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "scaling_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# request_units_consumption detector

variable "request_units_consumption_notifications" {
  description = "Notification recipients list per severity overridden for request_units_consumption detector"
  type        = map(list(string))
  default     = {}
}

variable "request_units_consumption_aggregation_function" {
  description = "Aggregation function and group by for request_units_consumption detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['collectionname', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "request_units_consumption_transformation_function" {
  description = "Transformation function for request_units_consumption detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "request_units_consumption_max_delay" {
  description = "Enforce max delay for request_units_consumption detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "request_units_consumption_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "request_units_consumption_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "request_units_consumption_disabled" {
  description = "Disable all alerting rules for request_units_consumption detector"
  type        = bool
  default     = null
}

variable "request_units_consumption_disabled_critical" {
  description = "Disable critical alerting rule for request_units_consumption detector"
  type        = bool
  default     = null
}

variable "request_units_consumption_disabled_major" {
  description = "Disable major alerting rule for request_units_consumption detector"
  type        = bool
  default     = null
}

variable "request_units_consumption_threshold_critical" {
  description = "Critical threshold for request_units_consumption detector in %"
  type        = number
  default     = 90
}

variable "request_units_consumption_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "request_units_consumption_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "request_units_consumption_threshold_major" {
  description = "Major threshold for request_units_consumption detector in %"
  type        = number
  default     = 80
}

variable "request_units_consumption_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "request_units_consumption_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
