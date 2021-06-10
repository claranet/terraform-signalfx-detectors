variable "filter_defaults" {
  description = "Filters as SignalFlow string to enforce the default filtering convention from the template"
  type        = string
  default     = ""
}

variable "filter_custom" {
  description = "Filters as SignalFlow string to override the default filtering convention from the user input"
  type        = string
  default     = ""
}

variable "append_mode" {
  description = "If true, the filter_custom will be appended to filter_defaults instead of fully replace it"
  type        = bool
  default     = false
}

