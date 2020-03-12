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

output "filter_custom" {
  description = "The full filtering pattern to use in detectors"
  value = coalesce(
    join(
      " and ",
      compact(
        [
          local.filter_custom_includes,
          local.filter_custom_excludes,
        ]
      )
    ),
    var.filter_defaults
  )
}
