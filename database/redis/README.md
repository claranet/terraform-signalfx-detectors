## Notes

Requires SignalFx Agent >= 5.5 and enable some extra metrics:

```
  - type: collectd/redis
    host: 127.0.0.1
    port: 6379
    extraMetrics:
      - bytes.total_system_memory
      - bytes.maxmemory
      - gauge.db0_keys
```
