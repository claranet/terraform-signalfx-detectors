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

