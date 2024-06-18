# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['EnvironmentName'])"
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

# health detector

variable "health_notifications" {
  description = "Notification recipients list per severity overridden for health detector"
  type        = map(list(string))
  default     = {}
}

variable "health_aggregation_function" {
  description = "Aggregation function and group by for health detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "health_transformation_function" {
  description = "Transformation function for health detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "health_max_delay" {
  description = "Enforce max delay for health detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "health_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "health_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "health_disabled" {
  description = "Disable all alerting rules for health detector"
  type        = bool
  default     = null
}

variable "health_disabled_critical" {
  description = "Disable critical alerting rule for health detector"
  type        = bool
  default     = null
}

variable "health_disabled_major" {
  description = "Disable major alerting rule for health detector"
  type        = bool
  default     = null
}

variable "health_threshold_critical" {
  description = "Critical threshold for health detector"
  type        = number
  default     = 20
}

variable "health_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "health_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "health_threshold_major" {
  description = "Major threshold for health detector"
  type        = number
  default     = 15
}

variable "health_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "health_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# latency_p90 detector

variable "latency_p90_notifications" {
  description = "Notification recipients list per severity overridden for latency_p90 detector"
  type        = map(list(string))
  default     = {}
}

variable "latency_p90_aggregation_function" {
  description = "Aggregation function and group by for latency_p90 detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "latency_p90_transformation_function" {
  description = "Transformation function for latency_p90 detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "latency_p90_max_delay" {
  description = "Enforce max delay for latency_p90 detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "latency_p90_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "latency_p90_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "latency_p90_disabled" {
  description = "Disable all alerting rules for latency_p90 detector"
  type        = bool
  default     = null
}

variable "latency_p90_disabled_critical" {
  description = "Disable critical alerting rule for latency_p90 detector"
  type        = bool
  default     = null
}

variable "latency_p90_disabled_major" {
  description = "Disable major alerting rule for latency_p90 detector"
  type        = bool
  default     = null
}

variable "latency_p90_threshold_critical" {
  description = "Critical threshold for latency_p90 detector"
  type        = number
  default     = 0.5
}

variable "latency_p90_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "latency_p90_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "latency_p90_threshold_major" {
  description = "Major threshold for latency_p90 detector"
  type        = number
  default     = 0.3
}

variable "latency_p90_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "latency_p90_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# app_5xx_error_rate detector

variable "app_5xx_error_rate_notifications" {
  description = "Notification recipients list per severity overridden for app_5xx_error_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "app_5xx_error_rate_aggregation_function" {
  description = "Aggregation function and group by for app_5xx_error_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "app_5xx_error_rate_transformation_function" {
  description = "Transformation function for app_5xx_error_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".sum(over='15m')"
}

variable "app_5xx_error_rate_max_delay" {
  description = "Enforce max delay for app_5xx_error_rate detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "app_5xx_error_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "app_5xx_error_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "app_5xx_error_rate_disabled" {
  description = "Disable all alerting rules for app_5xx_error_rate detector"
  type        = bool
  default     = null
}

variable "app_5xx_error_rate_disabled_critical" {
  description = "Disable critical alerting rule for app_5xx_error_rate detector"
  type        = bool
  default     = null
}

variable "app_5xx_error_rate_disabled_major" {
  description = "Disable major alerting rule for app_5xx_error_rate detector"
  type        = bool
  default     = null
}

variable "app_5xx_error_rate_threshold_critical" {
  description = "Critical threshold for app_5xx_error_rate detector"
  type        = number
  default     = 5
}

variable "app_5xx_error_rate_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "app_5xx_error_rate_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "app_5xx_error_rate_threshold_major" {
  description = "Major threshold for app_5xx_error_rate detector"
  type        = number
  default     = 3
}

variable "app_5xx_error_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "app_5xx_error_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# root_filesystem_usage detector

variable "root_filesystem_usage_notifications" {
  description = "Notification recipients list per severity overridden for root_filesystem_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "root_filesystem_usage_aggregation_function" {
  description = "Aggregation function and group by for root_filesystem_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "root_filesystem_usage_transformation_function" {
  description = "Transformation function for root_filesystem_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "root_filesystem_usage_max_delay" {
  description = "Enforce max delay for root_filesystem_usage detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "root_filesystem_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "root_filesystem_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "root_filesystem_usage_disabled" {
  description = "Disable all alerting rules for root_filesystem_usage detector"
  type        = bool
  default     = null
}

variable "root_filesystem_usage_disabled_critical" {
  description = "Disable critical alerting rule for root_filesystem_usage detector"
  type        = bool
  default     = null
}

variable "root_filesystem_usage_disabled_major" {
  description = "Disable major alerting rule for root_filesystem_usage detector"
  type        = bool
  default     = null
}

variable "root_filesystem_usage_threshold_critical" {
  description = "Critical threshold for root_filesystem_usage detector"
  type        = number
  default     = 90
}

variable "root_filesystem_usage_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "root_filesystem_usage_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "root_filesystem_usage_threshold_major" {
  description = "Major threshold for root_filesystem_usage detector"
  type        = number
  default     = 80
}

variable "root_filesystem_usage_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "root_filesystem_usage_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
