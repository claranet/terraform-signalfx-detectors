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

* This is highly recommended to configure the `collectd/mongodb` 
monitor for __all__ members of a replicaset to fetch metrics from 
both the primary and the secondaries which all have their own stats.

* This is mandatory for "primary" and "secondary" detectors because 
they need the information of every member of a replicaset to determine 
if there is a problem. Indeed, they group by the replicaset to know if 
there is, at least, one master and two scondaries.

* The heartbeat detector is also aggregated by replicaset (`cluster`) by 
default to avoid alert for each single member disapearance.

* Every other detectors do not use any aggegation because this is more 
flexible and they do not require it to work. But feel free to change 
the `aggregation_functions` variables for these tree or others to fit 
your environment.

