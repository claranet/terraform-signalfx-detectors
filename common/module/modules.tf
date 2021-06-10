module "filter-tags" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//common/filter-tags"

  filter_defaults = local.filters
  filter_custom   = var.filter_custom
  append_mode     = var.filter_append
}

