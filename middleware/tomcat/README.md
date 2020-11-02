## Notes

This module uses the [collectd/tomcat](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-tomcat.html)
monitor to collect metrics which require agent version `>= 5.5.5`.

There is not any specific configuration:

```yaml
  - type: collectd/tomcat
    host: 127.0.0.1
    port: 8050
```

You can use [genericjmx](../genericjmx/README.md) as complement 
to this module to monitor generic JMX metrics.
