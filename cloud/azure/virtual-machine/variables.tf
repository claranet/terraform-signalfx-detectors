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

# Azure virtual machine detectors specific

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_notifications" {
  description = "Notification recipients list for every alerting rules of heartbeat detector"
  type        = list(string)
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
  type        = list(string)
  default     = []
}

variable "cpu_usage_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of cpu_usage detector"
  type        = list(string)
  default     = []
}

variable "cpu_usage_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of cpu_usage detector"
  type        = list(string)
  default     = []
}

variable "cpu_usage_aggregation_function" {
  description = "Aggregation function and group by for cpu_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "cpu_usage_timer" {
  description = "Evaluation window for cpu_usage detector (i.e. 5m, 20m, 1h, 1d)"
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
  type        = list(string)
  default     = []
}

variable "credit_cpu_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of credit_cpu detector"
  type        = list(string)
  default     = []
}

variable "credit_cpu_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of credit_cpu detector"
  type        = list(string)
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

variable "credit_cpu_timer" {
  description = "Evaluation window for credit_cpu detector (i.e. 5m, 20m, 1h, 1d)"
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
