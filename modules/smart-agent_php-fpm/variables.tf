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

# PHP_fpm_connect_idle detector

variable "php_fpm_connect_idle_disabled" {
  description = "Disable all alerting rules for php_fpm_connect_idle detector"
  type        = bool
  default     = null
}

variable "php_fpm_connect_idle_disabled_critical" {
  description = "Disable critical alerting rule for php_fpm_connect_idle detector"
  type        = bool
  default     = null
}

variable "php_fpm_connect_idle_disabled_major" {
  description = "Disable major alerting rule for php_fpm_connect_idle detector"
  type        = bool
  default     = null
}

variable "php_fpm_connect_idle_notifications" {
  description = "Notification recipients list per severity overridden for php_fpm_connect_idle detector"
  type        = map(list(string))
  default     = {}
}

variable "php_fpm_connect_idle_aggregation_function" {
  description = "Aggregation function and group by for php_fpm_connect_idle detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "php_fpm_connect_idle_transformation_function" {
  description = "Transformation function for php_fpm_connect_idle detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='10m')"
}

variable "php_fpm_connect_idle_threshold_critical" {
  description = "Critical threshold for php_fpm_connect_idle detector"
  type        = number
  default     = 90
}

variable "php_fpm_connect_idle_threshold_major" {
  description = "Major threshold for php_fpm_connect_idle detector"
  type        = number
  default     = 80
}

