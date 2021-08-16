# messages_ready detector

variable "messages_ready_notifications" {
  description = "Notification recipients list per severity overridden for messages_ready detector"
  type        = map(list(string))
  default     = {}
}

variable "messages_ready_aggregation_function" {
  description = "Aggregation function and group by for messages_ready detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "messages_ready_transformation_function" {
  description = "Transformation function for messages_ready detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='20m')"
}

variable "messages_ready_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "messages_ready_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "messages_ready_disabled" {
  description = "Disable all alerting rules for messages_ready detector"
  type        = bool
  default     = null
}

variable "messages_ready_disabled_critical" {
  description = "Disable critical alerting rule for messages_ready detector"
  type        = bool
  default     = null
}

variable "messages_ready_disabled_major" {
  description = "Disable major alerting rule for messages_ready detector"
  type        = bool
  default     = null
}

variable "messages_ready_threshold_critical" {
  description = "Critical threshold for messages_ready detector"
  type        = number
  default     = 15000
}

variable "messages_ready_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "messages_ready_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "messages_ready_threshold_major" {
  description = "Major threshold for messages_ready detector"
  type        = number
  default     = 10000
}

variable "messages_ready_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "messages_ready_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# messages_unacknowledged detector

variable "messages_unacknowledged_notifications" {
  description = "Notification recipients list per severity overridden for messages_unacknowledged detector"
  type        = map(list(string))
  default     = {}
}

variable "messages_unacknowledged_aggregation_function" {
  description = "Aggregation function and group by for messages_unacknowledged detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "messages_unacknowledged_transformation_function" {
  description = "Transformation function for messages_unacknowledged detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='20m')"
}

variable "messages_unacknowledged_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "messages_unacknowledged_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "messages_unacknowledged_disabled" {
  description = "Disable all alerting rules for messages_unacknowledged detector"
  type        = bool
  default     = true
}

variable "messages_unacknowledged_disabled_critical" {
  description = "Disable critical alerting rule for messages_unacknowledged detector"
  type        = bool
  default     = null
}

variable "messages_unacknowledged_disabled_major" {
  description = "Disable major alerting rule for messages_unacknowledged detector"
  type        = bool
  default     = null
}

variable "messages_unacknowledged_threshold_critical" {
  description = "Critical threshold for messages_unacknowledged detector"
  type        = number
  default     = 15000
}

variable "messages_unacknowledged_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "messages_unacknowledged_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "messages_unacknowledged_threshold_major" {
  description = "Major threshold for messages_unacknowledged detector"
  type        = number
  default     = 10000
}

variable "messages_unacknowledged_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "messages_unacknowledged_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# messages_ack_rate detector

variable "messages_ack_rate_notifications" {
  description = "Notification recipients list per severity overridden for messages_ack_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "messages_ack_rate_aggregation_function" {
  description = "Aggregation function and group by for messages_ack_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "messages_ack_rate_transformation_function" {
  description = "Transformation function for messages_ack_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='20m')"
}

variable "messages_ack_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "messages_ack_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "messages_ack_rate_disabled" {
  description = "Disable all alerting rules for messages_ack_rate detector"
  type        = bool
  default     = true
}

variable "messages_ack_rate_disabled_critical" {
  description = "Disable critical alerting rule for messages_ack_rate detector"
  type        = bool
  default     = null
}

variable "messages_ack_rate_disabled_major" {
  description = "Disable major alerting rule for messages_ack_rate detector"
  type        = bool
  default     = null
}

variable "messages_ack_rate_threshold_critical" {
  description = "Critical threshold for messages_ack_rate detector"
  type        = number
  default     = 0.016666666666666666
}

variable "messages_ack_rate_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "messages_ack_rate_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "messages_ack_rate_threshold_major" {
  description = "Major threshold for messages_ack_rate detector"
  type        = number
  default     = 0.03333333333333333
}

variable "messages_ack_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "messages_ack_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# consumer_use detector

variable "consumer_use_notifications" {
  description = "Notification recipients list per severity overridden for consumer_use detector"
  type        = map(list(string))
  default     = {}
}

variable "consumer_use_aggregation_function" {
  description = "Aggregation function and group by for consumer_use detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "consumer_use_transformation_function" {
  description = "Transformation function for consumer_use detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='20m')"
}

variable "consumer_use_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "consumer_use_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "consumer_use_disabled" {
  description = "Disable all alerting rules for consumer_use detector"
  type        = bool
  default     = true
}

variable "consumer_use_disabled_critical" {
  description = "Disable critical alerting rule for consumer_use detector"
  type        = bool
  default     = null
}

variable "consumer_use_disabled_major" {
  description = "Disable major alerting rule for consumer_use detector"
  type        = bool
  default     = null
}

variable "consumer_use_threshold_critical" {
  description = "Critical threshold for consumer_use detector"
  type        = number
  default     = 0.8
}

variable "consumer_use_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "consumer_use_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "consumer_use_threshold_major" {
  description = "Major threshold for consumer_use detector"
  type        = number
  default     = 1
}

variable "consumer_use_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "consumer_use_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
