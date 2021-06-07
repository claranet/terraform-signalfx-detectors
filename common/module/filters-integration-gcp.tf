locals {
  filters = "filter('gcp_label_env', '${var.environment}') and filter('gcp_label_sfx_monitored', 'true')"
}

