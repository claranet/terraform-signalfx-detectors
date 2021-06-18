module "signalfx-detectors-smart-agent-system-common-basic" {

  # Import the module:
  # -------------------------------------------------------------------------------------------------------
  # Using Github as source and ref argument which can be any reference that would be accepted by the git
  # checkout command, including branch and tag names
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/smart-agent_system-common?ref=v1.7.0"

  # Or uncomment following lines to use the Terraform Registry as source instead of Github
  #source  = "claranet/detectors/signalfx//modules/smart-agent_system-common"
  # Only Git tags are available for version but it allows to use Terraform's syntax for version constraints like
  #version = ">= 1.7.0, < 2.0.0"
  # -------------------------------------------------------------------------------------------------------

  # Define the common required variables:
  # -------------------------------------------------------------------------------------------------------
  # The environment will be added as slug prefix in the names of the detectors. While we do not set the
  # `filtering_custom` variable, the default filtering policy is applied adding the  `env:${var.environment}`
  # and `sfx_monitored:true` as filters.
  environment = var.environment

  # The notifications variable will map for each severity a list of destinations to send alerts to
  notifications = local.notifications_devnull
  # See the ./notifications.tf file for more information about notifications binding
  # -------------------------------------------------------------------------------------------------------
}

