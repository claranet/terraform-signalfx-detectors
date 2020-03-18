module "filter-tags" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//common/filter-tags"

  filter_defaults        = "filter('env', '${var.environment}') and filter('sfx_monitored', 'true')"
  filter_custom_includes = var.filter_custom_includes
  filter_custom_excludes = var.filter_custom_excludes
}
