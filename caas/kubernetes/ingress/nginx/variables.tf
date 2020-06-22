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

# Kubernetes ingress detectors specific

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

# Nginx_ingress_too_many_5xx detectors

variable "nginx_ingress_too_many_5xx_disabled" {
  description = "Disable all alerting rules for nginx_ingress_too_many_5xx detector"
  type        = bool
  default     = null
}

variable "nginx_ingress_too_many_5xx_disabled_critical" {
  description = "Disable critical alerting rule for nginx_ingress_too_many_5xx detector"
  type        = bool
  default     = null
}

variable "nginx_ingress_too_many_5xx_disabled_warning" {
  description = "Disable warning alerting rule for nginx_ingress_too_many_5xx detector"
  type        = bool
  default     = null
}

variable "nginx_ingress_too_many_5xx_notifications" {
  description = "Notification recipients list for every alerting rules of nginx_ingress_too_many_5xx detector"
  type        = list
  default     = []
}

variable "nginx_ingress_too_many_5xx_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of nginx_ingress_too_many_5xx detector"
  type        = list
  default     = []
}

variable "nginx_ingress_too_many_5xx_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of nginx_ingress_too_many_5xx detector"
  type        = list
  default     = []
}

variable "nginx_ingress_too_many_5xx_aggregation_function" {
  description = "Aggregation function and group by for nginx_ingress_too_many_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['Ingress'])"
}

variable "nginx_ingress_too_many_5xx_transformation_function" {
  description = "Transformation function for nginx_ingress_too_many_5xx detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "nginx_ingress_too_many_5xx_transformation_window" {
  description = "Transformation window for nginx_ingress_too_many_5xx detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "nginx_ingress_too_many_5xx_threshold_critical" {
  description = "Critical threshold for nginx_ingress_too_many_5xx detector"
  type        = number
  default     = 20
}

variable "nginx_ingress_too_many_5xx_threshold_warning" {
  description = "Warning threshold for nginx_ingress_too_many_5xx detector"
  type        = number
  default     = 10
}

variable "nginx_ingress_too_many_5xx_aperiodic_duration" {
  description = "Duration for the nginx_ingress_too_many_5xx block"
  type        = string
  default     = "10m"
}

variable "nginx_ingress_too_many_5xx_aperiodic_percentage" {
  description = "Percentage for the nginx_ingress_too_many_5xx block"
  type        = number
  default     = 0.9
}

variable "nginx_ingress_too_many_5xx_clear_duration" {
  description = "Duration for the nginx_ingress_too_many_5xx clear condition"
  type        = string
  default     = "15m"
}

# Nginx_ingress_too_many_4xx detectors

variable "nginx_ingress_too_many_4xx_disabled" {
  description = "Disable all alerting rules for nginx_ingress_too_many_4xx detector"
  type        = bool
  default     = null
}

variable "nginx_ingress_too_many_4xx_disabled_critical" {
  description = "Disable critical alerting rule for nginx_ingress_too_many_4xx detector"
  type        = bool
  default     = null
}

variable "nginx_ingress_too_many_4xx_disabled_warning" {
  description = "Disable warning alerting rule for nginx_ingress_too_many_4xx detector"
  type        = bool
  default     = null
}

variable "nginx_ingress_too_many_4xx_notifications" {
  description = "Notification recipients list for every alerting rules of nginx_ingress_too_many_4xx detector"
  type        = list
  default     = []
}

variable "nginx_ingress_too_many_4xx_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of nginx_ingress_too_many_4xx detector"
  type        = list
  default     = []
}

variable "nginx_ingress_too_many_4xx_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of nginx_ingress_too_many_4xx detector"
  type        = list
  default     = []
}

variable "nginx_ingress_too_many_4xx_aggregation_function" {
  description = "Aggregation function and group by for nginx_ingress_too_many_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['Ingress'])"
}

variable "nginx_ingress_too_many_4xx_transformation_function" {
  description = "Transformation function for nginx_ingress_too_many_4xx detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "nginx_ingress_too_many_4xx_transformation_window" {
  description = "Transformation window for nginx_ingress_too_many_4xx detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "nginx_ingress_too_many_4xx_threshold_critical" {
  description = "Critical threshold for nginx_ingress_too_many_4xx detector"
  type        = number
  default     = 40
}

variable "nginx_ingress_too_many_4xx_threshold_warning" {
  description = "Warning threshold for nginx_ingress_too_many_4xx detector"
  type        = number
  default     = 20
}

variable "nginx_ingress_too_many_4xx_aperiodic_duration" {
  description = "Duration for the nginx_ingress_too_many_4xx block"
  type        = string
  default     = "10m"
}

variable "nginx_ingress_too_many_4xx_aperiodic_percentage" {
  description = "Percentage for the nginx_ingress_too_many_4xx block"
  type        = number
  default     = 0.9
}

variable "nginx_ingress_too_many_4xx_clear_duration" {
  description = "Duration for the nginx_ingress_too_many_4xx clear condition"
  type        = string
  default     = "15m"
}
