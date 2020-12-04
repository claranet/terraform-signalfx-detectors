# Module specific

# Aurora_mysql_replica_lag detector

variable "aurora_mysql_replica_lag_disabled" {
  description = "Disable all alerting rules for aurora_mysql_replica_lag detector"
  type        = bool
  default     = null
}

variable "aurora_mysql_replica_lag_disabled_critical" {
  description = "Disable critical alerting rule for aurora_mysql_replica_lag detector"
  type        = bool
  default     = null
}

variable "aurora_mysql_replica_lag_disabled_major" {
  description = "Disable major alerting rule for aurora_mysql_replica_lag detector"
  type        = bool
  default     = null
}

variable "aurora_mysql_replica_lag_notifications" {
  description = "Notification recipients list per severity overridden for aurora_mysql_replica_lag detector"
  type        = map(list(string))
  default     = {}
}

variable "aurora_mysql_replica_lag_aggregation_function" {
  description = "Aggregation function and group by for aurora_mysql_replica_lag detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "aurora_mysql_replica_lag_transformation_function" {
  description = "Transformation function for aurora_mysql_replica_lag detector (mean, min, max)"
  type        = string
  default     = ".min(over='5m')"
}

variable "aurora_mysql_replica_lag_threshold_critical" {
  description = "Critical threshold for aurora_mysql_replica_lag detector"
  type        = number
  default     = 200
}

variable "aurora_mysql_replica_lag_threshold_major" {
  description = "Major threshold for aurora_mysql_replica_lag detector"
  type        = number
  default     = 100
}

