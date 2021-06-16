variable "filtering_default" {
  description = "Filters as SignalFlow string to enforce the default filtering convention from the template"
  type        = string
  default     = ""
}

variable "filtering_custom" {
  description = "Filters as SignalFlow string to override the default filtering convention from the user input"
  type        = string
  default     = null
}

variable "append_mode" {
  description = "If true, the `filtering_custom` will be appended to `filtering_default` instead of fully replace it"
  type        = bool
  default     = false
}

