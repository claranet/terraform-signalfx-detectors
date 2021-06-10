module "filter-tags" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//common/filter-tags?ref=103_improve_filtering_and_append_mode"

  filter_defaults = local.filters
  filter_custom   = var.filter_custom
  append_mode     = var.filter_append
}

