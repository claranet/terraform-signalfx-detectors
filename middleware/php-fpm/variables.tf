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

# PHP FPM detectors specific

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

# PHP_fpm_connect_idle detectors

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

