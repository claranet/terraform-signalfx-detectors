locals {
  aggregation_function = var.is_parent ? ".mean(by=['childOrgName'])" : ""
}
