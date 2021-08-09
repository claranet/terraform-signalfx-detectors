# workloads_count detector

variable "workloads_count_notifications" {
  description = "Notification recipients list per severity overridden for workloads_count detector"
  type        = map(list(string))
  default     = {}
}

variable "workloads_count_aggregation_function" {
  description = "Aggregation function and group by for workloads_count detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_name','kubernetes_namespace']).count()"
}

variable "workloads_count_transformation_function" {
  description = "Transformation function for workloads_count detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "workloads_count_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "workloads_count_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "workloads_count_disabled" {
  description = "Disable all alerting rules for workloads_count detector"
  type        = bool
  default     = null
}

variable "workloads_count_disabled_minor" {
  description = "Disable minor alerting rule for workloads_count detector"
  type        = bool
  default     = null
}

variable "workloads_count_disabled_warning" {
  description = "Disable warning alerting rule for workloads_count detector"
  type        = bool
  default     = null
}

variable "workloads_count_threshold_minor" {
  description = "Minor threshold for workloads_count detector in records"
  type        = number
}

variable "workloads_count_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "None"
}

variable "workloads_count_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1.0
}

variable "workloads_count_threshold_warning" {
  description = "Warning threshold for workloads_count detector in records"
  type        = number
}

variable "workloads_count_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "None"
}

variable "workloads_count_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1.0
}

