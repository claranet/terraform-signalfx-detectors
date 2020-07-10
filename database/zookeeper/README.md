## Notes

The metrics `gauge.zk_outstanding_requests` and `gauge.zk_is_leader` are enabled even if not
yet used in detectors while it represents an highly valuable information during troubleshooting.

```yaml
  - type: collectd/zookeeper
    host: localhost
    port: 2181
    name: "zk" # set the value of `plugin_instance` dimension
    extraMetrics:
      - gauge.zk_service_health
      - gauge.zk_outstanding_requests
      - gauge.zk_is_leader
```
