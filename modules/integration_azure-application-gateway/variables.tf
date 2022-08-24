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
  default     = ".mean(by=['subscription_id'])"
}

# Total_requests detector

variable "total_requests_max_delay" {
  description = "Enforce max delay for total_requests detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "total_requests_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "total_requests_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "total_requests_disabled" {
  description = "Disable all alerting rules for total_requests detector"
  type        = bool
  default     = null
}

variable "total_requests_disabled_critical" {
  description = "Disable critical alerting rule for total_requests detector"
  type        = bool
  default     = null
}

variable "total_requests_notifications" {
  description = "Notification recipients list per severity overridden for total_requests detector"
  type        = map(list(string))
  default     = {}
}

variable "total_requests_aggregation_function" {
  description = "Aggregation function and group by for total_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "total_requests_lasting_duration_critical" {
  description = "Evaluation window for total_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

# backend_connect_time detector

variable "backend_connect_time_max_delay" {
  description = "Enforce max delay for backend_connect_time detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "backend_connect_time_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "backend_connect_time_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "backend_connect_time_disabled" {
  description = "Disable all alerting rules for backend_connect_time detector"
  type        = bool
  default     = null
}

variable "backend_connect_time_disabled_critical" {
  description = "Disable critical alerting rule for backend_connect_time detector"
  type        = bool
  default     = null
}

variable "backend_connect_time_disabled_major" {
  description = "Disable major alerting rule for backend_connect_time detector"
  type        = bool
  default     = null
}

variable "backend_connect_time_notifications" {
  description = "Notification recipients list per severity overridden for backend_connect_time detector"
  type        = map(list(string))
  default     = {}
}

variable "backend_connect_time_aggregation_function" {
  description = "Aggregation function and group by for backend_connect_time detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region', 'backendhttpsetting', 'backendpool', 'backendserver'])"
}

variable "backend_connect_time_lasting_duration_critical" {
  description = "Evaluation window for backend_connect_time detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "backend_connect_time_threshold_critical" {
  description = "Critical threshold for backend_connect_time detector"
  type        = number
  default     = 50
}

variable "backend_connect_time_lasting_duration_major" {
  description = "Evaluation window for backend_connect_time detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "backend_connect_time_threshold_major" {
  description = "Major threshold for backend_connect_time detector"
  type        = number
  default     = 40
}

# Failed_requests detector

variable "failed_requests_max_delay" {
  description = "Enforce max delay for failed_requests detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "failed_requests_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "failed_requests_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "failed_requests_disabled" {
  description = "Disable all alerting rules for failed_requests detector"
  type        = bool
  default     = null
}

variable "failed_requests_disabled_critical" {
  description = "Disable critical alerting rule for failed_requests detector"
  type        = bool
  default     = null
}

variable "failed_requests_disabled_major" {
  description = "Disable major alerting rule for failed_requests detector"
  type        = bool
  default     = null
}

variable "failed_requests_notifications" {
  description = "Notification recipients list per severity overridden for failed_requests detector"
  type        = map(list(string))
  default     = {}
}

variable "failed_requests_aggregation_function" {
  description = "Aggregation function and group by for failed_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region', 'backendsettingspool'])"
}

variable "failed_requests_lasting_duration_critical" {
  description = "Evaluation window for failed_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "failed_requests_threshold_critical" {
  description = "Critical threshold for failed_requests detector"
  type        = number
  default     = 95
}

variable "failed_requests_lasting_duration_major" {
  description = "Evaluation window for failed_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "failed_requests_threshold_major" {
  description = "Major threshold for failed_requests detector"
  type        = number
  default     = 80
}

# Unhealthy_host_ratio detector

variable "unhealthy_host_ratio_max_delay" {
  description = "Enforce max delay for unhealthy_host_ratio detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "unhealthy_host_ratio_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "unhealthy_host_ratio_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "unhealthy_host_ratio_disabled" {
  description = "Disable all alerting rules for unhealthy_host_ratio detector"
  type        = bool
  default     = null
}

variable "unhealthy_host_ratio_disabled_critical" {
  description = "Disable critical alerting rule for unhealthy_host_ratio detector"
  type        = bool
  default     = null
}

variable "unhealthy_host_ratio_disabled_major" {
  description = "Disable major alerting rule for unhealthy_host_ratio detector"
  type        = bool
  default     = null
}

variable "unhealthy_host_ratio_notifications" {
  description = "Notification recipients list per severity overridden for unhealthy_host_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "unhealthy_host_ratio_aggregation_function" {
  description = "Aggregation function and group by for unhealthy_host_ratio detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region', 'backendsettingspool'])"
}

variable "unhealthy_host_ratio_lasting_duration_critical" {
  description = "Evaluation window for unhealthy_host_ratio detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "unhealthy_host_ratio_threshold_critical" {
  description = "Critical threshold for unhealthy_host_ratio detector"
  type        = number
  default     = 75
}

variable "unhealthy_host_ratio_lasting_duration_major" {
  description = "Evaluation window for unhealthy_host_ratio detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "unhealthy_host_ratio_threshold_major" {
  description = "Major threshold for unhealthy_host_ratio detector"
  type        = number
  default     = 50
}

# Http_4xx_errors detector

variable "http_4xx_errors_max_delay" {
  description = "Enforce max delay for http_4xx_errors detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "http_4xx_errors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "http_4xx_errors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "http_4xx_errors_disabled" {
  description = "Disable all alerting rules for http_4xx_errors detector"
  type        = bool
  default     = null
}

variable "http_4xx_errors_disabled_major" {
  description = "Disable major alerting rule for http_4xx_errors detector"
  type        = bool
  default     = null
}

variable "http_4xx_errors_disabled_minor" {
  description = "Disable minor alerting rule for http_4xx_errors detector"
  type        = bool
  default     = null
}

variable "http_4xx_errors_notifications" {
  description = "Notification recipients list per severity overridden for http_4xx_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "http_4xx_errors_aggregation_function" {
  description = "Aggregation function and group by for http_4xx_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "http_4xx_errors_lasting_duration_major" {
  description = "Evaluation window for http_4xx_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "http_4xx_errors_threshold_major" {
  description = "Major threshold for http_4xx_errors detector"
  type        = number
  default     = 95
}

variable "http_4xx_errors_lasting_duration_minor" {
  description = "Evaluation window for http_4xx_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "http_4xx_errors_threshold_minor" {
  description = "Minor threshold for http_4xx_errors detector"
  type        = number
  default     = 90
}

# Http_5xx_errors detector

variable "http_5xx_errors_max_delay" {
  description = "Enforce max delay for http_5xx_errors detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "http_5xx_errors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "http_5xx_errors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "http_5xx_errors_disabled" {
  description = "Disable all alerting rules for http_5xx_errors detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_disabled_critical" {
  description = "Disable critical alerting rule for http_5xx_errors detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_disabled_major" {
  description = "Disable major alerting rule for http_5xx_errors detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_notifications" {
  description = "Notification recipients list per severity overridden for http_5xx_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "http_5xx_errors_aggregation_function" {
  description = "Aggregation function and group by for http_5xx_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "http_5xx_errors_lasting_duration_critical" {
  description = "Evaluation window for http_5xx_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "http_5xx_errors_threshold_critical" {
  description = "Critical threshold for http_5xx_errors detector"
  type        = number
  default     = 95
}

variable "http_5xx_errors_lasting_duration_major" {
  description = "Evaluation window for http_5xx_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "http_5xx_errors_threshold_major" {
  description = "Major threshold for http_5xx_errors detector"
  type        = number
  default     = 80
}

# Backend_http_4xx_errors detector

variable "backend_http_4xx_errors_max_delay" {
  description = "Enforce max delay for backend_http_4xx_errors detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "backend_http_4xx_errors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "backend_http_4xx_errors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "backend_http_4xx_errors_disabled" {
  description = "Disable all alerting rules for backend_http_4xx_errors detector"
  type        = bool
  default     = null
}

variable "backend_http_4xx_errors_disabled_critical" {
  description = "Disable critical alerting rule for backend_http_4xx_errors detector"
  type        = bool
  default     = null
}

variable "backend_http_4xx_errors_disabled_major" {
  description = "Disable major alerting rule for backend_http_4xx_errors detector"
  type        = bool
  default     = null
}

variable "backend_http_4xx_errors_notifications" {
  description = "Notification recipients list per severity overridden for backend_http_4xx_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "backend_http_4xx_errors_aggregation_function" {
  description = "Aggregation function and group by for backend_http_4xx_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region', 'backendhttpsetting', 'backendpool', 'backendserver'])"
}

variable "backend_http_4xx_errors_lasting_duration_critical" {
  description = "Evaluation window for backend_http_4xx_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "backend_http_4xx_errors_threshold_critical" {
  description = "Critical threshold for backend_http_4xx_errors detector"
  type        = number
  default     = 95
}

variable "backend_http_4xx_errors_lasting_duration_major" {
  description = "Evaluation window for backend_http_4xx_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "backend_http_4xx_errors_threshold_major" {
  description = "Major threshold for backend_http_4xx_errors detector"
  type        = number
  default     = 80
}

# Backend_http_5xx_errors detector

variable "backend_http_5xx_errors_max_delay" {
  description = "Enforce max delay for backend_http_5xx_errors detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "backend_http_5xx_errors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "backend_http_5xx_errors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "backend_http_5xx_errors_disabled" {
  description = "Disable all alerting rules for backend_http_5xx_errors detector"
  type        = bool
  default     = null
}

variable "backend_http_5xx_errors_disabled_critical" {
  description = "Disable critical alerting rule for backend_http_5xx_errors detector"
  type        = bool
  default     = null
}

variable "backend_http_5xx_errors_disabled_major" {
  description = "Disable major alerting rule for backend_http_5xx_errors detector"
  type        = bool
  default     = null
}

variable "backend_http_5xx_errors_notifications" {
  description = "Notification recipients list per severity overridden for backend_http_5xx_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "backend_http_5xx_errors_aggregation_function" {
  description = "Aggregation function and group by for backend_http_5xx_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region', 'backendhttpsetting', 'backendpool', 'backendserver'])"
}

variable "backend_http_5xx_errors_lasting_duration_critical" {
  description = "Evaluation window for backend_http_5xx_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "backend_http_5xx_errors_threshold_critical" {
  description = "Critical threshold for backend_http_5xx_errors detector"
  type        = number
  default     = 95
}

variable "backend_http_5xx_errors_lasting_duration_major" {
  description = "Evaluation window for backend_http_5xx_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "backend_http_5xx_errors_threshold_major" {
  description = "Major threshold for backend_http_5xx_errors detector"
  type        = number
  default     = 80
}
