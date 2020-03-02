locals {
  including_default_list = compact(
    concat(
      split(
        ",",
        format(
          "dd_monitoring:enabled,dd_%s:enabled,env:%s",
          var.resource,
          var.environment,
        ),
      ),
      compact(var.extra_tags),
    ),
  )
  including_custom_list = compact(
    concat(split(",", var.filter_tags_custom), compact(var.extra_tags)),
  )
  excluding_list = compact(
    split(
      ",",
      var.filter_tags_use_defaults == "true" ? join(",", compact(var.extra_tags_excluded)) : join(
        ",",
        concat(
          split(",", var.filter_tags_custom_excluded),
          compact(var.extra_tags_excluded),
        ),
      ),
    ),
  )

  including_string = var.filter_tags_use_defaults == "true" ? join(",", local.including_default_list) : join(",", local.including_custom_list)
  excluding_string = join(",", local.excluding_list)
}

# Inputs example values:
#TF_VAR_environment='prod' TF_VAR_resource='nginx' TF_VAR_filter_tags_use_defaults=false TF_VAR_filter_tags_custom="tag:val,tag2:val2" TF_VAR_filter_tags_custom_excluded="excludedtag:value,exludedtag2:value2" terraform apply

# query_alert = {tag:val,tag2:val2,!excludedtag:value,!exludedtag2:value2}
output "query_alert" {
  description = "The full filtering pattern including parentheses for service check monitor type"
  value = "{${join(
    ",",
    compact(
      concat(
        [local.including_string],
        formatlist("!%s", local.excluding_list),
      ),
    ),
  )}}"
}

# service_check = .over("tag:val","tag2:val2").exclude("excludedtag:value","exludedtag2:value2")
output "service_check" {
  description = "The full filtering pattern including braces for query alert monitor type"
  value       = ".over(\"${replace(local.including_string, ",", "\",\"")}\")${local.excluding_string == "" ? "" : ".exclude(\"${replace(local.excluding_string, ",", "\",\"")}\")"}"
}

# event_alert = tags:tag:val,tag2:val2 excluded_tags:excludedtag:value,exludedtag2:value2
output "event_alert" {
  description = "The full filtering pattern for event alert monitor type"
  value       = "tags:${local.including_string}${local.excluding_string == "" ? "" : " excluded_tags:${local.excluding_string}"}"
}
