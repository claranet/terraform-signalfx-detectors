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

# AWS ELB detectors specific

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

# no_healthy_instances detectors

variable "no_healthy_instances_disabled" {
  description = "Disable all alerting rules for no_healthy_instances detector"
  type        = bool
  default     = null
}

variable "no_healthy_instances_disabled_critical" {
  description = "Disable critical alerting rule for no_healthy_instances detector"
  type        = bool
  default     = null
}

variable "no_healthy_instances_disabled_warning" {
  description = "Disable warning alerting rule for no_healthy_instances detector"
  type        = bool
  default     = null
}

variable "no_healthy_instances_notifications" {
  description = "Notification recipients list for every alerting rules of no_healthy_instances detector"
  type        = list
  default     = []
}

variable "no_healthy_instances_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of no_healthy_instances detector"
  type        = list
  default     = []
}

variable "no_healthy_instances_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of no_healthy_instances detector"
  type        = list
  default     = []
}

variable "no_healthy_instances_aggregation_function" {
  description = "Aggregation function and group by for no_healthy_instances detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "no_healthy_instances_transformation_function" {
  description = "Transformation function for no_healthy_instances detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "no_healthy_instances_transformation_window" {
  description = "Transformation window for no_healthy_instances detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "no_healthy_instances_threshold_critical" {
  description = "Critical threshold for no_healthy_instances detector"
  type        = number
  default     = 1
}

variable "no_healthy_instances_threshold_warning" {
  description = "Warning threshold for no_healthy_instances detector"
  type        = number
  default     = 100
}

# Too_much_4xx detectors

variable "too_much_4xx_disabled" {
  description = "Disable all alerting rules for too_much_4xx detector"
  type        = bool
  default     = null
}

variable "too_much_4xx_disabled_critical" {
  description = "Disable critical alerting rule for too_much_4xx detector"
  type        = bool
  default     = null
}

variable "too_much_4xx_disabled_warning" {
  description = "Disable warning alerting rule for httpcode 5xx erros detector"
  type        = bool
  default     = null
}

variable "too_much_4xx_notifications" {
  description = "Notification recipients list for every alerting rules of too_much_4xx detector"
  type        = list
  default     = []
}

variable "too_much_4xx_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of too_much_4xx detector"
  type        = list
  default     = []
}

variable "too_much_4xx_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of too_much_4xx detector"
  type        = list
  default     = []
}

variable "too_much_4xx_aggregation_function" {
  description = "Aggregation function and group by for too_much_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "too_much_4xx_transformation_function" {
  description = "Transformation function for too_much_4xx detector (mean, min, max)"
  type        = string
  default     = "sum"
}

variable "too_much_4xx_transformation_window" {
  description = "Transformation window for too_much_4xx detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "too_much_4xx_threshold_critical" {
  description = "Critical threshold for too_much_4xx detector"
  type        = number
  default     = 10
}

variable "too_much_4xx_threshold_warning" {
  description = "Warning threshold for too_much_4xx detector"
  type        = number
  default     = 5
}

variable "too_much_4xx_threshold_number_requests" {
  description = "Number threshold for too_much_4xx detector"
  type        = number
  default     = 5
}

# Too_much_5xx detectors

variable "too_much_5xx_disabled" {
  description = "Disable all alerting rules for too_much_5xx detector"
  type        = bool
  default     = null
}

variable "too_much_5xx_disabled_critical" {
  description = "Disable critical alerting rule for too_much_5xx detector"
  type        = bool
  default     = null
}

variable "too_much_5xx_disabled_warning" {
  description = "Disable warning alerting rule for too_much_5xx detector"
  type        = bool
  default     = null
}

variable "too_much_5xx_notifications" {
  description = "Notification recipients list for every alerting rules of too_much_5xx detector"
  type        = list
  default     = []
}

variable "too_much_5xx_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of too_much_5xx detector"
  type        = list
  default     = []
}

variable "too_much_5xx_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of too_much_5xx detector"
  type        = list
  default     = []
}

variable "too_much_5xx_aggregation_function" {
  description = "Aggregation function and group by for too_much_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "too_much_5xx_transformation_function" {
  description = "Transformation function for too_much_5xx detector (mean, min, max)"
  type        = string
  default     = "sum"
}

variable "too_much_5xx_transformation_window" {
  description = "Transformation window for too_much_5xx detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "too_much_5xx_threshold_critical" {
  description = "Critical threshold for too_much_5xx detector"
  type        = number
  default     = 10
}

variable "too_much_5xx_threshold_warning" {
  description = "Warning threshold for too_much_5xx detector"
  type        = number
  default     = 5
}

variable "too_much_5xx_threshold_number_requests" {
  description = "Number threshold for too_much_5xx detector"
  type        = number
  default     = 5
}

# Too_much_4xx_backend detectors

variable "too_much_4xx_backend_disabled" {
  description = "Disable all alerting rules for too_much_4xx_backend detector"
  type        = bool
  default     = null
}

