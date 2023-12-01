variable "disk_io_usage_enabled" {
  description = "Enable IO time usage detector"
  type        = bool
  default     = true
}

variable "disk_weighted_io_usage_enabled" {
  description = "Enable weighted IO time usage detector"
  type        = bool
  default     = false
}
