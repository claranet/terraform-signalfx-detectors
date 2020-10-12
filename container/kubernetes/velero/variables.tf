# Module specific

# Velero_scheduled_backup_missing detector

variable "velero_scheduled_backup_missing_disabled" {
  description = "Disable all alerting rules for velero_scheduled_backup_missing detector"
  type        = bool
  default     = null
}

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

# Velero_backup_failure detector

variable "velero_backup_failure_disabled" {
  description = "Disable all alerting rules for velero_backup_failure detector"
  type        = bool
  default     = null
}

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

# Velero_backup_partial_failure detector

variable "velero_backup_partial_failure_disabled" {
  description = "Disable all alerting rules for velero_backup_partial_failure detector"
  type        = bool
  default     = null
}

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

# Velero_backup_deletion_failure detector

variable "velero_backup_deletion_failure_disabled" {
  description = "Disable all alerting rules for velero_backup_deletion_failure detector"
  type        = bool
  default     = null
}

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

# Velero_volume_snapshot_failure detector

variable "velero_volume_snapshot_failure_disabled" {
  description = "Disable all alerting rules for velero_volume_snapshot_failure detector"
  type        = bool
  default     = null
}

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

