locals {
  filters = "filter('FileSystemId', '${var.fsx_id}') and filter('aws_account_id', '${var.aws_account_id}') and filter('aws_region', '${var.aws_region}')"
}

