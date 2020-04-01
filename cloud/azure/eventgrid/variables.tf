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

# Azure eventgrid detectors specific

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_notifications" {
  description = "Notification recipients list for every alerting rules of heartbeat detector"
  type        = list
  default     = []
}

variable "heartbeat_timeframe" {
  description = "Timeframe for system not reporting detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

# No_successful_message detectors

variable "no_successful_message_disabled" {
  description = "Disable all alerting rules for no_successful_message detector"
  type        = bool
  default     = null
}

variable "no_successful_message_disabled_critical" {
  description = "Disable critical alerting rule for no_successful_message detector"
  type        = bool
  default     = null
}

variable "no_successful_message_disabled_warning" {
  description = "Disable warning alerting rule for no_successful_message detector"
  type        = bool
  default     = null
}

variable "no_successful_message_notifications" {
  description = "Notification recipients list for every alerting rules of no_successful_message detector"
  type        = list
  default     = []
}

variable "no_successful_message_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of no_successful_message detector"
  type        = list
  default     = []
}

variable "no_successful_message_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of no_successful_message detector"
  type        = list
  default     = []
}

variable "no_successful_message_aggregation_function" {
  description = "Aggregation function and group by for no_successful_message detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_region', 'azure_resource_group_name', 'azure_resource_name'])"
}

variable "no_successful_message_transformation_function" {
  description = "Transformation function for no_successful_message detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "no_successful_message_transformation_window" {
  description = "Transformation window for no_successful_message detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "no_successful_message_threshold_critical" {
  description = "Critical threshold for no_successful_message detector"
  type        = number
  default     = 0
}

variable "no_successful_message_threshold_warning" {
  description = "Warning threshold for no_successful_message detector"
  type        = number
  default     = 0
}

# failed_messages detectors

variable "failed_messages_disabled" {
  description = "Disable all alerting rules for failed_messages detector"
  type        = bool
  default     = null
}

variable "failed_messages_disabled_critical" {
  description = "Disable critical alerting rule for failed_messages detector"
  type        = bool
  default     = null
}

variable "failed_messages_disabled_warning" {
  description = "Disable warning alerting rule for failed_messages detector"
  type        = bool
  default     = null
}

variable "failed_messages_notifications" {
  description = "Notification recipients list for every alerting rules of failed_messages detector"
  type        = list
  default     = []
}

variable "failed_messages_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of failed_messages detector"
  type        = list
  default     = []
}

variable "failed_messages_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of failed_messages detector"
  type        = list
  default     = []
}

variable "failed_messages_aggregation_function" {
  description = "Aggregation function and group by for failed_messages detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_region', 'azure_resource_group_name', 'azure_resource_name'])"
}

variable "failed_messages_transformation_function" {
  description = "Transformation function for failed_messages detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "failed_messages_transformation_window" {
  description = "Transformation window for failed_messages detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "failed_messages_threshold_critical" {
  description = "Critical threshold for failed_messages detector"
  type        = number
  default     = 90
}

variable "failed_messages_threshold_warning" {
  description = "Warning threshold for failed_messages detector"
  type        = number
  default     = 50
}

variable "failed_messages_aperiodic_duration" {
  description = "Duration for the failed_messages block"
  type        = string
  default     = "10m"
}

variable "failed_messages_aperiodic_percentage" {
  description = "Percentage for the failed_messages block"
  type        = number
  default     = 0.9
}

# unmatched_events detectors

variable "unmatched_events_disabled" {
  description = "Disable all alerting rules for unmatched_events detector"
  type        = bool
  default     = null
}

variable "unmatched_events_disabled_critical" {
  description = "Disable critical alerting rule for unmatched_events detector"
  type        = bool
  default     = null
}

variable "unmatched_events_disabled_warning" {
  description = "Disable warning alerting rule for unmatched_events detector"
  type        = bool
  default     = null
}

variable "unmatched_events_notifications" {
  description = "Notification recipients list for every alerting rules of unmatched_events detector"
  type        = list
  default     = []
}

variable "unmatched_events_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of unmatched_events detector"
  type        = list
  default     = []
}

variable "unmatched_events_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of unmatched_events detector"
  type        = list
  default     = []
}

variable "unmatched_events_aggregation_function" {
  description = "Aggregation function and group by for unmatched_events detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_region', 'azure_resource_group_name', 'azure_resource_name'])"
}

variable "unmatched_events_transformation_function" {
  description = "Transformation function for unmatched_events detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "unmatched_events_transformation_window" {
  description = "Transformation window for unmatched_events detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "unmatched_events_threshold_critical" {
  description = "Critical threshold for unmatched_events detector"
  type        = number
  default     = 90
}

variable "unmatched_events_threshold_warning" {
  description = "Warning threshold for unmatched_events detector"
  type        = number
  default     = 50
}

variable "unmatched_events_aperiodic_duration" {
  description = "Duration for the unmatched_events block"
  type        = string
  default     = "10m"
}

variable "unmatched_events_aperiodic_percentage" {
  description = "Percentage for the unmatched_events block"
  type        = number
  default     = 0.9
}
