# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "heartbeat_max_delay" {
  description = "Enforce max delay for heartbeat detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
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

variable "heartbeat_exclude_not_running_vm" {
  description = "Don’t send alerts if associated VM is stopped or stopping (metadata provided by cloud provider integration). Can be useful for ephemeral infrastructure (such as auto scaling groups) as VM will be stopped and started regularly. Note that timeframe must be at least 25 minutes for the metadata to be available to the detector."
  type        = bool
  default     = true
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"25m\"). Must be at least \"25m\" if \"heartbeat_exclude_not_running_vm\" is true"
  type        = string
  default     = "25m"
}

# postfix_showq_message_size_bytes_count_deferred detector

variable "postfix_showq_message_size_bytes_count_deferred_notifications" {
  description = "Notification recipients list per severity overridden for postfix_showq_message_size_bytes_count_deferred detector"
  type        = map(list(string))
  default     = {}
}

variable "postfix_showq_message_size_bytes_count_deferred_aggregation_function" {
  description = "Aggregation function and group by for postfix_showq_message_size_bytes_count_deferred detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "postfix_showq_message_size_bytes_count_deferred_transformation_function" {
  description = "Transformation function for postfix_showq_message_size_bytes_count_deferred detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "postfix_showq_message_size_bytes_count_deferred_max_delay" {
  description = "Enforce max delay for postfix_showq_message_size_bytes_count_deferred detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "postfix_showq_message_size_bytes_count_deferred_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "postfix_showq_message_size_bytes_count_deferred_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "postfix_showq_message_size_bytes_count_deferred_disabled" {
  description = "Disable all alerting rules for postfix_showq_message_size_bytes_count_deferred detector"
  type        = bool
  default     = null
}

variable "postfix_showq_message_size_bytes_count_deferred_disabled_critical" {
  description = "Disable critical alerting rule for postfix_showq_message_size_bytes_count_deferred detector"
  type        = bool
  default     = null
}

variable "postfix_showq_message_size_bytes_count_deferred_disabled_major" {
  description = "Disable major alerting rule for postfix_showq_message_size_bytes_count_deferred detector"
  type        = bool
  default     = null
}

variable "postfix_showq_message_size_bytes_count_deferred_threshold_critical" {
  description = "Critical threshold for postfix_showq_message_size_bytes_count_deferred detector"
  type        = number
  default     = 600
}

variable "postfix_showq_message_size_bytes_count_deferred_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "postfix_showq_message_size_bytes_count_deferred_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "postfix_showq_message_size_bytes_count_deferred_threshold_major" {
  description = "Major threshold for postfix_showq_message_size_bytes_count_deferred detector"
  type        = number
  default     = 300
}

variable "postfix_showq_message_size_bytes_count_deferred_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "postfix_showq_message_size_bytes_count_deferred_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# postfix_showq_message_size_bytes_count_hold detector

variable "postfix_showq_message_size_bytes_count_hold_notifications" {
  description = "Notification recipients list per severity overridden for postfix_showq_message_size_bytes_count_hold detector"
  type        = map(list(string))
  default     = {}
}

variable "postfix_showq_message_size_bytes_count_hold_aggregation_function" {
  description = "Aggregation function and group by for postfix_showq_message_size_bytes_count_hold detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "postfix_showq_message_size_bytes_count_hold_transformation_function" {
  description = "Transformation function for postfix_showq_message_size_bytes_count_hold detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "postfix_showq_message_size_bytes_count_hold_max_delay" {
  description = "Enforce max delay for postfix_showq_message_size_bytes_count_hold detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "postfix_showq_message_size_bytes_count_hold_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "postfix_showq_message_size_bytes_count_hold_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "postfix_showq_message_size_bytes_count_hold_disabled" {
  description = "Disable all alerting rules for postfix_showq_message_size_bytes_count_hold detector"
  type        = bool
  default     = null
}

variable "postfix_showq_message_size_bytes_count_hold_disabled_critical" {
  description = "Disable critical alerting rule for postfix_showq_message_size_bytes_count_hold detector"
  type        = bool
  default     = null
}

variable "postfix_showq_message_size_bytes_count_hold_disabled_major" {
  description = "Disable major alerting rule for postfix_showq_message_size_bytes_count_hold detector"
  type        = bool
  default     = null
}

variable "postfix_showq_message_size_bytes_count_hold_threshold_critical" {
  description = "Critical threshold for postfix_showq_message_size_bytes_count_hold detector"
  type        = number
  default     = 600
}

variable "postfix_showq_message_size_bytes_count_hold_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "postfix_showq_message_size_bytes_count_hold_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "postfix_showq_message_size_bytes_count_hold_threshold_major" {
  description = "Major threshold for postfix_showq_message_size_bytes_count_hold detector"
  type        = number
  default     = 300
}

