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
  default     = ""
}

# Server_status detector

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
  description = "Notification recipients list per severity overridden for server status detector"
  type        = map(list(string))
  default     = {}
}

variable "server_status_aggregation_function" {
  description = "Aggregation function and group by for server status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "server_status_transformation_function" {
  description = "Transformation function for server status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

# Backend_status detector

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
  description = "Notification recipients list per severity overridden for backend status detector"
  type        = map(list(string))
  default     = {}
}

variable "backend_status_aggregation_function" {
  description = "Aggregation function and group by for backend status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "backend_status_transformation_function" {
  description = "Transformation function for backend status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

# Session_limit detector

variable "session_limit_disabled" {
  description = "Disable all alerting rules for session limit detector"
  type        = bool
  default     = null
}

variable "session_limit_disabled_major" {
  description = "Disable major alerting rule for session limit detector"
  type        = bool
  default     = null
}

variable "session_limit_disabled_critical" {
  description = "Disable critical alerting rule for session limit detector"
  type        = bool
  default     = null
}

variable "session_limit_notifications" {
  description = "Notification recipients list per severity overridden for session limit detector"
  type        = map(list(string))
  default     = {}
}

variable "session_limit_aggregation_function" {
  description = "Aggregation function and group by for session limit detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "session_limit_transformation_function" {
  description = "Transformation function for session limit detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "session_limit_threshold_major" {
  description = "Critical threshold for session limit detector"
  type        = number
  default     = 80
}

variable "session_limit_threshold_critical" {
  description = "Critical threshold for session limit detector"
  type        = number
  default     = 90
}

# Http_5xx_response detector

variable "http_5xx_response_disabled" {
  description = "Disable all alerting rules for http_5xx_response detector"
  type        = bool
  default     = null
}

variable "http_5xx_response_disabled_major" {
  description = "Disable major alerting rule for http_5xx_response detector"
  type        = bool
  default     = null
}

variable "http_5xx_response_disabled_critical" {
  description = "Disable critical alerting rule for http_5xx_response detector"
  type        = bool
  default     = null
}

variable "http_5xx_response_notifications" {
  description = "Notification recipients list per severity overridden for http_5xx_response detector"
  type        = map(list(string))
  default     = {}
}

variable "http_5xx_response_aggregation_function" {
  description = "Aggregation function and group by for http_5xx_response detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "http_5xx_response_transformation_function" {
  description = "Transformation function for http_5xx_response detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "http_5xx_response_threshold_major" {
  description = "Critical threshold for http_5xx_response detector"
  type        = number
  default     = 50
}

variable "http_5xx_response_threshold_critical" {
  description = "Critical threshold for http_5xx_response detector"
  type        = number
  default     = 80
}

# Http_4xx_response detector

variable "http_4xx_response_disabled" {
  description = "Disable all alerting rules for http_4xx_response detector"
  type        = bool
  default     = null
}

variable "http_4xx_response_disabled_major" {
  description = "Disable major alerting rule for http_4xx_response detector"
  type        = bool
  default     = null
}

variable "http_4xx_response_disabled_critical" {
  description = "Disable critical alerting rule for http_4xx_response detector"
  type        = bool
  default     = null
}

variable "http_4xx_response_notifications" {
  description = "Notification recipients list per severity overridden for http_4xx_response detector"
  type        = map(list(string))
  default     = {}
}

variable "http_4xx_response_aggregation_function" {
  description = "Aggregation function and group by for http_4xx_response detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "http_4xx_response_transformation_function" {
  description = "Transformation function for http_4xx_response detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "http_4xx_response_threshold_major" {
  description = "Critical threshold for http_4xx_response detector"
  type        = number
  default     = 50
}

variable "http_4xx_response_threshold_critical" {
  description = "Critical threshold for http_4xx_response detector"
  type        = number
  default     = 80
}

