# KONG SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [What are the available detectors in this module?](#what-are-the-available-detectors-in-this-module)
- [How to collect required metrics?](#how-to-collect-required-metrics)
  - [Examples](#examples)
  - [Metrics](#metrics)
- [Related documentation](#related-documentation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## How to use this module?

This directory defines a [Terraform](https://www.terraform.io/)
[module](https://www.terraform.io/language/modules/syntax) you can use in your
existing [stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) by adding a
`module` configuration and setting its `source` parameter to URL of this folder:

```hcl
module "signalfx-detectors-prometheus-exporter-kong" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/prometheus-exporter_kong?ref={revision}"

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
|Kong heartbeat|X|-|-|-|-|
|Kong treatment limit|X|X|-|-|-|

## How to collect required metrics?

This module deploys detectors using metrics reported by the
scraping of a server following the [OpenMetrics convention](https://openmetrics.io/) based on and compatible with [the Prometheus
exposition format](https://github.com/prometheus/docs/blob/main/content/docs/instrumenting/exposition_formats.md#openmetrics-text-format).

They are generally called `Prometheus Exporters` which can be fetched by both the [SignalFx Smart Agent](https://github.com/signalfx/signalfx-agent)
thanks to its [prometheus exporter monitor](https://github.com/signalfx/signalfx-agent/blob/main/docs/monitors/prometheus-exporter.md) and the
[OpenTelemetry Collector](https://github.com/signalfx/splunk-otel-collector) using its [prometheus
receiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/prometheusreceiver) or its derivatives.

These exporters could be embedded directly in the tool you want to monitor (e.g. nginx ingress) or must be installed next to it as
a separate program configured to connect, create metrics and expose them as server.


Check the [Related documentation](#related-documentation) section for more detailed and specific information about this module dependencies.

Kong provides a [prometheus plugin](https://docs.konghq.com/hub/kong-inc/prometheus/).
It must be enabled to expose its metrics in Prometheus exposition format which can be scraped by the agent.

### Examples

Here is an example of SignalFx agent configuration using:

```yaml
  - type: prometheus-exporter
    host: 127.0.0.1
    port: 8444
    useHTTPS: true
    skipVerify: true
    datapointsToExclude:
      - metricNames:
        - '*'
        - '!kong_http_status'
        - '!kong_latency'
        - '!kong_nginx_metric_errors_total'
        - '!kong_datastore_reachable'
        - '!kong_nginx_http_current_connections'
```

It uses whitelist [filtering](https://github.com/signalfx/signalfx-agent/blob/main/docs/filtering.md)
to keep only interesting metrics. Only the last two are required by this module.


### Metrics


Here is the list of required metrics for detectors in this module.

* `kong_datastore_reachable`
* `kong_nginx_http_current_connections`




## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Splunk Observability integrations](https://docs.splunk.com/Observability/gdi/get-data-in/integrations.html)
* [Kong](https://konghq.com/)
* [Kong Prometheus Plugin](https://docs.konghq.com/hub/kong-inc/prometheus/)
