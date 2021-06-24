module "signalfx-detectors-smart-agent-system-common-filtering" {

  # The minimal configuration same as the basic.tf example file:
  # -------------------------------------------------------------------------------------------------------
  source        = "claranet/detectors/signalfx//modules/smart-agent_system-common"
  version       = ">= 1.7.0, < 2.0.0"
  environment   = var.environment
  notifications = local.notifications_devnull
  # -------------------------------------------------------------------------------------------------------

  # Use the default filtering policy
  # -------------------------------------------------------------------------------------------------------
  # There is nothing to do! The default filtering policy will use `env:${var.environment}` and
  # `sfx_monitored:true` dimensions as filters, at least, for all modules based on the agent as source.
  # So you just have to add these dimensions to all agents deployed on hosts you want to apply detectors
  # -------------------------------------------------------------------------------------------------------

  # Use a custom filtering policy (fully replacing the default one)
  # -------------------------------------------------------------------------------------------------------
  # Uncomment this line to entirely replace the default filtering policy using a custom complex filters
  #filtering_custom = "filter('env', 'QA', 'PROD', 'MON') and not filter('serverType', 'API')"
  # This will apply to all detectors (in addition to any specific filter defined for each detector
  # -------------------------------------------------------------------------------------------------------

  # Append custom filtering to the default policy
  # -------------------------------------------------------------------------------------------------------
  # In some cases, we still want to follow the default policy but adding other filters depending on
  # dimensions available in our environment. For example, if the default filtering policy allows to split
  # module instances per environment you can want to add more levels like per team or/and per application
  filtering_custom = "filter('team', 'oncall') and filter('app', 'webfront')"
  # Or, uncomment the following line to keep the default filtering policy but add an exception to prevent
  # undeseriable alerts.
  #filtering_custom = "not filter('packer', 'true')"
  # Then enable the append mode to join the default filters and the custom ones with `and` logical operator
  filtering_append = true
  # -------------------------------------------------------------------------------------------------------
}

