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

# cpu_usage detector

variable "cpu_usage_notifications" {
  description = "Notification recipients list per severity overridden for cpu_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_usage_aggregation_function" {
  description = "Aggregation function and group by for cpu_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_usage_transformation_function" {
  description = "Transformation function for cpu_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "cpu_usage_max_delay" {
  description = "Enforce max delay for cpu_usage detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cpu_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cpu_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cpu_usage_disabled" {
  description = "Disable all alerting rules for cpu_usage detector"
  type        = bool
  default     = null
}

variable "cpu_usage_disabled_critical" {
  description = "Disable critical alerting rule for cpu_usage detector"
  type        = bool
  default     = null
}

variable "cpu_usage_disabled_major" {
  description = "Disable major alerting rule for cpu_usage detector"
  type        = bool
  default     = null
}

variable "cpu_usage_threshold_critical" {
  description = "Critical threshold for cpu_usage detector in %"
  type        = number
  default     = 95
}

variable "cpu_usage_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cpu_usage_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cpu_usage_threshold_major" {
  description = "Major threshold for cpu_usage detector in %"
  type        = number
  default     = 90
}

variable "cpu_usage_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cpu_usage_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# connection_refused_to_sql_ratio detector

variable "connection_refused_to_sql_ratio_notifications" {
  description = "Notification recipients list per severity overridden for connection_refused_to_sql_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "connection_refused_to_sql_ratio_aggregation_function" {
  description = "Aggregation function and group by for connection_refused_to_sql_ratio detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "connection_refused_to_sql_ratio_transformation_function" {
  description = "Transformation function for connection_refused_to_sql_ratio detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "connection_refused_to_sql_ratio_max_delay" {
  description = "Enforce max delay for connection_refused_to_sql_ratio detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "connection_refused_to_sql_ratio_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "connection_refused_to_sql_ratio_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "connection_refused_to_sql_ratio_disabled" {
  description = "Disable all alerting rules for connection_refused_to_sql_ratio detector"
  type        = bool
  default     = null
}

variable "connection_refused_to_sql_ratio_disabled_critical" {
  description = "Disable critical alerting rule for connection_refused_to_sql_ratio detector"
  type        = bool
  default     = null
}

variable "connection_refused_to_sql_ratio_disabled_major" {
  description = "Disable major alerting rule for connection_refused_to_sql_ratio detector"
  type        = bool
  default     = null
}

variable "connection_refused_to_sql_ratio_threshold_critical" {
  description = "Critical threshold for connection_refused_to_sql_ratio detector in %"
  type        = number
  default     = 5
}

variable "connection_refused_to_sql_ratio_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1h"
}

variable "connection_refused_to_sql_ratio_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.5
}
variable "connection_refused_to_sql_ratio_threshold_major" {
  description = "Major threshold for connection_refused_to_sql_ratio detector in %"
  type        = number
  default     = 0
}

variable "connection_refused_to_sql_ratio_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1h"
}

variable "connection_refused_to_sql_ratio_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.5
}
# error_rate_5xx detector

variable "error_rate_5xx_notifications" {
  description = "Notification recipients list per severity overridden for error_rate_5xx detector"
  type        = map(list(string))
  default     = {}
}

variable "error_rate_5xx_aggregation_function" {
  description = "Aggregation function and group by for error_rate_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['forwarding_rule_name', 'backend_target_name', 'backend_target_type'])"
}

variable "error_rate_5xx_transformation_function" {
  description = "Transformation function for error_rate_5xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "error_rate_5xx_max_delay" {
  description = "Enforce max delay for error_rate_5xx detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "error_rate_5xx_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "error_rate_5xx_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "error_rate_5xx_disabled" {
  description = "Disable all alerting rules for error_rate_5xx detector"
  type        = bool
  default     = null
}

variable "error_rate_5xx_disabled_critical" {
  description = "Disable critical alerting rule for error_rate_5xx detector"
  type        = bool
  default     = null
}

variable "error_rate_5xx_disabled_major" {
  description = "Disable major alerting rule for error_rate_5xx detector"
  type        = bool
  default     = null
}

variable "error_rate_5xx_threshold_critical" {
  description = "Critical threshold for error_rate_5xx detector in %"
  type        = number
  default     = 10
}

variable "error_rate_5xx_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "error_rate_5xx_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "error_rate_5xx_threshold_major" {
  description = "Major threshold for error_rate_5xx detector in %"
  type        = number
  default     = 5
}

variable "error_rate_5xx_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "error_rate_5xx_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
