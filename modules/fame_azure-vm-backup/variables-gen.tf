# vm_backup detector

variable "vm_backup_notifications" {
  description = "Notification recipients list per severity overridden for vm_backup detector"
  type        = map(list(string))
  default     = {}
}

variable "vm_backup_aggregation_function" {
  description = "Aggregation function and group by for vm_backup detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "vm_backup_transformation_function" {
  description = "Transformation function for vm_backup detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "vm_backup_max_delay" {
  description = "Enforce max delay for vm_backup detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "vm_backup_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "vm_backup_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "vm_backup_disabled" {
  description = "Disable all alerting rules for vm_backup detector"
  type        = bool
  default     = null
}

variable "vm_backup_threshold_critical" {
  description = "Critical threshold for vm_backup detector"
  type        = number
  default     = 1
}

variable "vm_backup_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1h"
}

variable "vm_backup_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
