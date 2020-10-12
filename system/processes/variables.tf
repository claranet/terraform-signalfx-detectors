# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx Module specific

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

#####

variable "processes_disabled" {
  description = "Disable all alerting rules for processes detector"
  type        = bool
  default     = null
}

variable "processes_disabled_critical" {
  description = "Disable critical alerting rule for processes detector"
  type        = bool
  default     = null
}

variable "processes_disabled_major" {
  description = "Disable major alerting rule for processes detector"
  type        = bool
  default     = true
}

variable "processes_notifications" {
  description = "Notification recipients list per severity overridden for processes detector"
  type        = map(list(string))
  default     = {}
}

variable "processes_aggregation_function" {
  description = "Aggregation function and group by for processes detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "processes_transformation_function" {
  description = "Transformation function for processes detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "processes_threshold_major" {
  description = "Major threshold for processes detector"
  type        = number
  default     = 2
}

