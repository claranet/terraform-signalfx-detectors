# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['DomainName'])"
}

variable "heartbeat_max_delay" {
  description = "Enforce max delay for heartbeat detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = 900
}

variable "heartbeat_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "heartbeat_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "10m"
}

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

variable "fivexx_http_response_disabled_critical_open_search" {
  description = "Disable critical_open_search alerting rule for fivexx_http_response detector"
  type        = bool
  default     = null
}

variable "fivexx_http_response_disabled_major_open_search" {
  description = "Disable major_open_search alerting rule for fivexx_http_response detector"
  type        = bool
  default     = null
}

variable "fivexx_http_response_disabled_critical_elastic_search" {
  description = "Disable critical_elastic_search alerting rule for fivexx_http_response detector"
  type        = bool
  default     = null
}

variable "fivexx_http_response_disabled_major_elastic_search" {
  description = "Disable major_elastic_search alerting rule for fivexx_http_response detector"
  type        = bool
  default     = null
}

variable "fivexx_http_response_threshold_critical_open_search" {
  description = "Critical_open_search threshold for fivexx_http_response detector in %"
  type        = number
  default     = 10
}

variable "fivexx_http_response_lasting_duration_critical_open_search" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "fivexx_http_response_at_least_percentage_critical_open_search" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "fivexx_http_response_threshold_major_open_search" {
  description = "Major_open_search threshold for fivexx_http_response detector in %"
  type        = number
  default     = 5
}

variable "fivexx_http_response_lasting_duration_major_open_search" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "fivexx_http_response_at_least_percentage_major_open_search" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "fivexx_http_response_threshold_critical_elastic_search" {
  description = "Critical_elastic_search threshold for fivexx_http_response detector in %"
  type        = number
  default     = 10
}

variable "fivexx_http_response_lasting_duration_critical_elastic_search" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "fivexx_http_response_at_least_percentage_critical_elastic_search" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "fivexx_http_response_threshold_major_elastic_search" {
  description = "Major_elastic_search threshold for fivexx_http_response detector in %"
  type        = number
  default     = 5
}

