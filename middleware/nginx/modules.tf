  module "filter-tags" {
  source = "../../common/filter-tags"

  environment                 = var.environment
  resource                    = "dns"
  filter_tags_defaults        =
  filter_tags_use_defaults    = var.filter_tags_use_defaults
  filter_tags_custom_include  = var.filter_tags_custom
  filter_tags_custom_excluded = var.filter_tags_custom_excluded
}
