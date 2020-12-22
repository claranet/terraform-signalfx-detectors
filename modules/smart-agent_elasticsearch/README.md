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
module "signalfx-detectors-smart-agent-elasticsearch" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/smart-agent_elasticsearch?ref={revision}"

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

* ElasticSearch cluster initializing shards
* ElasticSearch cluster relocating shards
* ElasticSearch cluster status
* ElasticSearch Cluster unassigned shards
* Elasticsearch CPU usage
* Elasticsearch fielddata cache evictions rate of change
* Elasticsearch file descriptors usage
* ElasticSearch heartbeat
* Elasticsearch index flushing to disk latency
* Elasticsearch indexing latency
* Elasticsearch JVM heap memory usage
* Elasticsearch JVM memory old usage
* Elasticsearch JVM memory young usage
* Elasticsearch max time spent by task in queue rate of change
* Elasticsearch old-generation garbage collections latency
* ElasticSearch Pending tasks
* Elasticsearch search fetch latency
* Elasticsearch search query latency
* Elasticsearch young-generation garbage collections latency

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
