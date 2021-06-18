module "signalfx-detectors-smart-agent-system-common-filtering" {

  # The minimal configuration same as the basic.tf example file:
  # -------------------------------------------------------------------------------------------------------
  source      = "github.com/claranet/terraform-signalfx-detectors.git//modules/smart-agent_system-common?ref=v1.7.0"
  environment = var.environment
  notifications = {
    critical = ["Email,doc@signalfx.null"]
    major    = ["Email,doc@signalfx.null"]
    minor    = ["Email,doc@signalfx.null"]
    warning  = ["Email,doc@signalfx.null"]
    info     = ["Email,doc@signalfx.null"]
  }
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
  # Then enable the append mode to join the default filters and the custom ones with `and` logical operator
  filtering_append = true
  # -------------------------------------------------------------------------------------------------------
}

