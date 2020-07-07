# MySQL SignalFX detectors

## How to use this module

```hcl

module "signalfx-detectors-database-mysql" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//database/mysql?ref={revision}"
  environment = var.environment
  notifications = var.notifications
}
```

In order to work properly, this module needs some [extraMetrics](https://docs.signalfx.com/en/latest/integrations/agent/monitors/haproxy.html#non-default-metrics-version-4-7-0), the agent needs a least the following configuration for the [mysql](https://docs.signalfx.com/en/latest/integrations/integrations-reference/integrations.mysql.html) monitor :

```yaml
monitors:
  - type: mysql
    extraMetrics:
      - threads.running
      - mysql_slow_queries
      - mysql_bpool_counters.reads
      - mysql_bpool_counters.read_requests
      - mysql_bpool_pages.free
      - mysql_bpool_pages.total
```

In addition, the `mysql_threads_anomaly` detector monitors query rate change of all `mysql_commands.*` metrics.
However, only `select`, `upadte`, `delete` and `insert` are enabled by default.

To have a working replication detector, you also need extra configuration for custom metrics:

```yaml
- type: sql
  host: mysql-slave
  port: 3306
  dbDriver: mysql
  params:
   user: root
   password: my_root_password
   dbname: performance_schema
  connectionString: '{{.params.user}}:{{.params.password}}@tcp({{.host}}:{{.port}})/{{.params.dbname}}'
  queries:
   - query: 'SELECT REPLACE(REPLACE(SERVICE_STATE, "ON", 1), "OFF", 0) as status FROM replication_connection_status;'
     metrics:
      - metricName: "replication_io_status"
        valueColumn: "status"
   - query: 'SELECT REPLACE(REPLACE(SERVICE_STATE, "ON", 1), "OFF", 0) as status FROM replication_applier_status;'
     metrics:
      - metricName: "replication_sql_status"
        valueColumn: "status"
```

## Purpose

Creates SignalFx detectors with the following checks:

 * MySQL heartbeat
 * MySQL Replication Status
 * MySQL queries changed abnomally (Only based on enabled `mysql_commands.* metrics`)
 * MySQL Innodb buffer pool efficiency
 * MySQL Innodb buffer pool utilization
 * MySQL slow queries rate
 * MySQL threads changed abnormally


## Providers

| Name | Version |
|------|---------|
| signalfx | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| detectors\_disabled | Disable all detectors in this module | `bool` | `false` | no |
| environment | Infrastructure environment | `string` | n/a | yes |
| filter\_custom\_excludes | List of tags to exclude when custom filtering is used | `list` | `[]` | no |
| filter\_custom\_includes | List of tags to include when custom filtering is used | `list` | `[]` | no |
| heartbeat\_disabled | Disable all alerting rules for heartbeat detector | `bool` | `null` | no |
| heartbeat\_notifications | Notification recipients list for every alerting rules of heartbeat detector | `list` | `[]` | no |
| heartbeat\_timeframe | Timeframe for system not reporting detector (i.e. "10m") | `string` | `"20m"` | no |
| mysql\_connections\_aggregation\_function | Aggregation function and group by for mysql\_connection detector (i.e. ".mean(by=['host'])") | `string` | `""` | no |
| mysql\_connections\_disabled | Disable all alerting rules for mysql\_connection detector | `bool` | `null` | no |
| mysql\_connections\_disabled\_critical | Disable critical alerting rule for mysql\_connection detector | `bool` | `null` | no |
| mysql\_connections\_disabled\_warning | Disable warning alerting rule for mysql\_connection detector | `bool` | `null` | no |
| mysql\_connections\_notifications | Notification recipients list for every alerting rules of mysql\_connection detector | `list` | `[]` | no |
| mysql\_connections\_notifications\_critical | Notification recipients list for critical alerting rule of mysql\_connection detector | `list` | `[]` | no |
| mysql\_connections\_notifications\_warning | Notification recipients list for warning alerting rule of mysql\_connection detector | `list` | `[]` | no |
| mysql\_connections\_threshold\_critical | Critical threshold for mysql\_connection detector | `number` | `80` | no |
| mysql\_connections\_threshold\_warning | Warning threshold for mysql\_connection detector | `number` | `70` | no |
| mysql\_connections\_transformation\_function | Transformation function for mysql\_connection detector (mean, min, max) | `string` | `"mean"` | no |
| mysql\_connections\_transformation\_window | Transformation window for mysql\_connection detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"10m"` | no |
| mysql\_pool\_efficiency\_aggregation\_function | Aggregation function and group by for mysql\_pool\_efficiency detector (i.e. ".mean(by=['host'])") | `string` | `""` | no |
| mysql\_pool\_efficiency\_disabled | Disable all alerting rules for mysql\_pool\_efficiency detector | `bool` | `null` | no |
| mysql\_pool\_efficiency\_disabled\_critical | Disable critical alerting rule for mysql\_pool\_efficiency detector | `bool` | `null` | no |
| mysql\_pool\_efficiency\_disabled\_warning | Disable warning alerting rule for mysql\_pool\_efficiency detector | `bool` | `null` | no |
| mysql\_pool\_efficiency\_notifications | Notification recipients list for every alerting rules of mysql\_pool\_efficiency detector | `list` | `[]` | no |
| mysql\_pool\_efficiency\_notifications\_critical | Notification recipients list for critical alerting rule of mysql\_pool\_efficiency detector | `list` | `[]` | no |
| mysql\_pool\_efficiency\_notifications\_warning | Notification recipients list for warning alerting rule of mysql\_pool\_efficiency detector | `list` | `[]` | no |
| mysql\_pool\_efficiency\_threshold\_critical | Critical threshold for mysql\_pool\_efficiency detector | `number` | `30` | no |
| mysql\_pool\_efficiency\_threshold\_warning | Warning threshold for mysql\_pool\_efficiency detector | `number` | `20` | no |
| mysql\_pool\_efficiency\_transformation\_function | Transformation function for mysql\_pool\_efficiency detector (mean, min, max) | `string` | `"min"` | no |
| mysql\_pool\_efficiency\_transformation\_window | Transformation window for mysql\_pool\_efficiency detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"1h"` | no |
| mysql\_pool\_utilization\_aggregation\_function | Aggregation function and group by for mysql\_pool\_utilization detector (i.e. ".mean(by=['host'])") | `string` | `""` | no |
| mysql\_pool\_utilization\_disabled | Disable all alerting rules for mysql\_pool\_utilization detector | `bool` | `null` | no |
| mysql\_pool\_utilization\_disabled\_critical | Disable critical alerting rule for mysql\_pool\_utilization detector | `bool` | `null` | no |
| mysql\_pool\_utilization\_disabled\_warning | Disable warning alerting rule for mysql\_pool\_utilization detector | `bool` | `null` | no |
| mysql\_pool\_utilization\_notifications | Notification recipients list for every alerting rules of mysql\_pool\_utilization detector | `list` | `[]` | no |
| mysql\_pool\_utilization\_notifications\_critical | Notification recipients list for critical alerting rule of mysql\_pool\_utilization detector | `list` | `[]` | no |
| mysql\_pool\_utilization\_notifications\_warning | Notification recipients list for warning alerting rule of mysql\_pool\_utilization detector | `list` | `[]` | no |
| mysql\_pool\_utilization\_threshold\_critical | Critical threshold for mysql\_pool\_utilization detector | `number` | `95` | no |
| mysql\_pool\_utilization\_threshold\_warning | Warning threshold for mysql\_pool\_utilization detector | `number` | `80` | no |
| mysql\_pool\_utilization\_transformation\_function | Transformation function for mysql\_pool\_utilization detector (mean, min, max) | `string` | `"min"` | no |
| mysql\_pool\_utilization\_transformation\_window | Transformation window for mysql\_pool\_utilization detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"1h"` | no |
| mysql\_questions\_anomaly\_aggregation\_function | Aggregation function and group by for mysql\_questions\_anomaly detector (i.e. ".mean(by=['host'])") | `string` | `""` | no |
| mysql\_questions\_anomaly\_clear\_growth\_rate\_threshold | Change over historical norm required to clear, should be >= 0 | `number` | `0.1` | no |
| mysql\_questions\_anomaly\_disabled | Disable all alerting rules for mysql\_questions\_anomaly detector | `bool` | `null` | no |
| mysql\_questions\_anomaly\_disabled\_critical | Disable critical alerting rule for mysql\_questions\_anomaly detector | `bool` | `null` | no |
| mysql\_questions\_anomaly\_disabled\_warning | Disable warning alerting rule for mysql\_questions\_anomaly detector | `bool` | `null` | no |
| mysql\_questions\_anomaly\_fire\_growth\_rate\_threshold | Change over historical norm required to fire, should be >= 0 | `number` | `0.2` | no |
| mysql\_questions\_anomaly\_notifications | Notification recipients list for every alerting rules of mysql\_questions\_anomaly detector | `list` | `[]` | no |
| mysql\_questions\_anomaly\_notifications\_critical | Notification recipients list for critical alerting rule of mysql\_questions\_anomaly detector | `list` | `[]` | no |
| mysql\_questions\_anomaly\_notifications\_warning | Notification recipients list for warning alerting rule of mysql\_questions\_anomaly detector | `list` | `[]` | no |
| mysql\_questions\_anomaly\_num\_windows | Number of previous periods used to define baseline, must be > 0 | `number` | `4` | no |
| mysql\_questions\_anomaly\_orientation | Specifies whether detect fires when signal is above, below, or out-of-band (Options:  above, below, out\_of\_band) | `string` | `"above"` | no |
| mysql\_questions\_anomaly\_space\_between\_windows | Time range reflecting the periodicity of the data stream | `string` | `"1d"` | no |
| mysql\_questions\_anomaly\_transformation\_function | Transformation function for mysql\_questions\_anomaly detector (mean, min, max) | `string` | `"mean"` | no |
| mysql\_questions\_anomaly\_transformation\_window | Transformation window for mysql\_questions\_anomaly detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"15m"` | no |
| mysql\_questions\_anomaly\_window\_to\_compare | Length of current window (being tested for anomalous values), and historical windows (used to establish a baseline) | `string` | `"15m"` | no |
| mysql\_replication\_lag\_aggregation\_function | Aggregation function and group by for mysql\_replication\_lag detector (i.e. ".mean(by=['host'])") | `string` | `""` | no |
| mysql\_replication\_lag\_disabled | Disable all alerting rules for mysql\_replication\_lag detector | `bool` | `null` | no |
| mysql\_replication\_lag\_disabled\_critical | Disable critical alerting rule for mysql\_replication\_lag detector | `bool` | `null` | no |
| mysql\_replication\_lag\_disabled\_warning | Disable warning alerting rule for mysql\_replication\_lag detector | `bool` | `null` | no |
| mysql\_replication\_lag\_notifications | Notification recipients list for every alerting rules of mysql\_replication\_lag detector | `list` | `[]` | no |
| mysql\_replication\_lag\_notifications\_critical | Notification recipients list for critical alerting rule of mysql\_replication\_lag detector | `list` | `[]` | no |
| mysql\_replication\_lag\_notifications\_warning | Notification recipients list for warning alerting rule of mysql\_replication\_lag detector | `list` | `[]` | no |
| mysql\_replication\_lag\_threshold\_critical | Critical threshold for mysql\_replication\_lag detector | `number` | `200` | no |
| mysql\_replication\_lag\_threshold\_warning | Warning threshold for mysql\_replication\_lag detector | `number` | `100` | no |
| mysql\_replication\_lag\_transformation\_function | Transformation function for mysql\_replication\_lag detector (mean, min, max) | `string` | `"min"` | no |
| mysql\_replication\_lag\_transformation\_window | Transformation window for mysql\_replication\_lag detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"15m"` | no |
| mysql\_replication\_status\_aggregation\_function | Aggregation function and group by for mysql\_replication\_status detector (i.e. ".mean(by=['host'])") | `string` | `""` | no |
| mysql\_replication\_status\_disabled | Disable all alerting rules for mysql\_replication\_status detector | `bool` | `null` | no |
| mysql\_replication\_status\_disabled\_critical | Disable critical alerting rule for mysql\_replication\_status detector | `bool` | `null` | no |
| mysql\_replication\_status\_notifications | Notification recipients list for every alerting rules of mysql\_replication\_status detector | `list` | `[]` | no |
| mysql\_replication\_status\_notifications\_critical | Notification recipients list for critical alerting rule of mysql\_replication\_status detector | `list` | `[]` | no |
| mysql\_replication\_status\_transformation\_function | Transformation function for mysql\_replication\_status detector (mean, min, max) | `string` | `"min"` | no |
| mysql\_replication\_status\_transformation\_window | Transformation window for mysql\_replication\_status detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"5m"` | no |
| mysql\_slow\_aggregation\_function | Aggregation function and group by for mysql\_slow detector (i.e. ".mean(by=['host'])") | `string` | `""` | no |
| mysql\_slow\_disabled | Disable all alerting rules for mysql\_slow detector | `bool` | `null` | no |
| mysql\_slow\_disabled\_critical | Disable critical alerting rule for mysql\_slow detector | `bool` | `null` | no |
| mysql\_slow\_disabled\_warning | Disable warning alerting rule for mysql\_slow detector | `bool` | `null` | no |
| mysql\_slow\_notifications | Notification recipients list for every alerting rules of mysql\_slow detector | `list` | `[]` | no |
| mysql\_slow\_notifications\_critical | Notification recipients list for critical alerting rule of mysql\_slow detector | `list` | `[]` | no |
| mysql\_slow\_notifications\_warning | Notification recipients list for warning alerting rule of mysql\_slow detector | `list` | `[]` | no |
| mysql\_slow\_threshold\_critical | Critical threshold for mysql\_slow detector | `number` | `20` | no |
| mysql\_slow\_threshold\_warning | Warning threshold for mysql\_slow detector | `number` | `5` | no |
| mysql\_slow\_transformation\_function | Transformation function for mysql\_slow detector (mean, min, max) | `string` | `"mean"` | no |
| mysql\_slow\_transformation\_window | Transformation window for mysql\_slow detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"15m"` | no |
| mysql\_threads\_anomaly\_aggregation\_function | Aggregation function and group by for mysql\_threads\_anomaly detector (i.e. ".mean(by=['host'])") | `string` | `""` | no |
| mysql\_threads\_anomaly\_clear\_growth\_rate\_threshold | Change over historical norm required to clear, should be >= 0 | `number` | `0.1` | no |
| mysql\_threads\_anomaly\_disabled | Disable all alerting rules for mysql\_threads\_anomaly detector | `bool` | `null` | no |
| mysql\_threads\_anomaly\_disabled\_critical | Disable critical alerting rule for mysql\_threads\_anomaly detector | `bool` | `null` | no |
| mysql\_threads\_anomaly\_disabled\_warning | Disable warning alerting rule for mysql\_threads\_anomaly detector | `bool` | `null` | no |
| mysql\_threads\_anomaly\_fire\_growth\_rate\_threshold | Change over historical norm required to fire, should be >= 0 | `number` | `0.2` | no |
| mysql\_threads\_anomaly\_notifications | Notification recipients list for every alerting rules of mysql\_threads\_anomaly detector | `list` | `[]` | no |
| mysql\_threads\_anomaly\_notifications\_critical | Notification recipients list for critical alerting rule of mysql\_threads\_anomaly detector | `list` | `[]` | no |
| mysql\_threads\_anomaly\_notifications\_warning | Notification recipients list for warning alerting rule of mysql\_threads\_anomaly detector | `list` | `[]` | no |
| mysql\_threads\_anomaly\_num\_windows | Number of previous periods used to define baseline, must be > 0 | `number` | `4` | no |
| mysql\_threads\_anomaly\_orientation | Specifies whether detect fires when signal is above, below, or out-of-band (Options:  above, below, out\_of\_band) | `string` | `"above"` | no |
| mysql\_threads\_anomaly\_space\_between\_windows | Time range reflecting the periodicity of the data stream | `string` | `"1d"` | no |
| mysql\_threads\_anomaly\_transformation\_function | Transformation function for mysql\_threads\_anomaly detector (mean, min, max) | `string` | `"mean"` | no |
| mysql\_threads\_anomaly\_transformation\_window | Transformation window for mysql\_threads\_anomaly detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"15m"` | no |
| mysql\_threads\_anomaly\_window\_to\_compare | Length of current window (being tested for anomalous values), and historical windows (used to establish a baseline) | `string` | `"15m"` | no |
| notifications | Notification recipients list for every detectors | `list` | n/a | yes |
| prefixes | Prefixes list to prepend between brackets on every monitors names before environment | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| heartbeat\_id | id for detector heartbeat |
| mysql\_questions\_anomaly\_id | id for detector mysql\_questions\_anomaly |
| mysql\_slow\_id | id for detector mysql\_slow |
| mysql\_threads\_anomaly\_id | id for detector mysql\_threads\_anomaly |

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/integrations-reference/integrations.mysql.html)

## TODO

Provide replication and connection usage monitoring. This however requires:

* To be able to export the `max_connections` mysql parameter
* To be able to parse the `show slave status` result (https://github.com/signalfx/signalfx-agent/pull/1363)
