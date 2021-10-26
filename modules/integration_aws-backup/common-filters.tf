locals {
  filters = "filter('aws_tag_env', '${var.environment}') and filter('aws_tag_sfx_monitored', 'true')"
}