# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Notification recipients list for every detectors"
  type        = list(string)
}

variable "prefixes" {
  description = "Prefixes list to prepend between brackets on every monitors names before environment"
  type        = list(string)
  default     = []
}

variable "filter_custom_includes" {
  description = "List of tags to include when custom filtering is used"
  type        = list(string)
  default     = []
}

variable "filter_custom_excludes" {
  description = "List of tags to exclude when custom filtering is used"
  type        = list(string)
  default     = []
}

variable "detectors_disabled" {
  description = "Disable all detectors in this module"
  type        = bool
  default     = false
}

# Azure storage detectors specific

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_notifications" {
  description = "Notification recipients list for every alerting rules of heartbeat detector"
  type        = list(string)
  default     = []
}

variable "heartbeat_timeframe" {
  description = "Timeframe for system not reporting detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

# Blobservices_requests_error detectors

variable "blobservices_requests_error_disabled" {
  description = "Disable all alerting rules for blobservices_requests_error detector"
  type        = bool
  default     = null
}

variable "blobservices_requests_error_disabled_critical" {
  description = "Disable critical alerting rule for blobservices_requests_error detector"
  type        = bool
  default     = null
}

variable "blobservices_requests_error_disabled_warning" {
  description = "Disable warning alerting rule for blobservices_requests_error detector"
  type        = bool
  default     = null
}

variable "blobservices_requests_error_notifications" {
  description = "Notification recipients list for every alerting rules of blobservices_requests_error detector"
  type        = list(string)
  default     = []
}

variable "blobservices_requests_error_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of blobservices_requests_error detector"
  type        = list(string)
  default     = []
}

variable "blobservices_requests_error_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of blobservices_requests_error detector"
  type        = list(string)
  default     = []
}

variable "blobservices_requests_error_aggregation_function" {
  description = "Aggregation function and group by for blobservices_requests_error detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "blobservices_requests_error_transformation_function" {
  description = "Transformation function for blobservices_requests_error detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "blobservices_requests_error_transformation_window" {
  description = "Transformation window for blobservices_requests_error detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "blobservices_requests_error_threshold_critical" {
  description = "Critical threshold for blobservices_requests_error detector"
  type        = number
  default     = 90
}

variable "blobservices_requests_error_threshold_warning" {
  description = "Warning threshold for blobservices_requests_error detector"
  type        = number
  default     = 70
}

variable "blobservices_requests_error_aperiodic_duration" {
  description = "Duration for the blobservices_requests_error block"
  type        = string
  default     = "10m"
}

variable "blobservices_requests_error_aperiodic_percentage" {
  description = "Percentage for the blobservices_requests_error block"
  type        = number
  default     = 0.9
}

# Fileservices_requests_error detectors

variable "fileservices_requests_error_disabled" {
  description = "Disable all alerting rules for fileservices_requests_error detector"
  type        = bool
  default     = null
}

variable "fileservices_requests_error_disabled_critical" {
  description = "Disable critical alerting rule for fileservices_requests_error detector"
  type        = bool
  default     = null
}

variable "fileservices_requests_error_disabled_warning" {
  description = "Disable warning alerting rule for fileservices_requests_error detector"
  type        = bool
  default     = null
}

variable "fileservices_requests_error_notifications" {
  description = "Notification recipients list for every alerting rules of fileservices_requests_error detector"
  type        = list(string)
  default     = []
}

variable "fileservices_requests_error_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of fileservices_requests_error detector"
  type        = list(string)
  default     = []
}

variable "fileservices_requests_error_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of fileservices_requests_error detector"
  type        = list(string)
  default     = []
}

variable "fileservices_requests_error_aggregation_function" {
  description = "Aggregation function and group by for fileservices_requests_error detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "fileservices_requests_error_transformation_function" {
  description = "Transformation function for fileservices_requests_error detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "fileservices_requests_error_transformation_window" {
  description = "Transformation window for fileservices_requests_error detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "fileservices_requests_error_threshold_critical" {
  description = "Critical threshold for fileservices_requests_error detector"
  type        = number
  default     = 90
}

variable "fileservices_requests_error_threshold_warning" {
  description = "Warning threshold for fileservices_requests_error detector"
  type        = number
  default     = 70
}

variable "fileservices_requests_error_aperiodic_duration" {
  description = "Duration for the fileservices_requests_error block"
  type        = string
  default     = "10m"
}

variable "fileservices_requests_error_aperiodic_percentage" {
  description = "Percentage for the fileservices_requests_error block"
  type        = number
  default     = 0.9
}

# Queueservices_requests_error detectors

variable "queueservices_requests_error_disabled" {
  description = "Disable all alerting rules for queueservices_requests_error detector"
  type        = bool
  default     = null
}

variable "queueservices_requests_error_disabled_critical" {
  description = "Disable critical alerting rule for queueservices_requests_error detector"
  type        = bool
  default     = null
}

variable "queueservices_requests_error_disabled_warning" {
  description = "Disable warning alerting rule for queueservices_requests_error detector"
  type        = bool
  default     = null
}

variable "queueservices_requests_error_notifications" {
  description = "Notification recipients list for every alerting rules of queueservices_requests_error detector"
  type        = list(string)
  default     = []
}

variable "queueservices_requests_error_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of queueservices_requests_error detector"
  type        = list(string)
  default     = []
}

variable "queueservices_requests_error_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of queueservices_requests_error detector"
  type        = list(string)
  default     = []
}

variable "queueservices_requests_error_aggregation_function" {
  description = "Aggregation function and group by for queueservices_requests_error detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "queueservices_requests_error_transformation_function" {
  description = "Transformation function for queueservices_requests_error detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "queueservices_requests_error_transformation_window" {
  description = "Transformation window for queueservices_requests_error detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "queueservices_requests_error_threshold_critical" {
  description = "Critical threshold for queueservices_requests_error detector"
  type        = number
  default     = 90
}

