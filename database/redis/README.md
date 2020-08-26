## Agent configuration

Requires SignalFx Agent >= 5.4.2 and enable some extra metrics:

```
  - type: collectd/redis
    host: 127.0.0.1
    port: 6379
    extraMetrics:
      - bytes.total_system_memory
      - bytes.maxmemory
      - gauge.db0_keys
```

## Notes

the "keyspace full" detector uses number of keys from database index 0, 
it will not work for other databases (1-15 by default).
This detector is disabled by default because it makes sens only when redis is used as cache.
