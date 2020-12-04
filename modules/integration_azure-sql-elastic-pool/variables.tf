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
  default     = ".mean(by=['databaseresourceid'])"
}

# cpu detector

variable "cpu_disabled" {
  description = "Disable all alerting rules for cpu detector"
  type        = bool
  default     = null
}

variable "cpu_disabled_critical" {
  description = "Disable critical alerting rule for cpu detector"
  type        = bool
  default     = null
}

variable "cpu_disabled_major" {
  description = "Disable major alerting rule for cpu detector"
  type        = bool
  default     = null
}

variable "cpu_notifications" {
  description = "Notification recipients list per severity overridden for cpu detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_aggregation_function" {
  description = "Aggregation function and group by for cpu detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "cpu_timer" {
  description = "Evaluation window for cpu detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "cpu_threshold_critical" {
  description = "Critical threshold for cpu detector"
  type        = number
  default     = 90
}

variable "cpu_threshold_major" {
  description = "Major threshold for cpu detector"
  type        = number
  default     = 80
}

# free_space detector

variable "free_space_disabled" {
  description = "Disable all alerting rules for free_space detector"
  type        = bool
  default     = null
}

variable "free_space_disabled_critical" {
  description = "Disable critical alerting rule for free_space detector"
  type        = bool
  default     = null
}

variable "free_space_disabled_major" {
  description = "Disable major alerting rule for free_space detector"
  type        = bool
  default     = null
}

variable "free_space_notifications" {
  description = "Notification recipients list per severity overridden for free_space detector"
  type        = map(list(string))
  default     = {}
}

variable "free_space_aggregation_function" {
  description = "Aggregation function and group by for free_space detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "free_space_timer" {
  description = "Evaluation window for free_space detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "free_space_threshold_critical" {
  description = "Critical threshold for free_space detector"
  type        = number
  default     = 90
}

variable "free_space_threshold_major" {
  description = "Major threshold for free_space detector"
  type        = number
  default     = 80
}

# dtu_consumption detector

variable "dtu_consumption_disabled" {
  description = "Disable all alerting rules for dtu_consumption detector"
  type        = bool
  default     = null
}

variable "dtu_consumption_disabled_critical" {
  description = "Disable critical alerting rule for dtu_consumption detector"
  type        = bool
  default     = null
}

variable "dtu_consumption_disabled_major" {
  description = "Disable major alerting rule for dtu_consumption detector"
  type        = bool
  default     = null
}

variable "dtu_consumption_notifications" {
  description = "Notification recipients list per severity overridden for dtu_consumption detector"
  type        = map(list(string))
  default     = {}
}

variable "dtu_consumption_aggregation_function" {
  description = "Aggregation function and group by for dtu_consumption detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "dtu_consumption_timer" {
  description = "Evaluation window for dtu_consumption detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "dtu_consumption_threshold_critical" {
  description = "Critical threshold for dtu_consumption detector"
  type        = number
  default     = 90
}

variable "dtu_consumption_threshold_major" {
  description = "Major threshold for dtu_consumption detector"
  type        = number
  default     = 85
}
