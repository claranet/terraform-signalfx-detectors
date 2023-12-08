# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['EntityName', 'azure_resource_name', 'azure_resource_group_name'])"
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

# deadlettered_messages detector

variable "deadlettered_messages_notifications" {
  description = "Notification recipients list per severity overridden for deadlettered_messages detector"
  type        = map(list(string))
  default     = {}
}

variable "deadlettered_messages_aggregation_function" {
  description = "Aggregation function and group by for deadlettered_messages detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['EntityName', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "deadlettered_messages_transformation_function" {
  description = "Transformation function for deadlettered_messages detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "deadlettered_messages_max_delay" {
  description = "Enforce max delay for deadlettered_messages detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "deadlettered_messages_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "deadlettered_messages_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "deadlettered_messages_disabled" {
  description = "Disable all alerting rules for deadlettered_messages detector"
  type        = bool
  default     = null
}

variable "deadlettered_messages_disabled_critical" {
  description = "Disable critical alerting rule for deadlettered_messages detector"
  type        = bool
  default     = null
}

variable "deadlettered_messages_disabled_major" {
  description = "Disable major alerting rule for deadlettered_messages detector"
  type        = bool
  default     = null
}

variable "deadlettered_messages_threshold_critical" {
  description = "Critical threshold for deadlettered_messages detector"
  type        = number
  default     = 10
}

variable "deadlettered_messages_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "deadlettered_messages_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "deadlettered_messages_threshold_major" {
  description = "Major threshold for deadlettered_messages detector"
  type        = number
  default     = 0
}

variable "deadlettered_messages_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "deadlettered_messages_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# user_errors detector

variable "user_errors_notifications" {
  description = "Notification recipients list per severity overridden for user_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "user_errors_aggregation_function" {
  description = "Aggregation function and group by for user_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['EntityName', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "user_errors_transformation_function" {
  description = "Transformation function for user_errors detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "user_errors_max_delay" {
  description = "Enforce max delay for user_errors detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "user_errors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "user_errors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "user_errors_disabled" {
  description = "Disable all alerting rules for user_errors detector"
  type        = bool
  default     = null
}

variable "user_errors_disabled_critical" {
  description = "Disable critical alerting rule for user_errors detector"
  type        = bool
  default     = null
}

variable "user_errors_disabled_major" {
  description = "Disable major alerting rule for user_errors detector"
  type        = bool
  default     = null
}

variable "user_errors_threshold_critical" {
  description = "Critical threshold for user_errors detector"
  type        = number
  default     = 90
}

variable "user_errors_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "user_errors_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "user_errors_threshold_major" {
  description = "Major threshold for user_errors detector"
  type        = number
  default     = 50
}

variable "user_errors_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "user_errors_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# server_errors detector

variable "server_errors_notifications" {
  description = "Notification recipients list per severity overridden for server_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "server_errors_aggregation_function" {
  description = "Aggregation function and group by for server_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['EntityName', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "server_errors_transformation_function" {
  description = "Transformation function for server_errors detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "server_errors_max_delay" {
  description = "Enforce max delay for server_errors detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "server_errors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "server_errors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "server_errors_disabled" {
  description = "Disable all alerting rules for server_errors detector"
  type        = bool
  default     = null
}

variable "server_errors_disabled_critical" {
  description = "Disable critical alerting rule for server_errors detector"
  type        = bool
  default     = null
}

variable "server_errors_disabled_major" {
  description = "Disable major alerting rule for server_errors detector"
  type        = bool
  default     = null
}

variable "server_errors_threshold_critical" {
  description = "Critical threshold for server_errors detector"
  type        = number
  default     = 90
}

variable "server_errors_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "server_errors_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "server_errors_threshold_major" {
  description = "Major threshold for server_errors detector"
  type        = number
  default     = 50
}

variable "server_errors_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "server_errors_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# throttled_requests detector

variable "throttled_requests_notifications" {
  description = "Notification recipients list per severity overridden for throttled_requests detector"
  type        = map(list(string))
  default     = {}
}

variable "throttled_requests_aggregation_function" {
  description = "Aggregation function and group by for throttled_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "throttled_requests_transformation_function" {
  description = "Transformation function for throttled_requests detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "throttled_requests_max_delay" {
  description = "Enforce max delay for throttled_requests detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "throttled_requests_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "throttled_requests_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "throttled_requests_disabled" {
  description = "Disable all alerting rules for throttled_requests detector"
  type        = bool
  default     = null
}

variable "throttled_requests_disabled_critical" {
  description = "Disable critical alerting rule for throttled_requests detector"
  type        = bool
  default     = null
}

variable "throttled_requests_disabled_major" {
  description = "Disable major alerting rule for throttled_requests detector"
  type        = bool
  default     = null
}

variable "throttled_requests_threshold_critical" {
  description = "Critical threshold for throttled_requests detector"
  type        = number
  default     = 90
}

variable "throttled_requests_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "throttled_requests_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "throttled_requests_threshold_major" {
  description = "Major threshold for throttled_requests detector"
  type        = number
  default     = 80
}

variable "throttled_requests_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "throttled_requests_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# active_connections detector

variable "active_connections_notifications" {
  description = "Notification recipients list per severity overridden for active_connections detector"
  type        = map(list(string))
  default     = {}
}

variable "active_connections_aggregation_function" {
  description = "Aggregation function and group by for active_connections detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "active_connections_transformation_function" {
  description = "Transformation function for active_connections detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "active_connections_max_delay" {
  description = "Enforce max delay for active_connections detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "active_connections_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "active_connections_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "active_connections_disabled" {
  description = "Disable all alerting rules for active_connections detector"
  type        = bool
  default     = null
}

variable "active_connections_threshold_critical" {
  description = "Critical threshold for active_connections detector"
  type        = number
  default     = 1
}

variable "active_connections_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "active_connections_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
