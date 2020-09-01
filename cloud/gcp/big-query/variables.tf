# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

variable "gcp_project_id" {
  description = "GCP project id used for default filtering while lables are not synced"
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

# GCP Bigquery detectors specific

# Concurrent_queries detectors

variable "concurrent_queries_disabled" {
  description = "Disable all alerting rules for concurrent_queries detector"
  type        = bool
  default     = null
}

variable "concurrent_queries_disabled_critical" {
  description = "Disable critical alerting rule for concurrent_queries detector"
  type        = bool
  default     = null
}

variable "concurrent_queries_disabled_warning" {
  description = "Disable warning alerting rule for concurrent_queries detector"
  type        = bool
  default     = null
}

variable "concurrent_queries_notifications" {
  description = "Notification recipients list for every alerting rules of concurrent_queries detector"
  type        = list
  default     = []
}

variable "concurrent_queries_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of concurrent_queries detector"
  type        = list
  default     = []
}

variable "concurrent_queries_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of concurrent_queries detector"
  type        = list
  default     = []
}

variable "concurrent_queries_aggregation_function" {
  description = "Aggregation function and group by for concurrent_queries detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "concurrent_queries_transformation_function" {
  description = "Transformation function for concurrent_queries detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='5m')"
}

variable "concurrent_queries_threshold_critical" {
  description = "Critical threshold for concurrent_queries detector"
  type        = number
  default     = 45
}

variable "concurrent_queries_threshold_warning" {
  description = "Warning threshold for concurrent_queries detector"
  type        = number
  default     = 40
}

variable "concurrent_queries_aperiodic_duration" {
  description = "Duration for the concurrent_queries block"
  type        = string
  default     = "10m"
}

variable "concurrent_queries_aperiodic_percentage" {
  description = "Percentage for the concurrent_queries block"
  type        = number
  default     = 0.9
}

variable "concurrent_queries_clear_duration" {
  description = "Duration for the concurrent_queries clear condition"
  type        = string
  default     = "15m"
}

# Execution_time detectors

variable "execution_time_disabled" {
  description = "Disable all alerting rules for execution_time detector"
  type        = bool
  default     = null
}

variable "execution_time_disabled_critical" {
  description = "Disable critical alerting rule for execution_time detector"
  type        = bool
  default     = null
}

variable "execution_time_disabled_warning" {
  description = "Disable warning alerting rule for execution_time detector"
  type        = bool
  default     = null
}

variable "execution_time_notifications" {
  description = "Notification recipients list for every alerting rules of execution_time detector"
  type        = list
  default     = []
}

variable "execution_time_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of execution_time detector"
  type        = list
  default     = []
}

variable "execution_time_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of execution_time detector"
  type        = list
  default     = []
}

variable "execution_time_aggregation_function" {
  description = "Aggregation function and group by for execution_time detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "execution_time_transformation_function" {
  description = "Transformation function for execution_time detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='5m')"
}

variable "execution_time_threshold_critical" {
  description = "Critical threshold for execution_time detector"
  type        = number
  default     = 150
}

variable "execution_time_threshold_warning" {
  description = "Warning threshold for execution_time detector"
  type        = number
  default     = 100
}

variable "execution_time_aperiodic_duration" {
  description = "Duration for the execution_time block"
  type        = string
  default     = "10m"
}

variable "execution_time_aperiodic_percentage" {
  description = "Percentage for the execution_time block"
  type        = number
  default     = 0.9
}

variable "execution_time_clear_duration" {
  description = "Duration for the execution_time clear condition"
  type        = string
  default     = "15m"
}

# Scanned_bytes detectors

variable "scanned_bytes_disabled" {
  description = "Disable all alerting rules for scanned_bytes detector"
  type        = bool
  default     = null
}

variable "scanned_bytes_disabled_critical" {
  description = "Disable critical alerting rule for scanned_bytes detector"
  type        = bool
  default     = null
}

variable "scanned_bytes_disabled_warning" {
  description = "Disable warning alerting rule for scanned_bytes detector"
  type        = bool
  default     = null
}

