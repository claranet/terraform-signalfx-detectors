# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

variable "gcp_project_name" {
  description = "GCP project name used for default filtering while lables are not synced"
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

# Failover_unavailable detectors

variable "failover_unavailable_disabled" {
  description = "Disable all alerting rules for failover_unavailable detector"
  type        = bool
  default     = null
}

variable "failover_unavailable_notifications" {
  description = "Notification recipients list for every alerting rules of failover_unavailable detector"
  type        = list
  default     = []
}

variable "failover_unavailable_aggregation_function" {
  description = "Aggregation function and group by for failover_unavailable detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "failover_unavailable_transformation_function" {
  description = "Transformation function for failover_unavailable detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".max(over='10m')"
}

