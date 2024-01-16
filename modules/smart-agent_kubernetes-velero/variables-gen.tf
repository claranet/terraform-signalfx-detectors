# velero_scheduled_backup_missing detector

variable "velero_scheduled_backup_missing_notifications" {
  description = "Notification recipients list per severity overridden for velero_scheduled_backup_missing detector"
  type        = map(list(string))
  default     = {}
}

variable "velero_scheduled_backup_missing_aggregation_function" {
  description = "Aggregation function and group by for velero_scheduled_backup_missing detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_cluster', 'schedule'])"
}

variable "velero_scheduled_backup_missing_transformation_function" {
  description = "Transformation function for velero_scheduled_backup_missing detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".sum(over='1d')"
}

variable "velero_scheduled_backup_missing_max_delay" {
  description = "Enforce max delay for velero_scheduled_backup_missing detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "velero_scheduled_backup_missing_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "velero_scheduled_backup_missing_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "velero_scheduled_backup_missing_disabled" {
  description = "Disable all alerting rules for velero_scheduled_backup_missing detector"
  type        = bool
  default     = null
}

variable "velero_scheduled_backup_missing_threshold_major" {
  description = "Major threshold for velero_scheduled_backup_missing detector"
  type        = number
  default     = 1
}

variable "velero_scheduled_backup_missing_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "velero_scheduled_backup_missing_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# velero_backup_failure detector

variable "velero_backup_failure_notifications" {
  description = "Notification recipients list per severity overridden for velero_backup_failure detector"
  type        = map(list(string))
  default     = {}
}

variable "velero_backup_failure_aggregation_function" {
  description = "Aggregation function and group by for velero_backup_failure detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_cluster', 'schedule'])"
}

variable "velero_backup_failure_transformation_function" {
  description = "Transformation function for velero_backup_failure detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".sum(over='1d')"
}

variable "velero_backup_failure_max_delay" {
  description = "Enforce max delay for velero_backup_failure detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "velero_backup_failure_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "velero_backup_failure_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "velero_backup_failure_disabled" {
  description = "Disable all alerting rules for velero_backup_failure detector"
  type        = bool
  default     = null
}

variable "velero_backup_failure_threshold_major" {
  description = "Major threshold for velero_backup_failure detector"
  type        = number
  default     = 0
}

variable "velero_backup_failure_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "velero_backup_failure_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# velero_backup_partial_failure detector

variable "velero_backup_partial_failure_notifications" {
  description = "Notification recipients list per severity overridden for velero_backup_partial_failure detector"
  type        = map(list(string))
  default     = {}
}

variable "velero_backup_partial_failure_aggregation_function" {
  description = "Aggregation function and group by for velero_backup_partial_failure detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_cluster', 'schedule'])"
}

variable "velero_backup_partial_failure_transformation_function" {
  description = "Transformation function for velero_backup_partial_failure detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".sum(over='1d')"
}

variable "velero_backup_partial_failure_max_delay" {
  description = "Enforce max delay for velero_backup_partial_failure detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "velero_backup_partial_failure_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "velero_backup_partial_failure_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "velero_backup_partial_failure_disabled" {
  description = "Disable all alerting rules for velero_backup_partial_failure detector"
  type        = bool
  default     = null
}

variable "velero_backup_partial_failure_threshold_major" {
  description = "Major threshold for velero_backup_partial_failure detector"
  type        = number
  default     = 0
}

variable "velero_backup_partial_failure_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "velero_backup_partial_failure_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# velero_backup_deletion_failure detector

variable "velero_backup_deletion_failure_notifications" {
  description = "Notification recipients list per severity overridden for velero_backup_deletion_failure detector"
  type        = map(list(string))
  default     = {}
}

variable "velero_backup_deletion_failure_aggregation_function" {
  description = "Aggregation function and group by for velero_backup_deletion_failure detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_cluster', 'schedule'])"
}

variable "velero_backup_deletion_failure_transformation_function" {
  description = "Transformation function for velero_backup_deletion_failure detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".sum(over='1d')"
}

variable "velero_backup_deletion_failure_max_delay" {
  description = "Enforce max delay for velero_backup_deletion_failure detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "velero_backup_deletion_failure_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "velero_backup_deletion_failure_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "velero_backup_deletion_failure_disabled" {
  description = "Disable all alerting rules for velero_backup_deletion_failure detector"
  type        = bool
  default     = null
}

variable "velero_backup_deletion_failure_threshold_major" {
  description = "Major threshold for velero_backup_deletion_failure detector"
  type        = number
  default     = 0
}

variable "velero_backup_deletion_failure_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "velero_backup_deletion_failure_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# velero_volume_snapshot_failure detector

variable "velero_volume_snapshot_failure_notifications" {
  description = "Notification recipients list per severity overridden for velero_volume_snapshot_failure detector"
  type        = map(list(string))
  default     = {}
}

variable "velero_volume_snapshot_failure_aggregation_function" {
  description = "Aggregation function and group by for velero_volume_snapshot_failure detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_cluster', 'schedule'])"
}

variable "velero_volume_snapshot_failure_transformation_function" {
  description = "Transformation function for velero_volume_snapshot_failure detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".sum(over='1d')"
}

variable "velero_volume_snapshot_failure_max_delay" {
  description = "Enforce max delay for velero_volume_snapshot_failure detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "velero_volume_snapshot_failure_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "velero_volume_snapshot_failure_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "velero_volume_snapshot_failure_disabled" {
  description = "Disable all alerting rules for velero_volume_snapshot_failure detector"
  type        = bool
  default     = null
}

variable "velero_volume_snapshot_failure_threshold_major" {
  description = "Major threshold for velero_volume_snapshot_failure detector"
  type        = number
  default     = 0
}

variable "velero_volume_snapshot_failure_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "velero_volume_snapshot_failure_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
