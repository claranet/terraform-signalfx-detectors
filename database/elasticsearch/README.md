# ELASTICSEARCH SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [What are the available detectors in this module?](#what-are-the-available-detectors-in-this-module)
- [How to collect required metrics?](#how-to-collect-required-metrics)
  - [Monitors](#monitors)
  - [Examples](#examples)
- [Related documentation](#related-documentation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## How to use this module?

This directory defines a [Terraform](https://www.terraform.io/) 
[module](https://www.terraform.io/docs/modules/usage.html) you can use in your
existing [stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) by adding a 
`module` configuration and setting its `source` parameter to URL of this folder:

```hcl
module "signalfx-detectors-database-elasticsearch" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//database/elasticsearch?ref={revision}"

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

* ElasticSearch heartbeat
* ElasticSearch cluster status
* ElasticSearch cluster initializing shards
* ElasticSearch cluster relocating shards
* ElasticSearch Cluster unassigned shards
* ElasticSearch Pending tasks
* Elasticsearch CPU usage
* Elasticsearch file descriptors usage
* Elasticsearch JVM heap memory usage
* Elasticsearch JVM memory young usage
* Elasticsearch JVM memory old usage
* Elasticsearch old-generation garbage collections latency
* Elasticsearch young-generation garbage collections latency
* Elasticsearch indexing latency
* Elasticsearch index flushing to disk latency
* Elasticsearch search query latency
* Elasticsearch search fetch latency
* Elasticsearch fielddata cache evictions rate of change
* Elasticsearch max time spent by task in queue rate of change

## How to collect required metrics?

This module uses metrics available from 
[monitors](https://docs.signalfx.com/en/latest/integrations/agent/monitors/_monitor-config.html)
available in the [SignalFx Smart 
Agent](https://github.com/signalfx/signalfx-agent). Check the "Related documentation" section for more 
information including the official documentation of this monitor.


Check the [integration 
documentation](https://docs.signalfx.com/en/latest/integrations/integrations-reference/integrations.elasticsearch.html) 
in addition to the monitor one which it uses.

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
[elasticsearch](https://docs.signalfx.com/en/latest/integrations/agent/monitors/elasticsearch.html) 
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




## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Smart Agent monitor](https://docs.signalfx.com/en/latest/integrations/agent/monitors/elasticsearch.html)
* [RabbitMQ management plugin](https://www.rabbitmq.com/management.html)
* [Collection script](https://github.com/signalfx/collectd-rabbitmq)
