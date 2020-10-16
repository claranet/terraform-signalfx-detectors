# Module specific

# Heartbeat detector

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

# connection detector

variable "connections_disabled" {
  description = "Disable all alerting rules for connection detector"
  type        = bool
  default     = null
}

variable "connections_disabled_critical" {
  description = "Disable critical alerting rule for connection detector"
  type        = bool
  default     = null
}

variable "connections_disabled_major" {
  description = "Disable major alerting rule for connection detector"
  type        = bool
  default     = null
}

variable "connections_notifications" {
  description = "Notification recipients list per severity overridden for connection detector"
  type        = map(list(string))
  default     = {}
}

variable "connections_aggregation_function" {
  description = "Aggregation function and group by for connection detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "connections_transformation_function" {
  description = "Transformation function for connection detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1m')"
}

variable "connections_threshold_critical" {
  description = "Critical threshold for connection detector"
  type        = number
  default     = 90
}

variable "connections_threshold_major" {
  description = "Major threshold for connection detector"
  type        = number
  default     = 70
}

# pool_efficiency detector

variable "pool_efficiency_disabled" {
  description = "Disable all alerting rules for pool_efficiency detector"
  type        = bool
  default     = null
}

variable "pool_efficiency_disabled_minor" {
  description = "Disable minor alerting rule for pool_efficiency detector"
  type        = bool
  default     = null
}

variable "pool_efficiency_disabled_warning" {
  description = "Disable warning alerting rule for pool_efficiency detector"
  type        = bool
  default     = null
}

variable "pool_efficiency_notifications" {
  description = "Notification recipients list per severity overridden for pool_efficiency detector"
  type        = map(list(string))
  default     = {}
}

variable "pool_efficiency_aggregation_function" {
  description = "Aggregation function and group by for pool_efficiency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "pool_efficiency_transformation_function" {
  description = "Transformation function for pool_efficiency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1h')"
}

variable "pool_efficiency_threshold_minor" {
  description = "minor threshold for pool_efficiency detector"
  type        = number
  default     = 30
}

variable "pool_efficiency_threshold_warning" {
  description = "warning threshold for pool_efficiency detector"
  type        = number
  default     = 20
}

# pool_utilization detector

variable "pool_utilization_disabled" {
  description = "Disable all alerting rules for pool_utilization detector"
  type        = bool
  default     = null
}

variable "pool_utilization_disabled_minor" {
  description = "Disable minor alerting rule for pool_utilization detector"
  type        = bool
  default     = null
}

variable "pool_utilization_disabled_warning" {
  description = "Disable warning alerting rule for pool_utilization detector"
  type        = bool
  default     = null
}

variable "pool_utilization_notifications" {
  description = "Notification recipients list per severity overridden for pool_utilization detector"
  type        = map(list(string))
  default     = {}
}

variable "pool_utilization_aggregation_function" {
  description = "Aggregation function and group by for pool_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "pool_utilization_transformation_function" {
  description = "Transformation function for pool_utilization detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1h')"
}

variable "pool_utilization_threshold_minor" {
  description = "minor threshold for pool_utilization detector"
  type        = number
  default     = 95
}

variable "pool_utilization_threshold_warning" {
  description = "warning threshold for pool_utilization detector"
  type        = number
  default     = 80
}

# slow detector

variable "slow_disabled" {
  description = "Disable all alerting rules for slow detector"
  type        = bool
  default     = null
}

variable "slow_disabled_critical" {
  description = "Disable critical alerting rule for slow detector"
  type        = bool
  default     = null
}

variable "slow_disabled_major" {
  description = "Disable major alerting rule for slow detector"
  type        = bool
  default     = null
}

variable "slow_notifications" {
  description = "Notification recipients list per severity overridden for slow detector"
  type        = map(list(string))
  default     = {}
}

variable "slow_aggregation_function" {
  description = "Aggregation function and group by for slow detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "slow_transformation_function" {
  description = "Transformation function for slow detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "slow_threshold_critical" {
  description = "Critical threshold for slow detector"
  type        = number
  default     = 25
}

variable "slow_threshold_major" {
  description = "Major threshold for slow detector"
  type        = number
  default     = 10
}

# threads_anomaly detector

variable "threads_anomaly_disabled" {
  description = "Disable all alerting rules for threads_anomaly detector"
  type        = bool
  default     = true
}

variable "threads_anomaly_notifications" {
  description = "Notification recipients list per severity overridden for threads_anomaly detector"
  type        = map(list(string))
  default     = {}
}