variable "scanned_bytes_notifications" {
  description = "Notification recipients list for every alerting rules of scanned_bytes detector"
  type        = list
  default     = []
}

variable "scanned_bytes_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of scanned_bytes detector"
  type        = list
  default     = []
}

variable "scanned_bytes_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of scanned_bytes detector"
  type        = list
  default     = []
}

variable "scanned_bytes_aggregation_function" {
  description = "Aggregation function and group by for scanned_bytes detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "scanned_bytes_transformation_function" {
  description = "Transformation function for scanned_bytes detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='4h')"
}

variable "scanned_bytes_threshold_critical" {
  description = "Critical threshold for scanned_bytes detector"
  type        = number
  default     = 1
}

variable "scanned_bytes_threshold_warning" {
  description = "Warning threshold for scanned_bytes detector"
  type        = number
  default     = 0
}

variable "scanned_bytes_aperiodic_duration" {
  description = "Duration for the scanned_bytes block"
  type        = string
  default     = "10m"
}

variable "scanned_bytes_aperiodic_percentage" {
  description = "Percentage for the scanned_bytes block"
  type        = number
  default     = 0.9
}

variable "scanned_bytes_clear_duration" {
  description = "Duration for the scanned_bytes clear condition"
  type        = string
  default     = "15m"
}

# Scanned_bytes_billed detectors

variable "scanned_bytes_billed_disabled" {
  description = "Disable all alerting rules for scanned_bytes_billed detector"
  type        = bool
  default     = null
}

variable "scanned_bytes_billed_disabled_critical" {
  description = "Disable critical alerting rule for scanned_bytes_billed detector"
  type        = bool
  default     = null
}

variable "scanned_bytes_billed_disabled_warning" {
  description = "Disable warning alerting rule for scanned_bytes_billed detector"
  type        = bool
  default     = null
}

variable "scanned_bytes_billed_notifications" {
  description = "Notification recipients list for every alerting rules of scanned_bytes_billed detector"
  type        = list
  default     = []
}

variable "scanned_bytes_billed_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of scanned_bytes_billed detector"
  type        = list
  default     = []
}

variable "scanned_bytes_billed_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of scanned_bytes_billed detector"
  type        = list
  default     = []
}

variable "scanned_bytes_billed_aggregation_function" {
  description = "Aggregation function and group by for scanned_bytes_billed detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "scanned_bytes_billed_transformation_function" {
  description = "Transformation function for scanned_bytes_billed detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='4h')"
}

variable "scanned_bytes_billed_threshold_critical" {
  description = "Critical threshold for scanned_bytes_billed detector"
  type        = number
  default     = 1
}

variable "scanned_bytes_billed_threshold_warning" {
  description = "Warning threshold for scanned_bytes_billed detector"
  type        = number
  default     = 0
}

variable "scanned_bytes_billed_aperiodic_duration" {
  description = "Duration for the scanned_bytes_billed block"
  type        = string
  default     = "10m"
}

variable "scanned_bytes_billed_aperiodic_percentage" {
  description = "Percentage for the scanned_bytes_billed block"
  type        = number
  default     = 0.9
}

variable "scanned_bytes_billed_clear_duration" {
  description = "Duration for the scanned_bytes_billed clear condition"
  type        = string
  default     = "15m"
}

# Available_slots detectors

variable "available_slots_disabled" {
  description = "Disable all alerting rules for available_slots detector"
  type        = bool
  default     = null
}

variable "available_slots_disabled_critical" {
  description = "Disable critical alerting rule for available_slots detector"
  type        = bool
  default     = null
}

variable "available_slots_disabled_warning" {
  description = "Disable warning alerting rule for available_slots detector"
  type        = bool
  default     = null
}

variable "available_slots_notifications" {
  description = "Notification recipients list for every alerting rules of available_slots detector"
  type        = list
  default     = []
}

variable "available_slots_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of available_slots detector"
  type        = list
  default     = []
}