variable "queueservices_requests_error_threshold_warning" {
  description = "Warning threshold for queueservices_requests_error detector"
  type        = number
  default     = 70
}

variable "queueservices_requests_error_aperiodic_duration" {
  description = "Duration for the queueservices_requests_error block"
  type        = string
  default     = "10m"
}

variable "queueservices_requests_error_aperiodic_percentage" {
  description = "Percentage for the queueservices_requests_error block"
  type        = number
  default     = 0.9
}

# Tableservices_requests_error detectors

variable "tableservices_requests_error_disabled" {
  description = "Disable all alerting rules for tableservices_requests_error detector"
  type        = bool
  default     = null
}

variable "tableservices_requests_error_disabled_critical" {
  description = "Disable critical alerting rule for tableservices_requests_error detector"
  type        = bool
  default     = null
}

variable "tableservices_requests_error_disabled_warning" {
  description = "Disable warning alerting rule for tableservices_requests_error detector"
  type        = bool
  default     = null
}

variable "tableservices_requests_error_notifications" {
  description = "Notification recipients list for every alerting rules of tableservices_requests_error detector"
  type        = list(string)
  default     = []
}

variable "tableservices_requests_error_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of tableservices_requests_error detector"
  type        = list(string)
  default     = []
}

variable "tableservices_requests_error_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of tableservices_requests_error detector"
  type        = list(string)
  default     = []
}

variable "tableservices_requests_error_aggregation_function" {
  description = "Aggregation function and group by for tableservices_requests_error detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "tableservices_requests_error_transformation_function" {
  description = "Transformation function for tableservices_requests_error detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "tableservices_requests_error_transformation_window" {
  description = "Transformation window for tableservices_requests_error detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "tableservices_requests_error_threshold_critical" {
  description = "Critical threshold for tableservices_requests_error detector"
  type        = number
  default     = 90
}

variable "tableservices_requests_error_threshold_warning" {
  description = "Warning threshold for tableservices_requests_error detector"
  type        = number
  default     = 70
}

variable "tableservices_requests_error_aperiodic_duration" {
  description = "Duration for the tableservices_requests_error block"
  type        = string
  default     = "10m"
}

variable "tableservices_requests_error_aperiodic_percentage" {
  description = "Percentage for the tableservices_requests_error block"
  type        = number
  default     = 0.9
}

# Blobservices_latency detectors

variable "blobservices_latency_disabled" {
  description = "Disable all alerting rules for Blobservices_latency detector"
  type        = bool
  default     = null
}

variable "blobservices_latency_disabled_critical" {
  description = "Disable critical alerting rule for Blobservices_latency detector"
  type        = bool
  default     = null
}

variable "blobservices_latency_disabled_warning" {
  description = "Disable warning alerting rule for Blobservices_latency detector"
  type        = bool
  default     = null
}

variable "blobservices_latency_notifications" {
  description = "Notification recipients list for every alerting rules of Blobservices_latency detector"
  type        = list(string)
  default     = []
}

variable "blobservices_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of Blobservices_latency detector"
  type        = list(string)
  default     = []
}

variable "blobservices_latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of Blobservices_latency detector"
  type        = list(string)
  default     = []
}

variable "blobservices_latency_aggregation_function" {
  description = "Aggregation function and group by for Blobservices_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "blobservices_latency_transformation_function" {
  description = "Transformation function for Blobservices_latency detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "blobservices_latency_transformation_window" {
  description = "Transformation window for Blobservices_latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "blobservices_latency_threshold_critical" {
  description = "Critical threshold for Blobservices_latency detector"
  type        = number
  default     = 2000
}

variable "blobservices_latency_threshold_warning" {
  description = "Warning threshold for Blobservices_latency detector"
  type        = number
  default     = 1000
}

variable "blobservices_latency_aperiodic_duration" {
  description = "Duration for the Blobservices_latency block"
  type        = string
  default     = "10m"
}

variable "blobservices_latency_aperiodic_percentage" {
  description = "Percentage for the Blobservices_latency block"
  type        = number
  default     = 0.9
}

# fileservices_latency detectors

variable "fileservices_latency_disabled" {
  description = "Disable all alerting rules for fileservices_latency detector"
  type        = bool
  default     = null
}

variable "fileservices_latency_disabled_critical" {
  description = "Disable critical alerting rule for fileservices_latency detector"
  type        = bool
  default     = null
}

variable "fileservices_latency_disabled_warning" {
  description = "Disable warning alerting rule for fileservices_latency detector"
  type        = bool
  default     = null
}

variable "fileservices_latency_notifications" {
  description = "Notification recipients list for every alerting rules of fileservices_latency detector"
  type        = list(string)
  default     = []
}

variable "fileservices_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of fileservices_latency detector"
  type        = list(string)
  default     = []
}

variable "fileservices_latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of fileservices_latency detector"
  type        = list(string)
  default     = []
}

variable "fileservices_latency_aggregation_function" {
  description = "Aggregation function and group by for fileservices_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "fileservices_latency_transformation_function" {
  description = "Transformation function for fileservices_latency detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "fileservices_latency_transformation_window" {
  description = "Transformation window for fileservices_latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "fileservices_latency_threshold_critical" {
  description = "Critical threshold for fileservices_latency detector"
  type        = number
  default     = 2000
}

variable "fileservices_latency_threshold_warning" {
  description = "Warning threshold for fileservices_latency detector"
  type        = number
  default     = 1000
}

variable "fileservices_latency_aperiodic_duration" {
  description = "Duration for the fileservices_latency block"
  type        = string
  default     = "10m"
}

variable "fileservices_latency_aperiodic_percentage" {
  description = "Percentage for the fileservices_latency block"
  type        = number
  default     = 0.9
}

# Queueservices_latency detectors

variable "queueservices_latency_disabled" {
  description = "Disable all alerting rules for queueservices_latency detector"
  type        = bool
  default     = null
}

