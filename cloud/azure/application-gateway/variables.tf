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

# Azure app gateway detectors specific

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

# Total_requests detectors

variable "total_requests_disabled" {
  description = "Disable all alerting rules for total_requests detector"
  type        = bool
  default     = null
}

variable "total_requests_disabled_critical" {
  description = "Disable critical alerting rule for total_requests detector"
  type        = bool
  default     = null
}

variable "total_requests_notifications" {
  description = "Notification recipients list per severity overridden for total_requests detector"
  type        = map(list(string))
  default     = {}
}

variable "total_requests_aggregation_function" {
  description = "Aggregation function and group by for total_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "total_requests_timer" {
  description = "Evaluation window for total_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

# backend_connect_time detectors

variable "backend_connect_time_disabled" {
  description = "Disable all alerting rules for backend_connect_time detector"
  type        = bool
  default     = null
}

variable "backend_connect_time_disabled_critical" {
  description = "Disable critical alerting rule for backend_connect_time detector"
  type        = bool
  default     = null
}

variable "backend_connect_time_disabled_warning" {
  description = "Disable warning alerting rule for backend_connect_time detector"
  type        = bool
  default     = null
}

variable "backend_connect_time_notifications" {
  description = "Notification recipients list per severity overridden for backend_connect_time detector"
  type        = map(list(string))
  default     = {}
}

variable "backend_connect_time_aggregation_function" {
  description = "Aggregation function and group by for backend_connect_time detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region', 'backendhttpsetting', 'backendpool', 'backendserver'])"
}

variable "backend_connect_time_timer" {
  description = "Evaluation window for backend_connect_time detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "backend_connect_time_threshold_critical" {
  description = "Critical threshold for backend_connect_time detector"
  type        = number
  default     = 50
}

variable "backend_connect_time_threshold_warning" {
  description = "Warning threshold for backend_connect_time detector"
  type        = number
  default     = 40
}

# Failed_requests detectors

variable "failed_requests_disabled" {
  description = "Disable all alerting rules for failed_requests detector"
  type        = bool
  default     = null
}

variable "failed_requests_disabled_critical" {
  description = "Disable critical alerting rule for failed_requests detector"
  type        = bool
  default     = null
}

variable "failed_requests_disabled_warning" {
  description = "Disable warning alerting rule for failed_requests detector"
  type        = bool
  default     = null
}

variable "failed_requests_notifications" {
  description = "Notification recipients list per severity overridden for failed_requests detector"
  type        = map(list(string))
  default     = {}
}

variable "failed_requests_aggregation_function" {
  description = "Aggregation function and group by for failed_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region', 'backendsettingspool'])"
}

variable "failed_requests_timer" {
  description = "Evaluation window for failed_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "failed_requests_threshold_critical" {
  description = "Critical threshold for failed_requests detector"
  type        = number
  default     = 95
}

variable "failed_requests_threshold_warning" {
  description = "Warning threshold for failed_requests detector"
  type        = number
  default     = 80
}

# Unhealthy_host_ratio detectors

variable "unhealthy_host_ratio_disabled" {
  description = "Disable all alerting rules for unhealthy_host_ratio detector"
  type        = bool
  default     = null
}

variable "unhealthy_host_ratio_disabled_critical" {
  description = "Disable critical alerting rule for unhealthy_host_ratio detector"
  type        = bool
  default     = null
}

variable "unhealthy_host_ratio_disabled_warning" {
  description = "Disable warning alerting rule for unhealthy_host_ratio detector"
  type        = bool
  default     = null
}

variable "unhealthy_host_ratio_notifications" {
  description = "Notification recipients list per severity overridden for unhealthy_host_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "unhealthy_host_ratio_aggregation_function" {
  description = "Aggregation function and group by for unhealthy_host_ratio detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region', 'backendsettingspool'])"
}

variable "unhealthy_host_ratio_timer" {
  description = "Evaluation window for unhealthy_host_ratio detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "unhealthy_host_ratio_threshold_critical" {
  description = "Critical threshold for unhealthy_host_ratio detector"
  type        = number
  default     = 75
}

variable "unhealthy_host_ratio_threshold_warning" {
  description = "Warning threshold for unhealthy_host_ratio detector"
  type        = number
  default     = 50
}

# Http_4xx_errors detectors

variable "http_4xx_errors_disabled" {
  description = "Disable all alerting rules for http_4xx_errors detector"
  type        = bool
  default     = null
}

variable "http_4xx_errors_disabled_critical" {
  description = "Disable critical alerting rule for http_4xx_errors detector"
  type        = bool
  default     = null
}

variable "http_4xx_errors_disabled_warning" {
  description = "Disable warning alerting rule for http_4xx_errors detector"
  type        = bool
  default     = null
}

variable "http_4xx_errors_notifications" {
  description = "Notification recipients list per severity overridden for http_4xx_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "http_4xx_errors_aggregation_function" {
  description = "Aggregation function and group by for http_4xx_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "http_4xx_errors_timer" {
  description = "Evaluation window for http_4xx_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "http_4xx_errors_threshold_critical" {
  description = "Critical threshold for http_4xx_errors detector"
  type        = number
  default     = 95
}

variable "http_4xx_errors_threshold_warning" {
  description = "Warning threshold for http_4xx_errors detector"
  type        = number
  default     = 80
}

# Http_5xx_errors detectors

variable "http_5xx_errors_disabled" {
  description = "Disable all alerting rules for http_5xx_errors detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_disabled_critical" {
  description = "Disable critical alerting rule for http_5xx_errors detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_disabled_warning" {
  description = "Disable warning alerting rule for http_5xx_errors detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_notifications" {
  description = "Notification recipients list per severity overridden for http_5xx_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "http_5xx_errors_aggregation_function" {
  description = "Aggregation function and group by for http_5xx_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "http_5xx_errors_timer" {
  description = "Evaluation window for http_5xx_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "http_5xx_errors_threshold_critical" {
  description = "Critical threshold for http_5xx_errors detector"
  type        = number
  default     = 95
}

variable "http_5xx_errors_threshold_warning" {
  description = "Warning threshold for http_5xx_errors detector"
  type        = number
  default     = 80
}

# Backend_http_4xx_errors detectors

variable "backend_http_4xx_errors_disabled" {
  description = "Disable all alerting rules for backend_http_4xx_errors detector"
  type        = bool
  default     = null
}

variable "backend_http_4xx_errors_disabled_critical" {
  description = "Disable critical alerting rule for backend_http_4xx_errors detector"
  type        = bool
  default     = null
}

variable "backend_http_4xx_errors_disabled_warning" {
  description = "Disable warning alerting rule for backend_http_4xx_errors detector"
  type        = bool
  default     = null
}

variable "backend_http_4xx_errors_notifications" {
  description = "Notification recipients list per severity overridden for backend_http_4xx_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "backend_http_4xx_errors_aggregation_function" {
  description = "Aggregation function and group by for backend_http_4xx_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region', 'backendhttpsetting', 'backendpool', 'backendserver'])"
}

variable "backend_http_4xx_errors_timer" {
  description = "Evaluation window for backend_http_4xx_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "backend_http_4xx_errors_threshold_critical" {
  description = "Critical threshold for backend_http_4xx_errors detector"
  type        = number
  default     = 95
}

variable "backend_http_4xx_errors_threshold_warning" {
  description = "Warning threshold for backend_http_4xx_errors detector"
  type        = number
  default     = 80
}

# Backend_http_5xx_errors detectors

variable "backend_http_5xx_errors_disabled" {
  description = "Disable all alerting rules for backend_http_5xx_errors detector"
  type        = bool
  default     = null
}

variable "backend_http_5xx_errors_disabled_critical" {
  description = "Disable critical alerting rule for backend_http_5xx_errors detector"
  type        = bool
  default     = null
}

variable "backend_http_5xx_errors_disabled_warning" {
  description = "Disable warning alerting rule for backend_http_5xx_errors detector"
  type        = bool
  default     = null
}

variable "backend_http_5xx_errors_notifications" {
  description = "Notification recipients list per severity overridden for backend_http_5xx_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "backend_http_5xx_errors_aggregation_function" {
  description = "Aggregation function and group by for backend_http_5xx_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region', 'backendhttpsetting', 'backendpool', 'backendserver'])"
}

variable "backend_http_5xx_errors_timer" {
  description = "Evaluation window for backend_http_5xx_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "backend_http_5xx_errors_threshold_critical" {
  description = "Critical threshold for backend_http_5xx_errors detector"
  type        = number
  default     = 95
}

variable "backend_http_5xx_errors_threshold_warning" {
  description = "Warning threshold for backend_http_5xx_errors detector"
  type        = number
  default     = 80
}
