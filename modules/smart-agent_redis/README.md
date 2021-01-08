# REDIS SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [What are the available detectors in this module?](#what-are-the-available-detectors-in-this-module)
- [How to collect required metrics?](#how-to-collect-required-metrics)
  - [Monitors](#monitors)
  - [PostgreSQL](#postgresql)
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
module "signalfx-detectors-smart-agent-redis" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/smart-agent_redis?ref={revision}"

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
  In general, it will also be used in `filter-tags` sub-module to apply a
  [filtering](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#filtering) based on our default 
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
|Redis heartbeat|X|-|-|-|-|
|Redis evicted keys rate of change|X|X|-|-|-|
|Redis expired keys rate of change|X|X|-|-|-|
|Redis blocked client rate|-|-|X|X|-|
|Redis keyspace seems full|-|X|-|-|-|
|Redis memory used over max memory (if configured)|X|X|-|-|-|
|Redis memory used over total system memory|X|X|-|-|-|
|Redis memory fragmentation ratio (excessive fragmentation)|X|X|-|-|-|
|Redis memory fragmentation ratio (missing memory)|X|X|-|-|-|
|Redis rejected connections (maxclient reached)|X|X|-|-|-|
|Redis hitrate|X|X|-|-|-|

## How to collect required metrics?

This module uses metrics available from 
[monitors](https://docs.signalfx.com/en/latest/integrations/agent/monitors/_monitor-config.html)
available in the [SignalFx Smart 
Agent](https://github.com/signalfx/signalfx-agent). Check the "Related documentation" section for more 
information including the official documentation of this monitor.


Check the [integration 
documentation](https://docs.signalfx.com/en/latest/integrations/integrations-reference/integrations.redis.html) 
in addition to the monitor one which it uses.

### Monitors

The `collectd/redis` monitor requires to enable the following `extraMetrics`:

* `bytes.total_system_memory`
* `bytes.maxmemory`
* `gauge.db0_keys`

Some of them are available since agent version `v5.4.2` like the two first.

### PostgreSQL

You have to configure your PostgreSQL database to provide a user to collect metrics.

And you also have to [enable statement tracking](https://www.postgresql.org/docs/9.3/pgstatstatements.html#AEN160631).
More information available on 
[postgresl](https://docs.signalfx.com/en/latest/integrations/agent/monitors/postgresql.html#metrics-about-queries) 
monitor documentation.


### Metrics


To filter only required metrics for the detectors of this module, add the 
[datapointsToExclude](https://docs.signalfx.com/en/latest/integrations/agent/filtering.html) parameter to 
the corresponding monitor configuration:

```yaml
    datapointsToExclude:
      - metricNames:
        - '*'
        - '!bytes.maxmemory'
        - '!bytes.total_system_memory'
        - '!bytes.used_memory'
        - '!bytes.used_memory_rss'
        - '!counter.evicted_keys'
        - '!counter.expired_keys'
        - '!counter.rejected_connections'
        - '!derive.keyspace_hits'
        - '!derive.keyspace_misses'
        - '!gauge.blocked_clients'
        - '!gauge.connected_clients'
        - '!gauge.db0_keys'

```

## Notes

* The "keyspace full" detector uses number of keys from database index 0, 
it will not work for other databases (1-15 by default).
This detector is disabled by default because it makes sens only when redis is used as cache.


## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Smart Agent monitor](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-redis.html)
* [Collection script](https://github.com/signalfx/redis-collectd-plugin)
