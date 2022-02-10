locals {
  # See https://dev.splunk.com/observability/docs/signalflow/functions/filter_function/ to create filters string
  filters = "filter('put a generic and source relevant', 'filter policy here') and filter('do not hesitate to use variable like', '${var.environment}')"
}

