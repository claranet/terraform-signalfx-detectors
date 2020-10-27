# MySQL Galera SignalFX detectors

## How to use this module

```hcl

module "signalfx-detectors-database-mysql" {
  source        = "github.com/claranet/terraform-signalfx-detectors.git//modules/database/galera?ref={revision}"
  environment   = var.environment
  notifications = var.notifications
}
```

## Notes

To prepare the Mysql server allowing monitoring you can use [this terraform module](https://github.com/claranet/terraform-signalfx-integrations/tree/master/database/mysql).

This module is usually used in addition with the [MySQL](../database/mysql) module.

## Agent configuration

This module is only based on the [sql](https://docs.signalfx.com/en/latest/integrations/agent/monitors/sql.html) monitor.

Here is a full configuration example working with these detectors:

```yaml
  - type: sql
    dbDriver: mysql
    host: localhost
    port: 3306
    extraDimensions:
      mysql_port: *mysqlPort
    params:
      host: *mysqlHost
      port: *mysqlPort
      dbname: mysql
      username: {"#from": "vault:secret/my-database[username]"}
      password: {"#from": "vault:secret/my-database[password]"}
    connectionString: '{{.username}}:{{.password}}@tcp({{.host}}:{{.port}})/{{.dbname}}'
    queries:
      - query: 'SHOW STATUS LIKE "wsrep_ready";'
        datapointExpressions:
          - 'GAUGE("mysql_wsrep_ready", {}, Value== "ON" ? 1: 0)'

      - query: 'SHOW STATUS LIKE "wsrep_local_state";'
        metrics:
          - metricName: "mysql_wsrep_local_state"
            valueColumn: "Value"
```

If you already use the MySQL module, you can just merge the `queries` attribute with the one already present in your configuration.

## Related documentation

* [Official SQL documentation](https://docs.signalfx.com/en/latest/integrations/integrations-reference/integrations.mysql.html)
* [Galera Status variables](https://galeracluster.com/library/documentation/galera-status-variables.html)
