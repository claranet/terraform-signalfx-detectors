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
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "heartbeat_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "heartbeat_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

# capacity detector

variable "capacity_notifications" {
  description = "Notification recipients list per severity overridden for capacity detector"
  type        = map(list(string))
  default     = {}
}

variable "capacity_aggregation_function" {
  description = "Aggregation function and group by for capacity detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "capacity_transformation_function" {
  description = "Transformation function for capacity detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "capacity_disabled" {
  description = "Disable all alerting rules for capacity detector"
  type        = bool
  default     = null
}

variable "capacity_disabled_critical" {
  description = "Disable critical alerting rule for capacity detector"
  type        = bool
  default     = null
}

variable "capacity_disabled_major" {
  description = "Disable major alerting rule for capacity detector"
  type        = bool
  default     = null
}

variable "capacity_threshold_critical" {
  description = "Critical threshold for capacity detector (in %)"
  type        = number
  default     = 95
}

variable "capacity_threshold_major" {
  description = "Major threshold for capacity detector (in %)"
  type        = number
  default     = 90
}

variable "capacity_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "capacity_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

# gateway requests Duration

variable "gateway_requests_duration_notifications" {
  description = "Notification recipients list per severity overridden for gateway requests duration detector"
  type        = map(list(string))
  default     = {}
}

variable "gateway_requests_duration_aggregation_function" {
  description = "Aggregation function and group by for gateway requests duration detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "gateway_requests_duration_transformation_function" {
  description = "Transformation function for gateway requests duration detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "gateway_requests_duration_disabled" {
  description = "Disable all alerting rules for gateway requests duration detector"
  type        = bool
  default     = null
}

variable "gateway_requests_duration_disabled_critical" {
  description = "Disable critical alerting rule for gateway requests duration detector"
  type        = bool
  default     = null
}

variable "gateway_requests_duration_disabled_major" {
  description = "Disable major alerting rule for gateway requests duration detector"
  type        = bool
  default     = null
}

variable "gateway_requests_duration_threshold_critical" {
  description = "Critical threshold for gateway requests duration detector (in s)"
  type        = number
  default     = 1.5
}

variable "gateway_requests_duration_threshold_major" {
  description = "Major threshold for gateway requests duration detector (in s)"
  type        = number
  default     = 1
}

variable "gateway_requests_duration_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "gateway_requests_duration_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

# Backend requests Duration

variable "backend_requests_duration_notifications" {
  description = "Notification recipients list per severity overridden for backend requests duration detector"
  type        = map(list(string))
  default     = {}
}

variable "backend_requests_duration_aggregation_function" {
  description = "Aggregation function and group by for backend requests duration detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "backend_requests_duration_transformation_function" {
  description = "Transformation function for backend requests duration detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "backend_requests_duration_disabled" {
  description = "Disable all alerting rules for backend requests duration detector"
  type        = bool
  default     = null
}

variable "backend_requests_duration_disabled_critical" {
  description = "Disable critical alerting rule for backend requests duration detector"
  type        = bool
  default     = null
}

variable "backend_requests_duration_disabled_major" {
  description = "Disable major alerting rule for backend requests duration detector"
  type        = bool
  default     = null
}

variable "backend_requests_duration_threshold_critical" {
  description = "Critical threshold for backend requests duration detector (in s)"
  type        = number
  default     = 1.5
}

variable "backend_requests_duration_threshold_major" {
  description = "Major threshold for backend requests duration detector (in s)"
  type        = number
  default     = 1
}

variable "backend_requests_duration_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "backend_requests_duration_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}