variable "available_slots_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of available_slots detector"
  type        = list
  default     = []
}

variable "available_slots_aggregation_function" {
  description = "Aggregation function and group by for available_slots detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "available_slots_transformation_function" {
  description = "Transformation function for available_slots detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='5m')"
}

variable "available_slots_threshold_critical" {
  description = "Critical threshold for available_slots detector"
  type        = number
  default     = 200
}

variable "available_slots_threshold_warning" {
  description = "Warning threshold for available_slots detector"
  type        = number
  default     = 300
}

variable "available_slots_aperiodic_duration" {
  description = "Duration for the available_slots block"
  type        = string
  default     = "10m"
}

variable "available_slots_aperiodic_percentage" {
  description = "Percentage for the available_slots block"
  type        = number
  default     = 0.9
}

variable "available_slots_clear_duration" {
  description = "Duration for the available_slots clear condition"
  type        = string
  default     = "15m"
}

# Stored_bytes detectors

variable "stored_bytes_disabled" {
  description = "Disable all alerting rules for stored_bytes detector"
  type        = bool
  default     = null
}

variable "stored_bytes_disabled_critical" {
  description = "Disable critical alerting rule for stored_bytes detector"
  type        = bool
  default     = null
}

variable "stored_bytes_disabled_warning" {
  description = "Disable warning alerting rule for stored_bytes detector"
  type        = bool
  default     = null
}

variable "stored_bytes_notifications" {
  description = "Notification recipients list for every alerting rules of stored_bytes detector"
  type        = list
  default     = []
}

variable "stored_bytes_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of stored_bytes detector"
  type        = list
  default     = []
}

variable "stored_bytes_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of stored_bytes detector"
  type        = list
  default     = []
}

variable "stored_bytes_aggregation_function" {
  description = "Aggregation function and group by for stored_bytes detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "stored_bytes_transformation_function" {
  description = "Transformation function for stored_bytes detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='5m')"
}

variable "stored_bytes_threshold_critical" {
  description = "Critical threshold for stored_bytes detector"
  type        = number
  default     = 1
}

variable "stored_bytes_threshold_warning" {
  description = "Warning threshold for stored_bytes detector"
  type        = number
  default     = 0
}

variable "stored_bytes_aperiodic_duration" {
  description = "Duration for the stored_bytes block"
  type        = string
  default     = "10m"
}

variable "stored_bytes_aperiodic_percentage" {
  description = "Percentage for the stored_bytes block"
  type        = number
  default     = 0.9
}

variable "stored_bytes_clear_duration" {
  description = "Duration for the stored_bytes clear condition"
  type        = string
  default     = "15m"
}

# table_count detectors

variable "table_count_disabled" {
  description = "Disable all alerting rules for table_count detector"
  type        = bool
  default     = null
}

variable "table_count_disabled_critical" {
  description = "Disable critical alerting rule for table_count detector"
  type        = bool
  default     = null
}

variable "table_count_disabled_warning" {
  description = "Disable warning alerting rule for table_count detector"
  type        = bool
  default     = null
}

variable "table_count_notifications" {
  description = "Notification recipients list for every alerting rules of table_count detector"
  type        = list
  default     = []
}

variable "table_count_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of table_count detector"
  type        = list
  default     = []
}

variable "table_count_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of table_count detector"
  type        = list
  default     = []
}

variable "table_count_aggregation_function" {
  description = "Aggregation function and group by for table_count detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "table_count_transformation_function" {
  description = "Transformation function for table_count detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='4h')"
}

variable "table_count_threshold_critical" {
  description = "Critical threshold for table_count detector"
  type        = number
  default     = 1
}

variable "table_count_threshold_warning" {
  description = "Warning threshold for table_count detector"
  type        = number
  default     = 0
}

variable "table_count_aperiodic_duration" {
  description = "Duration for the table_count block"
  type        = string
  default     = "10m"
}

variable "table_count_aperiodic_percentage" {
  description = "Percentage for the table_count block"
  type        = number
  default     = 0.9
}

