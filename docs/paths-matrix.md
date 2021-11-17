# Paths matrix

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->



<!-- END doctoc generated TOC please keep comment here to allow auto update -->

This is the table of correspondence of `source` terraform module from the:
- old path based on tree structure used by `v0.*.*` versions
- new path based on flat structure used by `v1+` versions

It is especially useful to upgrade from `v0.4.1` (the last "tree" based version) to `v1.0.0`
(the first "flat" based version).

| Old path                               | New path                                             |
| -------------------------------------- | ---------------------------------------------------- |
| //cloud/aws/alb                        | //modules/integration_aws-alb                        |
| //cloud/aws/apigateway                 | //modules/integration_aws-apigateway                 |
| //cloud/aws/beanstalk                  | //modules/integration_aws-beanstalk                  |
| //cloud/aws/ecs/cluster                | //modules/integration_aws-ecs-cluster                |
| //cloud/aws/ecs/service                | //modules/integration_aws-ecs-service                |
| //cloud/aws/elasticache/common         | //modules/integration_aws-elasticache-common         |
| //cloud/aws/elasticache/memcached      | //modules/integration_aws-elasticache-memcached      |
| //cloud/aws/elasticache/redis          | //modules/integration_aws-elasticache-redis          |
| //cloud/aws/elasticsearch              | //modules/integration_aws-elasticsearch              |
| //cloud/aws/elb                        | //modules/integration_aws-elb                        |
| //cloud/aws/kinesis-firehose           | //modules/integration_aws-kinesis-firehose           |
| //cloud/aws/lambda                     | //modules/integration_aws-lambda                     |
| //cloud/aws/nlb                        | //modules/integration_aws-nlb                        |
| //cloud/aws/rds/aurora/mysql           | //modules/integration_aws-rds-aurora-mysql           |
| //cloud/aws/rds/aurora/postgresql      | //modules/integration_aws-rds-aurora-postgresql      |
| //cloud/aws/rds/common                 | //modules/integration_aws-rds-common                 |
| //cloud/aws/sqs                        | //modules/integration_aws-sqs                        |
| //cloud/aws/vpn                        | //modules/integration_aws-vpn                        |
| //cloud/azure/application-gateway      | //modules/integration_azure-application-gateway      |
| //cloud/azure/app-service              | //modules/integration_azure-app-service              |
| //cloud/azure/app-service-plan         | //modules/integration_azure-app-service-plan         |
| //cloud/azure/azure-search             | //modules/integration_azure-azure-search             |
| //cloud/azure/cosmos-db                | //modules/integration_azure-cosmos-db                |
| //cloud/azure/functions                | //modules/integration_azure-functions                |
| //cloud/azure/key-vault                | //modules/integration_azure-key-vault                |
| //cloud/azure/load-balancer            | //modules/integration_azure-load-balancer            |
| //cloud/azure/mysql                    | //modules/integration_azure-mysql                    |
| //cloud/azure/postgresql               | //modules/integration_azure-postgresql               |
| //cloud/azure/redis                    | //modules/integration_azure-redis                    |
| //cloud/azure/service-bus              | //modules/integration_azure-service-bus              |
| //cloud/azure/sql-database             | //modules/integration_azure-sql-database             |
| //cloud/azure/sql-elastic-pool         | //modules/integration_azure-sql-elastic-pool         |
| //cloud/azure/storage-account-capacity | //modules/integration_azure-storage-account-capacity |
| //cloud/azure/stream-analytics         | //modules/integration_azure-stream-analytics         |
| //cloud/azure/virtual-machine          | //modules/integration_azure-virtual-machine          |
| //cloud/azure/virtual-machine-scaleset | //modules/integration_azure-virtual-machine-scaleset |
| //cloud/gcp/big-query                  | //modules/integration_gcp-bigquery                   |
| //cloud/gcp/cloud-sql/common           | //modules/integration_gcp-cloud-sql-common           |
| //cloud/gcp/cloud-sql/common/failover  | //modules/integration_gcp-cloud-sql-failover         |
| //cloud/gcp/cloud-sql/mysql            | //modules/integration_gcp-cloud-sql-mysql            |
| //cloud/gcp/gce/instance               | //modules/integration_gcp-compute-engine             |
| //cloud/gcp/lb                         | //modules/integration_gcp-load-balancing             |
| //cloud/gcp/pubsub/subscription        | //modules/integration_gcp-pubsub-subscription        |
| //cloud/gcp/pubsub/topic               | //modules/integration_gcp-pubsub-topic               |
| //saas/new-relic                       | //modules/integration_newrelic-apm                   |
| //organization/usage                   | //modules/organization_usage                         |
| //container/kubernetes/apiserver       | //modules/smart-agent_kubernetes-apiserver           |
| //container/kubernetes/common          | //modules/smart-agent_kubernetes-common              |
| //container/kubernetes/velero          | //modules/smart-agent_kubernetes-velero              |
| //container/kubernetes/volumes         | //modules/smart-agent_kubernetes-volumes             |
| //container/kubernetes/ingress/nginx   | //modules/smart-agent_nginx-ingress                  |
| //container/docker                     | //modules/smart-agent_docker                         |
| //network/http                         | //modules/smart-agent_http                           |
| //network/dns                          | //modules/smart-agent_dns                            |
| //system/processes                     | //modules/smart-agent_processes                      |
| //system/ntp                           | //modules/smart-agent_ntp                            |
| //system/nagios-status-check           | //modules/smart-agent_nagios-status-check            |
| //system/generic                       | //modules/smart-agent_system-common                  |
| //middleware/apache                    | //modules/smart-agent_apache                         |
| //database/cassandra                   | //modules/smart-agent_cassandra                      |
| //database/elasticsearch               | //modules/smart-agent_elasticsearch                  |
| //middleware/genericjmx                | //modules/smart-agent_genericjmx                     |
| //middleware/haproxy                   | //modules/smart-agent_haproxy                        |
| //middleware/kong                      | //modules/smart-agent_kong                           |
| //modules/memcached                    | //modules/smart-agent_memcached                      |
| //modules/database-mongo               | //modules/smart-agent_mongodb                        |
| //database/mysql                       | //modules/smart-agent_mysql                          |
| //middleware/nginx                     | //modules/smart-agent_nginx                          |
| //middleware/php-fpm                   | //modules/smart-agent_php-fpm                        |
| //database/postgresql                  | //modules/smart-agent_postgresql                     |
| //middleware/rabbitmq/node             | //modules/smart-agent_rabbitmq-node                  |
| //middleware/rabbitmq/queue            | //modules/smart-agent_rabbitmq-queue                 |
| //database/redis                       | //modules/smart-agent_redis                          |
| //database/solr                        | //modules/smart-agent_solr                           |
| //middleware/supervisor                | //modules/smart-agent_supervisor                     |
| //middleware/tomcat                    | //modules/smart-agent_tomcat                         |
| //middleware/varnish                   | //modules/smart-agent_varnish                        |
| //database/zookeeper                   | //modules/smart-agent_zookeeper                      |

Here is a bash script to update existing terraform configuration files from the old tree path to
the new flat and terraform registry compliant one:

```bash
while IFS= read -r line; do
  old=$(echo $line | cut -d '|' -f2 | xargs)
  new=$(echo $line | cut -d '|' -f3 | xargs)
  sed -i "s#${old}#${new}#g" $@
done < <(grep '//modules' matrix.md)
```

It loads the this table of correspondence and update file(s) provided in parameter.
