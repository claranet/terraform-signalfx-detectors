# jvm_memory_pressure detector

variable "jvm_memory_pressure_notifications" {
  description = "Notification recipients list per severity overridden for jvm_memory_pressure detector"
  type        = map(list(string))
  default     = {}
}

variable "jvm_memory_pressure_aggregation_function" {
  description = "Aggregation function and group by for jvm_memory_pressure detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "jvm_memory_pressure_transformation_function" {
  description = "Transformation function for jvm_memory_pressure detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "jvm_memory_pressure_max_delay" {
  description = "Enforce max delay for jvm_memory_pressure detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "jvm_memory_pressure_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    The cluster could encounter out of memory errors if usage increases. Consider scaling vertically.
EOF
}

variable "jvm_memory_pressure_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "jvm_memory_pressure_disabled" {
  description = "Disable all alerting rules for jvm_memory_pressure detector"
  type        = bool
  default     = null
}

variable "jvm_memory_pressure_disabled_critical" {
  description = "Disable critical alerting rule for jvm_memory_pressure detector"
  type        = bool
  default     = null
}

variable "jvm_memory_pressure_disabled_major" {
  description = "Disable major alerting rule for jvm_memory_pressure detector"
  type        = bool
  default     = null
}

variable "jvm_memory_pressure_threshold_critical" {
  description = "Critical threshold for jvm_memory_pressure detector in %"
  type        = number
  default     = 90
}

variable "jvm_memory_pressure_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "jvm_memory_pressure_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "jvm_memory_pressure_threshold_major" {
  description = "Major threshold for jvm_memory_pressure detector in %"
  type        = number
  default     = 80
}

variable "jvm_memory_pressure_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "jvm_memory_pressure_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# fourxx_http_response detector

variable "fourxx_http_response_notifications" {
  description = "Notification recipients list per severity overridden for fourxx_http_response detector"
  type        = map(list(string))
  default     = {}
}

variable "fourxx_http_response_aggregation_function" {
  description = "Aggregation function and group by for fourxx_http_response detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "fourxx_http_response_transformation_function" {
  description = "Transformation function for fourxx_http_response detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "fourxx_http_response_max_delay" {
  description = "Enforce max delay for fourxx_http_response detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "fourxx_http_response_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    In addition to the runbook, have a look at https://aws.amazon.com/premiumsupport/knowledge-center/opensearch-resolve-429-error/ and  https://docs.aws.amazon.com/opensearch-service/latest/developerguide/handling-errors.html#troubleshooting-throttle-api
EOF
}

variable "fourxx_http_response_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = "https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-cloudwatchmetrics.html"
}

variable "fourxx_http_response_disabled" {
  description = "Disable all alerting rules for fourxx_http_response detector"
  type        = bool
  default     = true
}

variable "fourxx_http_response_disabled_critical" {
  description = "Disable critical alerting rule for fourxx_http_response detector"
  type        = bool
  default     = null
}

variable "fourxx_http_response_disabled_major" {
  description = "Disable major alerting rule for fourxx_http_response detector"
  type        = bool
  default     = null
}

variable "fourxx_http_response_threshold_critical" {
  description = "Critical threshold for fourxx_http_response detector in %"
  type        = number
  default     = 10
}

variable "fourxx_http_response_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "fourxx_http_response_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "fourxx_http_response_threshold_major" {
  description = "Major threshold for fourxx_http_response detector in %"
  type        = number
  default     = 5
}

variable "fourxx_http_response_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "fourxx_http_response_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# fivexx_http_response detector

variable "fivexx_http_response_notifications" {
  description = "Notification recipients list per severity overridden for fivexx_http_response detector"
  type        = map(list(string))
  default     = {}
}

variable "fivexx_http_response_aggregation_function" {
  description = "Aggregation function and group by for fivexx_http_response detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "fivexx_http_response_transformation_function" {
  description = "Transformation function for fivexx_http_response detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "fivexx_http_response_max_delay" {
  description = "Enforce max delay for fivexx_http_response detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "fivexx_http_response_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    In addition to the runbook, have a look at https://aws.amazon.com/premiumsupport/knowledge-center/opensearch-5xx-errors/
EOF
}

variable "fivexx_http_response_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = "https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-cloudwatchmetrics.html"
}

variable "fivexx_http_response_disabled" {
  description = "Disable all alerting rules for fivexx_http_response detector"
  type        = bool
  default     = null
}

variable "fivexx_http_response_disabled_critical" {
  description = "Disable critical alerting rule for fivexx_http_response detector"
  type        = bool
  default     = null
}

variable "fivexx_http_response_disabled_major" {
  description = "Disable major alerting rule for fivexx_http_response detector"
  type        = bool
  default     = null
}

variable "fivexx_http_response_threshold_critical" {
  description = "Critical threshold for fivexx_http_response detector in %"
  type        = number
  default     = 10
}

variable "fivexx_http_response_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "fivexx_http_response_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "fivexx_http_response_threshold_major" {
  description = "Major threshold for fivexx_http_response detector in %"
  type        = number
  default     = 5
}

variable "fivexx_http_response_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "fivexx_http_response_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# shard_count detector

variable "shard_count_notifications" {
  description = "Notification recipients list per severity overridden for shard_count detector"
  type        = map(list(string))
  default     = {}
}

variable "shard_count_aggregation_function" {
  description = "Aggregation function and group by for shard_count detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "shard_count_transformation_function" {
  description = "Transformation function for shard_count detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "shard_count_max_delay" {
  description = "Enforce max delay for shard_count detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "shard_count_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    Have a look at https://docs.aws.amazon.com/opensearch-service/latest/developerguide/sizing-domains.html#bp-sharding
EOF
}

variable "shard_count_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "shard_count_disabled" {
  description = "Disable all alerting rules for shard_count detector"
  type        = bool
  default     = null
}

variable "shard_count_disabled_critical" {
  description = "Disable critical alerting rule for shard_count detector"
  type        = bool
  default     = null
}

variable "shard_count_disabled_major" {
  description = "Disable major alerting rule for shard_count detector"
  type        = bool
  default     = null
}

variable "shard_count_threshold_critical" {
  description = "Critical threshold for shard_count detector"
  type        = number
  default     = 900
}

variable "shard_count_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "shard_count_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "shard_count_threshold_major" {
  description = "Major threshold for shard_count detector"
  type        = number
  default     = 800
}

variable "shard_count_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "shard_count_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
