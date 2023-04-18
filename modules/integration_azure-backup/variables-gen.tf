# vm detector

variable "vm_notifications" {
  description = "Notification recipients list per severity overridden for vm detector"
  type        = map(list(string))
  default     = {}
}

variable "vm_aggregation_function" {
  description = "Aggregation function and group by for vm detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['backupinstancename', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "vm_transformation_function" {
  description = "Transformation function for vm detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".fill(0)"
}

variable "vm_max_delay" {
  description = "Enforce max delay for vm detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = 900
}

variable "vm_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "vm_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "vm_disabled" {
  description = "Disable all alerting rules for vm detector"
  type        = bool
  default     = null
}

variable "vm_disabled_critical" {
  description = "Disable critical alerting rule for vm detector"
  type        = bool
  default     = null
}

variable "vm_disabled_major" {
  description = "Disable major alerting rule for vm detector"
  type        = bool
  default     = null
}

variable "vm_threshold_critical" {
  description = "Critical threshold for vm detector"
  type        = number
  default     = 1
}

variable "vm_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "60h"
}

variable "vm_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "vm_threshold_major" {
  description = "Major threshold for vm detector"
  type        = number
  default     = 1
}

variable "vm_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "36h"
}

variable "vm_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# file_share detector

variable "file_share_notifications" {
  description = "Notification recipients list per severity overridden for file_share detector"
  type        = map(list(string))
  default     = {}
}

variable "file_share_aggregation_function" {
  description = "Aggregation function and group by for file_share detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['backupinstancename', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "file_share_transformation_function" {
  description = "Transformation function for file_share detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".fill(0)"
}

variable "file_share_max_delay" {
  description = "Enforce max delay for file_share detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = 900
}

variable "file_share_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "file_share_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "file_share_disabled" {
  description = "Disable all alerting rules for file_share detector"
  type        = bool
  default     = null
}

variable "file_share_disabled_critical" {
  description = "Disable critical alerting rule for file_share detector"
  type        = bool
  default     = null
}

variable "file_share_disabled_major" {
  description = "Disable major alerting rule for file_share detector"
  type        = bool
  default     = null
}

variable "file_share_threshold_critical" {
  description = "Critical threshold for file_share detector"
  type        = number
  default     = 1
}

variable "file_share_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "60h"
}

variable "file_share_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "file_share_threshold_major" {
  description = "Major threshold for file_share detector"
  type        = number
  default     = 1
}

variable "file_share_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "36h"
}

variable "file_share_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
