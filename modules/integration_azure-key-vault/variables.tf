# Module specific

# api_result detector

variable "api_result_disabled" {
  description = "Disable all alerting rules for api_result detector"
  type        = bool
  default     = null
}

variable "api_result_disabled_critical" {
  description = "Disable critical alerting rule for api_result detector"
  type        = bool
  default     = null
}

variable "api_result_disabled_major" {
  description = "Disable major alerting rule for api_result detector"
  type        = bool
  default     = null
}

variable "api_result_notifications" {
  description = "Notification recipients list per severity overridden for api_result detector"
  type        = map(list(string))
  default     = {}
}

variable "api_result_aggregation_function" {
  description = "Aggregation function and group by for api_result detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "api_result_timer" {
  description = "Evaluation window for api_result detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "api_result_threshold_critical" {
  description = "Critical threshold for api_result detector"
  type        = number
  default     = 10
}

variable "api_result_threshold_major" {
  description = "Major threshold for api_result detector"
  type        = number
  default     = 30
}

# api_latency detector

variable "api_latency_disabled" {
  description = "Disable all alerting rules for api_latency detector"
  type        = bool
  default     = null
}

variable "api_latency_disabled_critical" {
  description = "Disable critical alerting rule for api_latency detector"
  type        = bool
  default     = null
}

variable "api_latency_disabled_major" {
  description = "Disable major alerting rule for api_latency detector"
  type        = bool
  default     = null
}

variable "api_latency_notifications" {
  description = "Notification recipients list per severity overridden for api_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "api_latency_aggregation_function" {
  description = "Aggregation function and group by for api_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "api_latency_timer" {
  description = "Evaluation window for api_latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "api_latency_threshold_critical" {
  description = "Critical threshold for api_latency detector"
  type        = number
  default     = 100
}

variable "api_latency_threshold_major" {
  description = "Major threshold for api_latency detector"
  type        = number
  default     = 80
}
