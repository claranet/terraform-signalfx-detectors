# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Notification recipients list for every detectors"
  type        = list(string)
}

variable "prefixes" {
  description = "Prefixes list to prepend between brackets on every monitors names before environment"
  type        = list(string)
  default     = []
}

variable "filter_custom_includes" {
  description = "List of tags to include when custom filtering is used"
  type        = list(string)
  default     = []
}

variable "filter_custom_excludes" {
  description = "List of tags to exclude when custom filtering is used"
  type        = list(string)
  default     = []
}

variable "detectors_disabled" {
  description = "Disable all detectors in this module"
  type        = bool
  default     = false
}

# api_result detectors

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

variable "api_result_disabled_warning" {
  description = "Disable warning alerting rule for api_result detector"
  type        = bool
  default     = null
}

variable "api_result_notifications" {
  description = "Notification recipients list for every alerting rules of api_result detector"
  type        = list(string)
  default     = []
}

variable "api_result_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of api_result detector"
  type        = list(string)
  default     = []
}

variable "api_result_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of api_result detector"
  type        = list(string)
  default     = []
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

variable "api_result_threshold_warning" {
  description = "Warning threshold for api_result detector"
  type        = number
  default     = 30
}

# api_latency detectors

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

variable "api_latency_disabled_warning" {
  description = "Disable warning alerting rule for api_latency detector"
  type        = bool
  default     = null
}

variable "api_latency_notifications" {
  description = "Notification recipients list for every alerting rules of api_latency detector"
  type        = list(string)
  default     = []
}

variable "api_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of api_latency detector"
  type        = list(string)
  default     = []
}

variable "api_latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of api_latency detector"
  type        = list(string)
  default     = []
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

variable "api_latency_threshold_warning" {
  description = "Warning threshold for api_latency detector"
  type        = number
  default     = 80
}
