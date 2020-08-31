## Notes

Sample config with all required metrics:

```yaml
  - type: elasticsearch
    host: localhost
    port: 9200
    # `false` will always work but default `true` could works if use master node
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

__Note__: `clusterHealthStatsMasterOnly: false` is not always required but will allow to work in any case.
On cluster with separeted data and master nodes you will need to disable it if you gather metric from a data node.
But if you collect from master node or if master and data are the same node so you can uncomment it (or set to `true`).
