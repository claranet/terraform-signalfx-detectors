locals {
  filter_custom_includes = join(
    " and ",
    formatlist(
      "(filter('%s'))",
      [for tag in var.filter_custom_includes : replace(replace(tag, ":", "', '"), " ", "")]
    )
  )

  filter_custom_excludes = join(
    " and ",
    formatlist(
      "(not filter('%s'))",
      [for tag in var.filter_custom_excludes : replace(replace(tag, ":", "', '"), " ", "")]
    )
  )
}

