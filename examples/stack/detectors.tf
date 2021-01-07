module "signalfx-detectors-smart-agent-system-common" {
  source = "../../modules/smart-agent_system-common"

  environment   = var.environment
  notifications = local.notifications
}