variable "queueservices_latency_disabled_critical" {
  description = "Disable critical alerting rule for queueservices_latency detector"
  type        = bool
  default     = null
}

variable "queueservices_latency_disabled_warning" {
  description = "Disable warning alerting rule for queueservices_latency detector"
  type        = bool
  default     = null
}

variable "queueservices_latency_notifications" {
  description = "Notification recipients list for every alerting rules of queueservices_latency detector"
  type        = list(string)
  default     = []
}

variable "queueservices_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of queueservices_latency detector"
  type        = list(string)
  default     = []
}

variable "queueservices_latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of queueservices_latency detector"
  type        = list(string)
  default     = []
}

variable "queueservices_latency_aggregation_function" {
  description = "Aggregation function and group by for queueservices_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "queueservices_latency_transformation_function" {
  description = "Transformation function for queueservices_latency detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "queueservices_latency_transformation_window" {
  description = "Transformation window for queueservices_latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "queueservices_latency_threshold_critical" {
  description = "Critical threshold for queueservices_latency detector"
  type        = number
  default     = 2000
}

variable "queueservices_latency_threshold_warning" {
  description = "Warning threshold for queueservices_latency detector"
  type        = number
  default     = 1000
}

variable "queueservices_latency_aperiodic_duration" {
  description = "Duration for the queueservices_latency block"
  type        = string
  default     = "10m"
}

variable "queueservices_latency_aperiodic_percentage" {
  description = "Percentage for the queueservices_latency block"
  type        = number
  default     = 0.9
}

# Tableservices_latency detectors

variable "tableservices_latency_disabled" {
  description = "Disable all alerting rules for tableservices_latency detector"
  type        = bool
  default     = null
}

variable "tableservices_latency_disabled_critical" {
  description = "Disable critical alerting rule for tableservices_latency detector"
  type        = bool
  default     = null
}

variable "tableservices_latency_disabled_warning" {
  description = "Disable warning alerting rule for tableservices_latency detector"
  type        = bool
  default     = null
}

variable "tableservices_latency_notifications" {
  description = "Notification recipients list for every alerting rules of tableservices_latency detector"
  type        = list(string)
  default     = []
}

variable "tableservices_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of tableservices_latency detector"
  type        = list(string)
  default     = []
}

variable "tableservices_latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of tableservices_latency detector"
  type        = list(string)
  default     = []
}

variable "tableservices_latency_aggregation_function" {
  description = "Aggregation function and group by for tableservices_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "tableservices_latency_transformation_function" {
  description = "Transformation function for tableservices_latency detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "tableservices_latency_transformation_window" {
  description = "Transformation window for tableservices_latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "tableservices_latency_threshold_critical" {
  description = "Critical threshold for tableservices_latency detector"
  type        = number
  default     = 2000
}

variable "tableservices_latency_threshold_warning" {
  description = "Warning threshold for tableservices_latency detector"
  type        = number
  default     = 1000
}

variable "tableservices_latency_aperiodic_duration" {
  description = "Duration for the tableservices_latency block"
  type        = string
  default     = "10m"
}

variable "tableservices_latency_aperiodic_percentage" {
  description = "Percentage for the tableservices_latency block"
  type        = number
  default     = 0.9
}

# Blob_timeout_error_requests detectors

variable "blob_timeout_error_requests_disabled" {
  description = "Disable all alerting rules for blob_timeout_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_timeout_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for blob_timeout_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_timeout_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for blob_timeout_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_timeout_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of blob_timeout_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_timeout_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of blob_timeout_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_timeout_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of blob_timeout_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_timeout_error_requests_aggregation_function" {
  description = "Aggregation function and group by for blob_timeout_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "blob_timeout_error_requests_transformation_function" {
  description = "Transformation function for blob_timeout_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "blob_timeout_error_requests_transformation_window" {
  description = "Transformation window for blob_timeout_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "blob_timeout_error_requests_threshold_critical" {
  description = "Critical threshold for blob_timeout_error_requests detector"
  type        = number
  default     = 90
}

variable "blob_timeout_error_requests_threshold_warning" {
  description = "Warning threshold for blob_timeout_error_requests detector"
  type        = number
  default     = 50
}

variable "blob_timeout_error_requests_aperiodic_duration" {
  description = "Duration for the blob_timeout_error_requests block"
  type        = string
  default     = "10m"
}

variable "blob_timeout_error_requests_aperiodic_percentage" {
  description = "Percentage for the blob_timeout_error_requests block"
  type        = number
  default     = 0.9
}

# File_timeout_error_requests detectors

variable "file_timeout_error_requests_disabled" {
  description = "Disable all alerting rules for file_timeout_error_requests detector"
  type        = bool
  default     = null
}

variable "file_timeout_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for file_timeout_error_requests detector"
  type        = bool
  default     = null
}

variable "file_timeout_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for file_timeout_error_requests detector"
  type        = bool
  default     = null
}

variable "file_timeout_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of file_timeout_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_timeout_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of file_timeout_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_timeout_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of file_timeout_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_timeout_error_requests_aggregation_function" {
  description = "Aggregation function and group by for file_timeout_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "file_timeout_error_requests_transformation_function" {
  description = "Transformation function for file_timeout_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "file_timeout_error_requests_transformation_window" {
  description = "Transformation window for file_timeout_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "file_timeout_error_requests_threshold_critical" {
  description = "Critical threshold for file_timeout_error_requests detector"
  type        = number
  default     = 90
}

variable "file_timeout_error_requests_threshold_warning" {
  description = "Warning threshold for file_timeout_error_requests detector"
  type        = number
  default     = 50
}

variable "file_timeout_error_requests_aperiodic_duration" {
  description = "Duration for the file_timeout_error_requests block"
  type        = string
  default     = "10m"
}

