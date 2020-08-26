# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Notification recipients list for every detectors"
  type        = list
}

variable "prefixes" {
  description = "Prefixes list to prepend between brackets on every monitors names before environment"
  type        = list
  default     = []
}

variable "filter_custom_includes" {
  description = "List of tags to include when custom filtering is used"
  type        = list
  default     = []
}

variable "filter_custom_excludes" {
  description = "List of tags to exclude when custom filtering is used"
  type        = list
  default     = []
}

variable "detectors_disabled" {
  description = "Disable all detectors in this module"
  type        = bool
  default     = false
}

# Haproxy detectors specific

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_notifications" {
  description = "Notification recipients list for every alerting rules of heartbeat detector"
  type        = list
  default     = []
}

variable "heartbeat_timeframe" {
  description = "Timeframe for system not reporting detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

variable "server_status_disabled" {
  description = "Disable all alerting rules for server status detector"
  type        = bool
  default     = null
}

variable "server_status_disabled_critical" {
  description = "Disable critical alerting rule for server status detector"
  type        = bool
  default     = null
}

variable "server_status_notifications" {
  description = "Notification recipients list for every alerting rules of server status detector"
  type        = list
  default     = []
}

variable "server_status_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of server status detector"
  type        = list
  default     = []
}

variable "server_status_aggregation_function" {
  description = "Aggregation function and group by for server status detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "server_status_transformation_function" {
  description = "Transformation function for server status detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "backend_status_disabled" {
  description = "Disable all alerting rules for backend status detector"
  type        = bool
  default     = null
}

variable "backend_status_disabled_critical" {
  description = "Disable critical alerting rule for backend status detector"
  type        = bool
  default     = null
}

variable "backend_status_notifications" {
  description = "Notification recipients list for every alerting rules of backend status detector"
  type        = list
  default     = []
}

variable "backend_status_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of backend status detector"
  type        = list
  default     = []
}

variable "backend_status_aggregation_function" {
  description = "Aggregation function and group by for backend status detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "backend_status_transformation_function" {
  description = "Transformation function for backend status detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "session_limit_disabled" {
  description = "Disable all alerting rules for session limit detector"
  type        = bool
  default     = null
}

variable "session_limit_disabled_warning" {
  description = "Disable warning alerting rule for session limit detector"
  type        = bool
  default     = null
}

variable "session_limit_disabled_critical" {
  description = "Disable critical alerting rule for session limit detector"
  type        = bool
  default     = null
}

variable "session_limit_notifications" {
  description = "Notification recipients list for every alerting rules of session limit detector"
  type        = list
  default     = []
}

variable "session_limit_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of session limit detector"
  type        = list
  default     = []
}

variable "session_limit_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of session limit detector"
  type        = list
  default     = []
}

variable "session_limit_aggregation_function" {
  description = "Aggregation function and group by for session limit detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "session_limit_transformation_function" {
  description = "Transformation function for session limit detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='10m')"
}

variable "session_limit_threshold_warning" {
  description = "Critical threshold for session limit detector"
  type        = number
  default     = 80
}

variable "session_limit_threshold_critical" {
  description = "Critical threshold for session limit detector"
  type        = number
  default     = 90
}

variable "http_5xx_response_disabled" {
  description = "Disable all alerting rules for http_5xx_response detector"
  type        = bool
  default     = null
}

variable "http_5xx_response_disabled_warning" {
  description = "Disable warning alerting rule for http_5xx_response detector"
  type        = bool
  default     = null
}

variable "http_5xx_response_disabled_critical" {
  description = "Disable critical alerting rule for http_5xx_response detector"
  type        = bool
  default     = null
}

variable "http_5xx_response_notifications" {
  description = "Notification recipients list for every alerting rules of http_5xx_response detector"
  type        = list
  default     = []
}

variable "http_5xx_response_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of http_5xx_response detector"
  type        = list
  default     = []
}

variable "http_5xx_response_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of http_5xx_response detector"
  type        = list
  default     = []
}

variable "http_5xx_response_aggregation_function" {
  description = "Aggregation function and group by for http_5xx_response detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "http_5xx_response_transformation_function" {
  description = "Transformation function for http_5xx_response detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='10m')"
}

variable "http_5xx_response_threshold_warning" {
  description = "Critical threshold for http_5xx_response detector"
  type        = number
  default     = 50
}

variable "http_5xx_response_threshold_critical" {
  description = "Critical threshold for http_5xx_response detector"
  type        = number
  default     = 80
}

variable "http_4xx_response_disabled" {
  description = "Disable all alerting rules for http_4xx_response detector"
  type        = bool
  default     = null
}

variable "http_4xx_response_disabled_warning" {
  description = "Disable warning alerting rule for http_4xx_response detector"
  type        = bool
  default     = null
}

variable "http_4xx_response_disabled_critical" {
  description = "Disable critical alerting rule for http_4xx_response detector"
  type        = bool
  default     = null
}

variable "http_4xx_response_notifications" {
  description = "Notification recipients list for every alerting rules of http_4xx_response detector"
  type        = list
  default     = []
}

variable "http_4xx_response_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of http_4xx_response detector"
  type        = list
  default     = []
}

variable "http_4xx_response_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of http_4xx_response detector"
  type        = list
  default     = []
}

variable "http_4xx_response_aggregation_function" {
  description = "Aggregation function and group by for http_4xx_response detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "http_4xx_response_transformation_function" {
  description = "Transformation function for http_4xx_response detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='10m')"
}

variable "http_4xx_response_threshold_warning" {
  description = "Critical threshold for http_4xx_response detector"
  type        = number
  default     = 50
}

variable "http_4xx_response_threshold_critical" {
  description = "Critical threshold for http_4xx_response detector"
  type        = number
  default     = 80
}

