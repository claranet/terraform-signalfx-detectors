# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Notification recipients list for every detectors"
  type        = list
}

variable "prefixes" {
  description = "Prefixes list to prepend between brackets on every monitors names before environment"
  type        = list
  default     = []
}

variable "filter_custom_includes" {
  description = "List of tags to include when custom filtering is used"
  type        = list
  default     = []
}

variable "filter_custom_excludes" {
  description = "List of tags to exclude when custom filtering is used"
  type        = list
  default     = []
}

variable "detectors_disabled" {
  description = "Disable all detectors in this module"
  type        = bool
  default     = false
}

# Azure virtual machine detectors specific

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_notifications" {
  description = "Notification recipients list for every alerting rules of heartbeat detector"
  type        = list
  default     = []
}

variable "heartbeat_timeframe" {
  description = "Timeframe for system not reporting detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

# CPU_usage detectors

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

variable "cpu_usage_disabled_warning" {
  description = "Disable warning alerting rule for cpu_usage detector"
  type        = bool
  default     = null
}

variable "cpu_usage_notifications" {
  description = "Notification recipients list for every alerting rules of cpu_usage detector"
  type        = list
  default     = []
}

variable "cpu_usage_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of cpu_usage detector"
  type        = list
  default     = []
}

variable "cpu_usage_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of cpu_usage detector"
  type        = list
  default     = []
}

variable "cpu_usage_aggregation_function" {
  description = "Aggregation function and group by for cpu_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "cpu_usage_transformation_function" {
  description = "Transformation function for cpu_usage detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "cpu_usage_transformation_window" {
  description = "Transformation window for cpu_usage detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "cpu_usage_threshold_critical" {
  description = "Critical threshold for cpu_usage detector"
  type        = number
  default     = 90
}

variable "cpu_usage_threshold_warning" {
  description = "Warning threshold for cpu_usage detector"
  type        = number
  default     = 80
}

# Credit_cpu detectors

variable "credit_cpu_disabled" {
  description = "Disable all alerting rules for credit_cpu detector"
  type        = bool
  default     = null
}

variable "credit_cpu_disabled_critical" {
  description = "Disable critical alerting rule for credit_cpu detector"
  type        = bool
  default     = null
}

variable "credit_cpu_disabled_warning" {
  description = "Disable warning alerting rule for credit_cpu detector"
  type        = bool
  default     = null
}

variable "credit_cpu_notifications" {
  description = "Notification recipients list for every alerting rules of credit_cpu detector"
  type        = list
  default     = []
}

variable "credit_cpu_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of credit_cpu detector"
  type        = list
  default     = []
}

variable "credit_cpu_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of credit_cpu detector"
  type        = list
  default     = []
}

variable "credit_cpu_aggregation_function" {
  description = "Aggregation function and group by for credit_cpu detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "credit_cpu_transformation_function" {
  description = "Transformation function for credit_cpu detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "credit_cpu_transformation_window" {
  description = "Transformation window for credit_cpu detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "credit_cpu_threshold_critical" {
  description = "Critical threshold for credit_cpu detector"
  type        = number
  default     = 15
}

variable "credit_cpu_threshold_warning" {
  description = "Warning threshold for credit_cpu detector"
  type        = number
  default     = 30
}

# RAM_reserved detectors

variable "ram_reserved_disabled" {
  description = "Disable all alerting rules for ram_reserved detector"
  type        = bool
  default     = null
}

variable "ram_reserved_disabled_critical" {
  description = "Disable critical alerting rule for ram_reserved detector"
  type        = bool
  default     = null
}

variable "ram_reserved_disabled_warning" {
  description = "Disable warning alerting rule for ram_reserved detector"
  type        = bool
  default     = null
}

variable "ram_reserved_notifications" {
  description = "Notification recipients list for every alerting rules of ram_reserved detector"
  type        = list
  default     = []
}

variable "ram_reserved_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of ram_reserved detector"
  type        = list
  default     = []
}

variable "ram_reserved_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of ram_reserved detector"
  type        = list
  default     = []
}

variable "ram_reserved_aggregation_function" {
  description = "Aggregation function and group by for ram_reserved detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "ram_reserved_transformation_function" {
  description = "Transformation function for ram_reserved detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "ram_reserved_transformation_window" {
  description = "Transformation window for ram_reserved detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "ram_reserved_threshold_critical" {
  description = "Critical threshold for ram_reserved detector"
  type        = number
  default     = 95
}

variable "ram_reserved_threshold_warning" {
  description = "Warning threshold for ram_reserved detector"
  type        = number
  default     = 90
}

# Http_success_status_rate detectors

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

variable "http_success_status_rate_disabled_warning" {
  description = "Disable warning alerting rule for http_success_status_rate detector"
  type        = bool
  default     = null
}

variable "http_success_status_rate_notifications" {
  description = "Notification recipients list for every alerting rules of http_success_status_rate detector"
  type        = list
  default     = []
}

variable "http_success_status_rate_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of http_success_status_rate detector"
  type        = list
  default     = []
}

variable "http_success_status_rate_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of http_success_status_rate detector"
  type        = list
  default     = []
}

variable "http_success_status_rate_aggregation_function" {
  description = "Aggregation function and group by for http_success_status_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "http_success_status_rate_transformation_function" {
  description = "Transformation function for http_success_status_rate detector (mean, min, max)"
  type        = string
  default     = "max"
}

variable "http_success_status_rate_transformation_window" {
  description = "Transformation window for http_success_status_rate detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "http_success_status_rate_threshold_critical" {
  description = "Critical threshold for http_success_status_rate detector"
  type        = number
  default     = 10
}

variable "http_success_status_rate_threshold_warning" {
  description = "Warning threshold for http_success_status_rate detector"
  type        = number
  default     = 30
}

# Status detectors

variable "status_disabled" {
  description = "Disable all alerting rules for status detector"
  type        = bool
  default     = null
}

variable "status_disabled_critical" {
  description = "Disable critical alerting rule for status detector"
  type        = bool
  default     = null
}

variable "status_disabled_warning" {
  description = "Disable warning alerting rule for status detector"
  type        = bool
  default     = null
}

variable "status_notifications" {
  description = "Notification recipients list for every alerting rules of status detector"
  type        = list
  default     = []
}

variable "status_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of status detector"
  type        = list
  default     = []
}

variable "status_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of status detector"
  type        = list
  default     = []
}

variable "status_aggregation_function" {
  description = "Aggregation function and group by for status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "status_transformation_function" {
  description = "Transformation function for status detector (mean, min, max)"
  type        = string
  default     = "max"
}

variable "status_transformation_window" {
  description = "Transformation window for status detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "status_threshold_critical" {
  description = "Critical threshold for status detector"
  type        = number
  default     = 1
}

variable "status_threshold_warning" {
  description = "Warning threshold for status detector"
  type        = number
  default     = 1
}