variable "file_timeout_error_requests_aperiodic_percentage" {
  description = "Percentage for the file_timeout_error_requests block"
  type        = number
  default     = 0.9
}

# Queue_timeout_error_requests detectors

variable "queue_timeout_error_requests_disabled" {
  description = "Disable all alerting rules for queue_timeout_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_timeout_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for queue_timeout_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_timeout_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for queue_timeout_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_timeout_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of queue_timeout_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_timeout_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of queue_timeout_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_timeout_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of queue_timeout_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_timeout_error_requests_aggregation_function" {
  description = "Aggregation function and group by for queue_timeout_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "queue_timeout_error_requests_transformation_function" {
  description = "Transformation function for queue_timeout_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "queue_timeout_error_requests_transformation_window" {
  description = "Transformation window for queue_timeout_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "queue_timeout_error_requests_threshold_critical" {
  description = "Critical threshold for queue_timeout_error_requests detector"
  type        = number
  default     = 90
}

variable "queue_timeout_error_requests_threshold_warning" {
  description = "Warning threshold for queue_timeout_error_requests detector"
  type        = number
  default     = 50
}

variable "queue_timeout_error_requests_aperiodic_duration" {
  description = "Duration for the queue_timeout_error_requests block"
  type        = string
  default     = "10m"
}

variable "queue_timeout_error_requests_aperiodic_percentage" {
  description = "Percentage for the queue_timeout_error_requests block"
  type        = number
  default     = 0.9
}

# Table_timeout_error_requests detectors

variable "table_timeout_error_requests_disabled" {
  description = "Disable all alerting rules for table_timeout_error_requests detector"
  type        = bool
  default     = null
}

variable "table_timeout_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for table_timeout_error_requests detector"
  type        = bool
  default     = null
}

variable "table_timeout_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for table_timeout_error_requests detector"
  type        = bool
  default     = null
}

variable "table_timeout_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of table_timeout_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_timeout_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of table_timeout_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_timeout_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of table_timeout_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_timeout_error_requests_aggregation_function" {
  description = "Aggregation function and group by for table_timeout_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "table_timeout_error_requests_transformation_function" {
  description = "Transformation function for table_timeout_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "table_timeout_error_requests_transformation_window" {
  description = "Transformation window for table_timeout_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "table_timeout_error_requests_threshold_critical" {
  description = "Critical threshold for table_timeout_error_requests detector"
  type        = number
  default     = 90
}

variable "table_timeout_error_requests_threshold_warning" {
  description = "Warning threshold for table_timeout_error_requests detector"
  type        = number
  default     = 50
}

variable "table_timeout_error_requests_aperiodic_duration" {
  description = "Duration for the table_timeout_error_requests block"
  type        = string
  default     = "10m"
}

variable "table_timeout_error_requests_aperiodic_percentage" {
  description = "Percentage for the table_timeout_error_requests block"
  type        = number
  default     = 0.9
}

# Blob_network_error_requests detectors

variable "blob_network_error_requests_disabled" {
  description = "Disable all alerting rules for blob_network_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_network_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for blob_network_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_network_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for blob_network_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_network_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of blob_network_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_network_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of blob_network_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_network_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of blob_network_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_network_error_requests_aggregation_function" {
  description = "Aggregation function and group by for blob_network_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "blob_network_error_requests_transformation_function" {
  description = "Transformation function for blob_network_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "blob_network_error_requests_transformation_window" {
  description = "Transformation window for blob_network_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "blob_network_error_requests_threshold_critical" {
  description = "Critical threshold for blob_network_error_requests detector"
  type        = number
  default     = 90
}

variable "blob_network_error_requests_threshold_warning" {
  description = "Warning threshold for blob_network_error_requests detector"
  type        = number
  default     = 50
}

variable "blob_network_error_requests_aperiodic_duration" {
  description = "Duration for the blob_network_error_requests block"
  type        = string
  default     = "10m"
}

variable "blob_network_error_requests_aperiodic_percentage" {
  description = "Percentage for the blob_network_error_requests block"
  type        = number
  default     = 0.9
}

# File_network_error_requests detectors

variable "file_network_error_requests_disabled" {
  description = "Disable all alerting rules for file_network_error_requests detector"
  type        = bool
  default     = null
}

variable "file_network_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for file_network_error_requests detector"
  type        = bool
  default     = null
}

variable "file_network_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for file_network_error_requests detector"
  type        = bool
  default     = null
}

variable "file_network_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of file_network_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_network_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of file_network_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_network_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of file_network_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_network_error_requests_aggregation_function" {
  description = "Aggregation function and group by for file_network_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "file_network_error_requests_transformation_function" {
  description = "Transformation function for file_network_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "file_network_error_requests_transformation_window" {
  description = "Transformation window for file_network_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "file_network_error_requests_threshold_critical" {
  description = "Critical threshold for file_network_error_requests detector"
  type        = number
  default     = 90
}

variable "file_network_error_requests_threshold_warning" {
  description = "Warning threshold for file_network_error_requests detector"
  type        = number
  default     = 50
}

variable "file_network_error_requests_aperiodic_duration" {
  description = "Duration for the file_network_error_requests block"
  type        = string
  default     = "10m"
}

variable "file_network_error_requests_aperiodic_percentage" {
  description = "Percentage for the file_network_error_requests block"
  type        = number
  default     = 0.9
}

# Queue_network_error_requests detectors

