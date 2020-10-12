# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Default notification recipients list per severity"
  type = object({
    critical = list(string)
    major    = list(string)
    minor    = list(string)
    warning  = list(string)
    info     = list(string)
  })
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

# MySQL detectors specific

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

# Mysql_connection detectors

variable "mysql_connections_disabled" {
  description = "Disable all alerting rules for mysql_connection detector"
  type        = bool
  default     = null
}

variable "mysql_connections_disabled_critical" {
  description = "Disable critical alerting rule for mysql_connection detector"
  type        = bool
  default     = null
}

variable "mysql_connections_disabled_major" {
  description = "Disable major alerting rule for mysql_connection detector"
  type        = bool
  default     = null
}

variable "mysql_connections_notifications" {
  description = "Notification recipients list per severity overridden for mysql_connection detector"
  type        = map(list(string))
  default     = {}
}

variable "mysql_connections_aggregation_function" {
  description = "Aggregation function and group by for mysql_connection detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "mysql_connections_transformation_function" {
  description = "Transformation function for mysql_connection detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1m')"
}

variable "mysql_connections_threshold_critical" {
  description = "Critical threshold for mysql_connection detector"
  type        = number
  default     = 90
}

variable "mysql_connections_threshold_major" {
  description = "Major threshold for mysql_connection detector"
  type        = number
  default     = 70
}

# Mysql_pool_efficiency detectors

variable "mysql_pool_efficiency_disabled" {
  description = "Disable all alerting rules for mysql_pool_efficiency detector"
  type        = bool
  default     = null
}

variable "mysql_pool_efficiency_disabled_minor" {
  description = "Disable minor alerting rule for mysql_pool_efficiency detector"
  type        = bool
  default     = null
}

variable "mysql_pool_efficiency_disabled_warning" {
  description = "Disable warning alerting rule for mysql_pool_efficiency detector"
  type        = bool
  default     = null
}

variable "mysql_pool_efficiency_notifications" {
  description = "Notification recipients list per severity overridden for mysql_pool_efficiency detector"
  type        = map(list(string))
  default     = {}
}

variable "mysql_pool_efficiency_aggregation_function" {
  description = "Aggregation function and group by for mysql_pool_efficiency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "mysql_pool_efficiency_transformation_function" {
  description = "Transformation function for mysql_pool_efficiency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1h')"
}

variable "mysql_pool_efficiency_threshold_minor" {
  description = "minor threshold for mysql_pool_efficiency detector"
  type        = number
  default     = 30
}

variable "mysql_pool_efficiency_threshold_warning" {
  description = "warning threshold for mysql_pool_efficiency detector"
  type        = number
  default     = 20
}

# Mysql_pool_utilization detectors

variable "mysql_pool_utilization_disabled" {
  description = "Disable all alerting rules for mysql_pool_utilization detector"
  type        = bool
  default     = null
}

variable "mysql_pool_utilization_disabled_minor" {
  description = "Disable minor alerting rule for mysql_pool_utilization detector"
  type        = bool
  default     = null
}

variable "mysql_pool_utilization_disabled_warning" {
  description = "Disable warning alerting rule for mysql_pool_utilization detector"
  type        = bool
  default     = null
}

variable "mysql_pool_utilization_notifications" {
  description = "Notification recipients list per severity overridden for mysql_pool_utilization detector"
  type        = map(list(string))
  default     = {}
}

variable "mysql_pool_utilization_aggregation_function" {
  description = "Aggregation function and group by for mysql_pool_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "mysql_pool_utilization_transformation_function" {
  description = "Transformation function for mysql_pool_utilization detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1h')"
}

variable "mysql_pool_utilization_threshold_minor" {
  description = "minor threshold for mysql_pool_utilization detector"
  type        = number
  default     = 95
}

variable "mysql_pool_utilization_threshold_warning" {
  description = "warning threshold for mysql_pool_utilization detector"
  type        = number
  default     = 80
}

# Mysql_slow detectors

variable "mysql_slow_disabled" {
  description = "Disable all alerting rules for mysql_slow detector"
  type        = bool
  default     = null
}

variable "mysql_slow_disabled_critical" {
  description = "Disable critical alerting rule for mysql_slow detector"
  type        = bool
  default     = null
}

variable "mysql_slow_disabled_major" {
  description = "Disable major alerting rule for mysql_slow detector"
  type        = bool
  default     = null
}

variable "mysql_slow_notifications" {
  description = "Notification recipients list per severity overridden for mysql_slow detector"
  type        = map(list(string))
  default     = {}
}

variable "mysql_slow_aggregation_function" {
  description = "Aggregation function and group by for mysql_slow detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "mysql_slow_transformation_function" {
  description = "Transformation function for mysql_slow detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "mysql_slow_threshold_critical" {
  description = "Critical threshold for mysql_slow detector"
  type        = number
  default     = 25
}

variable "mysql_slow_threshold_major" {
  description = "Major threshold for mysql_slow detector"
  type        = number
  default     = 10
}

# Mysql_threads_anomaly detectors

