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
  default     = "4h"
}

# blob_requests_error detectors

variable "blob_requests_error_disabled" {
  description = "Disable all alerting rules for blob_requests_error detector"
  type        = bool
  default     = null
}

variable "blob_requests_error_disabled_critical" {
  description = "Disable critical alerting rule for blob_requests_error detector"
  type        = bool
  default     = null
}

variable "blob_requests_error_disabled_warning" {
  description = "Disable warning alerting rule for blob_requests_error detector"
  type        = bool
  default     = null
}

variable "blob_requests_error_notifications" {
  description = "Notification recipients list for every alerting rules of blob_requests_error detector"
  type        = list(string)
  default     = []
}

variable "blob_requests_error_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of blob_requests_error detector"
  type        = list(string)
  default     = []
}

variable "blob_requests_error_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of blob_requests_error detector"
  type        = list(string)
  default     = []
}

variable "blob_requests_error_aggregation_function" {
  description = "Aggregation function and group by for blob_requests_error detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "blob_requests_error_timer" {
  description = "Evaluation window for blob_requests_error detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "blob_requests_error_threshold_critical" {
  description = "Critical threshold for blob_requests_error detector"
  type        = number
  default     = 90
}

variable "blob_requests_error_threshold_warning" {
  description = "Warning threshold for blob_requests_error detector"
  type        = number
  default     = 70
}

# file_requests_error detectors

variable "file_requests_error_disabled" {
  description = "Disable all alerting rules for file_requests_error detector"
  type        = bool
  default     = null
}

variable "file_requests_error_disabled_critical" {
  description = "Disable critical alerting rule for file_requests_error detector"
  type        = bool
  default     = null
}

variable "file_requests_error_disabled_warning" {
  description = "Disable warning alerting rule for file_requests_error detector"
  type        = bool
  default     = null
}

variable "file_requests_error_notifications" {
  description = "Notification recipients list for every alerting rules of file_requests_error detector"
  type        = list(string)
  default     = []
}

variable "file_requests_error_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of file_requests_error detector"
  type        = list(string)
  default     = []
}

variable "file_requests_error_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of file_requests_error detector"
  type        = list(string)
  default     = []
}

variable "file_requests_error_aggregation_function" {
  description = "Aggregation function and group by for file_requests_error detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "file_requests_error_timer" {
  description = "Evaluation window for file_requests_error detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "file_requests_error_threshold_critical" {
  description = "Critical threshold for file_requests_error detector"
  type        = number
  default     = 90
}

variable "file_requests_error_threshold_warning" {
  description = "Warning threshold for file_requests_error detector"
  type        = number
  default     = 70
}

# queue_requests_error detectors

variable "queue_requests_error_disabled" {
  description = "Disable all alerting rules for queue_requests_error detector"
  type        = bool
  default     = null
}

variable "queue_requests_error_disabled_critical" {
  description = "Disable critical alerting rule for queue_requests_error detector"
  type        = bool
  default     = null
}

variable "queue_requests_error_disabled_warning" {
  description = "Disable warning alerting rule for queue_requests_error detector"
  type        = bool
  default     = null
}

variable "queue_requests_error_notifications" {
  description = "Notification recipients list for every alerting rules of queue_requests_error detector"
  type        = list(string)
  default     = []
}

variable "queue_requests_error_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of queue_requests_error detector"
  type        = list(string)
  default     = []
}

variable "queue_requests_error_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of queue_requests_error detector"
  type        = list(string)
  default     = []
}

variable "queue_requests_error_aggregation_function" {
  description = "Aggregation function and group by for queue_requests_error detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "queue_requests_error_timer" {
  description = "Evaluation window for queue_requests_error detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "queue_requests_error_threshold_critical" {
  description = "Critical threshold for queue_requests_error detector"
  type        = number
  default     = 90
}

variable "queue_requests_error_threshold_warning" {
  description = "Warning threshold for queue_requests_error detector"
  type        = number
  default     = 70
}

# table_requests_error detectors

variable "table_requests_error_disabled" {
  description = "Disable all alerting rules for table_requests_error detector"
  type        = bool
  default     = null
}

