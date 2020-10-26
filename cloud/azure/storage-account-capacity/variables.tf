# Module specific

# used_capacity detector

variable "used_capacity_notifications" {
  description = "Notification recipients list per severity overridden for used_capacity detector"
  type        = map(list(string))
  default     = {}
}

variable "used_capacity_aggregation_function" {
  description = "Aggregation function and group by for used_capacity detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "used_capacity_transformation_function" {
  description = "Transformation function for used_capacity detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='12h')"
}

variable "used_capacity_disabled" {
  description = "Disable all alerting rules for used_capacity detector"
  type        = bool
  default     = null
}

variable "used_capacity_disabled_critical" {
  description = "Disable critical alerting rule for used_capacity detector"
  type        = bool
  default     = null
}

variable "used_capacity_disabled_major" {
  description = "Disable major alerting rule for used_capacity detector"
  type        = bool
  default     = null
}

variable "used_capacity_threshold_critical" {
  description = "Critical threshold for used_capacity detector (in GB)"
  type        = number
}

variable "used_capacity_threshold_major" {
  description = "Major threshold for used_capacity detector (in GB)"
  type        = number
}
