# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Default notification recipients list per severity"
  type = object({
    critical = list(string)
    major    = list(string)
    minor    = list(string)
    warning  = list(string)
    info     = list(string)
  })
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

# Azure cosmosdb detectors specific

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
  description = "Timeframe for system not reporting detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

# db_4xx_requests detectors

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

# db_5xx_requests detectors

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

# Scaling detectors

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
