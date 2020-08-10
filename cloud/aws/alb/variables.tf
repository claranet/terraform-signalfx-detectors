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

variable "minimum_traffic" {
  description = "Minimum required traffic to evaluate rate of errors detectors"
  type        = number
  default     = 4
}

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
  default     = ".min(over='5m')"
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
  description = "Transformation function for latency detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ""
}

variable "latency_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 600
}

variable "latency_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
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

# alb_5xx detectors

variable "alb_5xx_disabled" {
  description = "Disable all alerting rules for alb_5xx detector"
  type        = bool
  default     = null
}

variable "alb_5xx_disabled_critical" {
  description = "Disable critical alerting rule for alb_5xx detector"
  type        = bool
  default     = null
}

variable "alb_5xx_disabled_warning" {
  description = "Disable warning alerting rule for alb_5xx detector"
  type        = bool
  default     = null
}

variable "alb_5xx_notifications" {
  description = "Notification recipients list for every alerting rules of alb_5xx detector"
  type        = list
  default     = []
}

variable "alb_5xx_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of alb_5xx detector"
  type        = list
  default     = []
}

variable "alb_5xx_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of alb_5xx detector"
  type        = list
  default     = []
}

variable "alb_5xx_aggregation_function" {
  description = "Aggregation function and group by for alb_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "alb_5xx_transformation_function" {
  description = "Transformation function for alb_5xx detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ""
}

variable "alb_5xx_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "alb_5xx_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "alb_5xx_threshold_critical" {
  description = "Critical threshold for alb_5xx detector"
  type        = number
  default     = 10
}

variable "alb_5xx_threshold_warning" {
  description = "Warning threshold for alb_5xx detector"
  type        = number
  default     = 5
}

# alb_4xx detectors

variable "alb_4xx_disabled" {
  description = "Disable all alerting rules for alb_4xx detector"
  type        = bool
  default     = null
}

variable "alb_4xx_disabled_critical" {
  description = "Disable critical alerting rule for alb_4xx detector"
  type        = bool
  default     = null
}

variable "alb_4xx_disabled_warning" {
  description = "Disable warning alerting rule for alb_4xx detector"
  type        = bool
  default     = null
}

variable "alb_4xx_notifications" {
  description = "Notification recipients list for every alerting rules of alb_4xx detector"
  type        = list
  default     = []
}

variable "alb_4xx_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of alb_4xx detector"
  type        = list
  default     = []
}

variable "alb_4xx_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of alb_4xx detector"
  type        = list
  default     = []
}

variable "alb_4xx_aggregation_function" {
  description = "Aggregation function and group by for alb_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "alb_4xx_transformation_function" {
  description = "Transformation function for alb_5xx detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ""
}

variable "alb_4xx_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "alb_4xx_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "alb_4xx_threshold_critical" {
  description = "Critical threshold for alb_4xx detector"
  type        = number
  default     = 40
}

variable "alb_4xx_threshold_warning" {
  description = "Warning threshold for alb_4xx detector"
  type        = number
  default     = 20
}

# target_5xx detectors

variable "target_5xx_disabled" {
  description = "Disable all alerting rules for target_5xx detector"
  type        = bool
  default     = null
}

variable "target_5xx_disabled_critical" {
  description = "Disable critical alerting rule for target_5xx detector"
  type        = bool
  default     = null
}

variable "target_5xx_disabled_warning" {
  description = "Disable warning alerting rule for target_5xx detector"
  type        = bool
  default     = null
}

variable "target_5xx_notifications" {
  description = "Notification recipients list for every alerting rules of target_5xx detector"
  type        = list
  default     = []
}

variable "target_5xx_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of target_5xx detector"
  type        = list
  default     = []
}

variable "target_5xx_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of target_5xx detector"
  type        = list
  default     = []
}

variable "target_5xx_aggregation_function" {
  description = "Aggregation function and group by for target_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "target_5xx_transformation_function" {
  description = "Transformation function for target_5xx detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ""
}

variable "target_5xx_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "target_5xx_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "target_5xx_threshold_critical" {
  description = "Critical threshold for target_5xx detector"
  type        = number
  default     = 10
}

variable "target_5xx_threshold_warning" {
  description = "Warning threshold for target_5xx detector"
  type        = number
  default     = 5
}

# target_4xx detectors

variable "target_4xx_disabled" {
  description = "Disable all alerting rules for target_4xx detector"
  type        = bool
  default     = null
}

variable "target_4xx_disabled_critical" {
  description = "Disable critical alerting rule for target_4xx detector"
  type        = bool
  default     = null
}

variable "target_4xx_disabled_warning" {
  description = "Disable warning alerting rule for target_4xx detector"
  type        = bool
  default     = null
}

variable "target_4xx_notifications" {
  description = "Notification recipients list for every alerting rules of target_4xx detector"
  type        = list
  default     = []
}

variable "target_4xx_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of target_4xx detector"
  type        = list
  default     = []
}

variable "target_4xx_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of target_4xx detector"
  type        = list
  default     = []
}

variable "target_4xx_aggregation_function" {
  description = "Aggregation function and group by for target_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "target_4xx_transformation_function" {
  description = "Transformation function for target_4xx detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ""
}

variable "target_4xx_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "target_4xx_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "target_4xx_threshold_critical" {
  description = "Critical threshold for target_4xx detector"
  type        = number
  default     = 40
}

variable "target_4xx_threshold_warning" {
  description = "Warning threshold for target_4xx detector"
  type        = number
  default     = 20
}