variable "queue_network_error_requests_disabled" {
  description = "Disable all alerting rules for queue_network_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_network_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for queue_network_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_network_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for queue_network_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_network_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of queue_network_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_network_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of queue_network_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_network_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of queue_network_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_network_error_requests_aggregation_function" {
  description = "Aggregation function and group by for queue_network_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "queue_network_error_requests_transformation_function" {
  description = "Transformation function for queue_network_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "queue_network_error_requests_transformation_window" {
  description = "Transformation window for queue_network_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "queue_network_error_requests_threshold_critical" {
  description = "Critical threshold for queue_network_error_requests detector"
  type        = number
  default     = 90
}

variable "queue_network_error_requests_threshold_warning" {
  description = "Warning threshold for queue_network_error_requests detector"
  type        = number
  default     = 50
}

variable "queue_network_error_requests_aperiodic_duration" {
  description = "Duration for the queue_network_error_requests block"
  type        = string
  default     = "10m"
}

variable "queue_network_error_requests_aperiodic_percentage" {
  description = "Percentage for the queue_network_error_requests block"
  type        = number
  default     = 0.9
}

# Table_network_error_requests detectors

variable "table_network_error_requests_disabled" {
  description = "Disable all alerting rules for table_network_error_requests detector"
  type        = bool
  default     = null
}

variable "table_network_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for table_network_error_requests detector"
  type        = bool
  default     = null
}

variable "table_network_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for table_network_error_requests detector"
  type        = bool
  default     = null
}

variable "table_network_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of table_network_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_network_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of table_network_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_network_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of table_network_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_network_error_requests_aggregation_function" {
  description = "Aggregation function and group by for table_network_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "table_network_error_requests_transformation_function" {
  description = "Transformation function for table_network_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "table_network_error_requests_transformation_window" {
  description = "Transformation window for table_network_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "table_network_error_requests_threshold_critical" {
  description = "Critical threshold for table_network_error_requests detector"
  type        = number
  default     = 90
}

variable "table_network_error_requests_threshold_warning" {
  description = "Warning threshold for table_network_error_requests detector"
  type        = number
  default     = 50
}

variable "table_network_error_requests_aperiodic_duration" {
  description = "Duration for the table_network_error_requests block"
  type        = string
  default     = "10m"
}

variable "table_network_error_requests_aperiodic_percentage" {
  description = "Percentage for the table_network_error_requests block"
  type        = number
  default     = 0.9
}

# Blob_throttling_error_requests detectors

variable "blob_throttling_error_requests_disabled" {
  description = "Disable all alerting rules for blob_throttling_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_throttling_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for blob_throttling_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_throttling_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for blob_throttling_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_throttling_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of blob_throttling_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_throttling_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of blob_throttling_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_throttling_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of blob_throttling_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_throttling_error_requests_aggregation_function" {
  description = "Aggregation function and group by for blob_throttling_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "blob_throttling_error_requests_transformation_function" {
  description = "Transformation function for blob_throttling_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "blob_throttling_error_requests_transformation_window" {
  description = "Transformation window for blob_throttling_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "blob_throttling_error_requests_threshold_critical" {
  description = "Critical threshold for blob_throttling_error_requests detector"
  type        = number
  default     = 90
}

variable "blob_throttling_error_requests_threshold_warning" {
  description = "Warning threshold for blob_throttling_error_requests detector"
  type        = number
  default     = 50
}

variable "blob_throttling_error_requests_aperiodic_duration" {
  description = "Duration for the blob_throttling_error_requests block"
  type        = string
  default     = "10m"
}

variable "blob_throttling_error_requests_aperiodic_percentage" {
  description = "Percentage for the blob_throttling_error_requests block"
  type        = number
  default     = 0.9
}

# File_throttling_error_requests detectors

variable "file_throttling_error_requests_disabled" {
  description = "Disable all alerting rules for file_throttling_error_requests detector"
  type        = bool
  default     = null
}

variable "file_throttling_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for file_throttling_error_requests detector"
  type        = bool
  default     = null
}

variable "file_throttling_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for file_throttling_error_requests detector"
  type        = bool
  default     = null
}

variable "file_throttling_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of file_throttling_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_throttling_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of file_throttling_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_throttling_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of file_throttling_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_throttling_error_requests_aggregation_function" {
  description = "Aggregation function and group by for file_throttling_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "file_throttling_error_requests_transformation_function" {
  description = "Transformation function for file_throttling_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "file_throttling_error_requests_transformation_window" {
  description = "Transformation window for file_throttling_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "file_throttling_error_requests_threshold_critical" {
  description = "Critical threshold for file_throttling_error_requests detector"
  type        = number
  default     = 90
}

variable "file_throttling_error_requests_threshold_warning" {
  description = "Warning threshold for file_throttling_error_requests detector"
  type        = number
  default     = 50
}

variable "file_throttling_error_requests_aperiodic_duration" {
  description = "Duration for the file_throttling_error_requests block"
  type        = string
  default     = "10m"
}

variable "file_throttling_error_requests_aperiodic_percentage" {
  description = "Percentage for the file_throttling_error_requests block"
  type        = number
  default     = 0.9
}

# Queue_throttling_error_requests detectors

variable "queue_throttling_error_requests_disabled" {
  description = "Disable all alerting rules for queue_throttling_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_throttling_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for queue_throttling_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_throttling_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for queue_throttling_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_throttling_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of queue_throttling_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_throttling_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of queue_throttling_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_throttling_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of queue_throttling_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_throttling_error_requests_aggregation_function" {
  description = "Aggregation function and group by for queue_throttling_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "queue_throttling_error_requests_transformation_function" {
  description = "Transformation function for queue_throttling_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "queue_throttling_error_requests_transformation_window" {
  description = "Transformation window for queue_throttling_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "queue_throttling_error_requests_threshold_critical" {
  description = "Critical threshold for queue_throttling_error_requests detector"
  type        = number
  default     = 90
}

variable "queue_throttling_error_requests_threshold_warning" {
  description = "Warning threshold for queue_throttling_error_requests detector"
  type        = number
  default     = 50
}

variable "queue_throttling_error_requests_aperiodic_duration" {
  description = "Duration for the queue_throttling_error_requests block"
  type        = string
  default     = "10m"
}

variable "queue_throttling_error_requests_aperiodic_percentage" {
  description = "Percentage for the queue_throttling_error_requests block"
  type        = number
  default     = 0.9
}

# Table_throttling_error_requests detectors

variable "table_throttling_error_requests_disabled" {
  description = "Disable all alerting rules for table_throttling_error_requests detector"
  type        = bool
  default     = null
}

variable "table_throttling_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for table_throttling_error_requests detector"
  type        = bool
  default     = null
}