variable "table_requests_error_disabled_critical" {
  description = "Disable critical alerting rule for table_requests_error detector"
  type        = bool
  default     = null
}

variable "table_requests_error_disabled_warning" {
  description = "Disable warning alerting rule for table_requests_error detector"
  type        = bool
  default     = null
}

variable "table_requests_error_notifications" {
  description = "Notification recipients list for every alerting rules of table_requests_error detector"
  type        = list(string)
  default     = []
}

variable "table_requests_error_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of table_requests_error detector"
  type        = list(string)
  default     = []
}

variable "table_requests_error_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of table_requests_error detector"
  type        = list(string)
  default     = []
}

variable "table_requests_error_aggregation_function" {
  description = "Aggregation function and group by for table_requests_error detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "table_requests_error_timer" {
  description = "Evaluation window for table_requests_error detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "table_requests_error_threshold_critical" {
  description = "Critical threshold for table_requests_error detector"
  type        = number
  default     = 90
}

variable "table_requests_error_threshold_warning" {
  description = "Warning threshold for table_requests_error detector"
  type        = number
  default     = 70
}

# blob_latency detectors

variable "blob_latency_disabled" {
  description = "Disable all alerting rules for blob_latency detector"
  type        = bool
  default     = null
}

variable "blob_latency_disabled_critical" {
  description = "Disable critical alerting rule for blob_latency detector"
  type        = bool
  default     = null
}

variable "blob_latency_disabled_warning" {
  description = "Disable warning alerting rule for blob_latency detector"
  type        = bool
  default     = null
}

variable "blob_latency_notifications" {
  description = "Notification recipients list for every alerting rules of blob_latency detector"
  type        = list(string)
  default     = []
}

variable "blob_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of blob_latency detector"
  type        = list(string)
  default     = []
}

variable "blob_latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of blob_latency detector"
  type        = list(string)
  default     = []
}

variable "blob_latency_aggregation_function" {
  description = "Aggregation function and group by for blob_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "blob_latency_timer" {
  description = "Evaluation window for blob_latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "blob_latency_threshold_critical" {
  description = "Critical threshold for blob_latency detector"
  type        = number
  default     = 2000
}

variable "blob_latency_threshold_warning" {
  description = "Warning threshold for blob_latency detector"
  type        = number
  default     = 1000
}

# file_latency detectors

variable "file_latency_disabled" {
  description = "Disable all alerting rules for file_latency detector"
  type        = bool
  default     = null
}

variable "file_latency_disabled_critical" {
  description = "Disable critical alerting rule for file_latency detector"
  type        = bool
  default     = null
}

variable "file_latency_disabled_warning" {
  description = "Disable warning alerting rule for file_latency detector"
  type        = bool
  default     = null
}

variable "file_latency_notifications" {
  description = "Notification recipients list for every alerting rules of file_latency detector"
  type        = list(string)
  default     = []
}

variable "file_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of file_latency detector"
  type        = list(string)
  default     = []
}

variable "file_latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of file_latency detector"
  type        = list(string)
  default     = []
}

variable "file_latency_aggregation_function" {
  description = "Aggregation function and group by for file_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "file_latency_timer" {
  description = "Evaluation window for file_latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "file_latency_threshold_critical" {
  description = "Critical threshold for file_latency detector"
  type        = number
  default     = 2000
}

variable "file_latency_threshold_warning" {
  description = "Warning threshold for file_latency detector"
  type        = number
  default     = 1000
}

# queue_latency detectors

variable "queue_latency_disabled" {
  description = "Disable all alerting rules for queue_latency detector"
  type        = bool
  default     = null
}

variable "queue_latency_disabled_critical" {
  description = "Disable critical alerting rule for queue_latency detector"
  type        = bool
  default     = null
}

variable "queue_latency_disabled_warning" {
  description = "Disable warning alerting rule for queue_latency detector"
  type        = bool
  default     = null
}

variable "queue_latency_notifications" {
  description = "Notification recipients list for every alerting rules of queue_latency detector"
  type        = list(string)
  default     = []
}

