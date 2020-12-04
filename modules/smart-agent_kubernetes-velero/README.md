# VELERO SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [What are the available detectors in this module?](#what-are-the-available-detectors-in-this-module)
- [How to collect required metrics?](#how-to-collect-required-metrics)
  - [Agent](#agent)
  - [Monitors](#monitors)
  - [Velero](#velero)
  - [Examples](#examples)
- [Notes](#notes)
- [Related documentation](#related-documentation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## How to use this module?

This directory defines a [Terraform](https://www.terraform.io/) 
[module](https://www.terraform.io/docs/modules/usage.html) you can use in your
existing [stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) by adding a 
`module` configuration and setting its `source` parameter to URL of this folder:

```hcl
module "signalfx-detectors-container-kubernetes-velero" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//container/kubernetes/velero?ref={revision}"

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

There are other Terraform [variables](https://www.terraform.io/docs/configuration/variables.html) in 
[variables.tf](variables.tf) so check their description to customize the detectors behavior to fit your needs. Most of them are 
common [variables](https://github.com/claranet/terraform-signalfx-detectors/wiki/Variables).
The [guidance](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance) documentation will help you to use 
common mechanims provided by the modules like [multi 
instances](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#Multiple-instances).

Feel free to explore the [wiki](https://github.com/claranet/terraform-signalfx-detectors/wiki) for more information about 
general usage of this repository.

## What are the available detectors in this module?

This module creates the following SignalFx detectors which could contain one or multiple alerting rules:

* Kubernetes velero successful backup
* Kubernetes velero failed backup
* Kubernetes velero failed partial backup
* Kubernetes velero failed backup deletion
* Kubernetes velero failed volume snapshot

## How to collect required metrics?

This module uses metrics available from 
[monitors](https://docs.signalfx.com/en/latest/integrations/agent/monitors/_monitor-config.html)
available in the [SignalFx Smart 
Agent](https://github.com/signalfx/signalfx-agent). Check the "Related documentation" section for more 
information including the official documentation of this monitor.


### Agent

Here is the official [main 
documentation](https://docs.signalfx.com/en/latest/integrations/integrations-reference/integrations.kubernetes.html) for 
kubernetes including the `signalfx-agent` installation which must be installed as 
[daemonset](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) on your cluster.

### Monitors

The detectors in this module are based on metrics reported by the following monitors:

* [prometheus/velero](https://docs.signalfx.com/en/latest/integrations/agent/monitors/prometheus-velero.html)

This monitor is only available for agent `>= 5.5.5` but it is basically a wrapper around [prometheus exporter 
monitor](https://docs.signalfx.com/en/latest/integrations/agent/monitors/prometheus-exporter.html) to filter important 
metrics while prometheus metrics are considered as custom metrics which could have an impact on SignalFx billing.

You must configure it for every velero deployments so this is almost sure you will need to use [service 
discovery](https://docs.signalfx.com/en/latest/integrations/agent/auto-discovery.html) to do it dynamically.

Detectors in this module will at least require these metrics:

* `velero_backup_partial_failure_total`
* `velero_backup_deletion_failure_total`
* `velero_backup_failure_total`
* `velero_volume_snapshot_failure_total`
* `velero_backup_success_total`

There are collected by default by `velero` monitor but you have to enable them if you use `prometheus-exporter`.

### Velero

These detectors use prometheus metrics from [Velero](https://github.com/vmware-tanzu/velero).

They should be enabled by default but be sure to enable the following flag:

* `metrics.enabled=true`

### Examples

Here is an example of SignalFx agent configuration with discovery rule:

```yaml
monitors:
  - type: prometheus/velero
    discoveryRule: container_image =~ "velero" && port == 8085
    port: 8085
```


## Notes

You can enable more metrics not used in this module for metrology or troubleshooting purposes:
```yaml
monitors:
  - type: prometheus/velero
    discoveryRule: container_image =~ "velero" && port == 8085
    port: 8085
    sendAllMetrics: true
    datapointsToExclude:
      - metricNames:
        - '*'
        - '!velero_backup_partial_failure_total'
        - '!velero_backup_deletion_failure_total'
        - '!velero_backup_failure_total'
        - '!velero_volume_snapshot_failure_total'
        - '!velero_backup_success_total'
        - '!velero_restore_success_total'
```

It uses whitelist [filtering](https://docs.signalfx.com/en/latest/integrations/agent/filtering.html) 
to keep only interesting metrics. The last one is not required by this module.

You can replace `prometheus/velero` by `prometheus-exporter` to make this module works 
with agent version prior `5.5.5`.


## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Smart Agent monitor](https://docs.signalfx.com/en/latest/integrations/agent/monitors/prometheus-velero.html)