variable "table_throttling_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for table_throttling_error_requests detector"
  type        = bool
  default     = null
}

variable "table_throttling_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of table_throttling_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_throttling_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of table_throttling_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_throttling_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of table_throttling_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_throttling_error_requests_aggregation_function" {
  description = "Aggregation function and group by for table_throttling_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "table_throttling_error_requests_transformation_function" {
  description = "Transformation function for table_throttling_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "table_throttling_error_requests_transformation_window" {
  description = "Transformation window for table_throttling_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "table_throttling_error_requests_threshold_critical" {
  description = "Critical threshold for table_throttling_error_requests detector"
  type        = number
  default     = 90
}

variable "table_throttling_error_requests_threshold_warning" {
  description = "Warning threshold for table_throttling_error_requests detector"
  type        = number
  default     = 50
}

variable "table_throttling_error_requests_aperiodic_duration" {
  description = "Duration for the table_throttling_error_requests block"
  type        = string
  default     = "10m"
}

variable "table_throttling_error_requests_aperiodic_percentage" {
  description = "Percentage for the table_throttling_error_requests block"
  type        = number
  default     = 0.9
}

# Blob_server_other_error_requests detectors

variable "blob_server_other_error_requests_disabled" {
  description = "Disable all alerting rules for blob_server_other_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_server_other_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for blob_server_other_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_server_other_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for blob_server_other_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_server_other_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of blob_server_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_server_other_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of blob_server_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_server_other_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of blob_server_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_server_other_error_requests_aggregation_function" {
  description = "Aggregation function and group by for blob_server_other_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "blob_server_other_error_requests_transformation_function" {
  description = "Transformation function for blob_server_other_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "blob_server_other_error_requests_transformation_window" {
  description = "Transformation window for blob_server_other_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "blob_server_other_error_requests_threshold_critical" {
  description = "Critical threshold for blob_server_other_error_requests detector"
  type        = number
  default     = 90
}

variable "blob_server_other_error_requests_threshold_warning" {
  description = "Warning threshold for blob_server_other_error_requests detector"
  type        = number
  default     = 50
}

variable "blob_server_other_error_requests_aperiodic_duration" {
  description = "Duration for the blob_server_other_error_requests block"
  type        = string
  default     = "10m"
}

variable "blob_server_other_error_requests_aperiodic_percentage" {
  description = "Percentage for the blob_server_other_error_requests block"
  type        = number
  default     = 0.9
}

# file_server_other_error_requests detectors

variable "file_server_other_error_requests_disabled" {
  description = "Disable all alerting rules for file_server_other_error_requests detector"
  type        = bool
  default     = null
}

variable "file_server_other_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for file_server_other_error_requests detector"
  type        = bool
  default     = null
}

variable "file_server_other_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for file_server_other_error_requests detector"
  type        = bool
  default     = null
}

variable "file_server_other_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of file_server_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_server_other_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of file_server_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_server_other_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of file_server_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_server_other_error_requests_aggregation_function" {
  description = "Aggregation function and group by for file_server_other_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "file_server_other_error_requests_transformation_function" {
  description = "Transformation function for file_server_other_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "file_server_other_error_requests_transformation_window" {
  description = "Transformation window for file_server_other_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "file_server_other_error_requests_threshold_critical" {
  description = "Critical threshold for file_server_other_error_requests detector"
  type        = number
  default     = 90
}

variable "file_server_other_error_requests_threshold_warning" {
  description = "Warning threshold for file_server_other_error_requests detector"
  type        = number
  default     = 50
}

variable "file_server_other_error_requests_aperiodic_duration" {
  description = "Duration for the file_server_other_error_requests block"
  type        = string
  default     = "10m"
}

variable "file_server_other_error_requests_aperiodic_percentage" {
  description = "Percentage for the file_server_other_error_requests block"
  type        = number
  default     = 0.9
}

# Queue_server_other_error_requests detectors

variable "queue_server_other_error_requests_disabled" {
  description = "Disable all alerting rules for queue_server_other_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_server_other_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for queue_server_other_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_server_other_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for queue_server_other_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_server_other_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of queue_server_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_server_other_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of queue_server_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_server_other_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of queue_server_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_server_other_error_requests_aggregation_function" {
  description = "Aggregation function and group by for queue_server_other_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "queue_server_other_error_requests_transformation_function" {
  description = "Transformation function for queue_server_other_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "queue_server_other_error_requests_transformation_window" {
  description = "Transformation window for queue_server_other_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "queue_server_other_error_requests_threshold_critical" {
  description = "Critical threshold for queue_server_other_error_requests detector"
  type        = number
  default     = 90
}

variable "queue_server_other_error_requests_threshold_warning" {
  description = "Warning threshold for queue_server_other_error_requests detector"
  type        = number
  default     = 50
}

variable "queue_server_other_error_requests_aperiodic_duration" {
  description = "Duration for the queue_server_other_error_requests block"
  type        = string
  default     = "10m"
}

variable "queue_server_other_error_requests_aperiodic_percentage" {
  description = "Percentage for the queue_server_other_error_requests block"
  type        = number
  default     = 0.9
}

# Table_server_other_error_requests detectors

variable "table_server_other_error_requests_disabled" {
  description = "Disable all alerting rules for table_server_other_error_requests detector"
  type        = bool
  default     = null
}

variable "table_server_other_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for table_server_other_error_requests detector"
  type        = bool
  default     = null
}

variable "table_server_other_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for table_server_other_error_requests detector"
  type        = bool
  default     = null
}