variable "mysql_threads_anomaly_disabled" {
  description = "Disable all alerting rules for mysql_threads_anomaly detector"
  type        = bool
  default     = true
}

variable "mysql_threads_anomaly_notifications" {
  description = "Notification recipients list per severity overridden for mysql_threads_anomaly detector"
  type        = map(list(string))
  default     = {}
}

variable "mysql_threads_anomaly_aggregation_function" {
  description = "Aggregation function and group by for mysql_threads_anomaly detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "mysql_threads_anomaly_transformation_function" {
  description = "Transformation function for mysql_threads_anomaly detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "mysql_threads_anomaly_window_to_compare" {
  description = "Length of current window (being tested for anomalous values), and historical windows (used to establish a baseline)"
  type        = string
  default     = "15m"
}

variable "mysql_threads_anomaly_space_between_windows" {
  description = "Time range reflecting the periodicity of the data stream"
  type        = string
  default     = "1d"
}

variable "mysql_threads_anomaly_num_windows" {
  description = "Number of previous periods used to define baseline, must be > 0"
  type        = number
  default     = 4
}

variable "mysql_threads_anomaly_fire_growth_rate_threshold" {
  description = "Change over historical norm required to fire, should be >= 0"
  type        = number
  default     = 0.2
}

variable "mysql_threads_anomaly_clear_growth_rate_threshold" {
  description = "Change over historical norm required to clear, should be >= 0"
  type        = number
  default     = 0.1
}

variable "mysql_threads_anomaly_orientation" {
  description = "Specifies whether detect fires when signal is above, below, or out-of-band (Options:  above, below, out_of_band)"
  type        = string
  default     = "above"
}

# Mysql_questions_anomaly detectors

variable "mysql_questions_anomaly_disabled" {
  description = "Disable all alerting rules for mysql_questions_anomaly detector"
  type        = bool
  default     = true
}

variable "mysql_questions_anomaly_notifications" {
  description = "Notification recipients list per severity overridden for mysql_questions_anomaly detector"
  type        = map(list(string))
  default     = {}
}

variable "mysql_questions_anomaly_aggregation_function" {
  description = "Aggregation function and group by for mysql_questions_anomaly detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "mysql_questions_anomaly_transformation_function" {
  description = "Transformation function for mysql_questions_anomaly detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "mysql_questions_anomaly_window_to_compare" {
  description = "Length of current window (being tested for anomalous values), and historical windows (used to establish a baseline)"
  type        = string
  default     = "15m"
}

variable "mysql_questions_anomaly_space_between_windows" {
  description = "Time range reflecting the periodicity of the data stream"
  type        = string
  default     = "1d"
}

variable "mysql_questions_anomaly_num_windows" {
  description = "Number of previous periods used to define baseline, must be > 0"
  type        = number
  default     = 4
}

variable "mysql_questions_anomaly_fire_growth_rate_threshold" {
  description = "Change over historical norm required to fire, should be >= 0"
  type        = number
  default     = 0.2
}

variable "mysql_questions_anomaly_clear_growth_rate_threshold" {
  description = "Change over historical norm required to clear, should be >= 0"
  type        = number
  default     = 0.1
}

variable "mysql_questions_anomaly_orientation" {
  description = "Specifies whether detect fires when signal is above, below, or out-of-band (Options:  above, below, out_of_band)"
  type        = string
  default     = "above"
}

# Mysql_replication_lag detectors

variable "mysql_replication_lag_disabled" {
  description = "Disable all alerting rules for mysql_replication_lag detector"
  type        = bool
  default     = null
}

variable "mysql_replication_lag_disabled_critical" {
  description = "Disable critical alerting rule for mysql_replication_lag detector"
  type        = bool
  default     = null
}

variable "mysql_replication_lag_disabled_major" {
  description = "Disable major alerting rule for mysql_replication_lag detector"
  type        = bool
  default     = null
}

variable "mysql_replication_lag_notifications" {
  description = "Notification recipients list per severity overridden for mysql_replication_lag detector"
  type        = map(list(string))
  default     = {}
}

variable "mysql_replication_lag_aggregation_function" {
  description = "Aggregation function and group by for mysql_replication_lag detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "mysql_replication_lag_transformation_function" {
  description = "Transformation function for mysql_replication_lag detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "mysql_replication_lag_threshold_critical" {
  description = "Critical threshold for mysql_replication_lag detector"
  type        = number
  default     = 200
}

variable "mysql_replication_lag_threshold_major" {
  description = "Major threshold for mysql_replication_lag detector"
  type        = number
  default     = 100
}

# Mysql_replication_status detectors

variable "mysql_replication_status_disabled" {
  description = "Disable all alerting rules for mysql_replication_status detector"
  type        = bool
  default     = null
}

variable "mysql_replication_status_notifications" {
  description = "Notification recipients list per severity overridden for mysql_replication_status detector"
  type        = map(list(string))
  default     = {}
}

variable "mysql_replication_status_aggregation_function" {
  description = "Aggregation function and group by for mysql_replication_status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "mysql_replication_status_transformation_function" {
  description = "Transformation function for mysql_replication_status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

