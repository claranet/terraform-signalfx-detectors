locals {
  filters = "filter('azure_tag_env', '${var.environment}') and filter('azure_tag_sfx_monitored', 'true')"
}

