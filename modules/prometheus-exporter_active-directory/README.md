# ACTIVE-DIRECTORY SignalFx detectors

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
module "signalfx-detectors-prometheus-exporter-active-directory" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/prometheus-exporter_active-directory?ref={revision}"

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

These 3 parameters alongs with all variables defined in [common-variables.tf](common-variables.tf) are common to all
[modules](../) in this repository. Other variables, specific to this module, are available in
[variables-gen.tf](variables-gen.tf).
In general, the default configuration "works" but all of these Terraform
[variables](https://www.terraform.io/language/values/variables) make it possible to
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
|Active-directory heartbeat|X|-|-|-|-|
|Active-directory replication errors|X|X|-|-|-|
|Active-directory active directory services|X|-|-|-|-|

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

The detectors of this module uses metrics from the [windows exporter](https://github.com/prometheus-community/windows_exporter) plugin for Prometheus.

You need to install it with at least `service` and `ad` modules by using `ENABLED_COLLECTORS=service,ad`.

Some filters must be added into the OTEL agent configuration to avoid reaching custom metrics limitations on Splunk.

### Examples

Sample OTEL Agent configuration with needed filters

```yaml
---
extensions:
  health_check:
    endpoint: 0.0.0.0:13133
  http_forwarder:
    ingress:
      endpoint: 0.0.0.0:6060
    egress:
      endpoint: "${SPLUNK_API_URL}"
  smartagent:
    bundleDir: "${SPLUNK_BUNDLE_DIR}"
    collectd:
      configDir: "${SPLUNK_COLLECTD_DIR}"

receivers:
  hostmetrics:
    collection_interval: 20s
    scrapers:
      cpu:
      disk:
      filesystem:
      memory:
      network:
      load:
      paging:
      processes:
  smartagent/signalfx-forwarder:
    type: signalfx-forwarder
    listenAddress: 0.0.0.0:9080
  signalfx:
    endpoint: 0.0.0.0:9943

  otlp:
    protocols:
      grpc:
        endpoint: 0.0.0.0:4317
      http:
        endpoint: 0.0.0.0:55681
  prometheus:
    config:
      scrape_configs:
        - job_name: 'otel-collector'
          scrape_interval: 2m
          static_configs:
            - targets: ['0.0.0.0:8888']
          metric_relabel_configs:
            - source_labels: [__name__]
              regex: '.*grpc_io.*'
              action: drop
  prometheus/exporter:
    config:
      scrape_configs:
        - job_name: 'prometheus-exporter-ad'
          scrape_interval: 1m
          static_configs:
            - targets: ['127.0.0.1:9182']
          metric_relabel_configs:
            - source_labels: [__name__]
              regex: 'windows_ad_replication.*'
              action: keep

        - job_name: 'prometheus-exporter-services'
          scrape_interval: 1m
          static_configs:
            - targets: ['127.0.0.1:9182']
          metric_relabel_configs:
            - source_labels: [__name__,name]
              separator: "@"
              regex: 'windows_service_state@(kdc|adws|dfs|dfsr|dns|ismserv|lanmanserver|lanmanworkstation|netlogon|ntds|w32time)'
              action: keep


processors:
  batch:
  memory_limiter:
    ballast_size_mib: ${SPLUNK_BALLAST_SIZE_MIB}
    check_interval: 2s
    limit_mib: ${SPLUNK_MEMORY_LIMIT_MIB}
  resourcedetection:
    detectors: [azure, system]
    override: false
  resource/add_global_dimensions:
    attributes:
      - action: upsert
        key: sfx_monitored
        value: true
      - action: upsert
        key: env
        value: prod

exporters:
  signalfx:
    access_token: "${SPLUNK_ACCESS_TOKEN}"
    api_url: "${SPLUNK_API_URL}"
    ingest_url: "${SPLUNK_INGEST_URL}"
    include_metrics:
      - metric_name: cpu.utilization_per_core
      - metric_name: cpu.wait
  otlp:
    endpoint: "${SPLUNK_GATEWAY_URL}:4317"
    insecure: true

service:
  extensions: [health_check, http_forwarder]
  pipelines:
    metrics:
      receivers: [hostmetrics, otlp, prometheus, signalfx, smartagent/signalfx-forwarder, prometheus/exporter]
      processors: [memory_limiter, batch, resourcedetection, resource/add_global_dimensions]
      exporters: [signalfx]
...
```


### Metrics


Here is the list of required metrics for detectors in this module.

* `windows_ad_replication_sync_requests_success_total`
* `windows_ad_replication_sync_requests_total`
* `windows_service_state`




## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Splunk Observability integrations](https://docs.splunk.com/Observability/gdi/get-data-in/integrations.html)
* [Prometheus Exporter for Windows](https://github.com/prometheus-community/windows_exporter)