variable "table_count_clear_duration" {
  description = "Duration for the table_count clear condition"
  type        = string
  default     = "15m"
}

# uploaded_bytes detectors

variable "uploaded_bytes_disabled" {
  description = "Disable all alerting rules for uploaded_bytes detector"
  type        = bool
  default     = null
}

variable "uploaded_bytes_disabled_critical" {
  description = "Disable critical alerting rule for uploaded_bytes detector"
  type        = bool
  default     = null
}

variable "uploaded_bytes_disabled_warning" {
  description = "Disable warning alerting rule for uploaded_bytes detector"
  type        = bool
  default     = null
}

variable "uploaded_bytes_notifications" {
  description = "Notification recipients list for every alerting rules of uploaded_bytes detector"
  type        = list
  default     = []
}

variable "uploaded_bytes_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of uploaded_bytes detector"
  type        = list
  default     = []
}

variable "uploaded_bytes_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of uploaded_bytes detector"
  type        = list
  default     = []
}

variable "uploaded_bytes_aggregation_function" {
  description = "Aggregation function and group by for uploaded_bytes detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "uploaded_bytes_transformation_function" {
  description = "Transformation function for uploaded_bytes detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='4h')"
}

variable "uploaded_bytes_threshold_critical" {
  description = "Critical threshold for uploaded_bytes detector"
  type        = number
  default     = 1
}

variable "uploaded_bytes_threshold_warning" {
  description = "Warning threshold for uploaded_bytes detector"
  type        = number
  default     = 0
}

variable "uploaded_bytes_aperiodic_duration" {
  description = "Duration for the uploaded_bytes block"
  type        = string
  default     = "10m"
}

variable "uploaded_bytes_aperiodic_percentage" {
  description = "Percentage for the uploaded_bytes block"
  type        = number
  default     = 0.9
}

variable "uploaded_bytes_clear_duration" {
  description = "Duration for the uploaded_bytes clear condition"
  type        = string
  default     = "15m"
}

# uploaded_bytes_billed detectors

variable "uploaded_bytes_billed_disabled" {
  description = "Disable all alerting rules for uploaded_bytes_billed detector"
  type        = bool
  default     = null
}

variable "uploaded_bytes_billed_disabled_critical" {
  description = "Disable critical alerting rule for uploaded_bytes_billed detector"
  type        = bool
  default     = null
}

variable "uploaded_bytes_billed_disabled_warning" {
  description = "Disable warning alerting rule for uploaded_bytes_billed detector"
  type        = bool
  default     = null
}

variable "uploaded_bytes_billed_notifications" {
  description = "Notification recipients list for every alerting rules of uploaded_bytes_billed detector"
  type        = list
  default     = []
}

variable "uploaded_bytes_billed_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of uploaded_bytes_billed detector"
  type        = list
  default     = []
}

variable "uploaded_bytes_billed_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of uploaded_bytes_billed detector"
  type        = list
  default     = []
}

variable "uploaded_bytes_billed_aggregation_function" {
  description = "Aggregation function and group by for uploaded_bytes_billed detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "uploaded_bytes_billed_transformation_function" {
  description = "Transformation function for uploaded_bytes_billed detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='4h')"
}

variable "uploaded_bytes_billed_threshold_critical" {
  description = "Critical threshold for uploaded_bytes_billed detector"
  type        = number
  default     = 1
}

variable "uploaded_bytes_billed_threshold_warning" {
  description = "Warning threshold for uploaded_bytes_billed detector"
  type        = number
  default     = 0
}

variable "uploaded_bytes_billed_aperiodic_duration" {
  description = "Duration for the uploaded_bytes_billed block"
  type        = string
  default     = "10m"
}

variable "uploaded_bytes_billed_aperiodic_percentage" {
  description = "Percentage for the uploaded_bytes_billed block"
  type        = number
  default     = 0.9
}

variable "uploaded_bytes_billed_clear_duration" {
  description = "Duration for the uploaded_bytes_billed clear condition"
  type        = string
  default     = "15m"
}
