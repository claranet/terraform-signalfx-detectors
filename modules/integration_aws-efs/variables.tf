# Module specific

variable "efs_id" {
  description = "The EFS id to filter on `FileSystemId` dimension"
  type        = string
  default     = "*"
}
