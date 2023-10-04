# Module specific

# Heartbeat detector

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

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "10m"
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

# Response_time detector

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

variable "response_time_lasting_duration_critical" {
  description = "Evaluation window for response_time detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "response_time_threshold_critical" {
  description = "Critical threshold for response_time detector"
  type        = number
  default     = 10
}

variable "response_time_lasting_duration_major" {
  description = "Evaluation window for response_time detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "response_time_threshold_major" {
  description = "Major threshold for response_time detector"
  type        = number
  default     = 5
}

# Memory_usage_count detector

variable "memory_usage_count_max_delay" {
  description = "Enforce max delay for memory_usage_count detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "memory_usage_count_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "memory_usage_count_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "memory_usage_count_disabled" {
  description = "Disable all alerting rules for memory_usage_count detector"
  type        = bool
  default     = null
}

variable "memory_usage_count_disabled_critical" {
  description = "Disable critical alerting rule for memory_usage_count detector"
  type        = bool
  default     = null
}

variable "memory_usage_count_disabled_major" {
  description = "Disable major alerting rule for memory_usage_count detector"
  type        = bool
  default     = null
}

variable "memory_usage_count_notifications" {
  description = "Notification recipients list per severity overridden for memory_usage_count detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_usage_count_aggregation_function" {
  description = "Aggregation function and group by for memory_usage_count detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "memory_usage_count_lasting_duration_critical" {
  description = "Evaluation window for memory_usage_count detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "memory_usage_count_threshold_critical" {
  description = "Critical threshold for memory_usage_count detector"
  type        = number
  default     = 1073741824 # 1Gb
}

variable "memory_usage_count_lasting_duration_major" {
  description = "Evaluation window for memory_usage_count detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "memory_usage_count_threshold_major" {
  description = "Major threshold for memory_usage_count detector"
  type        = number
  default     = 536870912 # 512Mb
}

# Http_5xx_errors_count detector

variable "http_5xx_errors_count_max_delay" {
  description = "Enforce max delay for http_5xx_errors_count detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "http_5xx_errors_count_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "http_5xx_errors_count_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "http_5xx_errors_count_disabled" {
  description = "Disable all alerting rules for http_5xx_errors_count detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_count_disabled_critical" {
  description = "Disable critical alerting rule for http_5xx_errors_count detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_count_disabled_major" {
  description = "Disable major alerting rule for http_5xx_errors_count detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_count_notifications" {
  description = "Notification recipients list per severity overridden for http_5xx_errors_count detector"
  type        = map(list(string))
  default     = {}
}

variable "http_5xx_errors_count_aggregation_function" {
  description = "Aggregation function and group by for http_5xx_errors_count detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "http_5xx_errors_count_lasting_duration_critical" {
  description = "Evaluation window for http_5xx_errors_count detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "http_5xx_errors_count_threshold_critical" {
  description = "Critical threshold for http_5xx_errors_count detector"
  type        = number
  default     = 90
}

variable "http_5xx_errors_count_lasting_duration_major" {
  description = "Evaluation window for http_5xx_errors_count detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "http_5xx_errors_count_threshold_major" {
  description = "Major threshold for http_5xx_errors_count detector"
  type        = number
  default     = 50
}

# http_4xx_errors_count detector

variable "http_4xx_errors_count_max_delay" {
  description = "Enforce max delay for http_4xx_errors_count detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "http_4xx_errors_count_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "http_4xx_errors_count_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "http_4xx_errors_count_disabled" {
  description = "Disable all alerting rules for http_4xx_errors_count detector"
  type        = bool
  default     = null
}

variable "http_4xx_errors_count_disabled_critical" {
  description = "Disable critical alerting rule for http_4xx_errors_count detector"
  type        = bool
  default     = true
}

variable "http_4xx_errors_count_disabled_major" {
  description = "Disable major alerting rule for http_4xx_errors_count detector"
  type        = bool
  default     = null
}

variable "http_4xx_errors_count_disabled_minor" {
  description = "Disable minor alerting rule for http_4xx_errors_count detector"
  type        = bool
  default     = null
}

variable "http_4xx_errors_count_notifications" {
  description = "Notification recipients list per severity overridden for http_4xx_errors_count detector"
  type        = map(list(string))
  default     = {}
}

variable "http_4xx_errors_count_aggregation_function" {
  description = "Aggregation function and group by for http_4xx_errors_count detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "http_4xx_errors_count_lasting_duration_critical" {
  description = "Evaluation window for http_4xx_errors_count detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "http_4xx_errors_count_threshold_critical" {
  description = "Critical threshold for http_4xx_errors_count detector"
  type        = number
  default     = 99
}

variable "http_4xx_errors_count_lasting_duration_major" {
  description = "Evaluation window for http_4xx_errors_count detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "http_4xx_errors_count_threshold_major" {
  description = "Major threshold for http_4xx_errors_count detector"
  type        = number
  default     = 95
}

variable "http_4xx_errors_count_lasting_duration_minor" {
  description = "Evaluation window for http_4xx_errors_count detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "http_4xx_errors_count_threshold_minor" {
  description = "Minor threshold for http_4xx_errors_count detector"
  type        = number
  default     = 90
}

# Http_success_status_rate detector

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

variable "http_success_status_rate_disabled_critical" {
  description = "Disable critical alerting rule for http_success_status_rate detector"
  type        = bool
  default     = null
}

variable "http_success_status_rate_disabled_major" {
  description = "Disable major alerting rule for http_success_status_rate detector"
  type        = bool
  default     = null
}

variable "http_success_status_rate_notifications" {
  description = "Notification recipients list per severity overridden for http_success_status_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "http_success_status_rate_aggregation_function" {
  description = "Aggregation function and group by for http_success_status_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "http_success_status_rate_lasting_duration_critical" {
  description = "Evaluation window for http_success_status_rate detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "http_success_status_rate_threshold_critical" {
  description = "Critical threshold for http_success_status_rate detector"
  type        = number
  default     = 10
}

variable "http_success_status_rate_lasting_duration_major" {
  description = "Evaluation window for http_success_status_rate detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "http_success_status_rate_threshold_major" {
  description = "Major threshold for http_success_status_rate detector"
  type        = number
  default     = 30
}
