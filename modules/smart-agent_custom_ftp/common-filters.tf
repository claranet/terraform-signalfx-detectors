locals {
  filters = "filter('env', '${var.environment}') and filter('sfx_monitored', 'true')"
}

