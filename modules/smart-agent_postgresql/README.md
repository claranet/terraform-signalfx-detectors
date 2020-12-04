# POSTGRESQL SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [What are the available detectors in this module?](#what-are-the-available-detectors-in-this-module)
- [How to collect required metrics?](#how-to-collect-required-metrics)
  - [Monitors](#monitors)
  - [PostgreSQL](#postgresql)
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
module "signalfx-detectors-database-postgresql" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//database/postgresql?ref={revision}"

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

* PostgreSQL heartbeat
* PostgreSQL deadlocks
* PostgreSQL hit ratio
* PostgreSQL rollbacks ratio compared to commits
* PostgreSQL conflicts
* PostgreSQL number of connections compared to max
* PostgreSQL replication lag
* PostgreSQL replication state

## How to collect required metrics?

This module uses metrics available from 
[monitors](https://docs.signalfx.com/en/latest/integrations/agent/monitors/_monitor-config.html)
available in the [SignalFx Smart 
Agent](https://github.com/signalfx/signalfx-agent). Check the "Related documentation" section for more 
information including the official documentation of this monitor.


Check the [integration 
documentation](https://docs.signalfx.com/en/latest/integrations/integrations-reference/integrations.postgresql.html) 
in addition to the monitor one which it uses.

### Monitors

The detectors in this module are based on metrics reported by the following monitors:

* [postgresql](https://docs.signalfx.com/en/latest/integrations/agent/monitors/postgresql.html)

The `postgresql` requires to enable the following `extraMetrics`:

* `postgres_xact_rollbacks`
* `postgres_xact_commits`
* `postgres_conflicts`
* `postgres_locks`
* `postgres_pct_connections`
* `postgres_replication_state`
* `postgres_replication_lag`

Some of them are available since agent version `v5.4.4` like the `replication` metric group.

Others metrics could be collected from the `sql` monitor thanks to custom queries. See examples below.

### PostgreSQL

You have to configure your PostgreSQL database to provide a user to collect metrics.

And you also have to [enable statement tracking](https://www.postgresql.org/docs/9.3/pgstatstatements.html#AEN160631).
More information available on 
[postgresl](https://docs.signalfx.com/en/latest/integrations/agent/monitors/postgresql.html#metrics-about-queries) 
monitor documentation.

### Examples

Here is a sample configuration fragment for the SignalFx agent monitors:

```yaml
  - type: postgresql
    host: &psqlHost localhost
    port: &psqlPort 5432
    params: &psqlParams
      username: {"#from": "vault:secret/my-database[username]"}
      password: {"#from": "vault:secret/my-database[password]"}
    masterDBName: &psqlDBName postgres
    # Uncomment only if postgresql server is not on the same host as signalfx agent
    #disableHostDimensions: true
    extraDimensions: &psqlDimensions
      # Uncomment only if you enabled `disableHostDimensions` or for "serverless" mode.
      #host: *psqlHost
      # Always add this extraDimension.
      postgres_port: *psqlPort
    # You should not have to change lines below
    # Do not add host, port and dbname
    connectionString: "user={{.username}} password={{.password}} sslmode=disable"
    extraMetrics:
      - "postgres_xact_rollbacks"
      - "postgres_xact_commits"
      - "postgres_conflicts"
      - "postgres_locks"
      - "postgres_pct_connections"
      - "postgres_replication_state"
      - "postgres_replication_lag"
# Example config to add custom queries:
#  - type: sql
#    dbDriver: postgres
#    extraDimensions: *psqlDimensions
#    params:
#      << : [ {host: *psqlHost}, {port: *psqlPort}, {dbname: *psqlDBName}, *psqlParams ]
#    connectionString: "host={{.host}} port={{.port}} dbname={{.dbname}} user={{.username}} password={{.password}} sslmode=disable"
#    queries:
#      - query: >-
#          SELECT COUNT(*) AS count FROM mytable;
#        metrics:
#          - metricName: "postgres_example"
#            valueColumn: "count"
```

__Note__: By default this configuration is for [standard 
deployment](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#deployment-mode). 
You have to `disableHostDimensions: true` and add your PostgreSQL server as `host` dimension in `extraDimensions`.


## Notes

* if you master database is protected you will need to override `databases` with the list of readable databases
or monitor will fail to collect metrics.

* the heartbeat detector works a little differently from other database modules because of its granularity.
Indeed, metrics are sent "per database" basis so this detector could raise alert for a deleted databse
in addition to the usual alert when the database server does not reponse anymore.

* For metrics about queries execution time, you must enable `pg_stat_statements` extension which should be specified 
in the `shared_preload_libraries` config option in the main PostgreSQL configuration at server start up. Then, the 
extension must be enabled for each database by running `CREATE EXTENSION IF NOT EXISTS pg_stat_statements;` on each database.

* Replica metrics are not available on Aurora


## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Smart Agent monitor postgresql](https://docs.signalfx.com/en/latest/integrations/agent/monitors/postgresql.html)
* [Smart Agent monitor sql](https://docs.signalfx.com/en/latest/integrations/agent/monitors/sql.html)
