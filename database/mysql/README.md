# MySQL SignalFX detectors

## How to use this module

```hcl

module "signalfx-detectors-database-mysql" {
  source        = "github.com/claranet/terraform-signalfx-detectors.git//database/mysql?ref={revision}"
  environment   = var.environment
  notifications = var.notifications
}
```

## Notes

To prepare the Mysql server allowing monitoring you can use [this terraform module](https://github.com/claranet/terraform-signalfx-integrations/tree/master/database/mysql).

## Agent configuration

In order to work properly, this module needs some [extraMetrics](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-mysql.html#non-default-metrics-version-4-7-0), the agent needs a least the following configuration for the [mysql](https://docs.signalfx.com/en/latest/integrations/integrations-reference/integrations.mysql.html) monitor :

- `threads.running`
- `mysql_bpool_counters.reads`
- `mysql_bpool_counters.read_requests`
- `mysql_bpool_pages.free`
- `mysql_bpool_pages.total`

In addition, the `mysql_threads_anomaly` detector monitors query rate change of all `mysql_commands.*` metrics.
However, only `select`, `upadte`, `delete` and `insert` are enabled by default.

Some detectors also depend on [sql](https://docs.signalfx.com/en/latest/integrations/agent/monitors/sql.html) monitor.
It brings more metrics not available in `collectd/mysql` thanks to custom queries.

Here is a full configuration example working with these detectors:

```yaml
  - type: collectd/mysql
    host: &mysqlHost localhost
    port: &mysqlPort 3306
    username: &mysqlUser {"#from": "vault:secret/my-database[username]"}
    password: &mysqlPass {"#from": "vault:secret/my-database[password]"}
    databases:
      - name: &mysqlDBName mysql
    # Uncomment only if mysql server is not on the same host as signalfx agent
    #disableHostDimensions: true
    extraDimensions: &mysqlDimensions
      # Uncomment only if you enabled `disableHostDimensions` or for "serverless" mode.
      #host: *mysqlHost
      # Always add this extraDimension.
      mysql_port: *mysqlPort
    # You should not have to change lines below
    innodbStats: true
    extraMetrics:
      - threads.running
      - mysql_bpool_counters.reads
      - mysql_bpool_counters.read_requests
      - mysql_bpool_pages.free
      - mysql_bpool_pages.total
  - type: sql
    dbDriver: mysql
    extraDimensions: *mysqlDimensions
    # This is a YAML reference to avoid duplicating the above config.
    host: *mysqlHost
    port: *mysqlPort
    params:
      host: *mysqlHost
      port: *mysqlPort
      dbname: *mysqlDBName
      username: *mysqlUser
      password: *mysqlPass
    connectionString: '{{.username}}:{{.password}}@tcp({{.host}}:{{.port}})/{{.dbname}}'
    queries:
      # Requires signalfx-agent >= v5.4.0
      - query: 'SHOW SLAVE STATUS;'
        datapointExpressions:
          - 'GAUGE("mysql_slave_sql_running", {master_uuid: Master_UUID, channel: Channel_name}, Slave_SQL_Running == "Yes" ? 1 : 0)'
          - 'GAUGE("mysql_seconds_behind_master", {master_uuid: Master_UUID, channel: Channel_name}, Seconds_Behind_Master)'
      # Works for older agent versions but does not support "seconds_behind_master" metric
      #- query: "SELECT IF(VARIABLE_VALUE LIKE 'ON', 1, 0) AS slave_sql_running FROM information_schema.GLOBAL_STATUS WHERE VARIABLE_NAME LIKE 'SLAVE_RUNNING';"
      #  metrics:
      #    - metricName: "mysql_slave_sql_running"
      #      valueColumn: "slave_sql_running"
      - query: 'SHOW GLOBAL STATUS WHERE Variable_name like "Aborted_connects";'
        metrics:
          - metricName: "mysql_aborted_connects"
            valueColumn: "Value"
            isCumulative: true
      - query: 'SHOW GLOBAL STATUS WHERE Variable_name like "Queries";'
        metrics:
          - metricName: "mysql_queries"
            valueColumn: "Value"
            isCumulative: true
      - query: 'SHOW GLOBAL STATUS WHERE Variable_name like "Slow_queries";'
        metrics:
          - metricName: "mysql_slow_queries"
            valueColumn: "Value"
            isCumulative: true
      - query: 'SHOW GLOBAL STATUS WHERE Variable_name like "Threads_connected";'
        metrics:
          - metricName: "mysql_threads_connected"
            valueColumn: "Value"
      - query: 'SHOW GLOBAL VARIABLES WHERE Variable_name like "max_connections";'
        metrics:
          - metricName: "mysql_max_connections"
            valueColumn: "Value"
```

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/integrations-reference/integrations.mysql.html)