variable "threads_anomaly_aggregation_function" {
  description = "Aggregation function and group by for threads_anomaly detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "threads_anomaly_transformation_function" {
  description = "Transformation function for threads_anomaly detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "threads_anomaly_window_to_compare" {
  description = "Length of current window (being tested for anomalous values), and historical windows (used to establish a baseline)"
  type        = string
  default     = "15m"
}

variable "threads_anomaly_space_between_windows" {
  description = "Time range reflecting the periodicity of the data stream"
  type        = string
  default     = "1d"
}

variable "threads_anomaly_num_windows" {
  description = "Number of previous periods used to define baseline, must be > 0"
  type        = number
  default     = 4
}

variable "threads_anomaly_fire_growth_rate_threshold" {
  description = "Change over historical norm required to fire, should be >= 0"
  type        = number
  default     = 0.2
}

variable "threads_anomaly_clear_growth_rate_threshold" {
  description = "Change over historical norm required to clear, should be >= 0"
  type        = number
  default     = 0.1
}

variable "threads_anomaly_orientation" {
  description = "Specifies whether detect fires when signal is above, below, or out-of-band (Options:  above, below, out_of_band)"
  type        = string
  default     = "above"
}

# questions_anomaly detector

variable "questions_anomaly_disabled" {
  description = "Disable all alerting rules for questions_anomaly detector"
  type        = bool
  default     = true
}

variable "questions_anomaly_notifications" {
  description = "Notification recipients list per severity overridden for questions_anomaly detector"
  type        = map(list(string))
  default     = {}
}

variable "questions_anomaly_aggregation_function" {
  description = "Aggregation function and group by for questions_anomaly detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "questions_anomaly_transformation_function" {
  description = "Transformation function for questions_anomaly detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "questions_anomaly_window_to_compare" {
  description = "Length of current window (being tested for anomalous values), and historical windows (used to establish a baseline)"
  type        = string
  default     = "15m"
}

variable "questions_anomaly_space_between_windows" {
  description = "Time range reflecting the periodicity of the data stream"
  type        = string
  default     = "1d"
}

variable "questions_anomaly_num_windows" {
  description = "Number of previous periods used to define baseline, must be > 0"
  type        = number
  default     = 4
}

variable "questions_anomaly_fire_growth_rate_threshold" {
  description = "Change over historical norm required to fire, should be >= 0"
  type        = number
  default     = 0.2
}

variable "questions_anomaly_clear_growth_rate_threshold" {
  description = "Change over historical norm required to clear, should be >= 0"
  type        = number
  default     = 0.1
}

variable "questions_anomaly_orientation" {
  description = "Specifies whether detect fires when signal is above, below, or out-of-band (Options:  above, below, out_of_band)"
  type        = string
  default     = "above"
}

# replication_lag detector

variable "replication_lag_disabled" {
  description = "Disable all alerting rules for replication_lag detector"
  type        = bool
  default     = null
}

variable "replication_lag_disabled_critical" {
  description = "Disable critical alerting rule for replication_lag detector"
  type        = bool
  default     = null
}

variable "replication_lag_disabled_major" {
  description = "Disable major alerting rule for replication_lag detector"
  type        = bool
  default     = null
}

variable "replication_lag_notifications" {
  description = "Notification recipients list per severity overridden for replication_lag detector"
  type        = map(list(string))
  default     = {}
}

variable "replication_lag_aggregation_function" {
  description = "Aggregation function and group by for replication_lag detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "replication_lag_transformation_function" {
  description = "Transformation function for replication_lag detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "replication_lag_threshold_critical" {
  description = "Critical threshold for replication_lag detector"
  type        = number
  default     = 200
}

variable "replication_lag_threshold_major" {
  description = "Major threshold for replication_lag detector"
  type        = number
  default     = 100
}

# slave_sql_status detector

variable "slave_sql_status_disabled" {
  description = "Disable all alerting rules for slave_sql_status detector"
  type        = bool
  default     = null
}

variable "slave_sql_status_notifications" {
  description = "Notification recipients list per severity overridden for slave_sql_status detector"
  type        = map(list(string))
  default     = {}
}

variable "slave_sql_status_aggregation_function" {
  description = "Aggregation function and group by for slave_sql_status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "slave_sql_status_transformation_function" {
  description = "Transformation function for slave_sql_status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

# slave_io_status detector

variable "slave_io_status_disabled" {
  description = "Disable all alerting rules for slave_io_status detector"
  type        = bool
  default     = null
}

variable "slave_io_status_notifications" {
  description = "Notification recipients list per severity overridden for slave_io_status detector"
  type        = map(list(string))
  default     = {}
}

variable "slave_io_status_aggregation_function" {
  description = "Aggregation function and group by for slave_io_status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "slave_io_status_transformation_function" {
  description = "Transformation function for slave_io_status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

