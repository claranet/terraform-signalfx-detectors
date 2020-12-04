# Module specific

variable "minimum_traffic" {
  description = "Minimum required traffic to evaluate rate of errors detectors"
  type        = number
  default     = 4
}

variable "is_v2" {
  description = "Flag to use HTTP API Gateway (v2) instead of REST API Gateway (v1)"
  type        = bool
  default     = false
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
  default     = 3000
}

variable "latency_threshold_major" {
  description = "Major threshold for latency detector"
  type        = number
  default     = 1000
}

# Http_5xx detector

variable "http_5xx_disabled" {
  description = "Disable all alerting rules for http_5xx detector"
  type        = bool
  default     = null
}

variable "http_5xx_disabled_critical" {
  description = "Disable critical alerting rule for http_5xx detector"
  type        = bool
  default     = null
}

variable "http_5xx_disabled_major" {
  description = "Disable major alerting rule for http_5xx detector"
  type        = bool
  default     = null
}

variable "http_5xx_notifications" {
  description = "Notification recipients list per severity overridden for http_5xx detector"
  type        = map(list(string))
  default     = {}
}

variable "http_5xx_aggregation_function" {
  description = "Aggregation function and group by for http_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "http_5xx_transformation_function" {
  description = "Transformation function for http_5xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "http_5xx_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "http_5xx_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "http_5xx_threshold_critical" {
  description = "Critical threshold for http_5xx detector"
  type        = number
  default     = 10
}

variable "http_5xx_threshold_major" {
  description = "Major threshold for http_5xx detector"
  type        = number
  default     = 5
}

# Http_4xx detector

variable "http_4xx_disabled" {
  description = "Disable all alerting rules for http_4xx detector"
  type        = bool
  default     = null
}

variable "http_4xx_disabled_critical" {
  description = "Disable critical alerting rule for http_4xx detector"
  type        = bool
  default     = null
}

variable "http_4xx_disabled_major" {
  description = "Disable major alerting rule for http_4xx detector"
  type        = bool
  default     = null
}

variable "http_4xx_notifications" {
  description = "Notification recipients list per severity overridden for http_4xx detector"
  type        = map(list(string))
  default     = {}
}

variable "http_4xx_aggregation_function" {
  description = "Aggregation function and group by for http_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "http_4xx_transformation_function" {
  description = "Transformation function for http_4xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "http_4xx_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "http_4xx_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "http_4xx_threshold_critical" {
  description = "Critical threshold for http_4xx detector"
  type        = number
  default     = 40
}

variable "http_4xx_threshold_major" {
  description = "Major threshold for http_4xx detector"
  type        = number
  default     = 20
}

