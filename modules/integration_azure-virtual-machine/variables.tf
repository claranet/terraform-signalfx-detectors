# Module specific

# Heartbeat detector

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
  default     = "20m"
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_id'])"
}

# CPU_usage detector

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

variable "cpu_usage_notifications" {
  description = "Notification recipients list per severity overridden for cpu_usage detector"
  type        = map(list(string))
  default     = {}
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

variable "cpu_usage_threshold_major" {
  description = "Major threshold for cpu_usage detector"
  type        = number
  default     = 80
}

# Credit_cpu detector

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

variable "credit_cpu_disabled_major" {
  description = "Disable major alerting rule for credit_cpu detector"
  type        = bool
  default     = null
}

variable "credit_cpu_notifications" {
  description = "Notification recipients list per severity overridden for credit_cpu detector"
  type        = map(list(string))
  default     = {}
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

variable "credit_cpu_threshold_major" {
  description = "Major threshold for credit_cpu detector"
  type        = number
  default     = 30
}
