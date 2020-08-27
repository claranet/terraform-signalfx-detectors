## Notes

This module deploy detectors which require both [postgresql](https://docs.signalfx.com/en/latest/integrations/agent/monitors/postgresql.html) and [sql](https://docs.signalfx.com/en/latest/integrations/agent/monitors/sql.html) monitors.

The last one brings more useful metrics thanks to specific SQL queries configured in Agent:

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
  - type: sql
    dbDriver: postgres
    extraDimensions: *psqlDimensions
    params:
      << : [ {host: *psqlHost}, {port: *psqlPort}, {dbname: *psqlDBName}, *psqlParams ]
    connectionString: "host={{.host}} port={{.port}} dbname={{.dbname}} user={{.username}} password={{.password}} sslmode=disable"
    queries:
      - query: >-
          WITH max_con AS (SELECT setting::float FROM pg_settings WHERE name = 'max_connections')
          SELECT COUNT(*)/MAX(setting) AS pct_connections FROM pg_stat_activity, max_con;
        metrics:
          - metricName: "postgres_pct_connections"
            valueColumn: "pct_connections"
      - query: >-
          SELECT GREATEST (0, (EXTRACT (EPOCH FROM now() - pg_last_xact_replay_timestamp()))) AS lag,
          CASE WHEN pg_is_in_recovery() THEN 'standby' ELSE 'master' END AS replication_role;
        metrics:
          - metricName: "postgres_replication_lag"
            valueColumn: "lag"
            dimensionColumns: ["replication_role"]
      - query: "SELECT slot_name, slot_type, database, case when active then 1 else 0 end AS active FROM pg_replication_slots;"
        metrics:
          - metricName: "postgres_replication_state"
            valueColumn: "active"
            dimensionColumns: ["slot_name", "slot_type", "database"]
      - query: "SELECT COUNT(*) AS locks FROM pg_locks WHERE NOT granted;"
        metrics:
          - metricName: "postgres_locks"
            valueColumn: "locks"
      - query: "SELECT datname AS database, xact_commit, xact_rollback, conflicts FROM pg_stat_database;"
        metrics:
          - metricName: "postgres_conflicts"
            valueColumn: "conflicts"
            dimensionColumns: ["database"]
            isCumulative: true
          - metricName: "postgres_xact_commits"
            valueColumn: "xact_commit"
            dimensionColumns: ["database"]
            isCumulative: true
          - metricName: "postgres_xact_rollbacks"
            valueColumn: "xact_rollback"
            dimensionColumns: ["database"]
            isCumulative: true
```

Feel free to add more queries either for specific use cases or for generic purpose (please submit a PR in this case).

__Note__: if you master database is protected you will need to override `databases` with the list of readable databases
or monitor will fail to collect metrics.

__Warning__: the heartbeat detector works a little differently from other database modules because of its granularity.
Indeed, metrics are sent "per database" basis so this detector could raise alert for a deleted databse
in addition to the usual alert when the database server does not reponse anymore.
