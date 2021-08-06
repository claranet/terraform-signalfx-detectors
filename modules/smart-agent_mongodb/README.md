# MONGODB SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [What are the available detectors in this module?](#what-are-the-available-detectors-in-this-module)
- [How to collect required metrics?](#how-to-collect-required-metrics)
  - [Monitors](#monitors)
  - [Examples](#examples)
  - [Metrics](#metrics)
- [Notes](#notes)
- [Related documentation](#related-documentation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## How to use this module?

This directory defines a [Terraform](https://www.terraform.io/) 
[module](https://www.terraform.io/docs/modules/usage.html) you can use in your
existing [stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) by adding a 
`module` configuration and setting its `source` parameter to URL of this folder:

```hcl
module "signalfx-detectors-smart-agent-mongodb" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/smart-agent_mongodb?ref={revision}"

  environment   = var.environment
  notifications = local.notifications
}
```

Note the following parameters:

* `source`: Use this parameter to specify the URL of the module. The double slash (`//`) is intentional  and required. 
  Terraform uses it to specify subfolders within a Git repo (see [module
  sources](https://www.terraform.io/docs/modules/sources.html)). The `ref` parameter specifies a specific Git tag in
  this repository. It is recommended to use the latest "pinned" version in place of `{revision}`. Avoid using a branch 
  like `master` except for testing purpose. Note that every modules in this repository are available on the Terraform 
  [registry](https://registry.terraform.io/modules/claranet/detectors/signalfx) and we recommend using it as source 
  instead of `git` which is more flexible but less future-proof.

* `environment`: Use this parameter to specify the 
  [environment](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#environment) used by this 
  instance of the module.
  Its value will be added to the `prefixes` list at the start of the [detector 
  name](https://github.com/claranet/terraform-signalfx-detectors/wiki/Templating#example).
  In general, it will also be used in the `filtering` internal sub-module to [apply
  filters](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#filtering) based on our default 
  [tagging convention](https://github.com/claranet/terraform-signalfx-detectors/wiki/Tagging-convention) by default.

* `notifications`: Use this parameter to define where alerts should be sent depending on their severity. It consists 
  of a Terraform [object](https://www.terraform.io/docs/configuration/types.html#object-) where each key represents an 
  available [detector rule severity](https://docs.signalfx.com/en/latest/detect-alert/set-up-detectors.html#severity) 
  and its value is a list of recipients. Every recipients must respect the [detector notification 
  format](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector#notification-format).
  Check the [notification binding](https://github.com/claranet/terraform-signalfx-detectors/wiki/Notifications-binding) 
  documentation to understand the recommended role of each severity.

These 3 parameters alongs with all variables defined in [common-variables.tf](common-variables.tf) are common to all 
[modules](../) in this repository. Other variables, specific to this module, are available in 
[variables.tf](variables.tf).
In general, the default configuration "works" but all of these Terraform 
[variables](https://www.terraform.io/docs/configuration/variables.html) make it possible to 
customize the detectors behavior to better fit your needs.

Most of them represent usual tips and rules detailled in the 
[guidance](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance) documentation and listed in the 
common [variables](https://github.com/claranet/terraform-signalfx-detectors/wiki/Variables) dedicated documentation.

Feel free to explore the [wiki](https://github.com/claranet/terraform-signalfx-detectors/wiki) for more information about 
general usage of this repository.

## What are the available detectors in this module?

This module creates the following SignalFx detectors which could contain one or multiple alerting rules:

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|MongoDB heartbeat|X|-|-|-|-|
|MongoDB page faults|-|-|-|X|-|
|MongoDB number of connections over max capacity|X|X|-|-|-|
|MongoDB asserts (warning and regular) errors|-|-|X|-|-|
|MongoDB primary in replicaset|X|-|-|-|-|
|MongoDB secondary members count in replicaset|X|-|-|-|-|
|MongoDB replication lag|X|X|-|-|-|

## How to collect required metrics?

This module uses metrics available from 
[monitors](https://docs.signalfx.com/en/latest/integrations/agent/monitors/_monitor-config.html)
available in the [SignalFx Smart 
Agent](https://github.com/signalfx/signalfx-agent). Check the [Related documentation](#related-documentation) section for more 
information including the official documentation of this monitor.


Check the [integration 
documentation](https://docs.signalfx.com/en/latest/integrations/integrations-reference/integrations.mongodb.html) 
in addition to the monitor one which it uses.

### Monitors

The `collectd/mongodb` monitor requires to enable the following `extraMetrics`:

* `gauge.connections.available`
* `counter.asserts.regular`
* `counter.asserts.warning`
* `gauge.repl.max_lag`
* `gauge.repl.active_nodes`
* `gauge.repl.is_primary_node`

The 3 last ones enabled by default since agent version `v5.5.6`.

This is highly recommended to configure the monitor on __all__ members of a replicaset 
to fetch metrics from both the primary and the secondaries which all have their own stats.
This is the only way to make the replicaset related detectors to work.

### Examples

```yaml
  - type: collectd/mongodb
    host: &mongoHost localhost
    port: &mongoPort 27017
    username: user
    password: pass
    databases:
      - admin
    # Uncomment only if mysql server is not on the same host as signalfx agent
    #disableHostDimensions: true
    extraDimensions:
      # Uncomment only if you enabled `disableHostDimensions` or for "serverless" mode.
      #host: *mongoHost
    # You should not have to change lines below
    extraMetrics:
      - gauge.connections.available
      - counter.asserts.regular
      - counter.asserts.warning
      # Only required if agent <= 5.5.5:
      - gauge.repl.max_lag
      - gauge.repl.active_nodes
      - gauge.repl.is_primary_node
```


### Metrics


To filter only required metrics for the detectors of this module, add the 
[datapointsToExclude](https://docs.signalfx.com/en/latest/integrations/agent/filtering.html) parameter to 
the corresponding monitor configuration:

```yaml
    datapointsToExclude:
      - metricNames:
        - '*'
        - '!counter.asserts.regular'
        - '!counter.asserts.warning'
        - '!counter.extra_info.page_faults'
        - '!gauge.connections.available'
        - '!gauge.connections.current'
        - '!gauge.repl.active_nodes'
        - '!gauge.repl.is_primary_node'
        - '!gauge.repl.max_lag'

```

## Notes

* This is mandatory for "primary" and "secondary" detectors because 
they need the information of every member of a replicaset to determine 
if there is a problem. Indeed, they group by the replicaset to know if 
there is, at least, one master and two scondaries.

* The heartbeat detector is also aggregated by replicaset (`cluster`) by 
default to avoid alert for each single member disapearance.

* Every other detectors do not use any aggegation because this is more 
flexible and they do not require it to work. But feel free to change 
the `aggregation_functions` variables for these tree or others to fit 
your environment.


## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Smart Agent monitor](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-mongodb.html)
* [Collection script](https://github.com/signalfx/collectd-mongodb)
