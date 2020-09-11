## Notes

These detectors use prometheus metrics from Nginx ingress controller only available for version `=> 0.16`.

Enable the following flags in the Nginx Ingress Controller chart:

- `controller.stats.enabled=true`
- `controller.metrics.enabled=true`

You need to declare a [prometheus exporter monitor](https://docs.signalfx.com/en/latest/integrations/agent/monitors/prometheus-exporter.html) for each ingress.
In general, they are lot of ingress so this is highly recommended to use [auto discovery](https://docs.signalfx.com/en/latest/integrations/agent/auto-discovery.html) to automate this.

Detectors in this module will at least require to add the following `extraMetrics`:

- `nginx_ingress_controller_requests`
- `nginx_ingress_controller_ingress_upstream_latency_seconds`

But feel free to add more metrics for dashboarding or troubleshooting purpose (but keep in mind it exposes lot of metrics).

Here is an example of SignalFx agent configuration for each ingress controller:

```
monitors:
  - type: prometheus-exporter
    discoveryRule: container_image =~ "nginx-ingress-controller" && port == 10254
    port: 10254
    datapointsToExclude:
      - metricNames:
        - '*'
        - '!nginx_ingress_controller_requests'
        - '!nginx_ingress_controller_ingress_upstream_latency_seconds'
        - '!nginx_ingress_controller_nginx_process_cpu_seconds_total'
        - '!nginx_ingress_controller_nginx_process_virtual_memory_bytes'
        - '!nginx_ingress_controller_nginx_process_resident_memory_bytes'
```

__Note__: This whitelisting type of metrics filtering is highly recommended
while prometheus exporters often send lot of metrics where not all useful.
And `prometheus-exporter` SignalFx monitor consider every metrics as custom,
so this could have a significant impact on billing.
