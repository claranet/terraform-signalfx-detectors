locals {
  filters = "filter('project_id', '${var.gcp_project_id}') and (not filter('database_id', '*-replica*'))"
}

