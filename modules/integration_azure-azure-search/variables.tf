# Module specific

# Search_latency detector

variable "search_latency_max_delay" {
  description = "Enforce max delay for search_latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "search_latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "search_latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "search_latency_disabled" {
  description = "Disable all alerting rules for search_latency detector"
  type        = bool
  default     = null
}

variable "search_latency_disabled_critical" {
  description = "Disable critical alerting rule for search_latency detector"
  type        = bool
  default     = null
}

variable "search_latency_disabled_major" {
  description = "Disable major alerting rule for search_latency detector"
  type        = bool
  default     = null
}

variable "search_latency_notifications" {
  description = "Notification recipients list per severity overridden for search_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "search_latency_aggregation_function" {
  description = "Aggregation function and group by for search_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "search_latency_lasting_duration_critical" {
  description = "Evaluation window for search_latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "search_latency_threshold_critical" {
  description = "Critical threshold for search_latency detector"
  type        = number
  default     = 4
}

variable "search_latency_lasting_duration_major" {
  description = "Evaluation window for search_latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "search_latency_threshold_major" {
  description = "Major threshold for search_latency detector"
  type        = number
  default     = 2
}

# search_throttled_queries_rate detector

variable "search_throttled_queries_rate_max_delay" {
  description = "Enforce max delay for search_throttled_queries_rate detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "search_throttled_queries_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "search_throttled_queries_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "search_throttled_queries_rate_disabled" {
  description = "Disable all alerting rules for search_throttled_queries_rate detector"
  type        = bool
  default     = null
}

variable "search_throttled_queries_rate_disabled_critical" {
  description = "Disable critical alerting rule for search_throttled_queries_rate detector"
  type        = bool
  default     = null
}

variable "search_throttled_queries_rate_disabled_major" {
  description = "Disable major alerting rule for search_throttled_queries_rate detector"
  type        = bool
  default     = null
}

variable "search_throttled_queries_rate_notifications" {
  description = "Notification recipients list per severity overridden for search_throttled_queries_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "search_throttled_queries_rate_aggregation_function" {
  description = "Aggregation function and group by for search_throttled_queries_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "search_throttled_queries_rate_lasting_duration_critical" {
  description = "Evaluation window for search_throttled_queries_rate detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "search_throttled_queries_rate_threshold_critical" {
  description = "Critical threshold for search_throttled_queries_rate detector"
  type        = number
  default     = 50
}

variable "search_throttled_queries_rate_lasting_duration_major" {
  description = "Evaluation window for search_throttled_queries_rate detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "search_throttled_queries_rate_threshold_major" {
  description = "Major threshold for search_throttled_queries_rate detector"
  type        = number
  default     = 20
}
