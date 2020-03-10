module "filter-tags" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//common/filter-tags"

  filter_defaults        = "filter('env', '${var.environment}') and filter('claranet_monitored', 'true')"
  filter_use_defaults    = var.filter_use_defaults
  filter_custom_includes = var.filter_custom_includes
  filter_custom_excludes = var.filter_custom_excludes
}

