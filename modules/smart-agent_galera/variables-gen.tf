# node detector

variable "node_notifications" {
  description = "Notification recipients list per severity overridden for node detector"
  type        = map(list(string))
  default     = {}
}

variable "node_aggregation_function" {
  description = "Aggregation function and group by for node detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "node_transformation_function" {
  description = "Transformation function for node detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "node_max_delay" {
  description = "Enforce max delay for node detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "node_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "node_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "node_disabled" {
  description = "Disable all alerting rules for node detector"
  type        = bool
  default     = null
}

variable "node_threshold_critical" {
  description = "Critical threshold for node detector"
  type        = number
  default     = 1
}

variable "node_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "node_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# node_state detector

variable "node_state_notifications" {
  description = "Notification recipients list per severity overridden for node_state detector"
  type        = map(list(string))
  default     = {}
}

variable "node_state_aggregation_function" {
  description = "Aggregation function and group by for node_state detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "node_state_transformation_function" {
  description = "Transformation function for node_state detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "node_state_max_delay" {
  description = "Enforce max delay for node_state detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "node_state_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "node_state_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "node_state_disabled" {
  description = "Disable all alerting rules for node_state detector"
  type        = bool
  default     = null
}

variable "node_state_threshold_critical" {
  description = "Critical threshold for node_state detector"
  type        = number
  default     = 4
}

variable "node_state_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "node_state_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# replication_paused_ratio detector

variable "replication_paused_ratio_notifications" {
  description = "Notification recipients list per severity overridden for replication_paused_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "replication_paused_ratio_aggregation_function" {
  description = "Aggregation function and group by for replication_paused_ratio detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "replication_paused_ratio_transformation_function" {
  description = "Transformation function for replication_paused_ratio detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "replication_paused_ratio_max_delay" {
  description = "Enforce max delay for replication_paused_ratio detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "replication_paused_ratio_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "replication_paused_ratio_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "replication_paused_ratio_disabled" {
  description = "Disable all alerting rules for replication_paused_ratio detector"
  type        = bool
  default     = true
}

variable "replication_paused_ratio_disabled_major" {
  description = "Disable major alerting rule for replication_paused_ratio detector"
  type        = bool
  default     = null
}

variable "replication_paused_ratio_disabled_minor" {
  description = "Disable minor alerting rule for replication_paused_ratio detector"
  type        = bool
  default     = null
}

variable "replication_paused_ratio_threshold_major" {
  description = "Major threshold for replication_paused_ratio detector"
  type        = number
  default     = 0.05
}

variable "replication_paused_ratio_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "replication_paused_ratio_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "replication_paused_ratio_threshold_minor" {
  description = "Minor threshold for replication_paused_ratio detector"
  type        = number
  default     = 0
}

variable "replication_paused_ratio_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "replication_paused_ratio_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# recv_queue_length detector

variable "recv_queue_length_notifications" {
  description = "Notification recipients list per severity overridden for recv_queue_length detector"
  type        = map(list(string))
  default     = {}
}

variable "recv_queue_length_aggregation_function" {
  description = "Aggregation function and group by for recv_queue_length detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "recv_queue_length_transformation_function" {
  description = "Transformation function for recv_queue_length detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "recv_queue_length_max_delay" {
  description = "Enforce max delay for recv_queue_length detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "recv_queue_length_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "recv_queue_length_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "recv_queue_length_disabled" {
  description = "Disable all alerting rules for recv_queue_length detector"
  type        = bool
  default     = true
}

variable "recv_queue_length_disabled_major" {
  description = "Disable major alerting rule for recv_queue_length detector"
  type        = bool
  default     = null
}

variable "recv_queue_length_disabled_minor" {
  description = "Disable minor alerting rule for recv_queue_length detector"
  type        = bool
  default     = null
}

variable "recv_queue_length_threshold_major" {
  description = "Major threshold for recv_queue_length detector"
  type        = number
  default     = 0.1
}

variable "recv_queue_length_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "recv_queue_length_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "recv_queue_length_threshold_minor" {
  description = "Minor threshold for recv_queue_length detector"
  type        = number
  default     = 0
}

variable "recv_queue_length_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "recv_queue_length_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
