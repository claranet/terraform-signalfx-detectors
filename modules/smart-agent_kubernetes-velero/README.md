# KUBERNETES-VELERO SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [What are the available detectors in this module?](#what-are-the-available-detectors-in-this-module)
- [How to collect required metrics?](#how-to-collect-required-metrics)
  - [Monitors](#monitors)
  - [Velero](#velero)
  - [Examples](#examples)
  - [Metrics](#metrics)
- [Notes](#notes)
- [Related documentation](#related-documentation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## How to use this module?

This directory defines a [Terraform](https://www.terraform.io/)
[module](https://www.terraform.io/language/modules/syntax) you can use in your
existing [stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) by adding a
`module` configuration and setting its `source` parameter to URL of this folder:

```hcl
module "signalfx-detectors-smart-agent-kubernetes-velero" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/smart-agent_kubernetes-velero?ref={revision}"

  environment   = var.environment
  notifications = local.notifications
}
```

Note the following parameters:

* `source`: Use this parameter to specify the URL of the module. The double slash (`//`) is intentional  and required.
  Terraform uses it to specify subfolders within a Git repo (see [module
  sources](https://www.terraform.io/language/modules/sources)). The `ref` parameter specifies a specific Git tag in
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
  of a Terraform [object](https://www.terraform.io/language/expressions/type-constraints#object) where each key represents an available
  [detector rule severity](https://docs.splunk.com/observability/alerts-detectors-notifications/create-detectors-for-alerts.html#severity)
  and its value is a list of recipients. Every recipients must respect the [detector notification
  format](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector#notification-format).
  Check the [notification binding](https://github.com/claranet/terraform-signalfx-detectors/wiki/Notifications-binding)
  documentation to understand the recommended role of each severity.

These 3 parameters along with all variables defined in [common-variables.tf](common-variables.tf) are common to all
[modules](../) in this repository. Other variables, specific to this module, are available in
[variables-gen.tf](variables-gen.tf).
In general, the default configuration "works" but all of these Terraform
[variables](https://www.terraform.io/language/values/variables) make it possible to
customize the detectors behavior to better fit your needs.

Most of them represent usual tips and rules detailed in the
[guidance](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance) documentation and listed in the
common [variables](https://github.com/claranet/terraform-signalfx-detectors/wiki/Variables) dedicated documentation.

Feel free to explore the [wiki](https://github.com/claranet/terraform-signalfx-detectors/wiki) for more information about
general usage of this repository.

## What are the available detectors in this module?

This module creates the following SignalFx detectors which could contain one or multiple alerting rules:

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Kubernetes velero successful backup|-|X|-|-|-|
|Kubernetes velero failed backup|-|X|-|-|-|
|Kubernetes velero failed partial backup|-|X|-|-|-|
|Kubernetes velero failed backup deletion|-|X|-|-|-|
|Kubernetes velero failed volume snapshot|-|X|-|-|-|

## How to collect required metrics?

This module deploys detectors using metrics reported by the
[SignalFx Smart Agent Monitors](https://github.com/signalfx/signalfx-agent#monitors).

Even if the [Smart Agent is deprecated](https://github.com/signalfx/signalfx-agent/blob/main/docs/smartagent-deprecation-notice.md)
it remains an efficient, lightweight and simple monitoring agent which still works fine.
See the [official documentation](https://docs.splunk.com/Observability/gdi/smart-agent/smart-agent-resources.html) for more information
about this agent.
You might find the related following documentations useful:
- the global level [agent configuration](https://github.com/signalfx/signalfx-agent/blob/main/docs/config-schema.md)
- the [monitor level configuration](https://github.com/signalfx/signalfx-agent/blob/main/docs/monitor-config.md)
- the internal [agent configuration tips](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#agent-configuration).
- the full list of [monitors available](https://github.com/signalfx/signalfx-agent/tree/main/docs/monitors) with their own specific documentation.

In addition, all of these monitors are still available in the [Splunk Otel Collector](https://github.com/signalfx/splunk-otel-collector),
the Splunk [distro of OpenTelemetry Collector](https://opentelemetry.io/docs/concepts/distributions/) which replaces SignalFx Smart Agent,
thanks to the internal [Smart Agent Receiver](https://github.com/signalfx/splunk-otel-collector/tree/main/pkg/receiver/smartagentreceiver).

As a result:
- any SignalFx Smart Agent monitor are compatible with the new agent OpenTelemetry Collector and related modules in this repository keep `smart-agent` as source name.
- any OpenTelemetry receiver not based on an existing Smart Agent monitor is not available from old agent so related modules in this repository use `otel-collector` as source name.


Check the [Related documentation](#related-documentation) section for more detailed and specific information about this module dependencies.

### Monitors

This monitor is only available for agent `>= 5.5.5` but it is basically a wrapper around [prometheus exporter
monitor](https://github.com/signalfx/signalfx-agent/blob/main/docs/monitors/prometheus-exporter.md) to filter important
metrics while prometheus metrics are considered as custom metrics which could have an impact on SignalFx billing.

You must configure it for every velero deployments so this is almost sure you will need to use [service
discovery](https://github.com/signalfx/signalfx-agent/blob/main/docs/auto-discovery.md) to do it dynamically.

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


### Metrics


To filter only required metrics for the detectors of this module, add the
[datapointsToExclude](https://docs.splunk.com/observability/gdi/smart-agent/smart-agent-resources.html#filtering-data-using-the-smart-agent)
parameter to the corresponding monitor configuration:

```yaml
    datapointsToExclude:
      - metricNames:
        - '*'
        - '!velero_backup_deletion_failure_total'
        - '!velero_backup_failure_total'
        - '!velero_backup_partial_failure_total'
        - '!velero_backup_success_total'
        - '!velero_volume_snapshot_failure_total'

```

## Notes

You can enable more metrics not used in this module for metrology or troubleshooting purposes:
```yaml
monitors:
  - type: prometheus/velero
    discoveryRule: container_image =~ "velero" && port == 8085
    port: 8085
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

It uses whitelist [filtering](https://github.com/signalfx/signalfx-agent/blob/main/docs/filtering.md)
to keep only interesting metrics. The last one is not required by this module.

You can replace `prometheus/velero` by `prometheus-exporter` to make this module works
with agent version prior `5.5.5`.


## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Splunk Observability integrations](https://docs.splunk.com/Observability/gdi/get-data-in/integrations.html)
* [Smart Agent monitor](https://github.com/signalfx/signalfx-agent/blob/main/docs/monitors/prometheus-velero.md)
* [Splunk Observability integration](https://docs.splunk.com/observability/en/gdi/monitors-prometheus/prometheus-velero.html)
