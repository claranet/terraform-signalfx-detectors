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

variable "minimum_traffic" {
  description = "Minimum required traffic to evaluate rate of errors detectors"
  type        = number
  default     = 4
}

# ingress_5xx detectors

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

variable "ingress_5xx_disabled_warning" {
  description = "Disable warning alerting rule for ingress_5xx detector"
  type        = bool
  default     = null
}

variable "ingress_5xx_notifications" {
  description = "Notification recipients list for every alerting rules of ingress_5xx detector"
  type        = list
  default     = []
}

variable "ingress_5xx_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of ingress_5xx detector"
  type        = list
  default     = []
}

variable "ingress_5xx_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of ingress_5xx detector"
  type        = list
  default     = []
}

variable "ingress_5xx_aggregation_function" {
  description = "Aggregation function and group by for ingress_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  # per pod could be generate too many alerts
  #default = ".sum(by=['controller_namespace', 'controller_class', 'controller_pod', 'ingress'])"
  default = ".sum(by=['controller_namespace', 'controller_class', 'ingress'])"
}

variable "ingress_5xx_transformation_function" {
  description = "Transformation function for ingress_5xx detector (i.e. \".mean(over='5m')\"))"
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

variable "ingress_5xx_threshold_warning" {
  description = "Warning threshold for ingress_5xx detector"
  type        = number
  default     = 5
}

# ingress_4xx detectors

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

variable "ingress_4xx_disabled_warning" {
  description = "Disable warning alerting rule for ingress_4xx detector"
  type        = bool
  default     = null
}

variable "ingress_4xx_notifications" {
  description = "Notification recipients list for every alerting rules of ingress_4xx detector"
  type        = list
  default     = []
}

variable "ingress_4xx_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of ingress_4xx detector"
  type        = list
  default     = []
}

variable "ingress_4xx_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of ingress_4xx detector"
  type        = list
  default     = []
}

variable "ingress_4xx_aggregation_function" {
  description = "Aggregation function and group by for ingress_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  # per pod could be generate too many alerts
  #default = ".sum(by=['controller_namespace', 'controller_class', 'controller_pod', 'ingress'])"
  default = ".sum(by=['controller_namespace', 'controller_class', 'ingress'])"
}

variable "ingress_4xx_transformation_function" {
  description = "Transformation function for ingress_4xx detector (i.e. \".mean(over='5m')\"))"
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

variable "ingress_4xx_threshold_warning" {
  description = "Warning threshold for ingress_4xx detector"
  type        = number
  default     = 20
}

# ingress_latency detectors

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

variable "ingress_latency_disabled_warning" {
  description = "Disable warning alerting rule for ingress_latency detector"
  type        = bool
  default     = null
}

variable "ingress_latency_notifications" {
  description = "Notification recipients list for every alerting rules of ingress_latency detector"
  type        = list
  default     = []
}

variable "ingress_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of ingress_latency detector"
  type        = list
  default     = []
}

variable "ingress_latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of ingress_latency detector"
  type        = list
  default     = []
}

variable "ingress_latency_aggregation_function" {
  description = "Aggregation function and group by for ingress_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  # per pod could be generate too many alerts
  #default = ".sum(by=['controller_namespace', 'controller_class', 'controller_pod', 'ingress'])"
  default = ".sum(by=['controller_namespace', 'controller_class', 'ingress'])"
}

variable "ingress_latency_transformation_function" {
  description = "Transformation function for ingress_latency detector (i.e. \".mean(over='5m')\"))"
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

variable "ingress_latency_threshold_warning" {
  description = "Warning threshold for ingress_latency detector"
  type        = number
  default     = 5
}

