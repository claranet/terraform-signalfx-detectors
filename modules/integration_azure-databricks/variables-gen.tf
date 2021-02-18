# spark_jvm_heap_usage detector

variable "spark_jvm_heap_usage_notifications" {
  description = "Notification recipients list per severity overridden for spark_jvm_heap_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "spark_jvm_heap_usage_aggregation_function" {
  description = "Aggregation function and group by for spark_jvm_heap_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_id', 'host'])"
}

variable "spark_jvm_heap_usage_transformation_function" {
  description = "Transformation function for spark_jvm_heap_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "spark_jvm_heap_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "spark_jvm_heap_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "spark_jvm_heap_usage_disabled" {
  description = "Disable all alerting rules for spark_jvm_heap_usage detector"
  type        = bool
  default     = null
}

variable "spark_jvm_heap_usage_disabled_critical" {
  description = "Disable critical alerting rule for spark_jvm_heap_usage detector"
  type        = bool
  default     = null
}

variable "spark_jvm_heap_usage_disabled_major" {
  description = "Disable major alerting rule for spark_jvm_heap_usage detector"
  type        = bool
  default     = null
}

variable "spark_jvm_heap_usage_threshold_critical" {
  description = "Critical threshold for spark_jvm_heap_usage detector in %"
  type        = number
  default     = 90
}

variable "spark_jvm_heap_usage_threshold_major" {
  description = "Major threshold for spark_jvm_heap_usage detector in %"
  type        = number
  default     = 80
}

# spark_jvm_heap_old_usage detector

variable "spark_jvm_heap_old_usage_notifications" {
  description = "Notification recipients list per severity overridden for spark_jvm_heap_old_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "spark_jvm_heap_old_usage_aggregation_function" {
  description = "Aggregation function and group by for spark_jvm_heap_old_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_id', 'host'])"
}

variable "spark_jvm_heap_old_usage_transformation_function" {
  description = "Transformation function for spark_jvm_heap_old_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "spark_jvm_heap_old_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "spark_jvm_heap_old_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "spark_jvm_heap_old_usage_disabled" {
  description = "Disable all alerting rules for spark_jvm_heap_old_usage detector"
  type        = bool
  default     = null
}

variable "spark_jvm_heap_old_usage_disabled_critical" {
  description = "Disable critical alerting rule for spark_jvm_heap_old_usage detector"
  type        = bool
  default     = null
}

variable "spark_jvm_heap_old_usage_disabled_major" {
  description = "Disable major alerting rule for spark_jvm_heap_old_usage detector"
  type        = bool
  default     = null
}

variable "spark_jvm_heap_old_usage_threshold_critical" {
  description = "Critical threshold for spark_jvm_heap_old_usage detector in %"
  type        = number
  default     = 90
}

variable "spark_jvm_heap_old_usage_threshold_major" {
  description = "Major threshold for spark_jvm_heap_old_usage detector in %"
  type        = number
  default     = 80
}