variable "postfix_showq_message_size_bytes_count_hold_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "postfix_showq_message_size_bytes_count_hold_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# postfix_showq_message_size_bytes_count_maildrop detector

variable "postfix_showq_message_size_bytes_count_maildrop_notifications" {
  description = "Notification recipients list per severity overridden for postfix_showq_message_size_bytes_count_maildrop detector"
  type        = map(list(string))
  default     = {}
}

variable "postfix_showq_message_size_bytes_count_maildrop_aggregation_function" {
  description = "Aggregation function and group by for postfix_showq_message_size_bytes_count_maildrop detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "postfix_showq_message_size_bytes_count_maildrop_transformation_function" {
  description = "Transformation function for postfix_showq_message_size_bytes_count_maildrop detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "postfix_showq_message_size_bytes_count_maildrop_max_delay" {
  description = "Enforce max delay for postfix_showq_message_size_bytes_count_maildrop detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "postfix_showq_message_size_bytes_count_maildrop_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "postfix_showq_message_size_bytes_count_maildrop_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "postfix_showq_message_size_bytes_count_maildrop_disabled" {
  description = "Disable all alerting rules for postfix_showq_message_size_bytes_count_maildrop detector"
  type        = bool
  default     = null
}

variable "postfix_showq_message_size_bytes_count_maildrop_disabled_critical" {
  description = "Disable critical alerting rule for postfix_showq_message_size_bytes_count_maildrop detector"
  type        = bool
  default     = null
}

variable "postfix_showq_message_size_bytes_count_maildrop_disabled_major" {
  description = "Disable major alerting rule for postfix_showq_message_size_bytes_count_maildrop detector"
  type        = bool
  default     = null
}

variable "postfix_showq_message_size_bytes_count_maildrop_threshold_critical" {
  description = "Critical threshold for postfix_showq_message_size_bytes_count_maildrop detector"
  type        = number
  default     = 600
}

variable "postfix_showq_message_size_bytes_count_maildrop_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "postfix_showq_message_size_bytes_count_maildrop_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "postfix_showq_message_size_bytes_count_maildrop_threshold_major" {
  description = "Major threshold for postfix_showq_message_size_bytes_count_maildrop detector"
  type        = number
  default     = 300
}

variable "postfix_showq_message_size_bytes_count_maildrop_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "postfix_showq_message_size_bytes_count_maildrop_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# postfix_smtp_delivery_delay_seconds_count detector

variable "postfix_smtp_delivery_delay_seconds_count_notifications" {
  description = "Notification recipients list per severity overridden for postfix_smtp_delivery_delay_seconds_count detector"
  type        = map(list(string))
  default     = {}
}

variable "postfix_smtp_delivery_delay_seconds_count_aggregation_function" {
  description = "Aggregation function and group by for postfix_smtp_delivery_delay_seconds_count detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "postfix_smtp_delivery_delay_seconds_count_transformation_function" {
  description = "Transformation function for postfix_smtp_delivery_delay_seconds_count detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "postfix_smtp_delivery_delay_seconds_count_max_delay" {
  description = "Enforce max delay for postfix_smtp_delivery_delay_seconds_count detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "postfix_smtp_delivery_delay_seconds_count_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "postfix_smtp_delivery_delay_seconds_count_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "postfix_smtp_delivery_delay_seconds_count_disabled" {
  description = "Disable all alerting rules for postfix_smtp_delivery_delay_seconds_count detector"
  type        = bool
  default     = null
}

variable "postfix_smtp_delivery_delay_seconds_count_disabled_critical" {
  description = "Disable critical alerting rule for postfix_smtp_delivery_delay_seconds_count detector"
  type        = bool
  default     = null
}

variable "postfix_smtp_delivery_delay_seconds_count_disabled_major" {
  description = "Disable major alerting rule for postfix_smtp_delivery_delay_seconds_count detector"
  type        = bool
  default     = null
}

variable "postfix_smtp_delivery_delay_seconds_count_threshold_critical" {
  description = "Critical threshold for postfix_smtp_delivery_delay_seconds_count detector"
  type        = number
  default     = 60
}

variable "postfix_smtp_delivery_delay_seconds_count_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "postfix_smtp_delivery_delay_seconds_count_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "postfix_smtp_delivery_delay_seconds_count_threshold_major" {
  description = "Major threshold for postfix_smtp_delivery_delay_seconds_count detector"
  type        = number
  default     = 45
}

variable "postfix_smtp_delivery_delay_seconds_count_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "postfix_smtp_delivery_delay_seconds_count_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
