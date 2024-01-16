# MYSQL SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [What are the available detectors in this module?](#what-are-the-available-detectors-in-this-module)
- [How to collect required metrics?](#how-to-collect-required-metrics)
  - [Monitors](#monitors)
  - [MySQL](#mysql)
  - [Suggested configuration](#suggested-configuration)
  - [Metrics](#metrics)
- [Notes](#notes)
- [Related documentation](#related-documentation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## How to use this module?

This directory defines a [Terraform](https://www.terraform.io/)
[module](https://www.terraform.io/language/modules/syntax) you can use in your
existing [stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) by adding a
`module` configuration and setting its `source` parameter to URL of this folder:

```hcl
module "signalfx-detectors-smart-agent-mysql" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/smart-agent_mysql?ref={revision}"

  environment   = var.environment
  notifications = local.notifications
}
```

Note the following parameters:

* `source`: Use this parameter to specify the URL of the module. The double slash (`//`) is intentional  and required.
  Terraform uses it to specify subfolders within a Git repo (see [module
  sources](https://www.terraform.io/language/modules/sources)). The `ref` parameter specifies a specific Git tag in
  this repository. It is recommended to use the latest "pinned" version in place of `{revision}`. Avoid using a branch
  like `master` except for testing purpose. Note that every modules in this repository are available on the Terraform
  [registry](https://registry.terraform.io/modules/claranet/detectors/signalfx) and we recommend using it as source
  instead of `git` which is more flexible but less future-proof.

* `environment`: Use this parameter to specify the
  [environment](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#environment) used by this
  instance of the module.
  Its value will be added to the `prefixes` list at the start of the [detector
  name](https://github.com/claranet/terraform-signalfx-detectors/wiki/Templating#example).
  In general, it will also be used in the `filtering` internal sub-module to [apply
  filters](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#filtering) based on our default
  [tagging convention](https://github.com/claranet/terraform-signalfx-detectors/wiki/Tagging-convention) by default.

* `notifications`: Use this parameter to define where alerts should be sent depending on their severity. It consists
  of a Terraform [object](https://www.terraform.io/language/expressions/type-constraints#object) where each key represents an available
  [detector rule severity](https://docs.splunk.com/observability/alerts-detectors-notifications/create-detectors-for-alerts.html#severity)
  and its value is a list of recipients. Every recipients must respect the [detector notification
  format](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector#notification-format).
  Check the [notification binding](https://github.com/claranet/terraform-signalfx-detectors/wiki/Notifications-binding)
  documentation to understand the recommended role of each severity.

These 3 parameters along with all variables defined in [common-variables.tf](common-variables.tf) are common to all
[modules](../) in this repository. Other variables, specific to this module, are available in
[variables.tf](variables.tf) and [variables-gen.tf](variables-gen.tf).
In general, the default configuration "works" but all of these Terraform
[variables](https://www.terraform.io/language/values/variables) make it possible to
customize the detectors behavior to better fit your needs.

Most of them represent usual tips and rules detailed in the
[guidance](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance) documentation and listed in the
common [variables](https://github.com/claranet/terraform-signalfx-detectors/wiki/Variables) dedicated documentation.

Feel free to explore the [wiki](https://github.com/claranet/terraform-signalfx-detectors/wiki) for more information about
general usage of this repository.

## What are the available detectors in this module?

This module creates the following SignalFx detectors which could contain one or multiple alerting rules:

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|MySQL heartbeat|X|-|-|-|-|
|MySQL number of connections over max capacity|X|X|-|-|-|
|MySQL slow queries percentage|X|X|-|-|-|
|MySQL innodb buffer pool efficiency|-|-|X|X|-|
|MySQL innodb buffer pool utilization|-|-|X|X|-|
|MySQL replication lag|X|X|-|-|-|
|MySQL slave sql status|X|-|-|-|-|
|MySQL slave io status|X|-|-|-|-|
|MySQL running threads changed abruptly|X|-|-|-|-|
|MySQL running queries changed abruptly|X|-|-|-|-|

## How to collect required metrics?

This module deploys detectors using metrics reported by the
[SignalFx Smart Agent Monitors](https://github.com/signalfx/signalfx-agent#monitors).

Even if the [Smart Agent is deprecated](https://github.com/signalfx/signalfx-agent/blob/main/docs/smartagent-deprecation-notice.md)
it remains an efficient, lightweight and simple monitoring agent which still works fine.
See the [official documentation](https://docs.splunk.com/Observability/gdi/smart-agent/smart-agent-resources.html) for more information
about this agent.
You might find the related following documentations useful:
- the global level [agent configuration](https://github.com/signalfx/signalfx-agent/blob/main/docs/config-schema.md)
- the [monitor level configuration](https://github.com/signalfx/signalfx-agent/blob/main/docs/monitor-config.md)
- the internal [agent configuration tips](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#agent-configuration).
- the full list of [monitors available](https://github.com/signalfx/signalfx-agent/tree/main/docs/monitors) with their own specific documentation.

In addition, all of these monitors are still available in the [Splunk Otel Collector](https://github.com/signalfx/splunk-otel-collector),
the Splunk [distro of OpenTelemetry Collector](https://opentelemetry.io/docs/concepts/distributions/) which replaces SignalFx Smart Agent,
thanks to the internal [Smart Agent Receiver](https://github.com/signalfx/splunk-otel-collector/tree/main/pkg/receiver/smartagentreceiver).

As a result:
- any SignalFx Smart Agent monitor are compatible with the new agent OpenTelemetry Collector and related modules in this repository keep `smart-agent` as source name.
- any OpenTelemetry receiver not based on an existing Smart Agent monitor is not available from old agent so related modules in this repository use `otel-collector` as source name.


Check the [Related documentation](#related-documentation) section for more detailed and specific information about this module dependencies.

### Monitors

The detectors in this module are based on metrics reported by the following monitors:

* [collectd/mysql](https://github.com/signalfx/signalfx-agent/blob/main/docs/monitors/collectd-mysql.md)
* [sql](https://github.com/signalfx/signalfx-agent/blob/main/docs/monitors/sql.md)

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
documentation](https://docs.splunk.com/Observability/gdi/mysql/mysql.html#creating-a-mysql-user-for-this-monitor).

### Suggested configuration

Here is a suggested configuration fragment for the SignalFx agent monitors:

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
    # if `mysqlHost` is 'localhost' (unix socket connection) and `mysqlUser` have different right
    # when connecting via tcp than unix socket
    # you should use the second connectionString
    connectionString: '{{.username}}:{{.password}}@tcp({{.host}}:{{.port}})/{{.dbname}}'
    #connectionString: '{{.username}}:{{.password}}@unix(/var/run/mysqld/mysqld.sock)/{{.dbname}}'
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

__Note__: This configuration should be your default for [standard
deployment](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#deployment-mode).
If the mysql server is not on the same host as the signalfx agent you have to:
  * uncomment `disableHostDimensions: true`
  * uncomment `host: *mysqlHost` in `extraDimensions`.

__Note__: If you deploy this configuration via ansible, you will need to escape `connectionString` with `{% raw %}…{% endraw %}`.


### Metrics


To filter only required metrics for the detectors of this module, add the
[datapointsToExclude](https://docs.splunk.com/observability/gdi/smart-agent/smart-agent-resources.html#filtering-data-using-the-smart-agent)
parameter to the corresponding monitor configuration:

```yaml
    datapointsToExclude:
      - metricNames:
        - '*'
        - '!mysql_bpool_counters.read_requests'
        - '!mysql_bpool_counters.reads'
        - '!mysql_bpool_pages.free'
        - '!mysql_bpool_pages.total'
        - '!mysql_commands.*'
        - '!mysql_max_connections'
        - '!mysql_octets.rx'
        - '!mysql_queries'
        - '!mysql_seconds_behind_master'
        - '!mysql_slave_io_running'
        - '!mysql_slave_sql_running'
        - '!mysql_slow_queries'
        - '!mysql_threads_connected'
        - '!threads.running'

```

## Notes

The `mysql_threads_anomaly` detector monitors query rate change of all `mysql_commands.*` metrics but only
`select`, `update`, `delete` and `insert` are enabled by default so feel free to more in `extraMetrics`.


## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Splunk Observability integrations](https://docs.splunk.com/Observability/gdi/get-data-in/integrations.html)
* [Smart Agent monitor mysql](https://github.com/signalfx/signalfx-agent/blob/main/docs/monitors/collectd-mysql.md)
* [Smart Agent monitor sql](https://github.com/signalfx/signalfx-agent/blob/main/docs/monitors/sql.md)
* [Splunk Observability integration mysql](https://docs.splunk.com/Observability/gdi/mysql/mysql.html)
* [Splunk Observability integration sql](https://docs.splunk.com/Observability/gdi/sql/sql.html)
