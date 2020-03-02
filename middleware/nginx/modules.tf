  module "filter-tags" {
  source = "../../common/filter-tags"

  filter_defaults             = "filter('env', '${var.environment}') and filter('claranet_monitored', 'true')"
  filter_use_defaults         = var.filter_use_defaults
  filter_custom_include       = var.filter_custom_include
  filter_custom_excluded      = var.filter_custom_excluded
}
