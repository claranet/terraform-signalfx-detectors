## Agent configuration

This module only requires [postgresql](https://docs.signalfx.com/en/latest/integrations/agent/monitors/postgresql.html) monitor but feel free to add custom queries thanks to [sql](https://docs.signalfx.com/en/latest/integrations/agent/monitors/sql.html) monitor.

```yaml
  - type: postgresql
    host: &psqlHost localhost
    port: &psqlPort 5432
    params: &psqlParams
      username: {"#from": "vault:secret/my-database[username]"}
      password: {"#from": "vault:secret/my-database[password]"}
    masterDBName: &psqlDBName postgres
    # Uncomment only if mysql server is not on the same host as signalfx agent
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
