locals {
  filters = "filter('gcp_metadata_sfx_env', '${var.environment}') and filter('gcp_metadata_sfx_monitored', 'true')"
}

