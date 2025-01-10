# used_space detector

variable "used_space_notifications" {
  description = "Notification recipients list per severity overridden for used_space detector"
  type        = map(list(string))
  default     = {}
}

variable "used_space_aggregation_function" {
  description = "Aggregation function and group by for used_space detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "used_space_transformation_function" {
  description = "Transformation function for used_space detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "used_space_max_delay" {
  description = "Enforce max delay for used_space detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "used_space_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "used_space_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "used_space_disabled" {
  description = "Disable all alerting rules for used_space detector"
  type        = bool
  default     = null
}

variable "used_space_disabled_critical" {
  description = "Disable critical alerting rule for used_space detector"
  type        = bool
  default     = null
}

variable "used_space_disabled_major" {
  description = "Disable major alerting rule for used_space detector"
  type        = bool
  default     = null
}

variable "used_space_threshold_critical" {
  description = "Critical threshold for used_space detector in Gibibyte"
  type        = number
}

variable "used_space_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "used_space_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "used_space_threshold_major" {
  description = "Major threshold for used_space detector in Gibibyte"
  type        = number
}

variable "used_space_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "used_space_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# io_limit detector

variable "io_limit_notifications" {
  description = "Notification recipients list per severity overridden for io_limit detector"
  type        = map(list(string))
  default     = {}
}

variable "io_limit_aggregation_function" {
  description = "Aggregation function and group by for io_limit detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "io_limit_transformation_function" {
  description = "Transformation function for io_limit detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "io_limit_max_delay" {
  description = "Enforce max delay for io_limit detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "io_limit_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    If you reach too often the limit with current General Purpose mode, consider moving your application to a file system using the Max I/O performance mode.
EOF
}

variable "io_limit_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "io_limit_disabled" {
  description = "Disable all alerting rules for io_limit detector"
  type        = bool
  default     = null
}

variable "io_limit_disabled_critical" {
  description = "Disable critical alerting rule for io_limit detector"
  type        = bool
  default     = null
}

variable "io_limit_disabled_major" {
  description = "Disable major alerting rule for io_limit detector"
  type        = bool
  default     = null
}

variable "io_limit_threshold_critical" {
  description = "Critical threshold for io_limit detector in %"
  type        = number
  default     = 90
}

variable "io_limit_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "30m"
}

variable "io_limit_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "io_limit_threshold_major" {
  description = "Major threshold for io_limit detector in %"
  type        = number
  default     = 80
}

variable "io_limit_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "30m"
}

variable "io_limit_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# read_throughput detector

variable "read_throughput_notifications" {
  description = "Notification recipients list per severity overridden for read_throughput detector"
  type        = map(list(string))
  default     = {}
}

variable "read_throughput_aggregation_function" {
  description = "Aggregation function and group by for read_throughput detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "read_throughput_transformation_function" {
  description = "Transformation function for read_throughput detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "read_throughput_max_delay" {
  description = "Enforce max delay for read_throughput detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "read_throughput_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "read_throughput_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "read_throughput_disabled" {
  description = "Disable all alerting rules for read_throughput detector"
  type        = bool
  default     = true
}

variable "read_throughput_disabled_critical" {
  description = "Disable critical alerting rule for read_throughput detector"
  type        = bool
  default     = null
}

variable "read_throughput_disabled_major" {
  description = "Disable major alerting rule for read_throughput detector"
  type        = bool
  default     = null
}

variable "read_throughput_threshold_critical" {
  description = "Critical threshold for read_throughput detector in %"
  type        = number
}

variable "read_throughput_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "read_throughput_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "read_throughput_threshold_major" {
  description = "Major threshold for read_throughput detector in %"
  type        = number
}

variable "read_throughput_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "read_throughput_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# write_throughput detector

variable "write_throughput_notifications" {
  description = "Notification recipients list per severity overridden for write_throughput detector"
  type        = map(list(string))
  default     = {}
}