variable "queue_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of queue_latency detector"
  type        = list(string)
  default     = []
}

variable "queue_latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of queue_latency detector"
  type        = list(string)
  default     = []
}

variable "queue_latency_aggregation_function" {
  description = "Aggregation function and group by for queue_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "queue_latency_timer" {
  description = "Evaluation window for queue_latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "queue_latency_threshold_critical" {
  description = "Critical threshold for queue_latency detector"
  type        = number
  default     = 2000
}

variable "queue_latency_threshold_warning" {
  description = "Warning threshold for queue_latency detector"
  type        = number
  default     = 1000
}

# table_latency detectors

variable "table_latency_disabled" {
  description = "Disable all alerting rules for table_latency detector"
  type        = bool
  default     = null
}

variable "table_latency_disabled_critical" {
  description = "Disable critical alerting rule for table_latency detector"
  type        = bool
  default     = null
}

variable "table_latency_disabled_warning" {
  description = "Disable warning alerting rule for table_latency detector"
  type        = bool
  default     = null
}

variable "table_latency_notifications" {
  description = "Notification recipients list for every alerting rules of table_latency detector"
  type        = list(string)
  default     = []
}

variable "table_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of table_latency detector"
  type        = list(string)
  default     = []
}

variable "table_latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of table_latency detector"
  type        = list(string)
  default     = []
}

variable "table_latency_aggregation_function" {
  description = "Aggregation function and group by for table_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "table_latency_timer" {
  description = "Evaluation window for table_latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "table_latency_threshold_critical" {
  description = "Critical threshold for table_latency detector"
  type        = number
  default     = 2000
}

variable "table_latency_threshold_warning" {
  description = "Warning threshold for table_latency detector"
  type        = number
  default     = 1000
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "blob_timeout_error_requests_timer" {
  description = "Evaluation window for blob_timeout_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "file_timeout_error_requests_timer" {
  description = "Evaluation window for file_timeout_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "queue_timeout_error_requests_timer" {
  description = "Evaluation window for queue_timeout_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "table_timeout_error_requests_timer" {
  description = "Evaluation window for table_timeout_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "blob_network_error_requests_timer" {
  description = "Evaluation window for blob_network_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "file_network_error_requests_timer" {
  description = "Evaluation window for file_network_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "queue_network_error_requests_timer" {
  description = "Evaluation window for queue_network_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "table_network_error_requests_timer" {
  description = "Evaluation window for table_network_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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

# Blob_busy_error_requests detectors

variable "blob_busy_error_requests_disabled" {
  description = "Disable all alerting rules for blob_busy_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_busy_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for blob_busy_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_busy_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for blob_busy_error_requests detector"
  type        = bool
  default     = null
}

variable "blob_busy_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of blob_busy_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_busy_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of blob_busy_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_busy_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of blob_busy_error_requests detector"
  type        = list(string)
  default     = []
}

variable "blob_busy_error_requests_aggregation_function" {
  description = "Aggregation function and group by for blob_busy_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "blob_busy_error_requests_timer" {
  description = "Evaluation window for blob_busy_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "blob_busy_error_requests_threshold_critical" {
  description = "Critical threshold for blob_busy_error_requests detector"
  type        = number
  default     = 90
}

variable "blob_busy_error_requests_threshold_warning" {
  description = "Warning threshold for blob_busy_error_requests detector"
  type        = number
  default     = 50
}

# File_busy_error_requests detectors

variable "file_busy_error_requests_disabled" {
  description = "Disable all alerting rules for file_busy_error_requests detector"
  type        = bool
  default     = null
}

variable "file_busy_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for file_busy_error_requests detector"
  type        = bool
  default     = null
}

variable "file_busy_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for file_busy_error_requests detector"
  type        = bool
  default     = null
}

variable "file_busy_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of file_busy_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_busy_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of file_busy_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_busy_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of file_busy_error_requests detector"
  type        = list(string)
  default     = []
}

variable "file_busy_error_requests_aggregation_function" {
  description = "Aggregation function and group by for file_busy_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "file_busy_error_requests_timer" {
  description = "Evaluation window for file_busy_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "file_busy_error_requests_threshold_critical" {
  description = "Critical threshold for file_busy_error_requests detector"
  type        = number
  default     = 90
}

