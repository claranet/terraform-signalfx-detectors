locals {
  filter_custom_includes = join(
    " and ",
    formatlist(
      "(filter('%s'))",
      [for tag in var.filter_custom_includes : replace(join("', '", regex("^([^:]+):(.*)", tag)), " ", "")]
    )
  )

  filter_custom_excludes = join(
    " and ",
    formatlist(
      "(not filter('%s'))",
      [for tag in var.filter_custom_excludes : replace(join("', '", regex("^([^:]+):(.*)", tag)), " ", "")]
    )
  )
}

