# Module specific

# threads_anomaly detector

variable "threads_anomaly_max_delay" {
  description = "Enforce max delay for threads_anomaly detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "threads_anomaly_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "threads_anomaly_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "questions_anomaly_max_delay" {
  description = "Enforce max delay for questions_anomaly detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "questions_anomaly_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "questions_anomaly_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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