variable "file_busy_error_requests_threshold_warning" {
  description = "Warning threshold for file_busy_error_requests detector"
  type        = number
  default     = 50
}

# Queue_busy_error_requests detectors

variable "queue_busy_error_requests_disabled" {
  description = "Disable all alerting rules for queue_busy_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_busy_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for queue_busy_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_busy_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for queue_busy_error_requests detector"
  type        = bool
  default     = null
}

variable "queue_busy_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of queue_busy_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_busy_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of queue_busy_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_busy_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of queue_busy_error_requests detector"
  type        = list(string)
  default     = []
}

variable "queue_busy_error_requests_aggregation_function" {
  description = "Aggregation function and group by for queue_busy_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "queue_busy_error_requests_timer" {
  description = "Evaluation window for queue_busy_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "queue_busy_error_requests_threshold_critical" {
  description = "Critical threshold for queue_busy_error_requests detector"
  type        = number
  default     = 90
}

variable "queue_busy_error_requests_threshold_warning" {
  description = "Warning threshold for queue_busy_error_requests detector"
  type        = number
  default     = 50
}

# Table_busy_error_requests detectors

variable "table_busy_error_requests_disabled" {
  description = "Disable all alerting rules for table_busy_error_requests detector"
  type        = bool
  default     = null
}

variable "table_busy_error_requests_disabled_critical" {
  description = "Disable critical alerting rule for table_busy_error_requests detector"
  type        = bool
  default     = null
}

variable "table_busy_error_requests_disabled_warning" {
  description = "Disable warning alerting rule for table_busy_error_requests detector"
  type        = bool
  default     = null
}

variable "table_busy_error_requests_notifications" {
  description = "Notification recipients list for every alerting rules of table_busy_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_busy_error_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of table_busy_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_busy_error_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of table_busy_error_requests detector"
  type        = list(string)
  default     = []
}

variable "table_busy_error_requests_aggregation_function" {
  description = "Aggregation function and group by for table_busy_error_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "table_busy_error_requests_timer" {
  description = "Evaluation window for table_busy_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "table_busy_error_requests_threshold_critical" {
  description = "Critical threshold for table_busy_error_requests detector"
  type        = number
  default     = 90
}

variable "table_busy_error_requests_threshold_warning" {
  description = "Warning threshold for table_busy_error_requests detector"
  type        = number
  default     = 50
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "blob_throttling_error_requests_timer" {
  description = "Evaluation window for blob_throttling_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "file_throttling_error_requests_timer" {
  description = "Evaluation window for file_throttling_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "queue_throttling_error_requests_timer" {
  description = "Evaluation window for queue_throttling_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "table_throttling_error_requests_timer" {
  description = "Evaluation window for table_throttling_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "blob_server_other_error_requests_timer" {
  description = "Evaluation window for blob_server_other_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "file_server_other_error_requests_timer" {
  description = "Evaluation window for file_server_other_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "queue_server_other_error_requests_timer" {
  description = "Evaluation window for queue_server_other_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "table_server_other_error_requests_timer" {
  description = "Evaluation window for table_server_other_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "blob_client_other_error_requests_timer" {
  description = "Evaluation window for blob_client_other_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "file_client_other_error_requests_timer" {
  description = "Evaluation window for file_client_other_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "queue_client_other_error_requests_timer" {
  description = "Evaluation window for queue_client_other_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "table_client_other_error_requests_timer" {
  description = "Evaluation window for table_client_other_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "blob_authorization_error_requests_timer" {
  description = "Evaluation window for blob_authorization_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "file_authorization_error_requests_timer" {
  description = "Evaluation window for file_authorization_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "queue_authorization_error_requests_timer" {
  description = "Evaluation window for queue_authorization_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
  default     = ".sum(by=['azure_resource_id', 'azure_resource_group_name'])"
}

variable "table_authorization_error_requests_timer" {
  description = "Evaluation window for table_authorization_error_requests detector (i.e. 5m, 20m, 1h, 1d)"
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

