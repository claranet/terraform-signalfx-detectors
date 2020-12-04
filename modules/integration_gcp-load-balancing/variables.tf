# Module specific

variable "gcp_project_id" {
  description = "GCP project id used for default filtering while lables are not synced"
  type        = string
}

variable "minimum_traffic" {
  description = "Minimum required traffic to evaluate rate of errors detectors"
  type        = number
  default     = 4
}

# Error_rate_4xx detector

variable "error_rate_4xx_disabled" {
  description = "Disable all alerting rules for error_rate_4xx detector"
  type        = bool
  default     = null
}

variable "error_rate_4xx_disabled_critical" {
  description = "Disable critical alerting rule for error_rate_4xx detector"
  type        = bool
  default     = null
}

variable "error_rate_4xx_disabled_major" {
  description = "Disable major alerting rule for error_rate_4xx detector"
  type        = bool
  default     = null
}

variable "error_rate_4xx_notifications" {
  description = "Notification recipients list per severity overridden for error_rate_4xx detector"
  type        = map(list(string))
  default     = {}
}

variable "error_rate_4xx_aggregation_function" {
  description = "Aggregation function and group by for error_rate_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['forwarding_rule_name', 'backend_target_name', 'backend_target_type'])"
}

variable "error_rate_4xx_transformation_function" {
  description = "Transformation function for error_rate_4xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "error_rate_4xx_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "error_rate_4xx_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "error_rate_4xx_threshold_critical" {
  description = "Critical threshold for error_rate_4xx detector"
  type        = number
  default     = 40
}

variable "error_rate_4xx_threshold_major" {
  description = "Major threshold for error_rate_4xx detector"
  type        = number
  default     = 20
}

# Error_rate_5xx detector

variable "error_rate_5xx_disabled" {
  description = "Disable all alerting rules for error_rate_5xx detector"
  type        = bool
  default     = null
}

variable "error_rate_5xx_disabled_critical" {
  description = "Disable critical alerting rule for error_rate_5xx detector"
  type        = bool
  default     = null
}

variable "error_rate_5xx_disabled_major" {
  description = "Disable major alerting rule for error_rate_5xx detector"
  type        = bool
  default     = null
}

variable "error_rate_5xx_notifications" {
  description = "Notification recipients list per severity overridden for error_rate_5xx detector"
  type        = map(list(string))
  default     = {}
}

variable "error_rate_5xx_aggregation_function" {
  description = "Aggregation function and group by for error_rate_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['forwarding_rule_name', 'backend_target_name', 'backend_target_type'])"
}

variable "error_rate_5xx_transformation_function" {
  description = "Transformation function for error_rate_5xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "error_rate_5xx_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "error_rate_5xx_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "error_rate_5xx_threshold_critical" {
  description = "Critical threshold for error_rate_5xx detector"
  type        = number
  default     = 10
}

variable "error_rate_5xx_threshold_major" {
  description = "Major threshold for error_rate_5xx detector"
  type        = number
  default     = 5
}

# backend_latency_service detector

variable "backend_latency_service_disabled" {
  description = "Disable all alerting rules for backend_latency_service detector"
  type        = bool
  default     = null
}

variable "backend_latency_service_disabled_critical" {
  description = "Disable critical alerting rule for backend_latency_service detector"
  type        = bool
  default     = null
}

variable "backend_latency_service_disabled_major" {
  description = "Disable major alerting rule for backend_latency_service detector"
  type        = bool
  default     = null
}

variable "backend_latency_service_notifications" {
  description = "Notification recipients list per severity overridden for backend_latency_service detector"
  type        = map(list(string))
  default     = {}
}

variable "backend_latency_service_aggregation_function" {
  description = "Aggregation function and group by for backend_latency_service detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['forwarding_rule_name', 'backend_target_name'])"
}

variable "backend_latency_service_transformation_function" {
  description = "Transformation function for backend_latency_service detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "backend_latency_service_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 600
}

variable "backend_latency_service_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "backend_latency_service_threshold_critical" {
  description = "Critical threshold for backend_latency_service detector"
  type        = number
  default     = 3000
}

variable "backend_latency_service_threshold_major" {
  description = "Major threshold for backend_latency_service detector"
  type        = number
  default     = 1000
}

# Backend_latency_bucket detector

variable "backend_latency_bucket_disabled" {
  description = "Disable all alerting rules for backend_latency_bucket detector"
  type        = bool
  default     = null
}

variable "backend_latency_bucket_disabled_critical" {
  description = "Disable critical alerting rule for backend_latency_bucket detector"
  type        = bool
  default     = null
}

variable "backend_latency_bucket_disabled_major" {
  description = "Disable major alerting rule for backend_latency_bucket detector"
  type        = bool
  default     = null
}

variable "backend_latency_bucket_notifications" {
  description = "Notification recipients list per severity overridden for backend_latency_bucket detector"
  type        = map(list(string))
  default     = {}
}

variable "backend_latency_bucket_aggregation_function" {
  description = "Aggregation function and group by for backend_latency_bucket detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['forwarding_rule_name', 'backend_target_name'])"
}

variable "backend_latency_bucket_transformation_function" {
  description = "Transformation function for backend_latency_bucket detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "backend_latency_bucket_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 600
}

variable "backend_latency_bucket_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "backend_latency_bucket_threshold_critical" {
  description = "Critical threshold for backend_latency_bucket detector"
  type        = number
  default     = 8000
}

variable "backend_latency_bucket_threshold_major" {
  description = "Major threshold for backend_latency_bucket detector"
  type        = number
  default     = 5000
}

# Request_count detector

variable "request_count_disabled" {
  description = "Disable all alerting rules for request_count detector"
  type        = bool
  default     = null
}

variable "request_count_notifications" {
  description = "Notification recipients list per severity overridden for request_count detector"
  type        = map(list(string))
  default     = {}
}

variable "request_count_aggregation_function" {
  description = "Aggregation function and group by for request_count detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['forwarding_rule_name', 'backend_target_name', 'backend_target_type'])"
}

variable "request_count_transformation_function" {
  description = "Transformation function for request_count detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "request_count_threshold_major" {
  description = "Major threshold for request_count detector"
  type        = number
  default     = 250
}

