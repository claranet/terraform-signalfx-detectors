## Notes

These detectors use prometheus metrics from [Nginx Ingress Controller](https://github.com/kubernetes/ingress-nginx) only available for version `>= 0.16`.

Enable the following flags in the Nginx Ingress Controller chart:

- `controller.stats.enabled=true`
- `controller.metrics.enabled=true`

You need to configure [prometheus/nginx-ingress](https://docs.signalfx.com/en/latest/integrations/agent/monitors/prometheus-nginx-ingress.html) monitor for each ingress but do not confon it with [prometheus/nginx-ingress](https://docs.signalfx.com/en/latest/integrations/agent/monitors/prometheus-nginx-vts.html) monitor which works only for Nginx Ingress Controller version `< 0.16`.

This is basically a wrapper around [prometheus exporter monitor](https://docs.signalfx.com/en/latest/integrations/agent/monitors/prometheus-exporter.html) to filter important metrics because Nginx Ingress Controller provides lot of metrics.

In general, they are lot of ingress on `Kubernetes`, so this is highly recommended to use [auto discovery](https://docs.signalfx.com/en/latest/integrations/agent/auto-discovery.html) to automate this.

Here is an example of SignalFx agent configuration with discovery rule:

```
monitors:
  - type: prometheus/nginx-ingress
    discoveryRule: container_image =~ "nginx-ingress-controller" && port == 10254
    port: 10254
```

__Note__: this configuration uses `prometheus/nginx-ingress` monitor avalaible for agent version `>= 5.5.5`. 
For prior versions, you have to use the generic `prometheus-exporter` with right filtering (see below).

Detectors in this module will at least require these metrics which are collected by default:

- `nginx_ingress_controller_requests`
- `nginx_ingress_controller_ingress_upstream_latency_seconds`

But feel free to add more metrics for dashboarding or troubleshooting purpose:

```
monitors:
  - type: prometheus/nginx-ingress
    discoveryRule: container_image =~ "nginx-ingress-controller" && port == 10254
    port: 10254
    sendAllMetrics: true
    datapointsToExclude:
      - metricNames:
        - '*'
        - '!nginx_ingress_controller_requests'
        - '!nginx_ingress_controller_ingress_upstream_latency_seconds'
        - '!nginx_ingress_controller_nginx_process_cpu_seconds_total'
        - '!nginx_ingress_controller_nginx_process_virtual_memory_bytes'
        - '!nginx_ingress_controller_nginx_process_resident_memory_bytes'
```

__Note__: this is a whitelist filtering containing required metrics and 3 optional others as example.
