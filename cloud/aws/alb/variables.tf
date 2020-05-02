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

# AWS Alb detectors specific

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

# No_healthy_instances detectors

variable "no_healthy_instances_disabled" {
  description = "Disable all alerting rules for No_healthy_instances detector"
  type        = bool
  default     = null
}

variable "no_healthy_instances_disabled_critical" {
  description = "Disable critical alerting rule for No_healthy_instances detector"
  type        = bool
  default     = null
}

variable "no_healthy_instances_disabled_warning" {
  description = "Disable warning alerting rule for No_healthy_instances detector"
  type        = bool
  default     = null
}

variable "no_healthy_instances_notifications" {
  description = "Notification recipients list for every alerting rules of No_healthy_instances detector"
  type        = list
  default     = []
}

variable "no_healthy_instances_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of No_healthy_instances detector"
  type        = list
  default     = []
}

variable "no_healthy_instances_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of No_healthy_instances detector"
  type        = list
  default     = []
}

variable "no_healthy_instances_aggregation_function" {
  description = "Aggregation function and group by for No_healthy_instances detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['LoadBalancer'])"
}

variable "no_healthy_instances_transformation_function" {
  description = "Transformation function for No_healthy_instances detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "no_healthy_instances_transformation_window" {
  description = "Transformation window for No_healthy_instances detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "no_healthy_instances_threshold_critical" {
  description = "Critical threshold for No_healthy_instances detector"
  type        = number
  default     = 1
}

variable "no_healthy_instances_threshold_warning" {
  description = "Warning threshold for No_healthy_instances detector"
  type        = number
  default     = 100
}

# Latency detectors

variable "latency_disabled" {
  description = "Disable all alerting rules for latency detector"
  type        = bool
  default     = null
}

variable "latency_disabled_critical" {
  description = "Disable critical alerting rule for latency detector"
  type        = bool
  default     = null
}

variable "latency_disabled_warning" {
  description = "Disable warning alerting rule for latency detector"
  type        = bool
  default     = null
}

variable "latency_notifications" {
  description = "Notification recipients list for every alerting rules of latency detector"
  type        = list
  default     = []
}

variable "latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of latency detector"
  type        = list
  default     = []
}

variable "latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of latency detector"
  type        = list
  default     = []
}

variable "latency_aggregation_function" {
  description = "Aggregation function and group by for latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "latency_transformation_function" {
  description = "Transformation function for latency detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "latency_transformation_window" {
  description = "Transformation window for latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "latency_threshold_critical" {
  description = "Critical threshold for latency detector"
  type        = number
  default     = 3
}

variable "latency_threshold_warning" {
  description = "Warning threshold for latency detector"
  type        = number
  default     = 1
}

variable "latency_aperiodic_duration" {
  description = "Duration for the latency block"
  type        = string
  default     = "10m"
}

variable "latency_aperiodic_percentage" {
  description = "Percentage for the latency block"
  type        = number
  default     = 0.9
}

variable "latency_aperiodic_upper_strict" {
  description = "If True, compare stream against upper with strict inequality; if False, non-strict"
  type        = bool
  default     = "0"
}

# Httpcode_5xx detectors

variable "httpcode_5xx_disabled" {
  description = "Disable all alerting rules for httpcode_5xx detector"
  type        = bool
  default     = null
}

variable "httpcode_5xx_disabled_critical" {
  description = "Disable critical alerting rule for httpcode_5xx detector"
  type        = bool
  default     = null
}

variable "httpcode_5xx_disabled_warning" {
  description = "Disable warning alerting rule for httpcode_5xx detector"
  type        = bool
  default     = null
}

variable "httpcode_5xx_notifications" {
  description = "Notification recipients list for every alerting rules of httpcode_5xx detector"
  type        = list
  default     = []
}

variable "httpcode_5xx_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of httpcode_5xx detector"
  type        = list
  default     = []
}

variable "httpcode_5xx_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of httpcode_5xx detector"
  type        = list
  default     = []
}

variable "httpcode_5xx_aggregation_function" {
  description = "Aggregation function and group by for httpcode_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "httpcode_5xx_transformation_function" {
  description = "Transformation function for httpcode_5xx detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "httpcode_5xx_transformation_window" {
  description = "Transformation window for httpcode_5xx detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "httpcode_5xx_threshold_critical" {
  description = "Critical threshold for httpcode_5xx detector"
  type        = number
  default     = 80
}

variable "httpcode_5xx_threshold_warning" {
  description = "Warning threshold for httpcode_5xx detector"
  type        = number
  default     = 60
}

variable "httpcode_5xx_threshold_number_requests" {
  description = "Number threshold for httpcode_5xx detector"
  type        = number
  default     = 5
}

# Httpcode_4xx detectors

variable "httpcode_4xx_disabled" {
  description = "Disable all alerting rules for httpcode_4xx detector"
  type        = bool
  default     = null
}

