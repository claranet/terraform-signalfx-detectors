## Agent configuration

Requires SignalFx Agent >= `5.5.5` and enable the following extra metrics:

```
  - type: collectd/cassandra
    host: localhost
    port: 7199
    extraMetrics:
      - "counter.cassandra.Storage.Exceptions.Count"
      - "counter.cassandra.ClientRequest.Read.TotalLatency.Count"
      - "counter.cassandra.ClientRequest.Write.TotalLatency.Count"
      - "counter.cassandra.ClientRequest.CASRead.Latency.Count"
      - "counter.cassandra.ClientRequest.CASRead.TotalLatency.Count"
      - "counter.cassandra.ClientRequest.CASWrite.Latency.Count"
      - "counter.cassandra.ClientRequest.CASWrite.TotalLatency.Count"
      - "gauge.cassandra.ClientRequest.CASRead.Latency.99thPercentile"
      - "gauge.cassandra.ClientRequest.CASWrite.Latency.99thPercentile"
```

You can use [genericjmx](../../middleware/genericjmx/README.md) as complement 
to this module to monitor generic JMX metrics.
