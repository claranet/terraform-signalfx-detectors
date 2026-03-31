module "filtering" {
  source = "../internal_filtering"

  filtering_default = local.filters
  filtering_custom  = var.filtering_custom
  append_mode       = var.filtering_append
}