variable "fivexx_http_response_lasting_duration_major_elastic_search" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "fivexx_http_response_at_least_percentage_major_elastic_search" {
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
# cluster_status detector

variable "cluster_status_notifications" {
  description = "Notification recipients list per severity overridden for cluster_status detector"
  type        = map(list(string))
  default     = {}
}

variable "cluster_status_aggregation_function" {
  description = "Aggregation function and group by for cluster_status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "cluster_status_transformation_function" {
  description = "Transformation function for cluster_status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "cluster_status_max_delay" {
  description = "Enforce max delay for cluster_status detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cluster_status_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cluster_status_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cluster_status_disabled" {
  description = "Disable all alerting rules for cluster_status detector"
  type        = bool
  default     = null
}

variable "cluster_status_disabled_critical" {
  description = "Disable critical alerting rule for cluster_status detector"
  type        = bool
  default     = null
}

variable "cluster_status_disabled_major" {
  description = "Disable major alerting rule for cluster_status detector"
  type        = bool
  default     = null
}

variable "cluster_status_threshold_critical" {
  description = "Critical threshold for cluster_status detector"
  type        = number
  default     = 1
}

variable "cluster_status_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cluster_status_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cluster_status_threshold_major" {
  description = "Major threshold for cluster_status detector"
  type        = number
  default     = 1
}

variable "cluster_status_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cluster_status_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# free_space detector

variable "free_space_notifications" {
  description = "Notification recipients list per severity overridden for free_space detector"
  type        = map(list(string))
  default     = {}
}

variable "free_space_transformation_function" {
  description = "Transformation function for free_space detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".scale(0.001)"
}

variable "free_space_max_delay" {
  description = "Enforce max delay for free_space detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "free_space_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "free_space_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "free_space_disabled" {
  description = "Disable all alerting rules for free_space detector"
  type        = bool
  default     = null
}

variable "free_space_disabled_major" {
  description = "Disable major alerting rule for free_space detector"
  type        = bool
  default     = null
}

variable "free_space_disabled_critical" {
  description = "Disable critical alerting rule for free_space detector"
  type        = bool
  default     = null
}

variable "free_space_threshold_major" {
  description = "Major threshold for free_space detector in Gibibyte"
  type        = number
  default     = 40
}

variable "free_space_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "free_space_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "free_space_threshold_critical" {
  description = "Critical threshold for free_space detector in Gibibyte"
  type        = number
  default     = 20
}

variable "free_space_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "free_space_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# ultrawarm_free_space detector

variable "ultrawarm_free_space_notifications" {
  description = "Notification recipients list per severity overridden for ultrawarm_free_space detector"
  type        = map(list(string))
  default     = {}
}

variable "ultrawarm_free_space_transformation_function" {
  description = "Transformation function for ultrawarm_free_space detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".scale(0.001)"
}

variable "ultrawarm_free_space_max_delay" {
  description = "Enforce max delay for ultrawarm_free_space detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "ultrawarm_free_space_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "ultrawarm_free_space_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "ultrawarm_free_space_disabled" {
  description = "Disable all alerting rules for ultrawarm_free_space detector"
  type        = bool
  default     = null
}

variable "ultrawarm_free_space_disabled_major" {
  description = "Disable major alerting rule for ultrawarm_free_space detector"
  type        = bool
  default     = null
}

variable "ultrawarm_free_space_disabled_critical" {
  description = "Disable critical alerting rule for ultrawarm_free_space detector"
  type        = bool
  default     = null
}

variable "ultrawarm_free_space_threshold_major" {
  description = "Major threshold for ultrawarm_free_space detector in Gibibyte"
  type        = number
  default     = 15
}

variable "ultrawarm_free_space_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "ultrawarm_free_space_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "ultrawarm_free_space_threshold_critical" {
  description = "Critical threshold for ultrawarm_free_space detector in Gibibyte"
  type        = number
  default     = 10
}

variable "ultrawarm_free_space_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "ultrawarm_free_space_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# cluster_cpu detector

variable "cluster_cpu_notifications" {
  description = "Notification recipients list per severity overridden for cluster_cpu detector"
  type        = map(list(string))
  default     = {}
}

variable "cluster_cpu_transformation_function" {
  description = "Transformation function for cluster_cpu detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='45m')"
}

variable "cluster_cpu_max_delay" {
  description = "Enforce max delay for cluster_cpu detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cluster_cpu_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cluster_cpu_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cluster_cpu_disabled" {
  description = "Disable all alerting rules for cluster_cpu detector"
  type        = bool
  default     = null
}

variable "cluster_cpu_disabled_major" {
  description = "Disable major alerting rule for cluster_cpu detector"
  type        = bool
  default     = null
}

variable "cluster_cpu_disabled_critical" {
  description = "Disable critical alerting rule for cluster_cpu detector"
  type        = bool
  default     = null
}

variable "cluster_cpu_threshold_major" {
  description = "Major threshold for cluster_cpu detector"
  type        = number
  default     = 80
}

variable "cluster_cpu_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cluster_cpu_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cluster_cpu_threshold_critical" {
  description = "Critical threshold for cluster_cpu detector"
  type        = number
  default     = 90
}

variable "cluster_cpu_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cluster_cpu_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# master_cpu detector

variable "master_cpu_notifications" {
  description = "Notification recipients list per severity overridden for master_cpu detector"
  type        = map(list(string))
  default     = {}
}

variable "master_cpu_transformation_function" {
  description = "Transformation function for master_cpu detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='20m')"
}

variable "master_cpu_max_delay" {
  description = "Enforce max delay for master_cpu detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "master_cpu_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "master_cpu_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "master_cpu_disabled" {
  description = "Disable all alerting rules for master_cpu detector"
  type        = bool
  default     = null
}

variable "master_cpu_disabled_major" {
  description = "Disable major alerting rule for master_cpu detector"
  type        = bool
  default     = null
}

variable "master_cpu_disabled_critical" {
  description = "Disable critical alerting rule for master_cpu detector"
  type        = bool
  default     = null
}

variable "master_cpu_threshold_major" {
  description = "Major threshold for master_cpu detector"
  type        = number
  default     = 50
}

variable "master_cpu_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "master_cpu_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "master_cpu_threshold_critical" {
  description = "Critical threshold for master_cpu detector"
  type        = number
  default     = 70
}

variable "master_cpu_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "master_cpu_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