variable "table_server_other_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of table_server_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_server_other_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of table_server_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_server_other_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of table_server_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_server_other_error_requests_aggregation_function" {
  description = "Aggregation function and group by for table_server_other_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "table_server_other_error_requests_transformation_function" {
  description = "Transformation function for table_server_other_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "table_server_other_error_requests_transformation_window" {
  description = "Transformation window for table_server_other_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "table_server_other_error_requests_threshold_critical" {
  description = "Critical threshold for table_server_other_error_requests detector"
  type        = number
  default     = 90
}

variable "table_server_other_error_requests_threshold_warning" {
  description = "Warning threshold for table_server_other_error_requests detector"
  type        = number
  default     = 50
}

variable "table_server_other_error_requests_aperiodic_duration" {
  description = "Duration for the table_server_other_error_requests block"
  type        = string
  default     = "10m"
}

variable "table_server_other_error_requests_aperiodic_percentage" {
  description = "Percentage for the table_server_other_error_requests block"
  type        = number
  default     = 0.9
}

# Blob_client_other_error_requests detectors

variable "blob_client_other_error_requests_disabled" {
  description = "Disable all alerting rules for blob_client_other_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_client_other_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for blob_client_other_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_client_other_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for blob_client_other_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_client_other_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of blob_client_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_client_other_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of blob_client_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_client_other_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of blob_client_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_client_other_error_requests_aggregation_function" {
  description = "Aggregation function and group by for blob_client_other_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "blob_client_other_error_requests_transformation_function" {
  description = "Transformation function for blob_client_other_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "blob_client_other_error_requests_transformation_window" {
  description = "Transformation window for blob_client_other_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "blob_client_other_error_requests_threshold_critical" {
  description = "Critical threshold for blob_client_other_error_requests detector"
  type        = number
  default     = 90
}

variable "blob_client_other_error_requests_threshold_warning" {
  description = "Warning threshold for blob_client_other_error_requests detector"
  type        = number
  default     = 50
}

variable "blob_client_other_error_requests_aperiodic_duration" {
  description = "Duration for the blob_client_other_error_requests block"
  type        = string
  default     = "10m"
}

variable "blob_client_other_error_requests_aperiodic_percentage" {
  description = "Percentage for the blob_client_other_error_requests block"
  type        = number
  default     = 0.9
}

# File_client_other_error_requests detectors

variable "file_client_other_error_requests_disabled" {
  description = "Disable all alerting rules for file_client_other_error_requests detector"
  type        = bool
  default     = null
}

variable "file_client_other_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for file_client_other_error_requests detector"
  type        = bool
  default     = null
}

variable "file_client_other_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for file_client_other_error_requests detector"
  type        = bool
  default     = null
}

variable "file_client_other_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of file_client_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_client_other_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of file_client_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_client_other_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of file_client_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_client_other_error_requests_aggregation_function" {
  description = "Aggregation function and group by for file_client_other_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "file_client_other_error_requests_transformation_function" {
  description = "Transformation function for file_client_other_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "file_client_other_error_requests_transformation_window" {
  description = "Transformation window for file_client_other_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "file_client_other_error_requests_threshold_critical" {
  description = "Critical threshold for file_client_other_error_requests detector"
  type        = number
  default     = 90
}

variable "file_client_other_error_requests_threshold_warning" {
  description = "Warning threshold for file_client_other_error_requests detector"
  type        = number
  default     = 50
}

variable "file_client_other_error_requests_aperiodic_duration" {
  description = "Duration for the file_client_other_error_requests block"
  type        = string
  default     = "10m"
}

variable "file_client_other_error_requests_aperiodic_percentage" {
  description = "Percentage for the file_client_other_error_requests block"
  type        = number
  default     = 0.9
}

# Queue_client_other_error_requests detectors

variable "queue_client_other_error_requests_disabled" {
  description = "Disable all alerting rules for queue_client_other_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_client_other_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for queue_client_other_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_client_other_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for queue_client_other_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_client_other_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of queue_client_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_client_other_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of queue_client_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_client_other_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of queue_client_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_client_other_error_requests_aggregation_function" {
  description = "Aggregation function and group by for queue_client_other_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "queue_client_other_error_requests_transformation_function" {
  description = "Transformation function for queue_client_other_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "queue_client_other_error_requests_transformation_window" {
  description = "Transformation window for queue_client_other_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "queue_client_other_error_requests_threshold_critical" {
  description = "Critical threshold for queue_client_other_error_requests detector"
  type        = number
  default     = 90
}

variable "queue_client_other_error_requests_threshold_warning" {
  description = "Warning threshold for queue_client_other_error_requests detector"
  type        = number
  default     = 50
}

variable "queue_client_other_error_requests_aperiodic_duration" {
  description = "Duration for the queue_client_other_error_requests block"
  type        = string
  default     = "10m"
}

variable "queue_client_other_error_requests_aperiodic_percentage" {
  description = "Percentage for the queue_client_other_error_requests block"
  type        = number
  default     = 0.9
}

# Table_client_other_error_requests detectors

variable "table_client_other_error_requests_disabled" {
  description = "Disable all alerting rules for table_client_other_error_requests detector"
  type        = bool
  default     = null
}

variable "table_client_other_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for table_client_other_error_requests detector"
  type        = bool
  default     = null
}

variable "table_client_other_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for table_client_other_error_requests detector"
  type        = bool
  default     = null
}

variable "table_client_other_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of table_client_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_client_other_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of table_client_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_client_other_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of table_client_other_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_client_other_error_requests_aggregation_function" {
  description = "Aggregation function and group by for table_client_other_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "table_client_other_error_requests_transformation_function" {
  description = "Transformation function for table_client_other_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "table_client_other_error_requests_transformation_window" {
  description = "Transformation window for table_client_other_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "table_client_other_error_requests_threshold_critical" {
  description = "Critical threshold for table_client_other_error_requests detector"
  type        = number
  default     = 90
}

