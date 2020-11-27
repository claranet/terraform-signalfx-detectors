# MYSQL SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [What are the available detectors in this module?](#what-are-the-available-detectors-in-this-module)
- [How to collect required metrics?](#how-to-collect-required-metrics)
  - [Monitors](#monitors)
  - [MySQL](#mysql)
  - [Examples](#examples)
- [Notes](#notes)
- [Related documentation](#related-documentation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## How to use this module?

This directory defines a [Terraform](https://www.terraform.io/) 
[module](https://www.terraform.io/docs/modules/usage.html) you can use in your
existing [stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) by adding a 
`module` configuration and setting its `source` parameter to URL of this folder:

```hcl
module "signalfx-detectors-database-mysql" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//database/mysql?ref={revision}"

  environment   = var.environment
  notifications = local.notifications
}
```

Note the following parameters:

* `source`: Use this parameter to specify the URL of the module. The double slash (`//`) is intentional  and required. 
  Terraform uses it to specify subfolders within a Git repo (see [module
  sources](https://www.terraform.io/docs/modules/sources.html)). The `ref` parameter specifies a specific Git tag in
  this repository. It is recommended to use the latest "pinned" version in place of `{revision}`. Avoid using a branch 
  like `master` except for testing purpose. Note that every modules in this repository are available on the Terraform 
  [registry](https://registry.terraform.io/modules/claranet/detectors/signalfx) and we recommend using it as source 
  instead of `git` which is more flexible but less future-proof.

* `environment`: Use this parameter to specify the 
  [environment](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#environment) used by this 
  instance of the module.
  Its value will be added to the `prefixes` list at the start of the [detector 
  name](https://github.com/claranet/terraform-signalfx-detectors/wiki/Templating#example).
  In general, it will also be used in `filter-tags` sub-module to apply a
  [filtering](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#filtering) based on our default 
  [tagging convention](https://github.com/claranet/terraform-signalfx-detectors/wiki/Tagging-convention) by default.

* `notifications`: Use this parameter to define where alerts should be sent depending on their severity. It consists 
  of a Terraform [object](https://www.terraform.io/docs/configuration/types.html#object-) where each key represents an 
  available [detector rule severity](https://docs.signalfx.com/en/latest/detect-alert/set-up-detectors.html#severity) 
  and its value is a list of recipients. Every recipients must respect the [detector notification 
  format](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector#notification-format).
  Check the [notification binding](https://github.com/claranet/terraform-signalfx-detectors/wiki/Notifications-binding) 
  documentation to understand the recommended role of each severity.

There are other Terraform [variables](https://www.terraform.io/docs/configuration/variables.html) in 
[variables.tf](variables.tf) so check their description to customize the detectors behavior to fit your needs. Most of them are 
common [variables](https://github.com/claranet/terraform-signalfx-detectors/wiki/Variables).
The [guidance](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance) documentation will help you to use 
common mechanims provided by the modules like [multi 
instances](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#Multiple-instances).

Feel free to explore the [wiki](https://github.com/claranet/terraform-signalfx-detectors/wiki) for more information about 
general usage of this repository.

## What are the available detectors in this module?

This module creates the following SignalFx detectors which could contain one or multiple alerting rules:

* MySQL heartbeat
* MySQL number of connections over max capacity
* MySQL slow queries percentage
* MySQL Innodb buffer pool efficiency
* MySQL Innodb buffer pool utilization
* MySQL running threads changed abruptly
* MySQL running queries changed abruptly
* MySQL replication lag
* MySQL slave sql status
* MySQL slave sql status

## How to collect required metrics?

This module uses metrics available from 
[monitors](https://docs.signalfx.com/en/latest/integrations/agent/monitors/_monitor-config.html)
available in the [SignalFx Smart 
Agent](https://github.com/signalfx/signalfx-agent). Check the "Related documentation" section for more 
information including the official documentation of this monitor.


Check the [integration 
documentation](https://docs.signalfx.com/en/latest/integrations/integrations-reference/integrations.mysql.html) 
in addition to the monitor one which it uses.

### Monitors

The detectors in this module are based on metrics reported by the following monitors:

* [collectd/mysql](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-mysql.html)
* [sql](https://docs.signalfx.com/en/latest/integrations/agent/monitors/sql.html)

The `collectd/mysql` requires to enable the following `extraMetrics`:

* `threads.running`
* `mysql_bpool_counters.reads`
* `mysql_bpool_counters.read_requests`
* `mysql_bpool_pages.free`
* `mysql_bpool_pages.total`

To collect InnoDB metrics you also have to `innodbStats: true` which is available since agent version `v5.3.3`.

Others metrics are collected from the `sql` monitor thanks to custom queries. See examples below.

### MySQL

You have to configure your MySQL database to provide a user to collect metrics.
You can use [this terraform module](https://github.com/claranet/terraform-signalfx-integrations/tree/master/database/mysql) 
or follow instruction in [integration 
documentation](https://docs.signalfx.com/en/latest/integrations/integrations-reference/integrations.mysql.html#creating-a-mysql-user-for-collectd).

### Examples

Here is a sample configuration fragment for the SignalFx agent monitors:

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
          - 'GAUGE("mysql_slave_io_running", {master_uuid: Master_UUID, channel: Channel_name}, Slave_IO_Running == "Yes" ? 1 : 0)'
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

__Note__: By default this configuration is for [standard 
deployment](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#deployment-mode). 
You have to `disableHostDimensions: true` and add your MySQL server as `host` dimension in `extraDimensions`.


## Notes

The `mysql_threads_anomaly` detector monitors query rate change of all `mysql_commands.*` metrics but only 
`select`, `update`, `delete` and `insert` are enabled by default so feel free to more in `extraMetrics`.


## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Smart Agent monitor mysql](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-mysql.html)
* [Smart Agent monitor sql](https://docs.signalfx.com/en/latest/integrations/agent/monitors/sql.html)