variable "httpcode_4xx_disabled_critical" {
  description = "Disable critical alerting rule for httpcode_4xx detector"
  type        = bool
  default     = null
}

variable "httpcode_4xx_disabled_warning" {
  description = "Disable warning alerting rule for httpcode_4xx detector"
  type        = bool
  default     = null
}

variable "httpcode_4xx_notifications" {
  description = "Notification recipients list for every alerting rules of httpcode_4xx detector"
  type        = list
  default     = []
}

variable "httpcode_4xx_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of httpcode_4xx detector"
  type        = list
  default     = []
}

variable "httpcode_4xx_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of httpcode_4xx detector"
  type        = list
  default     = []
}

variable "httpcode_4xx_aggregation_function" {
  description = "Aggregation function and group by for httpcode_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "httpcode_4xx_transformation_function" {
  description = "Transformation function for httpcode_4xx detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "httpcode_4xx_transformation_window" {
  description = "Transformation window for httpcode_4xx detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "httpcode_4xx_threshold_critical" {
  description = "Critical threshold for httpcode_4xx detector"
  type        = number
  default     = 80
}

variable "httpcode_4xx_threshold_warning" {
  description = "Warning threshold for httpcode_4xx detector"
  type        = number
  default     = 60
}

variable "httpcode_4xx_threshold_number_requests" {
  description = "Number threshold for httpcode_4xx detector"
  type        = number
  default     = 5
}

# Httpcode_target_5xx detectors

variable "httpcode_target_5xx_disabled" {
  description = "Disable all alerting rules for httpcode_target_5xx detector"
  type        = bool
  default     = null
}

variable "httpcode_target_5xx_disabled_critical" {
  description = "Disable critical alerting rule for httpcode_target_5xx detector"
  type        = bool
  default     = null
}

variable "httpcode_target_5xx_disabled_warning" {
  description = "Disable warning alerting rule for httpcode_target_5xx detector"
  type        = bool
  default     = null
}

variable "httpcode_target_5xx_notifications" {
  description = "Notification recipients list for every alerting rules of httpcode_target_5xx detector"
  type        = list
  default     = []
}

variable "httpcode_target_5xx_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of httpcode_target_5xx detector"
  type        = list
  default     = []
}

variable "httpcode_target_5xx_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of httpcode_target_5xx detector"
  type        = list
  default     = []
}

variable "httpcode_target_5xx_aggregation_function" {
  description = "Aggregation function and group by for httpcode_target_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "httpcode_target_5xx_transformation_function" {
  description = "Transformation function for httpcode_target_5xx detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "httpcode_target_5xx_transformation_window" {
  description = "Transformation window for httpcode_target_5xx detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "httpcode_target_5xx_threshold_critical" {
  description = "Critical threshold for httpcode_target_5xx detector"
  type        = number
  default     = 80
}

variable "httpcode_target_5xx_threshold_warning" {
  description = "Warning threshold for httpcode_target_5xx detector"
  type        = number
  default     = 60
}

variable "httpcode_target_5xx_threshold_number_requests" {
  description = "Number threshold for httpcode_target_5xx detector"
  type        = number
  default     = 5
}

# Httpcode_target_4xx detectors

variable "httpcode_target_4xx_disabled" {
  description = "Disable all alerting rules for httpcode_target_4xx detector"
  type        = bool
  default     = null
}

variable "httpcode_target_4xx_disabled_critical" {
  description = "Disable critical alerting rule for httpcode_target_4xx detector"
  type        = bool
  default     = null
}

variable "httpcode_target_4xx_disabled_warning" {
  description = "Disable warning alerting rule for httpcode_target_4xx detector"
  type        = bool
  default     = null
}

variable "httpcode_target_4xx_notifications" {
  description = "Notification recipients list for every alerting rules of httpcode_target_4xx detector"
  type        = list
  default     = []
}

variable "httpcode_target_4xx_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of httpcode_target_4xx detector"
  type        = list
  default     = []
}

variable "httpcode_target_4xx_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of httpcode_target_4xx detector"
  type        = list
  default     = []
}

variable "httpcode_target_4xx_aggregation_function" {
  description = "Aggregation function and group by for httpcode_target_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "httpcode_target_4xx_transformation_function" {
  description = "Transformation function for httpcode_target_4xx detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "httpcode_target_4xx_transformation_window" {
  description = "Transformation window for httpcode_target_4xx detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "httpcode_target_4xx_threshold_critical" {
  description = "Critical threshold for httpcode_target_4xx detector"
  type        = number
  default     = 80
}

variable "httpcode_target_4xx_threshold_warning" {
  description = "Warning threshold for httpcode_target_4xx detector"
  type        = number
  default     = 60
}

variable "httpcode_target_4xx_threshold_number_requests" {
  description = "Number threshold for httpcode_target_4xx detector"
  type        = number
  default     = 5
}
