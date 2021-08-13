# Severity per detector

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [aws-alb](#aws-alb)
- [aws-apigateway](#aws-apigateway)
- [aws-beanstalk](#aws-beanstalk)
- [aws-ecs-cluster](#aws-ecs-cluster)
- [aws-ecs-service](#aws-ecs-service)
- [aws-efs](#aws-efs)
- [aws-elasticache-common](#aws-elasticache-common)
- [aws-elasticache-memcached](#aws-elasticache-memcached)
- [aws-elasticache-redis](#aws-elasticache-redis)
- [aws-elasticsearch](#aws-elasticsearch)
- [aws-elb](#aws-elb)
- [aws-kinesis-firehose](#aws-kinesis-firehose)
- [aws-lambda](#aws-lambda)
- [aws-nlb](#aws-nlb)
- [aws-rds-aurora-mysql](#aws-rds-aurora-mysql)
- [aws-rds-aurora-postgresql](#aws-rds-aurora-postgresql)
- [aws-rds-common](#aws-rds-common)
- [aws-sqs](#aws-sqs)
- [aws-vpn](#aws-vpn)
- [azure-api-management-service](#azure-api-management-service)
- [azure-app-service-plan](#azure-app-service-plan)
- [azure-app-service](#azure-app-service)
- [azure-application-gateway](#azure-application-gateway)
- [azure-azure-search](#azure-azure-search)
- [azure-container-instance](#azure-container-instance)
- [azure-cosmos-db](#azure-cosmos-db)
- [azure-datafactory](#azure-datafactory)
- [azure-event-hub](#azure-event-hub)
- [azure-firewall](#azure-firewall)
- [azure-functions](#azure-functions)
- [azure-key-vault](#azure-key-vault)
- [azure-load-balancer](#azure-load-balancer)
- [azure-mysql](#azure-mysql)
- [azure-postgresql](#azure-postgresql)
- [azure-redis](#azure-redis)
- [azure-service-bus](#azure-service-bus)
- [azure-sql-database](#azure-sql-database)
- [azure-sql-elastic-pool](#azure-sql-elastic-pool)
- [azure-storage-account-blob](#azure-storage-account-blob)
- [azure-storage-account-capacity](#azure-storage-account-capacity)
- [azure-storage-account](#azure-storage-account)
- [azure-stream-analytics](#azure-stream-analytics)
- [azure-virtual-machine-scaleset](#azure-virtual-machine-scaleset)
- [azure-virtual-machine](#azure-virtual-machine)
- [gcp-bigquery](#gcp-bigquery)
- [gcp-cloud-sql-common](#gcp-cloud-sql-common)
- [gcp-cloud-sql-failover](#gcp-cloud-sql-failover)
- [gcp-cloud-sql-mysql](#gcp-cloud-sql-mysql)
- [gcp-compute-engine](#gcp-compute-engine)
- [gcp-load-balancing](#gcp-load-balancing)
- [gcp-pubsub-subscription](#gcp-pubsub-subscription)
- [gcp-pubsub-topic](#gcp-pubsub-topic)
- [newrelic-apm](#newrelic-apm)
- [usage](#usage)
- [apache](#apache)
- [cassandra-nodetool](#cassandra-nodetool)
- [cassandra](#cassandra)
- [couchbase](#couchbase)
- [dns](#dns)
- [docker](#docker)
- [elasticsearch](#elasticsearch)
- [genericjmx](#genericjmx)
- [haproxy](#haproxy)
- [health-checker](#health-checker)
- [http](#http)
- [kong](#kong)
- [kubernetes-apiserver](#kubernetes-apiserver)
- [kubernetes-common](#kubernetes-common)
- [kubernetes-velero](#kubernetes-velero)
- [kubernetes-volumes](#kubernetes-volumes)
- [kubernetes-workloads-count](#kubernetes-workloads-count)
- [mdadm](#mdadm)
- [memcached](#memcached)
- [mongodb](#mongodb)
- [mysql](#mysql)
- [nagios-status-check](#nagios-status-check)
- [nginx-ingress](#nginx-ingress)
- [nginx](#nginx)
- [ntp](#ntp)
- [php-fpm](#php-fpm)
- [postgresql](#postgresql)
- [processes](#processes)
- [rabbitmq-node](#rabbitmq-node)
- [rabbitmq-queue](#rabbitmq-queue)
- [redis](#redis)
- [solr](#solr)
- [supervisor](#supervisor)
- [system-common](#system-common)
- [systemd-services](#systemd-services)
- [tomcat](#tomcat)
- [varnish](#varnish)
- [zookeeper](#zookeeper)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## aws-alb

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS ALB heartbeat|X|-|-|-|-|
|AWS ALB target response time|X|X|-|-|-|
|AWS ALB 5xx error rate|X|X|-|-|-|
|AWS ALB 4xx error rate|X|X|-|-|-|
|AWS ALB target 5xx error rate|X|X|-|-|-|
|AWS ALB target 4xx error rate|X|X|-|-|-|
|AWS ALB healthy instances percentage|X|X|-|-|-|


## aws-apigateway

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS ApiGateway latency|X|X|-|-|-|
|AWS ApiGateway HTTP 5xx error rate|X|X|-|-|-|
|AWS ApiGateway HTTP 4xx error rate|X|X|-|-|-|


## aws-beanstalk

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS Beanstalk heartbeat|X|-|-|-|-|
|AWS Beanstalk environment health|X|X|-|-|-|
|AWS Beanstalk application latency p90|X|X|-|-|-|
|AWS Beanstalk application 5xx error rate|X|X|-|-|-|
|AWS Beanstalk instance root filesystem usage|X|X|-|-|-|


## aws-ecs-cluster

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS ECS heartbeat|X|-|-|-|-|
|AWS ECS cluster CPU utilization|X|X|-|-|-|
|AWS ECS cluster memory utilization|X|X|-|-|-|


## aws-ecs-service

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS ECS heartbeat|X|-|-|-|-|
|AWS ECS service CPU utilization|X|X|-|-|-|
|AWS ECS service memory utilization|X|X|-|-|-|


## aws-efs

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS EFS used space|X|X|-|-|-|
|AWS EFS percent of io limit|-|X|X|-|-|
|AWS EFS percent of read throughput|-|-|X|X|-|
|AWS EFS percent of write throughput|-|-|X|X|-|
|AWS EFS percent of permitted throughput|-|X|X|-|-|
|AWS EFS burst credit balance|-|X|-|-|-|


## aws-elasticache-common

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS ElastiCache heartbeat|X|-|-|-|-|
|AWS ElastiCache evictions|X|X|-|-|-|
|AWS ElastiCache connections over max allowed|X|-|-|-|-|
|AWS ElastiCache current connections|X|-|-|-|-|
|AWS ElastiCache swap|X|X|-|-|-|
|AWS ElastiCache freeable memory|-|X|X|-|-|
|AWS ElastiCache evictions changing rate grows|X|X|-|-|-|


## aws-elasticache-memcached

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS ElastiCache memcached hit ratio|X|X|-|-|-|
|AWS ElastiCache memcached CPU|X|X|-|-|-|


## aws-elasticache-redis

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS ElastiCache redis cache hit ratio|X|X|-|-|-|
|AWS ElastiCache redis CPU|X|X|-|-|-|
|AWS ElastiCache redis replication lag|X|X|-|-|-|
|AWS ElastiCache redis commands|X|X|-|-|-|


## aws-elasticsearch

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS ElasticSearch heartbeat|X|-|-|-|-|
|AWS ElasticSearch cluster status|X|X|-|-|-|
|AWS ElasticSearch cluster free storage space|X|X|-|-|-|
|AWS ElasticSearch cluster CPU|X|X|-|-|-|


## aws-elb

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS ELB heartbeat|X|-|-|-|-|
|AWS ELB backend latency|X|X|-|-|-|
|AWS ELB 5xx error rate|X|X|-|-|-|
|AWS ELB 4xx error rate|X|X|-|-|-|
|AWS ELB backend 5xx error rate|X|X|-|-|-|
|AWS ELB backend 4xx error rate|X|X|-|-|-|
|AWS ELB healthy instances percentage|X|X|-|-|-|


## aws-kinesis-firehose

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS Kinesis heartbeat|X|-|-|-|-|
|AWS Kinesis incoming records|X|X|-|-|-|


## aws-lambda

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS Lambda errors rate|X|X|-|-|-|
|AWS Lambda invocations throttled|X|X|-|-|-|
|AWS Lambda invocations|-|X|-|-|-|


## aws-nlb

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS NLB heartbeat|X|-|-|-|-|
|AWS NLB healthy instances percentage|X|X|-|-|-|


## aws-rds-aurora-mysql

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS RDS Aurora Mysql replica lag|X|X|-|-|-|


## aws-rds-aurora-postgresql

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS RDS Aurora PostgreSQL replica lag|X|X|-|-|-|


## aws-rds-common

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS RDS heartbeat|X|-|-|-|-|
|AWS RDS instance CPU|X|X|-|-|-|
|AWS RDS instance free space|X|X|-|-|-|
|AWS RDS replica lag|X|X|-|-|-|


## aws-sqs

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS SQS heartbeat|X|-|-|-|-|
|AWS SQS Visible messages|X|X|-|-|-|
|AWS SQS Age of the oldest message|X|X|-|-|-|


## aws-vpn

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|AWS VPN heartbeat|X|-|-|-|-|
|AWS VPN tunnel state|X|-|-|-|-|


## azure-api-management-service

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure API Management Service Heartbeat|X|-|-|-|-|
|Azure API Management Service Capacity|X|X|-|-|-|
|Azure API Management Service Duration of gateway request|X|X|-|-|-|
|Azure API Management Service Duration of backend request|X|X|-|-|-|


## azure-app-service-plan

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure App Service Plan heartbeat|X|-|-|-|-|
|Azure App Service Plan CPU percentage|X|X|-|-|-|
|Azure App Service Plan memory percentage|X|X|-|-|-|


## azure-app-service

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure App Service heartbeat|X|-|-|-|-|
|Azure App Service response time|X|X|-|-|-|
|Azure App Service memory usage|X|X|-|-|-|
|Azure App Service 5xx error rate|X|X|-|-|-|
|Azure App Service 4xx error rate|X|X|-|-|-|
|Azure App Service successful response rate|X|X|-|-|-|


## azure-application-gateway

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Application Gateway heartbeat|X|-|-|-|-|
|Azure Application Gateway has no request|X|-|-|-|-|
|Azure Application Gateway backend connect time|X|X|-|-|-|
|Azure Application Gateway failed request rate|X|X|-|-|-|
|Azure Application Gateway backend unhealthy host ratio|X|X|-|-|-|
|Azure Application Gateway 4xx error rate|X|X|-|-|-|
|Azure Application Gateway 5xx error rate|X|X|-|-|-|
|Azure Application Gateway backend 4xx error rate|X|X|-|-|-|
|Azure Application Gateway backend 5xx error rate|X|X|-|-|-|
|Azure Application Gateway capacity units|-|X|-|-|-|


## azure-azure-search

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Search latency|X|X|-|-|-|
|Azure Search throttled queries rate|X|X|-|-|-|


## azure-container-instance

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Container Instance heartbeat|X|-|-|-|-|


## azure-cosmos-db

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Cosmos DB heartbeat|X|-|-|-|-|
|Azure Cosmos DB 4xx request rate|X|X|-|-|-|
|Azure Cosmos DB 5xx error rate|X|X|-|-|-|
|Azure Cosmos DB scaling errors rate|X|X|-|-|-|
|Azure Cosmos DB used RUs capacity|X|X|-|-|-|


## azure-datafactory

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure DataFactory activity error rate|X|X|-|-|-|
|Azure DataFactory pipeline error rate|X|X|-|-|-|
|Azure DataFactory trigger error rate|X|X|-|-|-|
|Azure DataFactory available memory|X|X|-|-|-|
|Azure DataFactory cpu percentage|X|X|-|-|-|


## azure-event-hub

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Event Hub throttled requests|X|X|-|X|-|


## azure-firewall

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure firewall heartbeat|X|-|-|-|-|
|Azure firewall snat port utilization|X|X|-|-|-|
|Azure firewall throughput|X|X|X|X|-|
|Azure firewall health state|X|X|-|-|-|


## azure-functions

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Functions heartbeat|X|-|-|-|-|
|Azure Functions HTTP 5xx error rate|X|X|-|-|-|
|Azure Functions connections count|X|X|-|-|-|
|Azure Functions thread count|X|X|-|-|-|
|Azure Functions wrapper errors|X|X|-|-|-|


## azure-key-vault

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Key Vault API result rate|X|X|-|-|-|
|Azure Key Vault API latency|X|X|-|-|-|


## azure-load-balancer

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Load balancer heartbeat|X|-|-|-|-|


## azure-mysql

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure MySQL heartbeat|X|-|-|-|-|
|Azure MySQL CPU usage|X|X|-|-|-|
|Azure MySQL storage usage|X|X|-|-|-|
|Azure MySQL IO consumption|X|X|-|-|-|
|Azure MySQL memory usage|X|X|-|-|-|
|Azure MySQL replication lag|X|X|-|-|-|


## azure-postgresql

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure PostgreSQL heartbeat|X|-|-|-|-|
|Azure PostgreSQL CPU usage|X|X|-|-|-|
|Azure PostgreSQL has no connection|X|-|-|-|-|
|Azure PostgreSQL storage usage|X|X|-|-|-|
|Azure PostgreSQL IO consumption|X|X|-|-|-|
|Azure PostgreSQL memory usage |X|X|-|-|-|
||X|X|-|-|-|


## azure-redis

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Redis heartbeat|X|-|-|-|-|
|Azure Redis evicted keys|X|X|-|-|-|
|Azure Redis processor time|X|X|-|-|-|
|Azure Redis load|X|X|-|-|-|


## azure-service-bus

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Service Bus heartbeat|X|-|-|-|-|
|Azure Service Bus no active connections|X|-|-|-|-|
|Azure Service Bus user error rate|X|X|-|-|-|
|Azure Service Bus server error rate|X|X|-|-|-|
|Azure Service Bus throttled requests rate|X|X|-|-|-|


## azure-sql-database

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure SQL Database heartbeat|X|-|-|-|-|
|Azure Sql Database CPU|X|X|-|-|-|
|Azure SQL Database disk usage|X|X|-|-|-|
|Azure SQL Database DTU consumption|X|X|-|-|-|
|Azure SQL Database deadlocks count|X|-|-|-|-|


## azure-sql-elastic-pool

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure SQL Elastic Pool heartbeat|X|-|-|-|-|
|Azure SQL Elastic Pool CPU|X|X|-|-|-|
|Azure SQL Elastic Pool disk usage|X|X|-|-|-|
|Azure SQL Elastic Pool DTU consumption|X|X|-|-|-|


## azure-storage-account-blob

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Storage Account on Blob requests error rate|X|X|-|-|-|
|Azure Storage Account on Blob latency e2e|X|X|-|-|-|


## azure-storage-account-capacity

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure storage account Used capacity|X|X|-|-|-|


## azure-storage-account

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Storage Account count|X|X|-|-|-|
|Azure Storage Account capacity|X|X|-|-|-|
|Azure Storage Account ingress|X|X|-|-|-|
|Azure Storage Account egress|X|X|-|-|-|
|Azure Storage Account requests rate|X|X|-|-|-|


## azure-stream-analytics

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Stream Analytics heartbeat|X|-|-|-|-|
|Azure Stream Analytics resource utilization|X|X|-|-|-|
|Azure Stream Analytics failed function requests rate|X|X|-|-|-|
|Azure Stream Analytics conversion errors rate|X|X|-|-|-|
|Azure Stream Analytics runtime errors rate|X|X|-|-|-|


## azure-virtual-machine-scaleset

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Virtual Machine ScaleSet heartbeat|X|-|-|-|-|


## azure-virtual-machine

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure Virtual Machine heartbeat|X|-|-|-|-|
|Azure Virtual Machine CPU usage|X|X|-|-|-|
|Azure Virtual Machine remaining CPU credit|X|X|-|-|-|


## gcp-bigquery

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


## gcp-cloud-sql-common

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|GCP Cloud SQL heartbeat|X|-|-|-|-|
|GCP Cloud SQL CPU utilization|X|X|-|-|-|
|GCP Cloud SQL disk utilization|X|X|-|-|-|
|GCP Cloud SQL disk space is running out|X|-|-|-|-|
|GCP Cloud SQL memory utilization|X|X|-|-|-|
|GCP Cloud SQL memory is running out|X|-|-|-|-|


## gcp-cloud-sql-failover

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|GCP Cloud SQL failover|-|X|-|-|-|


## gcp-cloud-sql-mysql

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|GCP Cloud SQL MySQL replication lag|X|X|-|-|-|


## gcp-compute-engine

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|GCP GCE Instance heartbeat|X|-|-|-|-|
|GCP GCE Instance CPU utilization|X|X|-|-|-|
|GCP GCE Instance disk throttled bps|X|X|-|-|-|
|GCP GCE Instance disk throttled ops|X|X|-|-|-|


## gcp-load-balancing

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|GCP Load Balancer 4xx error rate|X|X|-|-|-|
|GCP Load Balancer 5xx error rate|X|X|-|-|-|
|GCP Load Balancer backend latency by service|X|X|-|-|-|
|GCP Load Balancer backend latency by bucket|X|X|-|-|-|
|GCP Load Balancer request count|-|X|-|-|-|


## gcp-pubsub-subscription

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|GCP Pub/Sub Subscription heartbeat|X|-|-|-|-|
|GCP Pub/Sub Subscription oldest unacknowledged message|X|X|-|-|-|
|GCP Pub/Sub Subscription latency on push endpoint|X|X|-|-|-|


## gcp-pubsub-topic

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|GCP Pub/Sub Topic sending messages operations|-|X|-|-|-|
|GCP Pub/Sub Topic sending unavailable messages|X|X|-|-|-|
|GCP Pub/Sub Topic sending unavailable messages ratio|X|X|-|-|-|


## newrelic-apm

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|New Relic heartbeat|-|X|-|-|-|
|New Relic error rate|X|X|-|-|-|
|New Relic apdex score ratio|X|X|-|-|-|


## usage

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Organization usage hosts limit|-|X|-|-|-|
|Organization usage containers limit|-|X|-|-|-|
|Organization usage custom metrics limit|-|X|-|-|-|
|Organization usage containers ratio per host included|-|X|-|-|-|
|Organization usage custom metrics ratio per host included|-|X|-|-|-|


## apache

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Apache heartbeat|X|-|-|-|-|
|Apache busy workers|X|X|-|-|-|


## cassandra-nodetool

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Cassandra nodetool node status|X|-|X|-|-|
|Cassandra nodetool node state|X|-|-|-|-|


## cassandra

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


## couchbase

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Couchbase memory used|X|X|-|-|-|
|Couchbase out of memory errors|X|-|-|-|-|
|Couchbase disk write queue|X|X|-|-|-|


## dns

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|DNS heartbeat|X|-|-|-|-|
|DNS query time|X|X|-|-|-|
|DNS query result|X|-|-|-|-|


## docker

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Docker host heartbeat|X|-|-|-|-|
|Docker container usage of cpu host|-|X|X|-|-|
|Docker container cpu throttling time|-|X|X|-|-|
|Docker memory usage|-|X|X|-|-|


## elasticsearch

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|ElasticSearch heartbeat|X|-|-|-|-|
|ElasticSearch cluster status|X|X|-|-|-|
|ElasticSearch cluster initializing shards|X|X|-|-|-|
|ElasticSearch cluster relocating shards|X|X|-|-|-|
|ElasticSearch Cluster unassigned shards|X|X|-|-|-|
|ElasticSearch Pending tasks|X|X|-|-|-|
|Elasticsearch CPU usage|X|X|-|-|-|
|Elasticsearch file descriptors usage|X|X|-|-|-|
|Elasticsearch JVM heap memory usage|X|X|-|-|-|
|Elasticsearch JVM memory young usage|-|X|X|-|-|
|Elasticsearch JVM memory old usage|-|X|X|-|-|
|Elasticsearch old-generation garbage collections latency|-|X|X|-|-|
|Elasticsearch young-generation garbage collections latency|-|X|X|-|-|
|Elasticsearch indexing latency|-|X|X|-|-|
|Elasticsearch index flushing to disk latency|-|X|X|-|-|
|Elasticsearch search query latency|-|X|X|-|-|
|Elasticsearch search fetch latency|-|X|X|-|-|
|Elasticsearch fielddata cache evictions rate of change|-|X|X|-|-|
|Elasticsearch max time spent by task in queue rate of change|-|X|X|-|-|


## genericjmx

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|JMX memory heap usage|X|X|-|-|-|
|JMX GC old generation usage|X|X|-|-|-|


## haproxy

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Haproxy heartbeat|X|-|-|-|-|
|Haproxy server status|X|-|-|-|-|
|Haproxy backend status|X|-|-|-|-|
|Haproxy session|X|X|-|-|-|
|Haproxy 5xx response rate|X|X|-|-|-|
|Haproxy 4xx response rate|X|X|-|-|-|


## health-checker

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Health-checker value|X|-|-|-|-|
|Health-checker status|X|-|-|-|-|


## http

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|HTTP heartbeat|X|-|-|-|-|
|HTTP code|X|-|-|-|-|
|HTTP regex expression|X|-|-|-|-|
|HTTP response time|X|X|-|-|-|
|HTTP content length|-|-|-|X|-|
|TLS certificate expiry date|-|X|X|-|-|
|TLS certificate|X|-|-|-|-|


## kong

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Kong heartbeat|X|-|-|-|-|
|Kong treatment limit|X|X|-|-|-|


## kubernetes-apiserver

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Kubernetes API server heartbeat|X|-|-|-|-|


## kubernetes-common

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Kubernetes hpa scale exceeded capacity|-|X|-|-|-|
|Kubernetes node heartbeat|X|-|-|-|-|
|Kubernetes node status|-|X|X|-|-|
|Kubernetes pod status phase|-|X|-|-|-|
|Kubernetes pod terminated abnormally|-|X|-|-|-|
|Kubernetes container killed by OOM|-|X|-|-|-|
|Kubernetes deployment in CrashLoopBackOff|-|X|-|-|-|
|Kubernetes daemonset in CrashLoopBackOff|-|X|-|-|-|
|Kubernetes job from cronjob failed|-|X|-|-|-|
|Kubernetes daemonsets not scheduled|X|-|-|-|-|
|Kubernetes daemonsets not ready|X|-|-|-|-|
|Kubernetes daemonsets misscheduled|X|-|-|-|-|
|Kubernetes deployments available|X|-|-|-|-|
|Kubernetes replicasets available|X|-|-|-|-|
|Kubernetes replication_controllers available|X|-|-|-|-|
|Kubernetes statefulsets ready|X|-|-|-|-|


## kubernetes-velero

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Kubernetes velero successful backup|-|X|-|-|-|
|Kubernetes velero failed backup|-|X|-|-|-|
|Kubernetes velero failed partial backup|-|X|-|-|-|
|Kubernetes velero failed backup deletion|-|X|-|-|-|
|Kubernetes velero failed volume snapshot|-|X|-|-|-|


## kubernetes-volumes

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Kubernetes node volume space usage|X|X|-|-|-|
|Kubernetes node volume inodes usage|X|X|-|-|-|


## kubernetes-workloads-count

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Kubernetes workloads count|-|-|X|X|-|


## mdadm

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Mdadm disk failed|X|X|-|-|-|
|Mdadm disk missing|X|X|-|-|-|


## memcached

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Memcached heartbeat|X|-|-|-|-|
|Memcached max conn|X|X|-|-|-|
|Memcached hit ratio|-|X|X|-|-|


## mongodb

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|MongoDB heartbeat|X|-|-|-|-|
|MongoDB page faults|-|-|-|X|-|
|MongoDB number of connections over max capacity|X|X|-|-|-|
|MongoDB asserts (warning and regular) errors|-|-|X|-|-|
|MongoDB primary in replicaset|X|-|-|-|-|
|MongoDB secondary members count in replicaset|X|-|-|-|-|
|MongoDB replication lag|X|X|-|-|-|


## mysql

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
|MySQL slave sql status|X|-|-|-|-|


## nagios-status-check

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Nagios check status|X|X|-|X|-|


## nginx-ingress

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Kubernetes Ingress Nginx 5xx errors ratio|X|X|-|-|-|
|Kubernetes Ingress Nginx 4xx errors ratio|X|X|-|-|-|
|Kubernetes Ingress Nginx latency|X|X|-|-|-|


## nginx

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Nginx heartbeat|X|-|-|-|-|
|Nginx dropped connections|X|X|-|-|-|


## ntp

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|NTP heartbeat|X|-|-|-|-|
|NTP offset|-|X|-|-|-|


## php-fpm

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|PHP-FPM heartbeat|X|-|-|-|-|
|PHP-FPM busy workers|X|X|-|-|-|


## postgresql

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


## processes

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Processes aliveness|X|X|-|-|-|


## rabbitmq-node

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|RabbitMQ heartbeat|X|-|-|-|-|
|RabbitMQ Node file descriptors usage|X|X|-|-|-|
|RabbitMQ Node process usage|X|X|-|-|-|
|RabbitMQ Node sockets usage|X|X|-|-|-|
|RabbitMQ Node vm_memory usage|X|X|-|-|-|


## rabbitmq-queue

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|RabbitMQ Queue messages ready|X|X|-|-|-|
|RabbitMQ Queue messages unacknowledged|X|X|-|-|-|
|RabbitMQ Queue messages ack rate|X|X|-|-|-|
|RabbitMQ Queue consumer use|X|X|-|-|-|


## redis

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Redis heartbeat|X|-|-|-|-|
|Redis evicted keys rate of change|X|X|-|-|-|
|Redis expired keys rate of change|X|X|-|-|-|
|Redis blocked client rate|-|-|X|X|-|
|Redis keyspace seems full|-|X|-|-|-|
|Redis memory used over max memory (if configured)|X|X|-|-|-|
|Redis memory used over total system memory|X|X|-|-|-|
|Redis memory fragmentation ratio (excessive fragmentation)|X|X|-|-|-|
|Redis memory fragmentation ratio (missing memory)|X|X|-|-|-|
|Redis rejected connections (maxclient reached)|X|X|-|-|-|
|Redis hitrate|X|X|-|-|-|


## solr

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Apache Solr heartbeat|X|-|-|-|-|
|Apache Solr errors count|X|X|-|-|-|
|Apache Solr searcher warmup time|X|X|-|-|-|


## supervisor

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Supervisor heartbeat|X|-|-|-|-|
|Supervisor process|X|X|-|-|-|


## system-common

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|System heartbeat|X|-|-|-|-|
|System cpu utilization|X|X|-|-|-|
|System load 5m ratio|X|X|-|-|-|
|System disk space utilization|X|X|-|-|-|
|System disk inodes utilization|X|X|-|-|-|
|System memory utilization|X|X|-|-|-|
|System disk space running out|-|X|-|-|-|


## systemd-services

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Systemd-services aliveness|X|-|-|-|-|


## tomcat

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Tomcat heartbeat|X|-|-|-|-|
|Tomcat average processing time|X|X|-|-|-|
|Tomcat busy threads percentage|X|X|-|-|-|


## varnish

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Varnish heartbeat|X|-|-|-|-|
|Varnish backend Failed|X|-|-|-|-|
|Varnish threads number|X|-|-|-|-|
|Varnish session dropped|X|-|-|-|-|
|Varnish hit rate|-|X|X|-|-|
|Varnish memory usage|X|X|-|-|-|


## zookeeper

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Zookeeper heartbeat|X|-|-|-|-|
|Zookeeper service health|X|-|-|-|-|
|Zookeeper latency|X|X|-|-|-|
|Zookeeper file descriptors usage|X|X|-|-|-|