variable "table_client_other_error_requests_threshold_warning" {
  description = "Warning threshold for table_client_other_error_requests detector"
  type        = number
  default     = 50
}

variable "table_client_other_error_requests_aperiodic_duration" {
  description = "Duration for the table_client_other_error_requests block"
  type        = string
  default     = "10m"
}

variable "table_client_other_error_requests_aperiodic_percentage" {
  description = "Percentage for the table_client_other_error_requests block"
  type        = number
  default     = 0.9
}

# Blob_authorization_error_requests detectors

variable "blob_authorization_error_requests_disabled" {
  description = "Disable all alerting rules for blob_authorization_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_authorization_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for blob_authorization_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_authorization_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for blob_authorization_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_authorization_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of blob_authorization_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_authorization_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of blob_authorization_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_authorization_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of blob_authorization_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_authorization_error_requests_aggregation_function" {
  description = "Aggregation function and group by for blob_authorization_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "blob_authorization_error_requests_transformation_function" {
  description = "Transformation function for blob_authorization_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "blob_authorization_error_requests_transformation_window" {
  description = "Transformation window for blob_authorization_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "blob_authorization_error_requests_threshold_critical" {
  description = "Critical threshold for blob_authorization_error_requests detector"
  type        = number
  default     = 90
}

variable "blob_authorization_error_requests_threshold_warning" {
  description = "Warning threshold for blob_authorization_error_requests detector"
  type        = number
  default     = 50
}

variable "blob_authorization_error_requests_aperiodic_duration" {
  description = "Duration for the blob_authorization_error_requests block"
  type        = string
  default     = "10m"
}

variable "blob_authorization_error_requests_aperiodic_percentage" {
  description = "Percentage for the blob_authorization_error_requests block"
  type        = number
  default     = 0.9
}

# File_authorization_error_requests detectors

variable "file_authorization_error_requests_disabled" {
  description = "Disable all alerting rules for file_authorization_error_requests detector"
  type        = bool
  default     = null
}

variable "file_authorization_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for file_authorization_error_requests detector"
  type        = bool
  default     = null
}

variable "file_authorization_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for file_authorization_error_requests detector"
  type        = bool
  default     = null
}

variable "file_authorization_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of file_authorization_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_authorization_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of file_authorization_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_authorization_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of file_authorization_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_authorization_error_requests_aggregation_function" {
  description = "Aggregation function and group by for file_authorization_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "file_authorization_error_requests_transformation_function" {
  description = "Transformation function for file_authorization_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "file_authorization_error_requests_transformation_window" {
  description = "Transformation window for file_authorization_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "file_authorization_error_requests_threshold_critical" {
  description = "Critical threshold for file_authorization_error_requests detector"
  type        = number
  default     = 90
}

variable "file_authorization_error_requests_threshold_warning" {
  description = "Warning threshold for file_authorization_error_requests detector"
  type        = number
  default     = 50
}

variable "file_authorization_error_requests_aperiodic_duration" {
  description = "Duration for the file_authorization_error_requests block"
  type        = string
  default     = "10m"
}

variable "file_authorization_error_requests_aperiodic_percentage" {
  description = "Percentage for the file_authorization_error_requests block"
  type        = number
  default     = 0.9
}

# Queue_authorization_error_requests detectors

variable "queue_authorization_error_requests_disabled" {
  description = "Disable all alerting rules for queue_authorization_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_authorization_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for queue_authorization_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_authorization_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for queue_authorization_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_authorization_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of queue_authorization_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_authorization_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of queue_authorization_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_authorization_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of queue_authorization_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_authorization_error_requests_aggregation_function" {
  description = "Aggregation function and group by for queue_authorization_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "queue_authorization_error_requests_transformation_function" {
  description = "Transformation function for queue_authorization_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "queue_authorization_error_requests_transformation_window" {
  description = "Transformation window for queue_authorization_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "queue_authorization_error_requests_threshold_critical" {
  description = "Critical threshold for queue_authorization_error_requests detector"
  type        = number
  default     = 90
}

variable "queue_authorization_error_requests_threshold_warning" {
  description = "Warning threshold for queue_authorization_error_requests detector"
  type        = number
  default     = 50
}

variable "queue_authorization_error_requests_aperiodic_duration" {
  description = "Duration for the queue_authorization_error_requests block"
  type        = string
  default     = "10m"
}

variable "queue_authorization_error_requests_aperiodic_percentage" {
  description = "Percentage for the queue_authorization_error_requests block"
  type        = number
  default     = 0.9
}

# Table_authorization_error_requests detectors

variable "table_authorization_error_requests_disabled" {
  description = "Disable all alerting rules for table_authorization_error_requests detector"
  type        = bool
  default     = null
}

variable "table_authorization_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for table_authorization_error_requests detector"
  type        = bool
  default     = null
}

variable "table_authorization_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for table_authorization_error_requests detector"
  type        = bool
  default     = null
}

variable "table_authorization_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of table_authorization_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_authorization_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of table_authorization_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_authorization_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of table_authorization_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_authorization_error_requests_aggregation_function" {
  description = "Aggregation function and group by for table_authorization_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name'])"
}

variable "table_authorization_error_requests_transformation_function" {
  description = "Transformation function for table_authorization_error_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "table_authorization_error_requests_transformation_window" {
  description = "Transformation window for table_authorization_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "table_authorization_error_requests_threshold_critical" {
  description = "Critical threshold for table_authorization_error_requests detector"
  type        = number
  default     = 90
}

variable "table_authorization_error_requests_threshold_warning" {
  description = "Warning threshold for table_authorization_error_requests detector"
  type        = number
  default     = 50
}

variable "table_authorization_error_requests_aperiodic_duration" {
  description = "Duration for the table_authorization_error_requests block"
  type        = string
  default     = "10m"
}

variable "table_authorization_error_requests_aperiodic_percentage" {
  description = "Percentage for the table_authorization_error_requests block"
  type        = number
  default     = 0.9
}
