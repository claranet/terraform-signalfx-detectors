# Severity per detector

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [cwagent-ec2](#cwagent-ec2)
- [fame_azure-automation-updates](#fame_azure-automation-updates)
- [fame_azure-storage-file-backup](#fame_azure-storage-file-backup)
- [fame_azure-update-center](#fame_azure-update-center)
- [fame_azure-vm-backup](#fame_azure-vm-backup)
- [fame_azure-vpn](#fame_azure-vpn)
- [integration_aws-alb](#integration_aws-alb)
- [integration_aws-amazonmq-rabbitmq](#integration_aws-amazonmq-rabbitmq)
- [integration_aws-apigateway](#integration_aws-apigateway)
- [integration_aws-backup](#integration_aws-backup)
- [integration_aws-beanstalk](#integration_aws-beanstalk)
- [integration_aws-ecs-cluster](#integration_aws-ecs-cluster)
- [integration_aws-ecs-service](#integration_aws-ecs-service)
- [integration_aws-efs](#integration_aws-efs)
- [integration_aws-elasticache-common](#integration_aws-elasticache-common)
- [integration_aws-elasticache-memcached](#integration_aws-elasticache-memcached)
- [integration_aws-elasticache-redis](#integration_aws-elasticache-redis)
- [integration_aws-elasticsearch](#integration_aws-elasticsearch)
- [integration_aws-elb](#integration_aws-elb)
- [integration_aws-kinesis-firehose](#integration_aws-kinesis-firehose)
- [integration_aws-lambda](#integration_aws-lambda)
- [integration_aws-nlb](#integration_aws-nlb)
- [integration_aws-rds-aurora-mysql](#integration_aws-rds-aurora-mysql)
- [integration_aws-rds-aurora-postgresql](#integration_aws-rds-aurora-postgresql)
- [integration_aws-rds-common](#integration_aws-rds-common)
- [integration_aws-redshift](#integration_aws-redshift)
- [integration_aws-s3](#integration_aws-s3)
- [integration_aws-sqs](#integration_aws-sqs)
- [integration_aws-vpn](#integration_aws-vpn)
- [integration_azure-api-management-service](#integration_azure-api-management-service)
- [integration_azure-app-service-plan](#integration_azure-app-service-plan)
- [integration_azure-app-service](#integration_azure-app-service)
- [integration_azure-application-gateway](#integration_azure-application-gateway)
- [integration_azure-azure-search](#integration_azure-azure-search)
- [integration_azure-backup](#integration_azure-backup)
- [integration_azure-cdn](#integration_azure-cdn)
- [integration_azure-container-instance](#integration_azure-container-instance)
- [integration_azure-cosmos-db](#integration_azure-cosmos-db)
- [integration_azure-datafactory](#integration_azure-datafactory)
- [integration_azure-event-hub](#integration_azure-event-hub)
- [integration_azure-express-route](#integration_azure-express-route)
- [integration_azure-firewall](#integration_azure-firewall)
- [integration_azure-flexible-mysql](#integration_azure-flexible-mysql)
- [integration_azure-flexible-postgresql](#integration_azure-flexible-postgresql)
- [integration_azure-functions](#integration_azure-functions)
- [integration_azure-key-vault](#integration_azure-key-vault)
- [integration_azure-load-balancer](#integration_azure-load-balancer)
- [integration_azure-mariadb](#integration_azure-mariadb)
- [integration_azure-mysql](#integration_azure-mysql)
- [integration_azure-postgresql](#integration_azure-postgresql)
- [integration_azure-redis](#integration_azure-redis)
- [integration_azure-service-bus](#integration_azure-service-bus)
- [integration_azure-sql-database](#integration_azure-sql-database)
- [integration_azure-sql-elastic-pool](#integration_azure-sql-elastic-pool)
- [integration_azure-storage-account-blob](#integration_azure-storage-account-blob)
- [integration_azure-storage-account-capacity](#integration_azure-storage-account-capacity)
- [integration_azure-storage-account](#integration_azure-storage-account)
- [integration_azure-stream-analytics](#integration_azure-stream-analytics)
- [integration_azure-virtual-machine-scaleset](#integration_azure-virtual-machine-scaleset)
- [integration_azure-virtual-machine](#integration_azure-virtual-machine)
- [integration_gcp-bigquery](#integration_gcp-bigquery)
- [integration_gcp-cloud-sql-common](#integration_gcp-cloud-sql-common)
- [integration_gcp-cloud-sql-failover](#integration_gcp-cloud-sql-failover)
- [integration_gcp-cloud-sql-mysql](#integration_gcp-cloud-sql-mysql)
- [integration_gcp-compute-engine](#integration_gcp-compute-engine)
- [integration_gcp-load-balancing](#integration_gcp-load-balancing)
- [integration_gcp-memorystore-redis](#integration_gcp-memorystore-redis)
- [integration_gcp-pubsub-subscription](#integration_gcp-pubsub-subscription)
- [integration_gcp-pubsub-topic](#integration_gcp-pubsub-topic)
- [integration_newrelic-apm](#integration_newrelic-apm)
- [organization_usage](#organization_usage)
- [otel-collector_kubernetes-common](#otel-collector_kubernetes-common)
- [prometheus-exporter_active-directory](#prometheus-exporter_active-directory)
- [prometheus-exporter_docker-state](#prometheus-exporter_docker-state)
- [prometheus-exporter_kong](#prometheus-exporter_kong)
- [prometheus-exporter_oracledb](#prometheus-exporter_oracledb)
- [prometheus-exporter_squid](#prometheus-exporter_squid)
- [prometheus-exporter_varnish](#prometheus-exporter_varnish)
- [prometheus-exporter_wallix-bastion](#prometheus-exporter_wallix-bastion)
- [smart-agent_apache](#smart-agent_apache)
- [smart-agent_cassandra-nodetool](#smart-agent_cassandra-nodetool)
- [smart-agent_cassandra](#smart-agent_cassandra)
- [smart-agent_couchbase](#smart-agent_couchbase)
- [smart-agent_dns](#smart-agent_dns)
- [smart-agent_docker](#smart-agent_docker)
- [smart-agent_elasticsearch](#smart-agent_elasticsearch)
- [smart-agent_genericjmx](#smart-agent_genericjmx)
- [smart-agent_haproxy](#smart-agent_haproxy)
- [smart-agent_health-checker](#smart-agent_health-checker)
- [smart-agent_http](#smart-agent_http)
- [smart-agent_kubernetes-apiserver](#smart-agent_kubernetes-apiserver)
- [smart-agent_kubernetes-common](#smart-agent_kubernetes-common)
- [smart-agent_kubernetes-velero](#smart-agent_kubernetes-velero)
- [smart-agent_kubernetes-volumes](#smart-agent_kubernetes-volumes)
- [smart-agent_kubernetes-workloads-count](#smart-agent_kubernetes-workloads-count)
- [smart-agent_mdadm](#smart-agent_mdadm)
- [smart-agent_memcached](#smart-agent_memcached)
- [smart-agent_mongodb](#smart-agent_mongodb)
- [smart-agent_mysql](#smart-agent_mysql)
- [smart-agent_nagios-status-check](#smart-agent_nagios-status-check)
- [smart-agent_nginx-ingress](#smart-agent_nginx-ingress)
- [smart-agent_nginx](#smart-agent_nginx)
- [smart-agent_ntp](#smart-agent_ntp)
- [smart-agent_php-fpm](#smart-agent_php-fpm)
- [smart-agent_postgresql](#smart-agent_postgresql)
- [smart-agent_processes](#smart-agent_processes)
- [smart-agent_rabbitmq-node](#smart-agent_rabbitmq-node)
- [smart-agent_rabbitmq-queue](#smart-agent_rabbitmq-queue)
- [smart-agent_redis](#smart-agent_redis)
- [smart-agent_solr](#smart-agent_solr)
- [smart-agent_supervisor](#smart-agent_supervisor)
- [smart-agent_system-common](#smart-agent_system-common)
- [smart-agent_systemd-services](#smart-agent_systemd-services)
- [smart-agent_systemd-timers](#smart-agent_systemd-timers)
- [smart-agent_tomcat](#smart-agent_tomcat)
- [smart-agent_varnish](#smart-agent_varnish)
- [smart-agent_zookeeper](#smart-agent_zookeeper)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## cwagent-ec2

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS CWAgent heartbeat|X|-|-|-|-|
|AWS CWAgent memory used|X|X|-|-|-|
|AWS CWAgent disk used|X|X|-|-|-|
|AWS CWAgent cpu usage active|X|X|-|-|-|


## fame_azure-automation-updates

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Automation Update failed updates|-|X|-|-|-|
|Azure Automation Update missing updates|-|X|-|-|-|


## fame_azure-storage-file-backup

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Storage File backup success|X|-|-|-|-|


## fame_azure-update-center

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Update Center failed updates|-|X|-|-|-|
|Azure Update Center missing updates|-|X|-|-|-|


## fame_azure-vm-backup

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure VM backup success|X|-|-|-|-|


## fame_azure-vpn

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure VPN heartbeat|X|-|-|-|-|
|Azure VPN total flow count|X|-|-|-|-|


## integration_aws-alb

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS ALB heartbeat|X|-|-|-|-|
|AWS ALB target response time|X|X|-|-|-|
|AWS ALB 5xx error rate|X|X|-|-|-|
|AWS ALB 4xx error rate|X|X|X|-|-|
|AWS ALB target 5xx error rate|X|X|-|-|-|
|AWS ALB target 4xx error rate|X|X|X|-|-|
|AWS ALB healthy instances percentage|X|X|-|-|-|


## integration_aws-amazonmq-rabbitmq

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS AmazonMQ RabbitMQ messages ready|X|X|-|-|-|
|AWS AmazonMQ RabbitMQ messages unacknowledged|X|X|-|-|-|
|AWS AmazonMQ RabbitMQ messages ack rate|X|X|-|-|-|
|AWS AmazonMQ RabbitMQ memory used|X|X|-|-|-|
|AWS AmazonMQ RabbitMQ disk free|X|X|-|-|-|


## integration_aws-apigateway

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS APIGateway latency|X|X|-|-|-|
|AWS APIGateway http 5xx error rate|X|X|-|-|-|
|AWS APIGateway http 4xx error rate|X|X|X|-|-|


## integration_aws-backup

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS Backup failed|X|-|-|-|-|
|AWS Backup job expired|X|-|-|-|-|
|AWS Backup copy jobs failed|X|-|-|-|-|
|AWS Backup check jobs completed successfully|X|-|-|-|-|
|AWS Backup recovery point partial|-|-|X|-|-|
|AWS Backup recovery point expired|-|X|-|-|-|


## integration_aws-beanstalk

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS Beanstalk heartbeat|X|-|-|-|-|
|AWS Beanstalk environment health|X|X|-|-|-|
|AWS Beanstalk application latency p90|X|X|-|-|-|
|AWS Beanstalk application 5xx error rate|X|X|-|-|-|
|AWS Beanstalk instance root filesystem usage|X|X|-|-|-|


## integration_aws-ecs-cluster

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS ECS heartbeat|X|-|-|-|-|
|AWS ECS cluster CPU utilization|X|X|-|-|-|
|AWS ECS cluster memory utilization|X|X|-|-|-|


## integration_aws-ecs-service

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS ECS heartbeat|X|-|-|-|-|
|AWS ECS service CPU utilization|X|X|-|-|-|
|AWS ECS service memory utilization|X|X|-|-|-|


## integration_aws-efs

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS EFS used space|X|X|-|-|-|
|AWS EFS percent of io limit|-|X|X|-|-|
|AWS EFS percent of read throughput|-|-|X|X|-|
|AWS EFS percent of write throughput|-|-|X|X|-|
|AWS EFS percent of permitted throughput|-|X|X|-|-|
|AWS EFS burst credit balance|-|X|-|-|-|


## integration_aws-elasticache-common

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS ElastiCache heartbeat|X|-|-|-|-|
|AWS ElastiCache evictions|X|X|-|-|-|
|AWS ElastiCache connections over max allowed|X|-|-|-|-|
|AWS ElastiCache current connections|X|-|-|-|-|
|AWS ElastiCache swap usage|X|X|-|-|-|
|AWS ElastiCache freeable memory|-|X|X|-|-|
|AWS ElastiCache evictions changing rate grows|X|X|-|-|-|


## integration_aws-elasticache-memcached

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS Elasticache memcached cpu|X|X|-|-|-|
|AWS Elasticache memcached hit ratio|-|X|X|-|-|


## integration_aws-elasticache-redis

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS ElastiCache redis cache hit ratio|-|X|X|-|-|
|AWS ElastiCache redis cpu|X|X|-|-|-|
|AWS ElastiCache redis replication lag|X|X|-|-|-|
|AWS ElastiCache redis commands|-|X|-|-|-|
|AWS ElastiCache redis network conntrack allowance exceeded|X|-|-|-|-|


## integration_aws-elasticsearch

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS Elasticsearch heartbeat|X|-|-|-|-|
|AWS Elasticsearch jvm memory pressure|X|X|-|-|-|
|AWS Elasticsearch 4xx http response|X|X|-|-|-|
|AWS Elasticsearch 5xx http response|X|X|-|-|-|
|AWS Elasticsearch shard count|X|X|-|-|-|
|AWS Elasticsearch cluster status|X|X|-|-|-|
|AWS Elasticsearch free storage space|X|X|-|-|-|
|AWS Elasticsearch ultrawarm free storage space|X|X|-|-|-|
|AWS Elasticsearch cpu utilization|X|X|-|-|-|
|AWS Elasticsearch master cpu utilization|X|X|-|-|-|


## integration_aws-elb

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS ELB heartbeat|X|-|-|-|-|
|AWS ELB backend latency|X|X|-|-|-|
|AWS ELB 5xx error rate|X|X|-|-|-|
|AWS ELB 4xx error rate|X|X|X|-|-|
|AWS ELB backend 5xx error rate|X|X|-|-|-|
|AWS ELB backend 4xx error rate|X|X|X|-|-|
|AWS ELB healthy instances percentage|X|X|-|-|-|


## integration_aws-kinesis-firehose

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS Kinesis heartbeat|X|-|-|-|-|
|AWS Kinesis incoming records|X|X|-|-|-|


## integration_aws-lambda

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS Lambda errors percentage|X|X|-|-|-|
|AWS Lambda invocations throttled|X|X|-|-|-|
|AWS Lambda invocations|-|X|-|-|-|


## integration_aws-nlb

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS NLB heartbeat|X|-|-|-|-|
|AWS NLB healthy instances percentage|X|X|-|-|-|


## integration_aws-rds-aurora-mysql

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS RDS Aurora Mysql replica lag|X|X|-|-|-|


## integration_aws-rds-aurora-postgresql

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS RDS Aurora PostgreSQL replica lag|X|X|-|-|-|


## integration_aws-rds-common

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS RDS Common db load|X|X|-|-|-|
|AWS RDS heartbeat|X|-|-|-|-|
|AWS RDS instance CPU|X|X|-|-|-|
|AWS RDS instance free space|X|X|-|-|-|
|AWS RDS replica lag|X|X|-|-|-|


## integration_aws-redshift

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS Redshift heartbeat|X|-|-|-|-|
|AWS Redshift cpu usage|X|X|-|-|-|
|AWS Redshift storage usage|X|X|-|-|-|


## integration_aws-s3

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS S3 s3 errors and requests|X|X|-|-|-|


## integration_aws-sqs

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS SQS heartbeat|X|-|-|-|-|
|AWS SQS Visible messages|X|X|-|-|-|
|AWS SQS Age of the oldest message|X|X|-|-|-|


## integration_aws-vpn

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS VPN heartbeat|X|-|-|-|-|
|AWS VPN tunnel state|X|-|-|-|-|


## integration_azure-api-management-service

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure API Management Service heartbeat|X|-|-|-|-|
|Azure API Management Service capacity|X|X|-|-|-|
|Azure API Management Service duration of gateway request|X|X|-|-|-|
|Azure API Management Service duration of backend request|X|X|-|-|-|


## integration_azure-app-service-plan

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure App Service Plan heartbeat|X|-|-|-|-|
|Azure App Service Plan cpu|X|X|-|-|-|
|Azure App Service Plan memory|X|X|-|-|-|


## integration_azure-app-service

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure App Service heartbeat|X|-|-|-|-|
|Azure App Service response time|X|X|-|-|-|
|Azure App Service http 5xx error rate|-|X|X|-|-|
|Azure App Service http 4xx error rate|-|X|X|-|-|
|Azure App Service http success status rate|-|X|X|-|-|


## integration_azure-application-gateway

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Application Gateway heartbeat|X|-|-|-|-|
|Azure Application Gateway has no request|X|-|-|-|-|
|Azure Application Gateway backend connect time|X|X|-|-|-|
|Azure Application Gateway failed request rate|X|X|-|-|-|
|Azure Application Gateway backend unhealthy host ratio|X|X|-|-|-|
|Azure Application Gateway 4xx error rate|X|X|X|-|-|
|Azure Application Gateway 5xx error rate|X|X|-|-|-|
|Azure Application Gateway backend 4xx error rate|X|X|-|-|-|
|Azure Application Gateway backend 5xx error rate|X|X|-|-|-|
|Azure Application Gateway capacity units|-|X|-|-|-|


## integration_azure-azure-search

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Search latency|X|X|-|-|-|
|Azure Search throttled queries rate|X|X|-|-|-|


## integration_azure-backup

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Backup vm|X|X|-|-|-|
|Azure Backup file share|X|X|-|-|-|


## integration_azure-cdn

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure CDN latency|X|X|-|-|-|


## integration_azure-container-instance

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Container Instance heartbeat|X|-|-|-|-|


## integration_azure-cosmos-db

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Cosmos DB heartbeat|X|-|-|-|-|
|Azure Cosmos DB database 4xx request rate|X|X|-|-|-|
|Azure Cosmos DB database 5xx request rate|X|X|-|-|-|
|Azure Cosmos DB scaling|X|X|-|-|-|
|Azure Cosmos DB request units consumption|X|X|-|-|-|


## integration_azure-datafactory

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure DataFactory activity error rate|X|X|-|-|-|
|Azure DataFactory pipeline error rate|X|X|-|-|-|
|Azure DataFactory trigger error rate|X|X|-|-|-|
|Azure DataFactory available memory|X|X|-|-|-|
|Azure DataFactory cpu percentage|X|X|-|-|-|


## integration_azure-event-hub

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Event Hub throttled requests|X|X|-|X|-|


## integration_azure-express-route

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Express Route heartbeat|X|-|-|-|-|
|Azure Express Route bgp availability|X|X|-|X|-|
|Azure Express Route arp availability|X|X|-|X|-|


## integration_azure-firewall

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure firewall heartbeat|X|-|-|-|-|
|Azure firewall snat port utilization|X|X|-|-|-|
|Azure firewall throughput|X|X|X|X|-|
|Azure firewall health state|X|X|-|-|-|


## integration_azure-flexible-mysql

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure MySQL heartbeat|X|-|-|-|-|
|Azure MySQL cpu usage|X|X|-|-|-|
|Azure MySQL storage usage|X|X|-|-|-|
|Azure MySQL io consumption|X|X|-|-|-|
|Azure MySQL memory usage|X|X|-|-|-|
|Azure MySQL replication lag|X|X|-|-|-|


## integration_azure-flexible-postgresql

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure PostgreSQL flexible heartbeat|X|-|-|-|-|
|Azure PostgreSQL flexible cpu usage|X|X|-|-|-|
|Azure PostgreSQL flexible has no connection|X|-|-|-|-|
|Azure PostgreSQL flexible storage usage|X|X|-|-|-|
|Azure PostgreSQL flexible disk iops consumption|X|X|-|-|-|
|Azure PostgreSQL flexible memory usage|X|X|-|-|-|
|Azure PostgreSQL flexible replication lag|X|X|-|-|-|


## integration_azure-functions

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Functions heartbeat|X|-|-|-|-|
|Azure Functions HTTP 5xx error rate|X|X|-|-|-|
|Azure Functions connections count|X|X|-|-|-|
|Azure Functions thread count|X|X|-|-|-|
|Azure Functions wrapper errors|X|X|-|-|-|


## integration_azure-key-vault

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Key Vault api result rate|X|X|-|-|-|
|Azure Key Vault api latency|-|X|X|-|-|


## integration_azure-load-balancer

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Load Balancer heartbeat|X|-|-|-|-|


## integration_azure-mariadb

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure MariaDB heartbeat|X|-|-|-|-|
|Azure MariaDB cpu usage|X|X|-|-|-|
|Azure MariaDB storage usage|X|X|-|-|-|
|Azure MariaDB io consumption|X|X|-|-|-|
|Azure MariaDB memory usage|X|X|-|-|-|
|Azure MariaDB replication lag|X|X|-|-|-|


## integration_azure-mysql

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure MySQL heartbeat|X|-|-|-|-|
|Azure MySQL cpu usage|X|X|-|-|-|
|Azure MySQL storage usage|X|X|-|-|-|
|Azure MySQL io consumption|X|X|-|-|-|
|Azure MySQL memory usage|X|X|-|-|-|
|Azure MySQL replication lag|X|X|-|-|-|


## integration_azure-postgresql

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure PostgreSQL heartbeat|X|-|-|-|-|
|Azure PostgreSQL cpu usage|X|X|-|-|-|
|Azure PostgreSQL active connections|X|-|-|-|-|
|Azure PostgreSQL storage usage|X|X|-|-|-|
|Azure PostgreSQL io consumption|X|X|-|-|-|
|Azure PostgreSQL memory usage|X|X|-|-|-|
|Azure PostgreSQL serverlog storage usage|X|X|-|-|-|


## integration_azure-redis

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Redis heartbeat|X|-|-|-|-|
|Azure Redis evicted keys|X|X|-|-|-|
|Azure Redis processor time|X|X|-|-|-|
|Azure Redis load|X|X|-|-|-|


## integration_azure-service-bus

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Service Bus deadlettered messages count|X|X|-|-|-|
|Azure Service Bus heartbeat|X|-|-|-|-|
|Azure Service Bus no active connections|X|-|-|-|-|
|Azure Service Bus user error rate|X|X|-|-|-|
|Azure Service Bus server error rate|X|X|-|-|-|
|Azure Service Bus throttled requests rate|X|X|-|-|-|


## integration_azure-sql-database

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure SQL Database heartbeat|X|-|-|-|-|
|Azure SQL Database cpu|X|X|-|-|-|
|Azure SQL Database storage usage|X|X|-|-|-|
|Azure SQL Database deadlocks count|X|-|-|-|-|
|Azure SQL Database dtu consumption|X|X|-|-|-|


## integration_azure-sql-elastic-pool

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure SQL Elastic Pool heartbeat|X|-|-|-|-|
|Azure SQL Elastic Pool cpu|X|X|-|-|-|
|Azure SQL Elastic Pool storage usage|X|X|-|-|-|
|Azure SQL Elastic Pool dtu consumption|X|X|-|-|-|


## integration_azure-storage-account-blob

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Storage Account on Blob requests error rate|X|X|-|-|-|
|Azure Storage Account on Blob latency e2e|X|X|-|-|-|


## integration_azure-storage-account-capacity

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure storage account Used capacity|X|X|-|-|-|


## integration_azure-storage-account

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Storage Account count|X|X|-|-|-|
|Azure Storage Account capacity|X|X|-|-|-|
|Azure Storage Account ingress|X|X|-|-|-|
|Azure Storage Account egress|X|X|-|-|-|
|Azure Storage Account requests rate|X|X|-|-|-|


## integration_azure-stream-analytics

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Stream Analytics heartbeat|X|-|-|-|-|
|Azure Stream Analytics resource utilization|X|X|-|-|-|
|Azure Stream Analytics failed function requests rate|X|X|-|-|-|
|Azure Stream Analytics conversion errors rate|X|X|-|-|-|
|Azure Stream Analytics runtime errors rate|X|X|-|-|-|


## integration_azure-virtual-machine-scaleset

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Virtual Machine ScaleSet heartbeat|X|-|-|-|-|


## integration_azure-virtual-machine

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Virtual Machine heartbeat|X|-|-|-|-|
|Azure Virtual Machine cpu|X|X|-|-|-|
|Azure Virtual Machine remaining cpu credit|X|X|-|-|-|


## integration_gcp-bigquery

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|GCP BigQuery concurrent queries|X|X|-|-|-|
|GCP BigQuery execution time|X|X|-|-|-|
|GCP BigQuery scanned bytes|X|X|-|-|-|
|GCP BigQuery scanned bytes billed|X|X|-|-|-|
|GCP BigQuery available slots|X|X|-|-|-|
|GCP BigQuery stored bytes|X|X|-|-|-|
|GCP BigQuery table count|X|X|-|-|-|
|GCP BigQuery uploaded bytes|X|X|-|-|-|
|GCP BigQuery uploaded bytes billed|X|X|-|-|-|


## integration_gcp-cloud-sql-common

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|GCP Cloud SQL heartbeat|X|-|-|-|-|
|GCP Cloud SQL CPU utilization|X|X|-|-|-|
|GCP Cloud SQL disk utilization|X|X|-|-|-|
|GCP Cloud SQL disk space is running out|X|-|-|-|-|
|GCP Cloud SQL memory utilization|X|X|-|-|-|
|GCP Cloud SQL memory is running out|X|-|-|-|-|


## integration_gcp-cloud-sql-failover

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|GCP Cloud SQL failover|-|X|-|-|-|


## integration_gcp-cloud-sql-mysql

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|GCP Cloud SQL MySQL replication lag|X|X|-|-|-|


## integration_gcp-compute-engine

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|GCP GCE Instance heartbeat|X|-|-|-|-|
|GCP GCE Instance CPU utilization|X|X|-|-|-|
|GCP GCE Instance disk throttled bps|X|X|-|-|-|
|GCP GCE Instance disk throttled ops|X|X|-|-|-|


## integration_gcp-load-balancing

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|GCP Load Balancer 5xx error rate|X|X|-|-|-|
|GCP Load Balancer 4xx error rate|X|X|X|-|-|
|GCP Load Balancer backend latency per service|X|X|-|-|-|
|GCP Load Balancer backend latency per bucket|X|X|-|-|-|
|GCP Load Balancer request count|-|-|X|X|-|


## integration_gcp-memorystore-redis

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|GCP Memorystore Redis heartbeat|X|-|-|-|-|
|GCP Memorystore Redis blocked over connected clients ratio|X|X|-|-|-|
|GCP Memorystore Redis system memory usage|X|X|-|-|-|
|GCP Memorystore Redis memory usage|X|X|-|-|-|


## integration_gcp-pubsub-subscription

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|GCP Pub/Sub Subscription heartbeat|X|-|-|-|-|
|GCP Pub/Sub Subscription oldest unacknowledged message|X|X|-|-|-|
|GCP Pub/Sub Subscription latency on push endpoint|X|X|-|-|-|


## integration_gcp-pubsub-topic

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|GCP Pub/Sub Topic sending messages operations|-|X|-|-|-|
|GCP Pub/Sub Topic sending unavailable messages|X|X|-|-|-|
|GCP Pub/Sub Topic sending unavailable messages ratio|X|X|-|-|-|


## integration_newrelic-apm

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|New Relic heartbeat|-|X|-|-|-|
|New Relic error rate|X|X|-|-|-|
|New Relic apdex score ratio|X|X|-|-|-|


## organization_usage

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Organization usage hosts limit|-|X|-|-|-|
|Organization usage containers limit|-|X|-|-|-|
|Organization usage custom metrics limit|-|X|-|-|-|
|Organization usage containers ratio per host included|-|X|-|-|-|
|Organization usage custom metrics ratio per host included|-|X|-|-|-|


## otel-collector_kubernetes-common

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Kubernetes heartbeat|X|-|-|-|-|
|Kubernetes hpa scale exceeded capacity|-|X|-|-|-|
|Kubernetes node status|-|X|X|-|-|
|Kubernetes pod phase status|-|X|X|X|-|
|Kubernetes pod terminated abnormally|-|X|-|-|-|
|Kubernetes container killed by oom|-|X|-|-|-|
|Kubernetes deployment in crashloopbackoff|-|X|-|-|-|
|Kubernetes daemonset in crashloopbackoff|-|X|-|-|-|
|Kubernetes job from cronjob failed|-|X|-|-|-|
|Kubernetes daemonsets scheduled|X|-|-|-|-|
|Kubernetes daemonsets ready|X|-|-|-|-|
|Kubernetes daemonsets misscheduled|X|-|-|-|-|
|Kubernetes deployments available|X|-|-|-|-|
|Kubernetes replicasets available|X|-|-|-|-|
|Kubernetes replication controllers available|X|-|-|-|-|
|Kubernetes statefulsets ready|X|-|-|-|-|


## prometheus-exporter_active-directory

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Active-directory heartbeat|X|-|-|-|-|
|Active-directory replication errors|X|X|-|-|-|
|Active-directory active directory services|X|-|-|-|-|


## prometheus-exporter_docker-state

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Docker-state heartbeat|X|-|-|-|-|
|Docker-state state health status|X|-|-|-|-|
|Docker-state state status|X|-|-|-|-|
|Docker-state state oom killed|X|-|-|-|-|


## prometheus-exporter_kong

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Kong heartbeat|X|-|-|-|-|
|Kong treatment limit|X|X|-|-|-|


## prometheus-exporter_oracledb

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Oracle heartbeat|X|-|-|-|-|
|Oracle database status|X|-|-|-|-|


## prometheus-exporter_squid

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Squid heartbeat|X|-|-|-|-|
|Squid status|X|-|-|-|-|
|Squid server errors ratio|X|X|-|-|-|
|Squid total amount of requests|X|-|-|-|-|


## prometheus-exporter_varnish

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Varnish heartbeat|X|-|-|-|-|
|Varnish backend failed|X|-|-|-|-|
|Varnish thread number|X|-|-|-|-|
|Varnish dropped sessions|X|-|-|-|-|
|Varnish hit rate|-|X|X|-|-|
|Varnish memory usage|X|X|-|-|-|


## prometheus-exporter_wallix-bastion

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Wallix-bastion heartbeat|X|-|-|-|-|
|Wallix-bastion status|X|-|-|-|-|
|Wallix-bastion total number of current sessions|-|X|X|-|-|
|Wallix-bastion encryption status|X|-|-|-|-|
|Wallix-bastion license|X|-|-|-|-|


## smart-agent_apache

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Apache heartbeat|X|-|-|-|-|
|Apache busy workers|X|X|-|-|-|


## smart-agent_cassandra-nodetool

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Cassandra nodetool node status|X|-|X|-|-|
|Cassandra nodetool node state|X|-|-|-|-|


## smart-agent_cassandra

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Cassandra heartbeat|X|-|-|-|-|
|Cassandra read latency 99th percentile|X|X|-|-|-|
|Cassandra write latency 99th percentile|X|X|-|-|-|
|Cassandra read latency real time|X|X|-|-|-|
|Cassandra write latency real time|X|X|-|-|-|
|Cassandra transactional read latency 99th percentile|X|X|-|-|-|
|Cassandra transactional write latency 99th percentile|X|X|-|-|-|
|Cassandra transactional read latency real time|X|X|-|-|-|
|Cassandra transactional write latency real time|X|X|-|-|-|
|Cassandra storage exceptions count|-|X|-|-|-|


## smart-agent_couchbase

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Couchbase heartbeat|X|-|-|-|-|
|Couchbase memory used|X|X|-|-|-|
|Couchbase out of memory errors|X|-|-|-|-|
|Couchbase disk write queue|X|X|-|-|-|


## smart-agent_dns

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|DNS heartbeat|X|-|-|-|-|
|DNS query time|X|X|-|-|-|
|DNS query result|X|-|-|-|-|


## smart-agent_docker

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Docker host heartbeat|X|-|-|-|-|
|Docker container usage of cpu host|-|X|X|-|-|
|Docker container cpu throttling time|-|X|X|-|-|
|Docker memory usage|-|X|X|-|-|


## smart-agent_elasticsearch

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Elasticsearch heartbeat|X|-|-|-|-|
|ElasticSearch cluster status|X|X|-|-|-|
|ElasticSearch cluster initializing shards|X|X|-|-|-|
|ElasticSearch cluster relocating shards|X|X|-|-|-|
|ElasticSearch cluster unassigned shards|X|X|-|-|-|
|ElasticSearch cluster pending tasks|X|X|-|-|-|
|ElasticSearch cpu usage|X|X|-|-|-|
|ElasticSearch file descriptors usage|X|X|-|-|-|
|ElasticSearch jvm heap memory usage|X|X|-|-|-|
|ElasticSearch jvm memory young usage|-|X|X|-|-|
|ElasticSearch jvm memory old usage|-|X|X|-|-|
|ElasticSearch old-generation garbage collections latency|-|X|X|-|-|
|ElasticSearch young-generation garbage collections latency|-|X|X|-|-|
|ElasticSearch indexing latency|-|X|X|-|-|
|ElasticSearch index flushing to disk latency|-|X|X|-|-|
|ElasticSearch search query latency|-|X|X|-|-|
|ElasticSearch search fetch latency|-|X|X|-|-|
|ElasticSearch fielddata cache evictions rate of change|-|X|X|-|-|
|ElasticSearch max time spent by task in queue rate of change|-|X|X|-|-|


## smart-agent_genericjmx

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Genericjmx heartbeat|X|-|-|-|-|
|Genericjmx memory heap|X|X|-|-|-|
|Genericjmx gc old gen|X|X|-|-|-|


## smart-agent_haproxy

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Haproxy heartbeat|X|-|-|-|-|
|Haproxy server status|X|-|-|-|-|
|Haproxy backend status|X|-|-|-|-|
|Haproxy session|X|X|-|-|-|
|Haproxy 5xx response rate|X|X|-|-|-|
|Haproxy 4xx response rate|X|X|X|-|-|


## smart-agent_health-checker

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Health-checker value|X|-|-|-|-|
|Health-checker status|X|-|-|-|-|


## smart-agent_http

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|HTTP heartbeat|X|-|-|-|-|
|HTTP code|X|-|-|-|-|
|HTTP regex expression|X|-|-|-|-|
|HTTP response time|X|X|-|-|-|
|HTTP content length|-|-|-|X|-|
|TLS certificate expiry date|-|X|X|-|-|
|TLS certificate|X|-|-|-|-|


## smart-agent_kubernetes-apiserver

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Kubernetes API server heartbeat|X|-|-|-|-|


## smart-agent_kubernetes-common

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Kubernetes heartbeat|X|-|-|-|-|
|Kubernetes hpa scale exceeded capacity|-|X|-|-|-|
|Kubernetes node status|-|X|X|-|-|
|Kubernetes pod phase status|-|X|X|X|-|
|Kubernetes pod terminated abnormally|-|X|-|-|-|
|Kubernetes container killed by oom|-|X|-|-|-|
|Kubernetes deployment in crashloopbackoff|-|X|-|-|-|
|Kubernetes daemonset in crashloopbackoff|-|X|-|-|-|
|Kubernetes job from cronjob failed|-|X|-|-|-|
|Kubernetes daemonsets scheduled|X|-|-|-|-|
|Kubernetes daemonsets ready|X|-|-|-|-|
|Kubernetes daemonsets misscheduled|X|-|-|-|-|
|Kubernetes deployments available|X|-|-|-|-|
|Kubernetes replicasets available|X|-|-|-|-|
|Kubernetes replication controllers available|X|-|-|-|-|
|Kubernetes statefulsets ready|X|-|-|-|-|


## smart-agent_kubernetes-velero

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Kubernetes velero successful backup|-|X|-|-|-|
|Kubernetes velero failed backup|-|X|-|-|-|
|Kubernetes velero failed partial backup|-|X|-|-|-|
|Kubernetes velero failed backup deletion|-|X|-|-|-|
|Kubernetes velero failed volume snapshot|-|X|-|-|-|


## smart-agent_kubernetes-volumes

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Kubernetes node volume space usage|X|X|-|-|-|
|Kubernetes node volume inodes usage|X|X|-|-|-|


## smart-agent_kubernetes-workloads-count

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Kubernetes workloads count|-|-|X|X|-|


## smart-agent_mdadm

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Mdadm disk failed|X|X|-|-|-|
|Mdadm disk missing|X|X|-|-|-|


## smart-agent_memcached

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Memcached heartbeat|X|-|-|-|-|
|Memcached max conn|X|X|-|-|-|
|Memcached hit ratio|-|X|X|-|-|


## smart-agent_mongodb

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|MongoDB heartbeat|X|-|-|-|-|
|MongoDB page faults|-|-|-|X|-|
|MongoDB number of connections over max capacity|X|X|-|-|-|
|MongoDB asserts (warning and regular) errors|-|-|X|-|-|
|MongoDB primary in replicaset|X|-|-|-|-|
|MongoDB secondary members count in replicaset|X|-|-|-|-|
|MongoDB replication lag|X|X|-|-|-|


## smart-agent_mysql

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|MySQL heartbeat|X|-|-|-|-|
|MySQL number of connections over max capacity|X|X|-|-|-|
|MySQL slow queries percentage|X|X|-|-|-|
|MySQL Innodb buffer pool efficiency|-|-|X|X|-|
|MySQL Innodb buffer pool utilization|-|-|X|X|-|
|MySQL running threads changed abruptly|X|-|-|-|-|
|MySQL running queries changed abruptly|X|-|-|-|-|
|MySQL replication lag|X|X|-|-|-|
|MySQL slave sql status|X|-|-|-|-|
|MySQL slave io status|X|-|-|-|-|


## smart-agent_nagios-status-check

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Nagios status check|X|X|-|X|-|


## smart-agent_nginx-ingress

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Ingress Nginx latency|X|X|-|-|-|
|Ingress Nginx 5xx errors ratio|X|X|-|-|-|
|Ingress Nginx 4xx errors ratio|X|X|X|-|-|


## smart-agent_nginx

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Nginx heartbeat|X|-|-|-|-|
|Nginx dropped connections|X|X|-|-|-|


## smart-agent_ntp

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|NTP heartbeat|X|-|-|-|-|
|NTP offset|-|X|-|-|-|


## smart-agent_php-fpm

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|PHP-FPM heartbeat|X|-|-|-|-|
|PHP-FPM busy workers|X|X|-|-|-|


## smart-agent_postgresql

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|PostgreSQL heartbeat|X|-|-|-|-|
|PostgreSQL deadlocks|-|X|X|-|-|
|PostgreSQL hit ratio|-|-|X|X|-|
|PostgreSQL rollbacks ratio compared to commits|-|X|X|-|-|
|PostgreSQL conflicts|-|X|X|-|-|
|PostgreSQL number of connections compared to max|X|X|-|-|-|
|PostgreSQL replication lag|X|X|-|-|-|
|PostgreSQL replication state|X|-|-|-|-|


## smart-agent_processes

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Processes aliveness count|X|X|-|-|-|


## smart-agent_rabbitmq-node

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|RabbitMQ heartbeat|X|-|-|-|-|
|RabbitMQ Node file descriptors usage|X|X|-|-|-|
|RabbitMQ Node process usage|X|X|-|-|-|
|RabbitMQ Node sockets usage|X|X|-|-|-|
|RabbitMQ Node vm_memory usage|X|X|-|-|-|


## smart-agent_rabbitmq-queue

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|RabbitMQ Queue messages ready|X|X|-|-|-|
|RabbitMQ Queue messages unacknowledged|X|X|-|-|-|
|RabbitMQ Queue messages ack rate|X|X|-|-|-|
|RabbitMQ Queue consumer use|X|X|-|-|-|


## smart-agent_redis

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Redis heartbeat|X|-|-|-|-|
|Redis evicted keys change rate|X|X|-|-|-|
|Redis expired keys change rate|X|X|-|-|-|
|Redis blocked over connected clients ratio|X|X|-|-|-|
|Redis stored keys change rate|-|X|-|-|-|
|Redis percentage memory used over max memory set|X|X|-|-|-|
|Redis percentage memory used over system memory|X|X|-|-|-|
|Redis high memory fragmentation ratio|X|X|-|-|-|
|Redis low memory fragmentation ratio|X|X|-|-|-|
|Redis rejected connections|X|X|-|-|-|
|Redis hitrate|X|X|X|-|-|


## smart-agent_solr

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Apache Solr heartbeat|X|-|-|-|-|
|Apache Solr errors count|X|X|-|-|-|
|Apache Solr searcher warmup time|X|X|-|-|-|


## smart-agent_supervisor

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Supervisor heartbeat|X|-|-|-|-|
|Supervisor process|X|X|-|-|-|


## smart-agent_system-common

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|System heartbeat|X|-|-|-|-|
|System cpu utilization|X|X|-|-|-|
|System load 5m ratio|X|X|-|-|-|
|System disk space utilization|X|X|-|-|-|
|System filesystem inodes utilization|X|X|-|-|-|
|System disk inodes utilization|X|X|-|-|-|
|System memory utilization|X|X|-|-|-|
|System swap in/out|X|X|-|-|-|
|System disk space running out|-|X|-|-|-|


## smart-agent_systemd-services

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Systemd-services aliveness|X|-|-|-|-|


## smart-agent_systemd-timers

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Systemd-timers heartbeat|-|-|X|-|-|
|Systemd-timers execution delay|-|X|-|-|-|
|Systemd-timers last execution state|-|X|-|-|-|


## smart-agent_tomcat

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Tomcat heartbeat|X|-|-|-|-|
|Tomcat average processing time|X|X|-|-|-|
|Tomcat busy threads percentage|X|X|-|-|-|


## smart-agent_varnish

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Varnish heartbeat|X|-|-|-|-|
|Varnish backend Failed|X|-|-|-|-|
|Varnish threads number|X|-|-|-|-|
|Varnish session dropped|X|-|-|-|-|
|Varnish hit rate|-|X|X|-|-|
|Varnish memory usage|X|X|-|-|-|


## smart-agent_zookeeper

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Zookeeper heartbeat|X|-|-|-|-|
|Zookeeper service health|X|-|-|-|-|
|Zookeeper latency|X|X|-|-|-|
|Zookeeper file descriptors usage|X|X|-|-|-|


