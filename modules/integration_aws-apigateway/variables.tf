# Module specific

variable "minimum_traffic" {
  description = "Minimum required traffic to evaluate rate of errors detectors"
  type        = number
  default     = 4
}

variable "is_v2" {
  description = "Flag to use HTTP API Gateway (v2) instead of REST API Gateway (v1)"
  type        = bool
  default     = false
}

