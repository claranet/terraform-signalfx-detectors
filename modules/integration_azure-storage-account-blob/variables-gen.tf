# requests_error_rate detector

variable "requests_error_rate_notifications" {
  description = "Notification recipients list per severity overridden for requests_error_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "requests_error_rate_aggregation_function" {
  description = "Aggregation function and group by for requests_error_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "requests_error_rate_transformation_function" {
  description = "Transformation function for requests_error_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "requests_error_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "requests_error_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "requests_error_rate_disabled" {
  description = "Disable all alerting rules for requests_error_rate detector"
  type        = bool
  default     = true
}

variable "requests_error_rate_disabled_critical" {
  description = "Disable critical alerting rule for requests_error_rate detector"
  type        = bool
  default     = null
}

variable "requests_error_rate_disabled_major" {
  description = "Disable major alerting rule for requests_error_rate detector"
  type        = bool
  default     = null
}

variable "requests_error_rate_threshold_critical" {
  description = "Critical threshold for requests_error_rate detector in %"
  type        = number
  default     = 90
}

variable "requests_error_rate_threshold_major" {
  description = "Major threshold for requests_error_rate detector in %"
  type        = number
  default     = 80
}

# latency_e2e detector

variable "latency_e2e_notifications" {
  description = "Notification recipients list per severity overridden for latency_e2e detector"
  type        = map(list(string))
  default     = {}
}

variable "latency_e2e_aggregation_function" {
  description = "Aggregation function and group by for latency_e2e detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "latency_e2e_transformation_function" {
  description = "Transformation function for latency_e2e detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "latency_e2e_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "latency_e2e_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "latency_e2e_disabled" {
  description = "Disable all alerting rules for latency_e2e detector"
  type        = bool
  default     = true
}

variable "latency_e2e_disabled_critical" {
  description = "Disable critical alerting rule for latency_e2e detector"
  type        = bool
  default     = null
}

variable "latency_e2e_disabled_major" {
  description = "Disable major alerting rule for latency_e2e detector"
  type        = bool
  default     = null
}

variable "latency_e2e_threshold_critical" {
  description = "Critical threshold for latency_e2e detector in s"
  type        = number
  default     = 20
}

variable "latency_e2e_threshold_major" {
  description = "Major threshold for latency_e2e detector in s"
  type        = number
  default     = 10
}

