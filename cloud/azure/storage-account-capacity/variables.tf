# Module specific

# storage_capacity detectors

variable "storage_capacity_disabled" {
  description = "Disable all alerting rules for storage_capacity detector"
  type        = bool
  default     = null
}

variable "storage_capacity_disabled_critical" {
  description = "Disable critical alerting rule for storage_capacity detector"
  type        = bool
  default     = null
}

variable "storage_capacity_disabled_major" {
  description = "Disable major alerting rule for storage_capacity detector"
  type        = bool
  default     = null
}

variable "storage_capacity_notifications" {
  description = "Notification recipients list per severity overridden for storage_capacity detector"
  type        = map(list(string))
  default     = {}
}

variable "storage_capacity_aggregation_function" {
  description = "Aggregation function and group by for storage_capacity detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "storage_capacity_timer" {
  description = "Evaluation window for storage_capacity detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "12h"
}

variable "storage_capacity_threshold_critical" {
  description = "Critical threshold for storage_capacity detector (in octets)"
  type        = number
}

variable "storage_capacity_threshold_major" {
  description = "Major threshold for storage_capacity detector (in octets)"
  type        = number
  default     = 100 * 1024 * 1024 * 1024 # 100GB
}
