module "filter-tags" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//common/filter-tags"

  filter_defaults        = "filter('entityname ', '${var.entity_name}')"
  filter_custom_includes = var.filter_custom_includes
  filter_custom_excludes = var.filter_custom_excludes
}
