# ELASTICSEARCH SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [What are the available detectors in this module?](#what-are-the-available-detectors-in-this-module)
- [How to collect required metrics?](#how-to-collect-required-metrics)
  - [Monitors](#monitors)
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
module "signalfx-detectors-smart-agent-elasticsearch" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/smart-agent_elasticsearch?ref={revision}"

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
[variables.tf](variables.tf).
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
|ElasticSearch heartbeat|X|-|-|-|-|
|ElasticSearch cluster status|X|X|-|-|-|
|ElasticSearch cluster initializing shards|X|X|-|-|-|
|ElasticSearch cluster relocating shards|X|X|-|-|-|
|ElasticSearch Cluster unassigned shards|X|X|-|-|-|
|ElasticSearch Pending tasks|X|X|-|-|-|
|Elasticsearch CPU usage|X|X|-|-|-|
|Elasticsearch file descriptors usage|X|X|-|-|-|
|Elasticsearch JVM heap memory usage|X|X|-|-|-|
|Elasticsearch JVM memory young usage|-|X|X|-|-|
|Elasticsearch JVM memory old usage|-|X|X|-|-|
|Elasticsearch old-generation garbage collections latency|-|X|X|-|-|
|Elasticsearch young-generation garbage collections latency|-|X|X|-|-|
|Elasticsearch indexing latency|-|X|X|-|-|
|Elasticsearch index flushing to disk latency|-|X|X|-|-|
|Elasticsearch search query latency|-|X|X|-|-|
|Elasticsearch search fetch latency|-|X|X|-|-|
|Elasticsearch fielddata cache evictions rate of change|-|X|X|-|-|
|Elasticsearch max time spent by task in queue rate of change|-|X|X|-|-|

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
thanks to the internal [Smart Agent Receiver](https://github.com/signalfx/splunk-otel-collector/tree/main/internal/receiver/smartagentreceiver).

As a result:
- any SignalFx Smart Agent monitor are compatible with the new agent OpenTelemetry Collector and related modules in this repository keep `smart-agent` as source name.
- any OpenTelemetry receiver not based on an existing Smart Agent monitor is not available from old agent so related modules in this repository use `otel-collector` as source name.


Check the [Related documentation](#related-documentation) section for more detailed and specific information about this module dependencies.

### Monitors

You have to enable the following `extraMetrics` in your monitor configuration:

* `elasticsearch.process.max_file_descriptors`
* `elasticsearch.process.cpu.percent`
* `elasticsearch.cluster.pending-tasks`
* `elasticsearch.cluster.initializing-shards`
* `elasticsearch.cluster.status`
* `elasticsearch.cluster.task-max-wait-time`
* `elasticsearch.jvm.gc.old-time`
* `elasticsearch.jvm.gc.count`
* `elasticsearch.jvm.mem.heap-used-percent`
* `elasticsearch.jvm.mem.pools.old.used_in_bytes`
* `elasticsearch.jvm.mem.pools.old.max_in_bytes`
* `elasticsearch.jvm.mem.pools.young.used_in_bytes`
* `elasticsearch.jvm.mem.pools.young.max_in_bytes`
* `elasticsearch.jvm.gc.time`
* `elasticsearch.jvm.gc.count`
* `elasticsearch.indices.fielddata.evictions`
* `elasticsearch.indices.query-cache.evictions`
* `elasticsearch.indices.request-cache.evictions`
* `elasticsearch.indices.flush.total-time`
* `elasticsearch.indices.flush.total`
* `elasticsearch.indices.indexing.index-time`
* `elasticsearch.indices.indexing.index-total`
* `elasticsearch.indices.search.fetch-time`
* `elasticsearch.indices.search.fetch-total`

You also have to configure following parameters from the
[elasticsearch](https://github.com/signalfx/signalfx-agent/blob/main/docs/monitors/elasticsearch.md)
monitor configuration:

* `enableEnhancedClusterHealthStats` to `true`
* `enableEnhancedNodeIndicesStats` to `['search', 'indexing', 'flush', 'fielddata', 'query_cache', 'request_cache']`
* `clusterHealthStatsMasterOnly: false` will work in any case but prefer to set to `true` you collect from master
node or if the master and data are the same node.

### Examples

```yaml
  - type: elasticsearch
    host: localhost
    port: 9200
    # `false` should works in any case but prefer `true` for master node
    clusterHealthStatsMasterOnly: false
    enableEnhancedClusterHealthStats: true
    enableEnhancedNodeIndicesStats:
      - search
      - indexing
      - flush
      - fielddata
      - query_cache
      - request_cache
    extraMetrics:
      - elasticsearch.process.max_file_descriptors
      - elasticsearch.process.cpu.percent
      - elasticsearch.cluster.pending-tasks
      - elasticsearch.cluster.initializing-shards
      - elasticsearch.cluster.status
      - elasticsearch.cluster.task-max-wait-time
      - elasticsearch.jvm.gc.old-time
      - elasticsearch.jvm.gc.count
      - elasticsearch.jvm.mem.heap-used-percent
      - elasticsearch.jvm.mem.pools.old.used_in_bytes
      - elasticsearch.jvm.mem.pools.old.max_in_bytes
      - elasticsearch.jvm.mem.pools.young.used_in_bytes
      - elasticsearch.jvm.mem.pools.young.max_in_bytes
      - elasticsearch.jvm.gc.time
      - elasticsearch.jvm.gc.count
      - elasticsearch.indices.fielddata.evictions
      - elasticsearch.indices.query-cache.evictions
      - elasticsearch.indices.request-cache.evictions
      - elasticsearch.indices.flush.total-time
      - elasticsearch.indices.flush.total
      - elasticsearch.indices.indexing.index-time
      - elasticsearch.indices.indexing.index-total
      - elasticsearch.indices.search.fetch-time
      - elasticsearch.indices.search.fetch-total
```


### Metrics


To filter only required metrics for the detectors of this module, add the
[datapointsToExclude](https://docs.splunk.com/observability/gdi/smart-agent/smart-agent-resources.html#filtering-data-using-the-smart-agent)
parameter to the corresponding monitor configuration:

```yaml
    datapointsToExclude:
      - metricNames:
        - '*'
        - '!elasticsearch.cluster.initializing-shards'
        - '!elasticsearch.cluster.number-of-nodes'
        - '!elasticsearch.cluster.pending-tasks'
        - '!elasticsearch.cluster.relocating-shards'
        - '!elasticsearch.cluster.status'
        - '!elasticsearch.cluster.task-max-wait-time'
        - '!elasticsearch.cluster.unassigned-shards'
        - '!elasticsearch.indices.fielddata.evictions'
        - '!elasticsearch.indices.flush.total'
        - '!elasticsearch.indices.flush.total-time'
        - '!elasticsearch.indices.indexing.index-time'
        - '!elasticsearch.indices.indexing.index-total'
        - '!elasticsearch.indices.search.fetch-time'
        - '!elasticsearch.indices.search.fetch-total'
        - '!elasticsearch.indices.search.query-time'
        - '!elasticsearch.indices.search.query-total'
        - '!elasticsearch.jvm.gc.count'
        - '!elasticsearch.jvm.gc.old-count'
        - '!elasticsearch.jvm.gc.old-time'
        - '!elasticsearch.jvm.gc.time'
        - '!elasticsearch.jvm.mem.heap-used-percent'
        - '!elasticsearch.jvm.mem.pools.old.max_in_bytes'
        - '!elasticsearch.jvm.mem.pools.old.used_in_bytes'
        - '!elasticsearch.jvm.mem.pools.young.max_in_bytes'
        - '!elasticsearch.jvm.mem.pools.young.used_in_bytes'
        - '!elasticsearch.process.cpu.percent'
        - '!elasticsearch.process.max_file_descriptors'
        - '!elasticsearch.process.open_file_descriptors'

```



## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Splunk Observability integrations](https://docs.splunk.com/Observability/gdi/get-data-in/integrations.html)
* [Smart Agent monitor](https://github.com/signalfx/signalfx-agent/blob/main/docs/monitors/elasticsearch.md)
* [Splunk Observability integration](https://docs.splunk.com/Observability/gdi/elasticsearch/elasticsearch.html)
