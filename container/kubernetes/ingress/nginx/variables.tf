# Module specific

variable "minimum_traffic" {
  description = "Minimum required traffic to evaluate rate of errors detectors"
  type        = number
  default     = 4
}

# ingress_5xx detector

variable "ingress_5xx_disabled" {
  description = "Disable all alerting rules for ingress_5xx detector"
  type        = bool
  default     = null
}

variable "ingress_5xx_disabled_critical" {
  description = "Disable critical alerting rule for ingress_5xx detector"
  type        = bool
  default     = null
}

variable "ingress_5xx_disabled_major" {
  description = "Disable major alerting rule for ingress_5xx detector"
  type        = bool
  default     = null
}

variable "ingress_5xx_notifications" {
  description = "Notification recipients list per severity overridden for ingress_5xx detector"
  type        = map(list(string))
  default     = {}
}

variable "ingress_5xx_aggregation_function" {
  description = "Aggregation function and group by for ingress_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  # per pod could be generate too many alerts
  #default = ".sum(by=['controller_namespace', 'controller_class', 'controller_pod', 'ingress'])"
  default = ".sum(by=['controller_namespace', 'controller_class', 'ingress'])"
}

variable "ingress_5xx_transformation_function" {
  description = "Transformation function for ingress_5xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "ingress_5xx_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "ingress_5xx_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "ingress_5xx_threshold_critical" {
  description = "Critical threshold for ingress_5xx detector"
  type        = number
  default     = 10
}

variable "ingress_5xx_threshold_major" {
  description = "Major threshold for ingress_5xx detector"
  type        = number
  default     = 5
}

# ingress_4xx detector

variable "ingress_4xx_disabled" {
  description = "Disable all alerting rules for ingress_4xx detector"
  type        = bool
  default     = null
}

variable "ingress_4xx_disabled_critical" {
  description = "Disable critical alerting rule for ingress_4xx detector"
  type        = bool
  default     = null
}

variable "ingress_4xx_disabled_major" {
  description = "Disable major alerting rule for ingress_4xx detector"
  type        = bool
  default     = null
}

variable "ingress_4xx_notifications" {
  description = "Notification recipients list per severity overridden for ingress_4xx detector"
  type        = map(list(string))
  default     = {}
}

variable "ingress_4xx_aggregation_function" {
  description = "Aggregation function and group by for ingress_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  # per pod could be generate too many alerts
  #default = ".sum(by=['controller_namespace', 'controller_class', 'controller_pod', 'ingress'])"
  default = ".sum(by=['controller_namespace', 'controller_class', 'ingress'])"
}

variable "ingress_4xx_transformation_function" {
  description = "Transformation function for ingress_4xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "ingress_4xx_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "ingress_4xx_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "ingress_4xx_threshold_critical" {
  description = "Critical threshold for ingress_4xx detector"
  type        = number
  default     = 40
}

variable "ingress_4xx_threshold_major" {
  description = "Major threshold for ingress_4xx detector"
  type        = number
  default     = 20
}

# ingress_latency detector

variable "ingress_latency_disabled" {
  description = "Disable all alerting rules for ingress_latency detector"
  type        = bool
  default     = null
}

variable "ingress_latency_disabled_critical" {
  description = "Disable critical alerting rule for ingress_latency detector"
  type        = bool
  default     = null
}

variable "ingress_latency_disabled_major" {
  description = "Disable major alerting rule for ingress_latency detector"
  type        = bool
  default     = null
}

variable "ingress_latency_notifications" {
  description = "Notification recipients list per severity overridden for ingress_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "ingress_latency_aggregation_function" {
  description = "Aggregation function and group by for ingress_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  # per pod could be generate too many alerts
  #default = ".sum(by=['controller_namespace', 'controller_class', 'controller_pod', 'ingress'])"
  default = ".sum(by=['controller_namespace', 'controller_class', 'ingress'])"
}

variable "ingress_latency_transformation_function" {
  description = "Transformation function for ingress_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "ingress_latency_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "ingress_latency_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "ingress_latency_threshold_critical" {
  description = "Critical threshold for ingress_latency detector"
  type        = number
  default     = 10
}

variable "ingress_latency_threshold_major" {
  description = "Major threshold for ingress_latency detector"
  type        = number
  default     = 5
}

