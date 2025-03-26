variable "used_space_detector_enabled" {
  description = "Enable used space detector"
  type        = bool
  default     = true
}

variable "io_limit_detector_enabled" {
  description = "Enable io limit detector"
  type        = bool
  default     = true
}

variable "read_throughput_detector_enabled" {
  description = "Enable read throughput detector"
  type        = bool
  default     = true
}

variable "write_throughput_detector_enabled" {
  description = "Enable write throughput detector"
  type        = bool
  default     = true
}

variable "permitted_throughput_detector_enabled" {
  description = "Enable permitted throughput detector"
  type        = bool
  default     = true
}

variable "burst_credit_balance_detector_enabled" {
  description = "Enable burst credit balance detector"
  type        = bool
  default     = true
}

# Module specific

variable "efs_id" {
  description = "The EFS id to filter on `FileSystemId` dimension"
  type        = string
  default     = "*"
}
