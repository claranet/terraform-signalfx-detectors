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

# db_4xx_requests detector

variable "db_4xx_requests_disabled" {
  description = "Disable all alerting rules for db_4xx_requests detector"
  type        = bool
  default     = null
}

variable "db_4xx_requests_disabled_critical" {
  description = "Disable critical alerting rule for db_4xx_requests detector"
  type        = bool
  default     = null
}

variable "db_4xx_requests_disabled_major" {
  description = "Disable major alerting rule for db_4xx_requests detector"
  type        = bool
  default     = null
}

variable "db_4xx_requests_notifications" {
  description = "Notification recipients list per severity overridden for db_4xx_requests detector"
  type        = map(list(string))
  default     = {}
}

variable "db_4xx_requests_aggregation_function" {
  description = "Aggregation function and group by for db_4xx_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['databasename', 'collectionname', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "db_4xx_requests_timer" {
  description = "Evaluation window for db_4xx_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "db_4xx_requests_threshold_critical" {
  description = "Critical threshold for db_4xx_requests detector"
  type        = number
  default     = 80
}

variable "db_4xx_requests_threshold_major" {
  description = "Major threshold for db_4xx_requests detector"
  type        = number
  default     = 50
}

# db_5xx_requests detector

variable "db_5xx_requests_disabled" {
  description = "Disable all alerting rules for db_5xx_requests detector"
  type        = bool
  default     = null
}

variable "db_5xx_requests_disabled_critical" {
  description = "Disable critical alerting rule for db_5xx_requests detector"
  type        = bool
  default     = null
}

variable "db_5xx_requests_disabled_major" {
  description = "Disable major alerting rule for db_5xx_requests detector"
  type        = bool
  default     = null
}

variable "db_5xx_requests_notifications" {
  description = "Notification recipients list per severity overridden for db_5xx_requests detector"
  type        = map(list(string))
  default     = {}
}

variable "db_5xx_requests_aggregation_function" {
  description = "Aggregation function and group by for db_5xx_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['databasename', 'collectionname', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "db_5xx_requests_timer" {
  description = "Evaluation window for db_5xx_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "db_5xx_requests_threshold_critical" {
  description = "Critical threshold for db_5xx_requests detector"
  type        = number
  default     = 80
}

variable "db_5xx_requests_threshold_major" {
  description = "Major threshold for db_5xx_requests detector"
  type        = number
  default     = 50
}

# Scaling detector

variable "scaling_disabled" {
  description = "Disable all alerting rules for scaling detector"
  type        = bool
  default     = null
}

variable "scaling_disabled_critical" {
  description = "Disable critical alerting rule for scaling detector"
  type        = bool
  default     = null
}

variable "scaling_disabled_major" {
  description = "Disable major alerting rule for scaling detector"
  type        = bool
  default     = null
}

variable "scaling_notifications" {
  description = "Notification recipients list per severity overridden for scaling detector"
  type        = map(list(string))
  default     = {}
}

variable "scaling_aggregation_function" {
  description = "Aggregation function and group by for scaling detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['databasename', 'collectionname', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "scaling_timer" {
  description = "Evaluation window for scaling detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "scaling_threshold_critical" {
  description = "Critical threshold for scaling detector"
  type        = number
  default     = 10
}

variable "scaling_threshold_major" {
  description = "Major threshold for scaling detector"
  type        = number
  default     = 5
}

# used_rus_capacity detector

variable "used_rus_capacity_notifications" {
  description = "Notification recipients list per severity overridden for used_rus_capacity detector"
  type        = map(list(string))
  default     = {}
}

variable "used_rus_capacity_aggregation_function" {
  description = "Aggregation function and group by for used_rus_capacity detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['CollectionName, azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "used_rus_capacity_transformation_function" {
  description = "Transformation function for used_rus_capacity detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='15m')"
}

variable "used_rus_capacity_disabled" {
  description = "Disable all alerting rules for used_rus_capacity detector"
  type        = bool
  default     = null
}

variable "used_rus_capacity_disabled_critical" {
  description = "Disable critical alerting rule for used_rus_capacity detector"
  type        = bool
  default     = null
}

variable "used_rus_capacity_disabled_major" {
  description = "Disable major alerting rule for used_rus_capacity detector"
  type        = bool
  default     = null
}

variable "used_rus_capacity_threshold_critical" {
  description = "Critical threshold for used_rus_capacity detector"
  type        = number
  default     = 90
}

variable "used_rus_capacity_threshold_major" {
  description = "Major threshold for used_rus_capacity detector"
  type        = number
  default     = 80
}
