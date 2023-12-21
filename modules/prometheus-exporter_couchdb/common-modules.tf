module "filtering" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/internal_filtering?ref=v1.26.0"

  filtering_default = local.filters
  filtering_custom  = var.filtering_custom
  append_mode       = var.filtering_append
}

