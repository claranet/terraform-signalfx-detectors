# Split the module instantiation per scope and responsability in addition to default environment
# -------------------------------------------------------------------------------------------------------

# Define map of teams of map of notifications
locals {
  notifications_team = {
    # Use Jira for severity higher or equal to major for itsm team
    itsm = merge(local.notifications_devnull, {
      critical = ["Jira,credentialId"]
      major    = ["Jira,credentialId"]
    })
    # Use PagerDuty for severity higher or equal to major for cloud team
    cloud = merge(local.notifications_devnull, {
      critical = ["PagerDuty,credentialId"]
      major    = ["PagerDuty,credentialId"]
    })
  }
}

# Import the module for the team "itsm"
module "signalfx-detectors-smart-agent-system-common-team-itsm" {
  source      = "claranet/detectors/signalfx//modules/smart-agent_system-common"
  version     = ">= 1.7.0, < 2.0.0"
  environment = var.environment

  # Remember modules are already oriented per environment but we can want an higher level of granularity
  filtering_custom = "filter('team', 'itsm')"
  filtering_append = true
  # Here, in addition to the default filtering per environment, we append a filtering per team.
  # Everything is possible while you have a metadata (e.g. dimension) on MTS on which detectors apply on
  # to identify the "scope" of this instance of the module

  # It can be useful to set a notifications binding specific to this team which can have different
  # alerting tools.
  notifications = local.notifications_team["itsm"]
  # To easily find the corresponding detector from its name
  prefixes = ["team:itsm"]
}

# Then import it again for the team "cloud"
module "signalfx-detectors-smart-agent-system-common-team-cloud" {
  source      = "claranet/detectors/signalfx//modules/smart-agent_system-common"
  version     = ">= 1.7.0, < 2.0.0"
  environment = var.environment

  filtering_custom = "filter('team', 'cloud')"
  filtering_append = true
  notifications    = local.notifications_team["cloud"]
  # To easily find the corresponding detector from its name
  prefixes = ["team:cloud"]
}

# This example is intentionally simple to keep it readable but Terraform syntax is rich since 0.12
# so we can use `for_each` on module declaration or `for` to merge a common notfications map with
# another one specific by team.
# -------------------------------------------------------------------------------------------------------

# Split the module instantiation per single resource
# -------------------------------------------------------------------------------------------------------

# Import the module for the host named "foo"
module "signalfx-detectors-smart-agent-system-common-host-foo" {
  source      = "claranet/detectors/signalfx//modules/smart-agent_system-common"
  version     = ">= 1.7.0, < 2.0.0"
  environment = var.environment

  filtering_custom = "filter('host', 'foo')"
  filtering_append = false # the default behavior
  notifications    = local.notifications_devnull
  # To easily find the corresponding detector from its name
  prefixes = ["host:foo"]
}

# Import the module for the host named "bar"
module "signalfx-detectors-smart-agent-system-common-host-bar" {
  source      = "claranet/detectors/signalfx//modules/smart-agent_system-common"
  version     = ">= 1.7.0, < 2.0.0"
  environment = var.environment

  filtering_custom = "filter('host', 'bar')"
  filtering_append = false # the default behavior
  notifications    = local.notifications_devnull
  prefixes         = ["host:bar"]
}

# It can be annoying and not flexible to use this host oriented approach similar
# to traditional monitoring tools like Nagios, so we can at least use wildcard
# to match a "group" of resources will common pattern

module "signalfx-detectors-smart-agent-system-common-stack-toto" {
  source      = "claranet/detectors/signalfx//modules/smart-agent_system-common"
  version     = ">= 1.7.0, < 2.0.0"
  environment = var.environment

  # Suppose the hostname follows a naming convention which contains the "stack"
  # but, sadly, there is no dedicated tag to filter on
  filtering_custom = "filter('host', '*-toto-*')"
  filtering_append = false # the default behavior
  notifications    = local.notifications_devnull
  prefixes         = ["toto"]
}
# -------------------------------------------------------------------------------------------------------

# Split the module instantiation to handle an exception but keeping discovery
# -------------------------------------------------------------------------------------------------------

# Import the module to match everything except our exception applying common alerting conditions
module "signalfx-detectors-smart-agent-system-common-app-default" {
  source      = "claranet/detectors/signalfx//modules/smart-agent_system-common"
  version     = ">= 1.7.0, < 2.0.0"
  environment = var.environment

  filtering_custom = "not filter('app', 'webfront')"
  filtering_append = true
  notifications    = local.notifications_devnull
  # To easily find the corresponding detector from its name
  prefixes = ["host:foo"]
}

# Import it again to match only our exception applying specific alerting conditions for webfront app
module "signalfx-detectors-smart-agent-system-common-app-webfront" {
  source      = "claranet/detectors/signalfx//modules/smart-agent_system-common"
  version     = ">= 1.7.0, < 2.0.0"
  environment = var.environment

  filtering_custom = "filter('app', 'webfront')"
  filtering_append = true
  notifications    = local.notifications_devnull
  # To easily find the corresponding detector from its name
  prefixes = ["webfront"]

  # Disable all alerting rules related to cpu detector
  cpu_disabled = true
}
# -------------------------------------------------------------------------------------------------------