variable "write_throughput_aggregation_function" {
  description = "Aggregation function and group by for write_throughput detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "write_throughput_transformation_function" {
  description = "Transformation function for write_throughput detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "write_throughput_max_delay" {
  description = "Enforce max delay for write_throughput detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "write_throughput_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "write_throughput_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "write_throughput_disabled" {
  description = "Disable all alerting rules for write_throughput detector"
  type        = bool
  default     = true
}

variable "write_throughput_disabled_critical" {
  description = "Disable critical alerting rule for write_throughput detector"
  type        = bool
  default     = null
}

variable "write_throughput_disabled_major" {
  description = "Disable major alerting rule for write_throughput detector"
  type        = bool
  default     = null
}

variable "write_throughput_threshold_critical" {
  description = "Critical threshold for write_throughput detector in %"
  type        = number
}

variable "write_throughput_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "write_throughput_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "write_throughput_threshold_major" {
  description = "Major threshold for write_throughput detector in %"
  type        = number
}

variable "write_throughput_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "write_throughput_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# percent_of_permitted_throughput detector

variable "percent_of_permitted_throughput_notifications" {
  description = "Notification recipients list per severity overridden for percent_of_permitted_throughput detector"
  type        = map(list(string))
  default     = {}
}

variable "percent_of_permitted_throughput_aggregation_function" {
  description = "Aggregation function and group by for percent_of_permitted_throughput detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "percent_of_permitted_throughput_transformation_function" {
  description = "Transformation function for percent_of_permitted_throughput detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "percent_of_permitted_throughput_max_delay" {
  description = "Enforce max delay for percent_of_permitted_throughput detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "percent_of_permitted_throughput_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    You are consuming the entire amount of throughput allocated to your file system, In this situation, you might consider changing the file system's throughput mode to Provisioned Throughput to get higher throughput.
EOF
}

variable "percent_of_permitted_throughput_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "percent_of_permitted_throughput_disabled" {
  description = "Disable all alerting rules for percent_of_permitted_throughput detector"
  type        = bool
  default     = null
}

variable "percent_of_permitted_throughput_disabled_critical" {
  description = "Disable critical alerting rule for percent_of_permitted_throughput detector"
  type        = bool
  default     = null
}

variable "percent_of_permitted_throughput_disabled_major" {
  description = "Disable major alerting rule for percent_of_permitted_throughput detector"
  type        = bool
  default     = null
}

variable "percent_of_permitted_throughput_threshold_critical" {
  description = "Critical threshold for percent_of_permitted_throughput detector in %"
  type        = number
  default     = 90
}

variable "percent_of_permitted_throughput_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "30m"
}

variable "percent_of_permitted_throughput_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "percent_of_permitted_throughput_threshold_major" {
  description = "Major threshold for percent_of_permitted_throughput detector in %"
  type        = number
  default     = 80
}

variable "percent_of_permitted_throughput_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "30m"
}

variable "percent_of_permitted_throughput_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# burst_credit_balance detector

variable "burst_credit_balance_notifications" {
  description = "Notification recipients list per severity overridden for burst_credit_balance detector"
  type        = map(list(string))
  default     = {}
}

variable "burst_credit_balance_aggregation_function" {
  description = "Aggregation function and group by for burst_credit_balance detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "burst_credit_balance_transformation_function" {
  description = "Transformation function for burst_credit_balance detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "burst_credit_balance_max_delay" {
  description = "Enforce max delay for burst_credit_balance detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "burst_credit_balance_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    See https://docs.aws.amazon.com/efs/latest/ug/performance.html#bursting
EOF
}

variable "burst_credit_balance_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "burst_credit_balance_disabled" {
  description = "Disable all alerting rules for burst_credit_balance detector"
  type        = bool
  default     = null
}

variable "burst_credit_balance_threshold_critical" {
  description = "Critical threshold for burst_credit_balance detector in credits"
  type        = number
  default     = 1
}

variable "burst_credit_balance_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "burst_credit_balance_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
