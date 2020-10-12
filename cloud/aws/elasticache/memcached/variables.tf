# Module specific

# hit_ratio detector

variable "hit_ratio_disabled" {
  description = "Disable all alerting rules for hit_ratio detector"
  type        = bool
  default     = null
}

variable "hit_ratio_disabled_critical" {
  description = "Disable critical alerting rule for hit_ratio detector"
  type        = bool
  default     = null
}

variable "hit_ratio_disabled_major" {
  description = "Disable major alerting rule for hit_ratio detector"
  type        = bool
  default     = null
}

variable "hit_ratio_notifications" {
  description = "Notification recipients list per severity overridden for hit_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "hit_ratio_aggregation_function" {
  description = "Aggregation function and group by for elb_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "hit_ratio_transformation_function" {
  description = "Transformation function for elb_4xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "hit_ratio_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "hit_ratio_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "hit_ratio_threshold_critical" {
  description = "Critical threshold for hit_ratio detector"
  type        = number
  default     = 60
}

variable "hit_ratio_threshold_major" {
  description = "Major threshold for hit_ratio detector"
  type        = number
  default     = 80
}

# cpu detector

variable "cpu_disabled" {
  description = "Disable all alerting rules for cpu detector"
  type        = bool
  default     = null
}

variable "cpu_disabled_critical" {
  description = "Disable critical alerting rule for cpu detector"
  type        = bool
  default     = null
}

variable "cpu_disabled_major" {
  description = "Disable major alerting rule for httpcode 5xx erros detector"
  type        = bool
  default     = null
}

variable "cpu_notifications" {
  description = "Notification recipients list per severity overridden for cpu detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_aggregation_function" {
  description = "Aggregation function and group by for cpu detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_transformation_function" {
  description = "Transformation function for cpu detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "cpu_threshold_critical" {
  description = "Critical threshold for cpu detector"
  type        = number
  default     = 90
}

variable "cpu_threshold_major" {
  description = "Major threshold for cpu detector"
  type        = number
  default     = 75
}

