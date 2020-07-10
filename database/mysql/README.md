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
    host: &mysqlHost 127.0.0.1
    port: &mysqlPort 3306
    username: &mysqlUser {"#from": "vault:secret/my-database[username]"}
    password: &mysqlPass {"#from": "vault:secret/my-database[password]"}
    databases:
      - name: &mysqlDBName mysql
    extraDimensions: &mysqlDimensions
      mysql_host: *mysqlHost
      mysql_port: *mysqlPort
    innodbStats: true
    extraMetrics:
      - threads.running
      - mysql_bpool_counters.reads
      - mysql_bpool_counters.read_requests
      - mysql_bpool_pages.free
      - mysql_bpool_pages.total
  # You should not have to change this while it uses collectd/mysql  monitor config
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
      - query: 'SELECT v.VARIABLE_VALUE AS max_connections, s.processcount AS connections, ((s.processcount/v.VARIABLE_VALUE)*100) AS pct_connections FROM information_schema.GLOBAL_VARIABLES v, (SELECT (@proc_connect:=count(*)) processcount FROM information_schema.PROCESSLIST) s WHERE v.VARIABLE_NAME = "max_connections";'
        metrics:
          - metricName: "mysql_pct_connections"
            valueColumn: "pct_connections"
      - query: 'SELECT VARIABLE_VALUE AS aborted_connects FROM information_schema.GLOBAL_STATUS WHERE VARIABLE_NAME LIKE "ABORTED_CONNECTS";'
        metrics:
          - metricName: "mysql_aborted_connects"
            valueColumn: "aborted_connects"
            isCumulative: true
      - query: 'SELECT VARIABLE_VALUE AS queries FROM information_schema.GLOBAL_STATUS WHERE VARIABLE_NAME LIKE "QUERIES";'
        metrics:
          - metricName: "mysql_queries"
            valueColumn: "queries"
            isCumulative: true
      - query: 'SELECT VARIABLE_VALUE AS slow_queries FROM information_schema.GLOBAL_STATUS WHERE VARIABLE_NAME LIKE "SLOW_QUERIES";'
        metrics:
          - metricName: "mysql_slow_queries"
            valueColumn: "slow_queries"
            isCumulative: true
```

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/integrations-reference/integrations.mysql.html)
