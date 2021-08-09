# hpa_scale_exceeded_capacity detector

variable "hpa_scale_exceeded_capacity_notifications" {
  description = "Notification recipients list per severity overridden for hpa_scale_exceeded_capacity detector"
  type        = map(list(string))
  default     = {}
}

variable "hpa_scale_exceeded_capacity_aggregation_function" {
  description = "Aggregation function and group by for hpa_scale_exceeded_capacity detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "hpa_scale_exceeded_capacity_transformation_function" {
  description = "Transformation function for hpa_scale_exceeded_capacity detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "hpa_scale_exceeded_capacity_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    hpa ask to scale for too long, the maximum number of desired Pods has been hit or there is a lack of resources
EOF
}

variable "hpa_scale_exceeded_capacity_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "hpa_scale_exceeded_capacity_disabled" {
  description = "Disable all alerting rules for hpa_scale_exceeded_capacity detector"
  type        = bool
  default     = null
}

variable "hpa_scale_exceeded_capacity_threshold_major" {
  description = "Major threshold for hpa_scale_exceeded_capacity detector"
  type        = number
  default     = 0
}

variable "hpa_scale_exceeded_capacity_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "300s"
}

variable "hpa_scale_exceeded_capacity_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1.0
}

