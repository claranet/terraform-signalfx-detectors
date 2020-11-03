## Agent configuration

This module uses [collectd/mongodb](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-mongodb.html) monitor.

```yaml
  - type: collectd/mongodb
    host: &mongoHost localhost
    port: &mongoPort 27017
    username: user
    password: pass
    databases:
      - admin
    # Uncomment only if mysql server is not on the same host as signalfx agent
    #disableHostDimensions: true
    extraDimensions:
      # Uncomment only if you enabled `disableHostDimensions` or for "serverless" mode.
      #host: *mongoHost
    # You should not have to change lines below
    extraMetrics:
      - gauge.connections.available
      - counter.asserts.regular
      - counter.asserts.warning
      # Only required if agent <= 5.5.5:
      - gauge.repl.max_lag
      - gauge.repl.active_nodes
      - gauge.repl.is_primary_node
```

## Notes

* Primary and secondary detectors require to configure on all members 
of the replicat because they use explicitly aggregation by replicaset 
(`cluster` by default) to work. Change default value of corresponding 
`aggregation_function` variable if necessary.

* The heartbeat detector is by aggregated replicaset (`cluster`) by 
default to avoid alert for each single member disapearance.
