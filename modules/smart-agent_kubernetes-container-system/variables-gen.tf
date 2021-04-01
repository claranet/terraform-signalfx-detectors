# container_cpu_usage detector

variable "container_cpu_usage_notifications" {
  description = "Notification recipients list per severity overridden for container_cpu_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "container_cpu_usage_aggregation_function" {
  description = "Aggregation function and group by for container_cpu_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_pod_name','kubernetes_namespace'])"
}

variable "container_cpu_usage_transformation_function" {
  description = "Transformation function for container_cpu_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='30m')"
}

variable "container_cpu_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "container_cpu_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "container_cpu_usage_disabled" {
  description = "Disable all alerting rules for container_cpu_usage detector"
  type        = bool
  default     = null
}

variable "container_cpu_usage_disabled_minor" {
  description = "Disable minor alerting rule for container_cpu_usage detector"
  type        = bool
  default     = null
}

variable "container_cpu_usage_disabled_warning" {
  description = "Disable warning alerting rule for container_cpu_usage detector"
  type        = bool
  default     = null
}

variable "container_cpu_usage_threshold_minor" {
  description = "Minor threshold for container_cpu_usage detector in %"
  type        = number
  default     = 95
}

variable "container_cpu_usage_threshold_warning" {
  description = "Warning threshold for container_cpu_usage detector in %"
  type        = number
  default     = 90
}

# container_mem_usage detector

variable "container_mem_usage_notifications" {
  description = "Notification recipients list per severity overridden for container_mem_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "container_mem_usage_aggregation_function" {
  description = "Aggregation function and group by for container_mem_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_pod_name','kubernetes_namespace'])"
}

variable "container_mem_usage_transformation_function" {
  description = "Transformation function for container_mem_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='30m')"
}

variable "container_mem_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "container_mem_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "container_mem_usage_disabled" {
  description = "Disable all alerting rules for container_mem_usage detector"
  type        = bool
  default     = null
}

variable "container_mem_usage_disabled_minor" {
  description = "Disable minor alerting rule for container_mem_usage detector"
  type        = bool
  default     = null
}

variable "container_mem_usage_disabled_warning" {
  description = "Disable warning alerting rule for container_mem_usage detector"
  type        = bool
  default     = null
}

variable "container_mem_usage_threshold_minor" {
  description = "Minor threshold for container_mem_usage detector in %"
  type        = number
  default     = 95
}

variable "container_mem_usage_threshold_warning" {
  description = "Warning threshold for container_mem_usage detector in %"
  type        = number
  default     = 90
}

