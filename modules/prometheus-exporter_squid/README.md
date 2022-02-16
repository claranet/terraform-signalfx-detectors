# SQUID SignalFx detectors

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
[module](https://www.terraform.io/docs/modules/usage.html) you can use in your
existing [stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) by adding a
`module` configuration and setting its `source` parameter to URL of this folder:

```hcl
module "signalfx-detectors-prometheus-exporter-squid" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/prometheus-exporter_squid?ref={revision}"

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
  of a Terraform [object](https://www.terraform.io/docs/configuration/types.html#object-) where each key represents an available
  [detector rule severity](https://docs.splunk.com/observability/alerts-detectors-notifications/create-detectors-for-alerts.html#severity)
  and its value is a list of recipients. Every recipients must respect the [detector notification
  format](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector#notification-format).
  Check the [notification binding](https://github.com/claranet/terraform-signalfx-detectors/wiki/Notifications-binding)
  documentation to understand the recommended role of each severity.

These 3 parameters alongs with all variables defined in [common-variables.tf](common-variables.tf) are common to all
[modules](../) in this repository. Other variables, specific to this module, are available in
[variables-gen.tf](variables-gen.tf).
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
|Squid heartbeat|X|-|-|-|-|
|Squid status|X|-|-|-|-|
|Squid server errors ratio|X|X|-|-|-|
|Squid total amount of requests|X|-|-|-|-|

## How to collect required metrics?

This module deploys detectors using metrics reported by the
scraping of a server following the [OpenMetrics convention](https://openmetrics.io/) based on and compatible with [the Prometheus
exposition format](https://github.com/prometheus/docs/blob/main/content/docs/instrumenting/exposition_formats.md#openmetrics-text-format).

They are generally called `Prometheus Exporters` which can be fetched by both the [SignalFx Smart Agent](https://github.com/signalfx/signalfx-agent)
thanks to its [prometheus exporter monitor](https://github.com/signalfx/signalfx-agent/blob/main/docs/monitors/prometheus-exporter.md) and the
[OpenTelemetry Collector](https://github.com/signalfx/splunk-otel-collector) using its [prometheus
receiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/prometheusreceiver) or its derivates.

These exporters could be embedded directly in the tool you want to monitor (e.g. nginx ingress) or must be installed next to it as
a separate program configured to connect, create metrics and expose them as server.


Check the [Related documentation](#related-documentation) section for more detailed and specific information about this module dependencies.

The detectors of this module uses metrics from the [squid exporter prometheus](https://github.com/boynux/squid-exporter).
Check its documentation to install and configure it appropriately with your Squid server.

### Examples

Here is a sample configuration fragment for the [OpenTelemetry Collector](https://opentelemetry.io/docs/collector/) agent using
the [prometheusexec receiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/prometheusexecreceiver).

```yaml
receivers:
  prometheus_exec/squid:
  exec: /etc/otel/collector/scripts/squid-exporter -listen 127.0.0.1:{{port}} -metrics-path "/metrics" -squid-hostname localhost -squid-port 3128 -extractservicetimes false
  port: 9095
  scrape_interval: 60s
processors:
  filter/squid:
    metrics:
      include:
        match_type: regexp
        metric_names:
          - squid_server_all_.*
          - squid_client_http_.*
          - squid_up
  metricstransform/squid:
    transforms:
    - action: update
      include: squid_up
      match_type: strict
      operations:
      # Empty the `host` label set by the exporter for squid_up metric only:
      # https://github.com/boynux/squid-exporter/blob/afadec8336ae6d8208ef9085156ba3803a5b71ca/collector/metrics.go
      # It can cause conflict with the `host.name` dimension from the new OpenTelemetry convention
      - action: update_label
        label: host
        value_actions:
          # change to the host value provided for `squid-hostname` parameter
          - value: localhost
            new_value:
  resourcedetection/internal:
    detectors: [system, gce, ecs, ec2, azure]
    # Useful in combination with the prometheus receivers which set `host.name` dimension from the scrapped url but we prefer to keep the hostname where the agent runs.
    override: true
service:
  pipelines:
    metrics/squid:
      receivers: [prometheus_exec/squid]
      processors: [resourcedetection/internal, filter/squid, metricstransform/squid]
      exporters: [signalfx]
```


### Metrics


Here is the list of required metrics for detectors in this module.

* `squid_client_http_requests_total`
* `squid_server_all_errors_total`
* `squid_server_all_requests_total`
* `squid_up`




## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Splunk Observability integrations](https://docs.splunk.com/Observability/gdi/get-data-in/integrations.html)
* [Squid Server](http://www.squid-cache.org/)
* [Prometheus Exporter for Squid](https://github.com/boynux/squid-exporter)
