## Notes

These detectors use prometheus metrics from [Velero](https://github.com/vmware-tanzu/velero).

You need to configure [prometheus/velero](https://docs.signalfx.com/en/latest/integrations/agent/monitors/prometheus-nginx-ingress.html) monitor for each velero deployment.

This is basically a wrapper around [prometheus exporter monitor](https://docs.signalfx.com/en/latest/integrations/agent/monitors/prometheus-exporter.html) to filter useful metrics from Velero for alerting prupose.

In general, we use [auto discovery](https://docs.signalfx.com/en/latest/integrations/agent/auto-discovery.html) to automate configuration of `prometheus-exporter` based monitors on `Kubernetes`.

Here is an example of SignalFx agent configuration with discovery rule:

```
monitors:
  - type: prometheus/velero
    discoveryRule: container_image =~ "velero" && port == 8085
    port: 8085
```

__Note__: this configuration uses `prometheus/velero` monitor avalaible for agent version `>= 5.5.5`. 
For prior versions, you have to use the generic `prometheus-exporter` with right filtering (see below).

Detectors in this module will at least require these metrics which are collected by default:

- `velero_backup_partial_failure_total`
- `velero_backup_deletion_failure_total`
- `velero_backup_failure_total`
- `velero_volume_snapshot_failure_total`
- `velero_backup_success_total`

But feel free to add more metrics for dashboarding or troubleshooting purpose:

```
monitors:
  - type: prometheus/velero
    discoveryRule: container_image =~ "velero" && port == 8085
    port: 8085
    sendAllMetrics: true
    datapointsToExclude:
      - metricNames:
        - '*'
        - '!velero_backup_partial_failure_total'
        - '!velero_backup_deletion_failure_total'
        - '!velero_backup_failure_total'
        - '!velero_volume_snapshot_failure_total'
        - '!velero_backup_success_total'
        - '!velero_restore_success_total'
```

__Note__: this is a whitelist filtering containing required metrics and an optional other one as example.
