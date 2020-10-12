# Module specific

variable "minimum_traffic" {
  description = "Minimum required traffic to evaluate rate of errors detectors"
  type        = number
  default     = 4
}

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
  default     = ".mean(by=['LoadBalancer'])"
}

# No_healthy_instances detector

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

variable "no_healthy_instances_disabled_major" {
  description = "Disable major alerting rule for No_healthy_instances detector"
  type        = bool
  default     = null
}

variable "no_healthy_instances_notifications" {
  description = "Notification recipients list per severity overridden for No_healthy_instances detector"
  type        = map(list(string))
  default     = {}
}

variable "no_healthy_instances_aggregation_function" {
  description = "Aggregation function and group by for No_healthy_instances detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "no_healthy_instances_transformation_function" {
  description = "Transformation function for No_healthy_instances detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "no_healthy_instances_threshold_critical" {
  description = "Critical threshold for No_healthy_instances detector"
  type        = number
  default     = 1
}

variable "no_healthy_instances_threshold_major" {
  description = "Major threshold for No_healthy_instances detector"
  type        = number
  default     = 100
}

# Latency detector

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

variable "latency_disabled_major" {
  description = "Disable major alerting rule for latency detector"
  type        = bool
  default     = null
}

variable "latency_notifications" {
  description = "Notification recipients list per severity overridden for latency detector"
  type        = map(list(string))
  default     = {}
}

variable "latency_aggregation_function" {
  description = "Aggregation function and group by for latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "latency_transformation_function" {
  description = "Transformation function for latency detector (i.e. \".mean(over='5m')\")"
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

variable "latency_threshold_major" {
  description = "Major threshold for latency detector"
  type        = number
  default     = 1
}

# alb_5xx detector

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

variable "alb_5xx_disabled_major" {
  description = "Disable major alerting rule for alb_5xx detector"
  type        = bool
  default     = null
}

variable "alb_5xx_notifications" {
  description = "Notification recipients list per severity overridden for alb_5xx detector"
  type        = map(list(string))
  default     = {}
}

variable "alb_5xx_aggregation_function" {
  description = "Aggregation function and group by for alb_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "alb_5xx_transformation_function" {
  description = "Transformation function for alb_5xx detector (i.e. \".mean(over='5m')\")"
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

variable "alb_5xx_threshold_major" {
  description = "Major threshold for alb_5xx detector"
  type        = number
  default     = 5
}

# alb_4xx detector

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

variable "alb_4xx_disabled_major" {
  description = "Disable major alerting rule for alb_4xx detector"
  type        = bool
  default     = null
}

variable "alb_4xx_notifications" {
  description = "Notification recipients list per severity overridden for alb_4xx detector"
  type        = map(list(string))
  default     = {}
}

variable "alb_4xx_aggregation_function" {
  description = "Aggregation function and group by for alb_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "alb_4xx_transformation_function" {
  description = "Transformation function for alb_5xx detector (i.e. \".mean(over='5m')\")"
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

variable "alb_4xx_threshold_major" {
  description = "Major threshold for alb_4xx detector"
  type        = number
  default     = 20
}

# target_5xx detector

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

variable "target_5xx_disabled_major" {
  description = "Disable major alerting rule for target_5xx detector"
  type        = bool
  default     = null
}

variable "target_5xx_notifications" {
  description = "Notification recipients list per severity overridden for target_5xx detector"
  type        = map(list(string))
  default     = {}
}

variable "target_5xx_aggregation_function" {
  description = "Aggregation function and group by for target_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "target_5xx_transformation_function" {
  description = "Transformation function for target_5xx detector (i.e. \".mean(over='5m')\")"
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

variable "target_5xx_threshold_major" {
  description = "Major threshold for target_5xx detector"
  type        = number
  default     = 5
}

# target_4xx detector

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

variable "target_4xx_disabled_major" {
  description = "Disable major alerting rule for target_4xx detector"
  type        = bool
  default     = null
}

variable "target_4xx_notifications" {
  description = "Notification recipients list per severity overridden for target_4xx detector"
  type        = map(list(string))
  default     = {}
}

variable "target_4xx_aggregation_function" {
  description = "Aggregation function and group by for target_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "target_4xx_transformation_function" {
  description = "Transformation function for target_4xx detector (i.e. \".mean(over='5m')\")"
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

variable "target_4xx_threshold_major" {
  description = "Major threshold for target_4xx detector"
  type        = number
  default     = 20
}

