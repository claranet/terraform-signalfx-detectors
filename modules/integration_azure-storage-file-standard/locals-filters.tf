locals {
  filters = "filter('azure_tag_sa_env', '${var.environment}') and filter('azure_tag_sa_sfx_monitored', 'true')"
}

