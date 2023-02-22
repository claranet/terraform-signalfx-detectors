# AZURE-FRONTDOOR-V2 SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [What are the available detectors in this module?](#what-are-the-available-detectors-in-this-module)
- [How to collect required metrics?](#how-to-collect-required-metrics)
  - [Pre-requisites FAME queries](#pre-requisites-fame-queries)
  - [Metrics](#metrics)
- [Related documentation](#related-documentation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## How to use this module?

This directory defines a [Terraform](https://www.terraform.io/)
[module](https://www.terraform.io/language/modules/syntax) you can use in your
existing [stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) by adding a
`module` configuration and setting its `source` parameter to URL of this folder:

```hcl
module "signalfx-detectors-fame-azure-frontdoor-v2" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/fame_azure-frontdoor-v2?ref={revision}"

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

These 3 parameters alongs with all variables defined in [common-variables.tf](common-variables.tf) are common to all
[modules](../) in this repository. Other variables, specific to this module, are available in
[variables.tf](variables.tf) and [variables-gen.tf](variables-gen.tf).
In general, the default configuration "works" but all of these Terraform
[variables](https://www.terraform.io/language/values/variables) make it possible to
customize the detectors behavior to better fit your needs.

Most of them represent usual tips and rules detailled in the
[guidance](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance) documentation and listed in the
common [variables](https://github.com/claranet/terraform-signalfx-detectors/wiki/Variables) dedicated documentation.

Feel free to explore the [wiki](https://github.com/claranet/terraform-signalfx-detectors/wiki) for more information about
general usage of this repository.

## What are the available detectors in this module?

This module creates the following SignalFx detectors which could contain one or multiple alerting rules:

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Azure FrontDoor v2 heartbeat|X|-|-|-|-|
|Azure FrontDoor v2 http errors|X|X|-|-|-|
|Azure FrontDoor v2 probes errors|X|X|-|-|-|
|Azure FrontDoor v2 cache hit rate|-|-|-|X|-|
|Azure FrontDoor v2 waf actions|-|-|-|X|-|

## How to collect required metrics?

This module deploys detectors using metrics reported by the
the [Function for Azure Monitoring Extension](https://github.com/claranet/fame), an Azure Function App written in Python by Claranet
which allows to run Log Analytics queries and send result to Splunk Observability as metrics.

More information available in the [dedicated readme](https://github.com/claranet/fame/blob/master/README.md).


Check the [Related documentation](#related-documentation) section for more detailed and specific information about this module dependencies.

This module uses the [Sudden Change](https://github.com/signalfx/signalflow-library/tree/master/library/signalfx/detectors/against_recent) functions for the **waf actions** detector.  

The detectors of this module uses metrics from the [FAME](https://github.com/claranet/fame) tool for Azure.  
Check its documentation to install and configure it appropriately.

The Azure Front Door Premium/Standard resource is not yet integrated with the Azure SFX integration.  
You will find the FAME queries used by this module below.

### Pre-requisites FAME queries

Here are the must have FAME queries for your Front Door v2 resources: 

```hcl
resource "azurerm_storage_table_entity" "query_fd_response_status" {
  storage_account_name = [FAME_storage_account_name]
  table_name           = [FAME_storage_queries_table_name]

  partition_key = "LogQuery"
  row_key       = "frontdoor_response_status"
  entity = {
    MetricName : "fame.azure.frontdoor.response_status"
    MetricType : "gauge"
    Query : <<EOQ
        AzureDiagnostics
        | where ResourceProvider == "MICROSOFT.CDN"
        | where Category == "FrontDoorAccessLog"
        | where TimeGenerated > ago(20m)
        | summarize metric_value=count() by timestamp=bin(TimeGenerated, 1m), http_status_code=tostring(toint(httpStatusCode_d)), azure_resource_name=Resource, azure_resource_group_name=ResourceGroup, subscription_id=SubscriptionId
        | order by timestamp desc
      EOQ
  }
}

resource "azurerm_storage_table_entity" "query_fd_probe_response_status" {
  storage_account_name = [FAME_storage_account_name]
  table_name           = [FAME_storage_queries_table_name]

  partition_key = "LogQuery"
  row_key       = "frontdoor_probe_response_status"
  entity = {
    MetricName : "fame.azure.frontdoor.probe_response_status"
    MetricType : "gauge"
    Query : <<EOQ
        AzureDiagnostics
        | where ResourceProvider == "MICROSOFT.CDN"
        | where Category == "FrontDoorHealthProbeLog"
        | where TimeGenerated > ago(20m)
        | summarize metric_value=count() by timestamp=bin(TimeGenerated, 1m), result=(result_s), http_status_code=tostring(toint(httpStatusCode_d)), origin_name=(originName_s),azure_resource_name=Resource, azure_resource_group_name=ResourceGroup, subscription_id=SubscriptionId
        | order by timestamp desc
      EOQ
  }
}

resource "azurerm_storage_table_entity" "query_fd_waf_actions" {
  storage_account_name = [FAME_storage_account_name]
  table_name           = [FAME_storage_queries_table_name]

  partition_key = "LogQuery"
  row_key       = "frontdoor_waf_actions"
  entity = {
    MetricName : "fame.azure.frontdoor.waf_actions"
    MetricType : "gauge"
    Query : <<EOQ
        AzureDiagnostics
        | where ResourceProvider == "MICROSOFT.CDN"
        | where Category == "FrontDoorWebApplicationFirewallLog"
        | where TimeGenerated > ago(20m)
        | summarize metric_value=count() by timestamp=bin(TimeGenerated, 1m), action=tolower(action_s), policy=(policy_s), host=(host_s), azure_resource_name=Resource, azure_resource_group_name=ResourceGroup, subscription_id=SubscriptionId
        | order by timestamp desc
      EOQ
  }
}

resource "azurerm_storage_table_entity" "query_fd_cache_hit_rate" {
  storage_account_name = [FAME_storage_account_name]
  table_name           = [FAME_storage_queries_table_name]

  partition_key = "LogQuery"
  row_key       = "frontdoor_cache_hit_rate"
  entity = {
    MetricName : "fame.azure.frontdoor.cache_hit_rate"
    MetricType : "gauge"
    Query : <<EOQ
        AzureDiagnostics 
        | where Category == "FrontDoorAccessLog"
        | where TimeGenerated > ago(20m)
        | summarize metric_value = tostring(todouble(countif(cacheStatus_s == "HIT" or cacheStatus_s == "REMOTE_HIT")) / count() * 100) by timestamp=bin(TimeGenerated, 1m), endpoint=endpoint_s, azure_resource_name=Resource, azure_resource_group_name=ResourceGroup, subscription_id=SubscriptionId
        | order by timestamp desc
      EOQ
  }
}
```

Without them you will not be able to have your metrics and detectors working.

### Metrics


Here is the list of required metrics for detectors in this module.

* `fame.azure.frontdoor.cache_hit_rate`
* `fame.azure.frontdoor.probe_response_status`
* `fame.azure.frontdoor.response_status`
* `fame.azure.frontdoor.waf_actions`




## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Splunk Observability integrations](https://docs.splunk.com/Observability/gdi/get-data-in/integrations.html)
* [Azure Monitor Metrics](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported)
* [Azure Front Door Standard/Premium logs and metrics](https://docs.microsoft.com/en-us/azure/frontdoor/standard-premium/how-to-monitor-metrics)
* [FAME - Function for Azure Monitoring Extension](https://github.com/claranet/fame)
* [Sudden Change SFX functions](https://github.com/signalfx/signalflow-library/tree/master/library/signalfx/detectors/against_recent)
