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
  default     = ".mean(by=['LoadBalancerName'])"
}

# no_healthy_instances detector

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

variable "no_healthy_instances_disabled_major" {
  description = "Disable major alerting rule for no_healthy_instances detector"
  type        = bool
  default     = null
}

variable "no_healthy_instances_notifications" {
  description = "Notification recipients list per severity overridden for no_healthy_instances detector"
  type        = map(list(string))
  default     = {}
}

variable "no_healthy_instances_aggregation_function" {
  description = "Aggregation function and group by for no_healthy_instances detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "no_healthy_instances_transformation_function" {
  description = "Transformation function for no_healthy_instances detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "no_healthy_instances_threshold_critical" {
  description = "Critical threshold for no_healthy_instances detector"
  type        = number
  default     = 1
}

variable "no_healthy_instances_threshold_major" {
  description = "Major threshold for no_healthy_instances detector"
  type        = number
  default     = 100
}

# 4xx detector

variable "elb_4xx_disabled" {
  description = "Disable all alerting rules for 4xx detector"
  type        = bool
  default     = null
}

variable "elb_4xx_disabled_critical" {
  description = "Disable critical alerting rule for 4xx detector"
  type        = bool
  default     = null
}

variable "elb_4xx_disabled_major" {
  description = "Disable major alerting rule for httpcode 4xx erros detector"
  type        = bool
  default     = null
}

variable "elb_4xx_notifications" {
  description = "Notification recipients list per severity overridden for 4xx detector"
  type        = map(list(string))
  default     = {}
}

variable "elb_4xx_aggregation_function" {
  description = "Aggregation function and group by for elb_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "elb_4xx_transformation_function" {
  description = "Transformation function for elb_4xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "elb_4xx_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "elb_4xx_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "elb_4xx_threshold_critical" {
  description = "Critical threshold for 4xx detector"
  type        = number
  default     = 40
}

variable "elb_4xx_threshold_major" {
  description = "Major threshold for 4xx detector"
  type        = number
  default     = 20
}

# 5xx detector

variable "elb_5xx_disabled" {
  description = "Disable all alerting rules for 5xx detector"
  type        = bool
  default     = null
}

variable "elb_5xx_disabled_critical" {
  description = "Disable critical alerting rule for 5xx detector"
  type        = bool
  default     = null
}

variable "elb_5xx_disabled_major" {
  description = "Disable major alerting rule for 5xx detector"
  type        = bool
  default     = null
}

variable "elb_5xx_notifications" {
  description = "Notification recipients list per severity overridden for 5xx detector"
  type        = map(list(string))
  default     = {}
}

variable "elb_5xx_aggregation_function" {
  description = "Aggregation function and group by for elb_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "elb_5xx_transformation_function" {
  description = "Transformation function for elb_5xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "elb_5xx_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "elb_5xx_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "elb_5xx_threshold_critical" {
  description = "Critical threshold for 5xx detector"
  type        = number
  default     = 10
}

variable "elb_5xx_threshold_major" {
  description = "Major threshold for 5xx detector"
  type        = number
  default     = 5
}

# backend_4xx detector

variable "backend_4xx_disabled" {
  description = "Disable all alerting rules for backend_4xx detector"
  type        = bool
  default     = null
}

variable "backend_4xx_disabled_critical" {
  description = "Disable critical alerting rule for backend_4xx detector"
  type        = bool
  default     = null
}

variable "backend_4xx_disabled_major" {
  description = "Disable major alerting rule for backend_4xx detector"
  type        = bool
  default     = null
}

variable "backend_4xx_notifications" {
  description = "Notification recipients list per severity overridden for backend_4xx detector"
  type        = map(list(string))
  default     = {}
}

variable "backend_4xx_aggregation_function" {
  description = "Aggregation function and group by for backend_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "backend_4xx_transformation_function" {
  description = "Transformation function for backend_4xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "backend_4xx_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "backend_4xx_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "backend_4xx_threshold_critical" {
  description = "Critical threshold for backend_4xx detector"
  type        = number
  default     = 40
}

variable "backend_4xx_threshold_major" {
  description = "Major threshold for backend_4xx detector"
  type        = number
  default     = 20
}

# backend_5xx detector

variable "backend_5xx_disabled" {
  description = "Disable all alerting rules for backend_5xx detector"
  type        = bool
  default     = null
}

variable "backend_5xx_disabled_critical" {
  description = "Disable critical alerting rule for backend_5xx detector"
  type        = bool
  default     = null
}

variable "backend_5xx_disabled_major" {
  description = "Disable major alerting rule for backend_5xx detector"
  type        = bool
  default     = null
}

variable "backend_5xx_notifications" {
  description = "Notification recipients list per severity overridden for backend_5xx detector"
  type        = map(list(string))
  default     = {}
}

variable "backend_5xx_aggregation_function" {
  description = "Aggregation function and group by for backend_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "backend_5xx_transformation_function" {
  description = "Transformation function for backend_5xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "backend_5xx_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "backend_5xx_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "backend_5xx_threshold_critical" {
  description = "Critical threshold for backend_5xx detector"
  type        = number
  default     = 10
}

variable "backend_5xx_threshold_major" {
  description = "Major threshold for backend_5xx detector"
  type        = number
  default     = 5
}

# Backend_latency detector

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

variable "backend_latency_disabled_major" {
  description = "Disable major alerting rule for backend_latency detector"
  type        = bool
  default     = null
}

variable "backend_latency_notifications" {
  description = "Notification recipients list per severity overridden for backend_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "backend_latency_aggregation_function" {
  description = "Aggregation function and group by for backend_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "backend_latency_transformation_function" {
  description = "Transformation function for backend_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "backend_latency_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 600
}

variable "backend_latency_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "backend_latency_threshold_critical" {
  description = "Critical threshold for backend_latency detector"
  type        = number
  default     = 3
}

variable "backend_latency_threshold_major" {
  description = "Major threshold for backend_latency detector"
  type        = number
  default     = 1
}

