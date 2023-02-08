# backup_failed detector

variable "backup_failed_notifications" {
  description = "Notification recipients list per severity overridden for backup_failed detector"
  type        = map(list(string))
  default     = {}
}

variable "backup_failed_aggregation_function" {
  description = "Aggregation function and group by for backup_failed detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "backup_failed_transformation_function" {
  description = "Transformation function for backup_failed detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1h')"
}

variable "backup_failed_max_delay" {
  description = "Enforce max delay for backup_failed detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "backup_failed_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "backup_failed_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "backup_failed_disabled" {
  description = "Disable all alerting rules for backup_failed detector"
  type        = bool
  default     = null
}

variable "backup_failed_threshold_critical" {
  description = "Critical threshold for backup_failed detector in count"
  type        = number
  default     = 0
}

variable "backup_failed_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "2h"
}

variable "backup_failed_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# backup_job_expired detector

variable "backup_job_expired_notifications" {
  description = "Notification recipients list per severity overridden for backup_job_expired detector"
  type        = map(list(string))
  default     = {}
}

variable "backup_job_expired_aggregation_function" {
  description = "Aggregation function and group by for backup_job_expired detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "backup_job_expired_transformation_function" {
  description = "Transformation function for backup_job_expired detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1h')"
}

variable "backup_job_expired_max_delay" {
  description = "Enforce max delay for backup_job_expired detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "backup_job_expired_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "backup_job_expired_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "backup_job_expired_disabled" {
  description = "Disable all alerting rules for backup_job_expired detector"
  type        = bool
  default     = null
}

variable "backup_job_expired_threshold_critical" {
  description = "Critical threshold for backup_job_expired detector in count"
  type        = number
  default     = 0
}

variable "backup_job_expired_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "2h"
}

variable "backup_job_expired_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# backup_copy_jobs_failed detector

variable "backup_copy_jobs_failed_notifications" {
  description = "Notification recipients list per severity overridden for backup_copy_jobs_failed detector"
  type        = map(list(string))
  default     = {}
}

variable "backup_copy_jobs_failed_aggregation_function" {
  description = "Aggregation function and group by for backup_copy_jobs_failed detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "backup_copy_jobs_failed_transformation_function" {
  description = "Transformation function for backup_copy_jobs_failed detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1h')"
}

variable "backup_copy_jobs_failed_max_delay" {
  description = "Enforce max delay for backup_copy_jobs_failed detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "backup_copy_jobs_failed_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "backup_copy_jobs_failed_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "backup_copy_jobs_failed_disabled" {
  description = "Disable all alerting rules for backup_copy_jobs_failed detector"
  type        = bool
  default     = null
}

variable "backup_copy_jobs_failed_threshold_critical" {
  description = "Critical threshold for backup_copy_jobs_failed detector in count"
  type        = number
  default     = 0
}

variable "backup_copy_jobs_failed_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "2h"
}

variable "backup_copy_jobs_failed_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# backup detector

variable "backup_notifications" {
  description = "Notification recipients list per severity overridden for backup detector"
  type        = map(list(string))
  default     = {}
}

variable "backup_aggregation_function" {
  description = "Aggregation function and group by for backup detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "backup_transformation_function" {
  description = "Transformation function for backup detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='23h')"
}

variable "backup_max_delay" {
  description = "Enforce max delay for backup detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "backup_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "backup_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "backup_disabled" {
  description = "Disable all alerting rules for backup detector"
  type        = bool
  default     = null
}

variable "backup_threshold_critical" {
  description = "Critical threshold for backup detector in count"
  type        = number
  default     = 0
}

variable "backup_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1d"
}

variable "backup_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# backup_rp_partial detector

variable "backup_rp_partial_notifications" {
  description = "Notification recipients list per severity overridden for backup_rp_partial detector"
  type        = map(list(string))
  default     = {}
}

variable "backup_rp_partial_aggregation_function" {
  description = "Aggregation function and group by for backup_rp_partial detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "backup_rp_partial_transformation_function" {
  description = "Transformation function for backup_rp_partial detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1h')"
}

variable "backup_rp_partial_max_delay" {
  description = "Enforce max delay for backup_rp_partial detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "backup_rp_partial_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "backup_rp_partial_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "backup_rp_partial_disabled" {
  description = "Disable all alerting rules for backup_rp_partial detector"
  type        = bool
  default     = null
}

variable "backup_rp_partial_threshold_minor" {
  description = "Minor threshold for backup_rp_partial detector in count"
  type        = number
  default     = 0
}

variable "backup_rp_partial_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "2h"
}

variable "backup_rp_partial_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# backup_rp_expired detector

variable "backup_rp_expired_notifications" {
  description = "Notification recipients list per severity overridden for backup_rp_expired detector"
  type        = map(list(string))
  default     = {}
}

variable "backup_rp_expired_aggregation_function" {
  description = "Aggregation function and group by for backup_rp_expired detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "backup_rp_expired_transformation_function" {
  description = "Transformation function for backup_rp_expired detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1h')"
}

variable "backup_rp_expired_max_delay" {
  description = "Enforce max delay for backup_rp_expired detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "backup_rp_expired_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "backup_rp_expired_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "backup_rp_expired_disabled" {
  description = "Disable all alerting rules for backup_rp_expired detector"
  type        = bool
  default     = null
}

variable "backup_rp_expired_threshold_major" {
  description = "Major threshold for backup_rp_expired detector in count"
  type        = number
  default     = 0
}

variable "backup_rp_expired_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "2h"
}

variable "backup_rp_expired_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
