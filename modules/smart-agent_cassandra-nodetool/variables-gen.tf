# node_status detector

variable "node_status_notifications" {
  description = "Notification recipients list per severity overridden for node_status detector"
  type        = map(list(string))
  default     = {}
}

variable "node_status_aggregation_function" {
  description = "Aggregation function and group by for node_status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "node_status_transformation_function" {
  description = "Transformation function for node_status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "node_status_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "node_status_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "node_status_disabled" {
  description = "Disable all alerting rules for node_status detector"
  type        = bool
  default     = null
}

variable "node_status_disabled_critical" {
  description = "Disable critical alerting rule for node_status detector"
  type        = bool
  default     = null
}

variable "node_status_disabled_minor" {
  description = "Disable minor alerting rule for node_status detector"
  type        = bool
  default     = null
}

variable "node_status_threshold_critical" {
  description = "Critical threshold for node_status detector"
  type        = number
  default     = 0
}

variable "node_status_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "None"
}

variable "node_status_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1.0
}

variable "node_status_threshold_minor" {
  description = "Minor threshold for node_status detector"
  type        = number
  default     = 0
}

variable "node_status_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "None"
}

variable "node_status_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1.0
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
  default     = ".min(over='1h')"
}

variable "node_state_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    The node state may be in leaving/joining for too long. Check the nodetool status result
EOF
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
  default     = 1
}

variable "node_state_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "None"
}

variable "node_state_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1.0
}

