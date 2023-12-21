# Module specific

variable "fsx_id" {
  description = "The FSx id to filter on `FileSystemId` dimension"
  type        = string
  default     = "*"
}

variable "aws_account_id" {
  description = "The AWS account id to filter on `aws_account_id` dimension"
  type        = string
  default     = "*"
}

variable "aws_region" {
  description = "The AWS region name to filter on `aws_region` dimension"
  type        = string
  default     = "*"
}
