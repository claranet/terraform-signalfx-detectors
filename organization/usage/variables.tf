# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
  default     = "global"
}

variable "runbook_url" {
  description = "Runbook url to add in detectors messages"
  type        = string
  default     = ""
}

variable "is_parent" {
  description = "Use \"child version\" of org metrics if true. Disable for child org."
  type        = bool
  default     = true
}

variable "multiplier" {
  description = "Multiplier should be 2 for \"enterprise\" or 1 for \"pro\" plan (i.e. 2 = 200 custom metrics and 20 containers per host)."
  type        = number
  default     = 2
}

# SignalFx module specific

variable "notifications" {
  description = "Default notification recipients list per severity"
  type = object({
    critical = list(string)
    major    = list(string)
    minor    = list(string)
    warning  = list(string)
    info     = list(string)
  })
}

variable "prefixes" {
  description = "Prefixes list to prepend between brackets on every monitors names before environment"
  type        = list
  default     = []
}

variable "detectors_disabled" {
  description = "Disable all detectors in this module"
  type        = bool
  default     = false
}

# Organization detectors specific

# hosts_limit detector

variable "hosts_limit_disabled" {
  description = "Disable all alerting rules for hosts_limit detector"
  type        = bool
  default     = null
}

variable "hosts_limit_notifications" {
  description = "Notification recipients list per severity overridden for hosts_limit detector"
  type        = map(list(string))
  default     = {}
}

variable "hosts_limit_transformation_function" {
  description = "Transformation function for hosts_limit detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='4w')"
}

# containers_limit detector

variable "containers_limit_disabled" {
  description = "Disable all alerting rules for containers_limit detector"
  type        = bool
  default     = null
}

variable "containers_limit_notifications" {
  description = "Notification recipients list per severity overridden for containers_limit detector"
  type        = map(list(string))
  default     = {}
}

variable "containers_limit_transformation_function" {
  description = "Transformation function for containers_limit detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='4w')"
}

# custom_metrics_limit detector

variable "custom_metrics_limit_disabled" {
  description = "Disable all alerting rules for custom_metrics_limit detector"
  type        = bool
  default     = null
}

variable "custom_metrics_limit_notifications" {
  description = "Notification recipients list per severity overridden for custom_metrics_limit detector"
  type        = map(list(string))
  default     = {}
}

variable "custom_metrics_limit_transformation_function" {
  description = "Transformation function for custom_metrics_limit detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='4w')"
}

# containers_ratio detector

variable "containers_ratio_disabled" {
  description = "Disable all alerting rules for containers_ratio detector"
  type        = bool
  default     = null
}

variable "containers_ratio_notifications" {
  description = "Notification recipients list per severity overridden for containers_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "containers_ratio_transformation_function" {
  description = "Transformation function for containers_ratio detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='4w')"
}

variable "containers_ratio_threshold_warning" {
  description = "Warning threshold for containers_ratio detector"
  type        = number
  default     = 100
}

# custom_metrics_ratio detector

variable "custom_metrics_ratio_disabled" {
  description = "Disable all alerting rules for custom_metrics_ratio detector"
  type        = bool
  default     = null
}

variable "custom_metrics_ratio_notifications" {
  description = "Notification recipients list per severity overridden for custom_metrics_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "custom_metrics_ratio_transformation_function" {
  description = "Transformation function for custom_metrics_ratio detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='4w')"
}

variable "custom_metrics_ratio_threshold_warning" {
  description = "Warning threshold for custom_metrics_ratio detector"
  type        = number
  default     = 100
}