variable "too_much_4xx_backend_disabled_critical" {
  description = "Disable critical alerting rule for too_much_4xx_backend detector"
  type        = bool
  default     = null
}

variable "too_much_4xx_backend_disabled_warning" {
  description = "Disable warning alerting rule for too_much_4xx_backend detector"
  type        = bool
  default     = null
}

variable "too_much_4xx_backend_notifications" {
  description = "Notification recipients list for every alerting rules of too_much_4xx_backend detector"
  type        = list
  default     = []
}

variable "too_much_4xx_backend_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of too_much_4xx_backend detector"
  type        = list
  default     = []
}

variable "too_much_4xx_backend_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of too_much_4xx_backend detector"
  type        = list
  default     = []
}

variable "too_much_4xx_backend_aggregation_function" {
  description = "Aggregation function and group by for too_much_4xx_backend detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "too_much_4xx_backend_transformation_function" {
  description = "Transformation function for too_much_4xx_backend detector (mean, min, max)"
  type        = string
  default     = "sum"
}

variable "too_much_4xx_backend_transformation_window" {
  description = "Transformation window for too_much_4xx_backend detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "too_much_4xx_backend_threshold_critical" {
  description = "Critical threshold for too_much_4xx_backend detector"
  type        = number
  default     = 10
}

variable "too_much_4xx_backend_threshold_warning" {
  description = "Warning threshold for too_much_4xx_backend detector"
  type        = number
  default     = 5
}

variable "too_much_4xx_backend_threshold_number_requests" {
  description = "Number threshold for too_much_4xx_backend detector"
  type        = number
  default     = 5
}

# too_much_5xx_backend detectors

variable "too_much_5xx_backend_disabled" {
  description = "Disable all alerting rules for too_much_5xx_backend detector"
  type        = bool
  default     = null
}

variable "too_much_5xx_backend_disabled_critical" {
  description = "Disable critical alerting rule for too_much_5xx_backend detector"
  type        = bool
  default     = null
}

variable "too_much_5xx_backend_disabled_warning" {
  description = "Disable warning alerting rule for too_much_5xx_backend detector"
  type        = bool
  default     = null
}

variable "too_much_5xx_backend_notifications" {
  description = "Notification recipients list for every alerting rules of too_much_5xx_backend detector"
  type        = list
  default     = []
}

variable "too_much_5xx_backend_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of too_much_5xx_backend detector"
  type        = list
  default     = []
}

variable "too_much_5xx_backend_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of too_much_5xx_backend detector"
  type        = list
  default     = []
}

variable "too_much_5xx_backend_aggregation_function" {
  description = "Aggregation function and group by for too_much_5xx_backend detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "too_much_5xx_backend_transformation_function" {
  description = "Transformation function for too_much_5xx_backend detector (mean, min, max)"
  type        = string
  default     = "sum"
}

variable "too_much_5xx_backend_transformation_window" {
  description = "Transformation window for too_much_5xx_backend detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "too_much_5xx_backend_threshold_critical" {
  description = "Critical threshold for too_much_5xx_backend detector"
  type        = number
  default     = 10
}

variable "too_much_5xx_backend_threshold_warning" {
  description = "Warning threshold for too_much_5xx_backend detector"
  type        = number
  default     = 5
}

variable "too_much_5xx_backend_threshold_number_requests" {
  description = "Number threshold for too_much_5xx_backend detector"
  type        = number
  default     = 5
}

# Backend_latency detectors

variable "backend_latency_disabled" {
  description = "Disable all alerting rules for backend_latency detector"
  type        = bool
  default     = null
}

variable "backend_latency_disabled_critical" {
  description = "Disable critical alerting rule for backend_latency detector"
  type        = bool
  default     = null
}

variable "backend_latency_disabled_warning" {
  description = "Disable warning alerting rule for backend_latency detector"
  type        = bool
  default     = null
}

variable "backend_latency_notifications" {
  description = "Notification recipients list for every alerting rules of backend_latency detector"
  type        = list
  default     = []
}

variable "backend_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of backend_latency detector"
  type        = list
  default     = []
}

variable "backend_latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of backend_latency detector"
  type        = list
  default     = []
}

variable "backend_latency_aggregation_function" {
  description = "Aggregation function and group by for backend_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "backend_latency_transformation_function" {
  description = "Transformation function for backend_latency detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "backend_latency_transformation_window" {
  description = "Transformation window for backend_latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "backend_latency_threshold_critical" {
  description = "Critical threshold for backend_latency detector"
  type        = number
  default     = 3
}

variable "backend_latency_threshold_warning" {
  description = "Warning threshold for backend_latency detector"
  type        = number
  default     = 1
}

variable "backend_latency_aperiodic_duration" {
  description = "Duration for the backend_latency block"
  type        = string
  default     = "10m"
}

variable "backend_latency_aperiodic_percentage" {
  description = "Percentage for the backend_latency block"
  type        = number
  default     = 0.9
}

variable "backend_latency_aperiodic_upper_strict" {
  description = "If True, compare stream against upper with strict inequality; if False, non-strict"
  type        = bool
  default     = "0"
}
