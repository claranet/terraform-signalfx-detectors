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

# Kubernetes velero detectors specific

# Velero_scheduled_backup_missing detectors

variable "velero_scheduled_backup_missing_disabled" {
  description = "Disable all alerting rules for velero_scheduled_backup_missing detector"
  type        = bool
  default     = null
}

variable "velero_scheduled_backup_missing_notifications" {
  description = "Notification recipients list for every alerting rules of velero_scheduled_backup_missing detector"
  type        = list
  default     = []
}

variable "velero_scheduled_backup_missing_aggregation_function" {
  description = "Aggregation function and group by for velero_scheduled_backup_missing detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_cluster', 'kubernetes_namespace', 'schedule'])"
}

variable "velero_scheduled_backup_missing_transformation_function" {
  description = "Transformation function for velero_scheduled_backup_missing detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".sum(over='1d')"
}

# Velero_backup_failure detectors

variable "velero_backup_failure_disabled" {
  description = "Disable all alerting rules for velero_backup_failure detector"
  type        = bool
  default     = null
}

variable "velero_backup_failure_notifications" {
  description = "Notification recipients list for every alerting rules of velero_backup_failure detector"
  type        = list
  default     = []
}

variable "velero_backup_failure_aggregation_function" {
  description = "Aggregation function and group by for velero_backup_failure detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_cluster', 'kubernetes_namespace', 'schedule'])"
}

variable "velero_backup_failure_transformation_function" {
  description = "Transformation function for velero_backup_failure detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".sum(over='1d')"
}

# Velero_backup_partial_failure detectors

variable "velero_backup_partial_failure_disabled" {
  description = "Disable all alerting rules for velero_backup_partial_failure detector"
  type        = bool
  default     = null
}

variable "velero_backup_partial_failure_notifications" {
  description = "Notification recipients list for every alerting rules of velero_backup_partial_failure detector"
  type        = list
  default     = []
}

variable "velero_backup_partial_failure_aggregation_function" {
  description = "Aggregation function and group by for velero_backup_partial_failure detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_cluster', 'kubernetes_namespace', 'schedule'])"
}

variable "velero_backup_partial_failure_transformation_function" {
  description = "Transformation function for velero_backup_partial_failure detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".sum(over='1d')"
}

# Velero_backup_deletion_failure detectors

variable "velero_backup_deletion_failure_disabled" {
  description = "Disable all alerting rules for velero_backup_deletion_failure detector"
  type        = bool
  default     = null
}

variable "velero_backup_deletion_failure_notifications" {
  description = "Notification recipients list for every alerting rules of velero_backup_deletion_failure detector"
  type        = list
  default     = []
}

variable "velero_backup_deletion_failure_aggregation_function" {
  description = "Aggregation function and group by for velero_backup_deletion_failure detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_cluster', 'kubernetes_namespace', 'schedule'])"
}

variable "velero_backup_deletion_failure_transformation_function" {
  description = "Transformation function for velero_backup_deletion_failure detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".sum(over='1d')"
}

# Velero_volume_snapshot_failure detectors

variable "velero_volume_snapshot_failure_disabled" {
  description = "Disable all alerting rules for velero_volume_snapshot_failure detector"
  type        = bool
  default     = null
}

variable "velero_volume_snapshot_failure_notifications" {
  description = "Notification recipients list for every alerting rules of velero_volume_snapshot_failure detector"
  type        = list
  default     = []
}

variable "velero_volume_snapshot_failure_aggregation_function" {
  description = "Aggregation function and group by for velero_volume_snapshot_failure detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['kubernetes_cluster', 'kubernetes_namespace', 'schedule'])"
}

variable "velero_volume_snapshot_failure_transformation_function" {
  description = "Transformation function for velero_volume_snapshot_failure detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".sum(over='1d')"
}

