## Notes

These detectors require the following agent configuration to work:

```
monitors:
  - type: prometheus-exporter
    discoveryRule: container_image =~ "velero" && port == 8085
    port: 8085
    datapointsToExclude:
      - metricNames:
        - '*'
        - '!velero_backup_partial_failure_total'
        - '!velero_backup_deletion_failure_total'
        - '!velero_backup_failure_total'
        - '!velero_volume_snapshot_failure_total'
        - '!velero_backup_success_total'
```

__Note__: This whielisting type of metrics filtering is highly recommended
while prometheus exporters often send lot of metrics where not all useful.
And `prometheus-exporter` SignalFx monitor consider every metrics as custom,
so this could have a significant impact on billing.
