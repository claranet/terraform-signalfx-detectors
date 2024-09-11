# GCP-CLOUD-RUN SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [What are the available detectors in this module?](#what-are-the-available-detectors-in-this-module)
- [How to collect required metrics?](#how-to-collect-required-metrics)
  - [Metrics](#metrics)
- [Notes](#notes)
  - [Metadata configuration for default filtering](#metadata-configuration-for-default-filtering)
  - [CPU utilizations](#cpu-utilizations)
  - [Memory utilizations](#memory-utilizations)
  - [Connection refused to cloud sql](#connection-refused-to-cloud-sql)
  - [Error 5xx](#error-5xx)
- [Related documentation](#related-documentation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## How to use this module?

This directory defines a [Terraform](https://www.terraform.io/)
[module](https://www.terraform.io/language/modules/syntax) you can use in your
existing [stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) by adding a
`module` configuration and setting its `source` parameter to URL of this folder:

```hcl
module "signalfx-detectors-integration-gcp-cloud-run" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/integration_gcp-cloud-run?ref={revision}"

  environment    = var.environment
  notifications  = local.notifications
  gcp_project_id = "fillme"
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
|GCP Cloud Run cpu utilizations|X|X|-|-|-|
|GCP Cloud Run memory utilizations|X|X|-|-|-|
|GCP Cloud Run cloudsql connections refused to requests ratio|X|X|-|-|-|

## How to collect required metrics?

This module deploys detectors using metrics reported by the
[GCP integration](https://docs.splunk.com/observability/en/gdi/get-data-in/connect/gcp/gcp-metrics.html) configurable
with [this Terraform module](https://github.com/claranet/terraform-signalfx-integrations/tree/master/cloud/gcp).


Check the [Related documentation](#related-documentation) section for more detailed and specific information about this module dependencies.



### Metrics


Here is the list of required metrics for detectors in this module.

* `container/cpu/utilizations`
* `infrastructure/cloudsql/connection_refused_count`
* `infrastructure/cloudsql/connection_request_count`


## Notes


### Metadata configuration for default filtering

label to use : 

sfx_env = true
sfx_monitored = true

For example:

via gcloud, at the Cloud Run level:
```
gcloud run deploy hello \
--image=us-docker.pkg.dev/cloudrun/container/hello \
--allow-unauthenticated \
--port=8080 \
--service-account=123456789-compute@developer.gserviceaccount.com \
--region=europe-west9 \
--project=claranet-425413 \
--labels=sfx_env=true,sfx_monitored=true
```
via terraform, [at the Cloud Run level](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service#nested_metadata)
```hcl
resource "google_cloud_run_service" "hello" {
  name     = "hello"
  location = "europe-west9"

  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
        resources {
          limits = {
            cpu    = "1000m"  // adjust based on your needs
            memory = "512Mi"  // adjust based on your needs
          }
        }
        ports {
          name           = "http1"   // This name is a standard identifier (http1 or h2c) for the protocol
          container_port = 8080      
        }
      }
      service_account_name = "123456789-compute@developer.gserviceaccount.com"
    }

    metadata {
      annotations = {
        "run.googleapis.com/launch-stage" = "BETA"  // adjust this according to the launch stage of your application
      }
      labels = {
        sfx_env       = "true"
        sfx_monitored = "true"
      }
    }
  }
  autogenerate_revision_name = true

  traffic {
    percent         = 100
    latest_revision = true
  }

  project = "claranet-425413"
}
```
You also **need** to check if those metadata are in the metadata `includeList` in your [SignalFx GCP
integration](https://dev.splunk.com/observability/docs/integrations/gcp_integration_overview/#Optional-fields).

### CPU utilizations 

Monitoring the CPU utilization helps in understanding the system's capability and efficiency.

```hcl
module "signalfx-detectors-integration_gcp-cloud-run" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/integration_gcp-cloud-run"

  environment    = var.environment
  gcp_project_id = var.project_id
  notifications  = local.notifications

  # We keep default filtering policy here, we just want to append additional filter to it
  filtering_append = true
  # We define the additional filter
  filtering_custom = "filter('service_name', '*service-name*')"
  # We can configure the thresholds of the probes
  cpu_usage_threshold_critical = 85
  cpu_usage_threshold_major    = 80
}
```

### Memory utilizations

Accurate tracking of memory usage aids in optimizing and improving performance.

```hcl                                                                                                                                                                                                                                                                                                              
module "signalfx-detectors-integration_gcp-cloud-run" {                                                                                                                                                                                                                                                             
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/integration_gcp-cloud-run"                                                                                                                                                                                                                
                                                                                                                                                                                                                                                                                                                    
  environment    = var.environment                                                                                                                                                                                                                                                                                  
  gcp_project_id = var.project_id                                                                                                                                                                                                                                                                                   
  notifications  = local.notifications                                                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                                                                                    
  # We keep default filtering policy here, we just want to append additional filter to it                                                                                                                                                                                                                           
  filtering_append = true                                                                                                                                                                                                                                                                                           
  # We define the additional filter                                                                                                                                                                                                                                             
  filtering_custom = "filter('service_name', '*service-name*')"                                                                                                                                                                                                                                                     
  # We can configure the thresholds of the probes
  memory_usage_threshold_critical = 85                                                                                                                                                                                                                                                                                 
  memory_usage_threshold_major    = 80                                                                                                                                                                                                                                                                                 
}                                                                                                                                                                                                                                                                                                                   
```

### Connection refused to cloud sql

Keeping track of this ratio is crucial in ensuring smooth and maintained service.

```hcl                                                                                                                                                                                                                                                                                                               
module "signalfx-detectors-integration_gcp-cloud-run" {                                                                                                                                                                                                                                                             
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/integration_gcp-cloud-run"                                                                                                                                                                                                                
                                                                                                                                                                                                                                                                                                                    
  environment    = var.environment                                                                                                                                                                                                                                                                                  
  gcp_project_id = var.project_id                                                                                                                                                                                                                                                                                   
  notifications  = local.notifications                                                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                                                                                    
  # We keep default filtering policy here, we just want to append additional filter to it                                                                                                                                                                                                                           
  filtering_append = true                                                                                                                                                                                                                                                                                           
  # We define the additional filter
  filtering_custom = "filter('service_name', '*service-name*')"                                                                                                                                                                                                                                                     
  # We can configure the thresholds of the probes
  connection_refused_to_sql_ratio_threshold_critical = 85                                                                                                                                                                                                                                                                              
  connection_refused_to_sql_ratio_threshold_major    = 80                                                                                                                                                                                                                                                                              
}                                                                                                                                                                                                                                                                                                                   
```
### Error 5xx

Monitoring server-side errors to track and rectify system issues.

```hcl                                                                                                                                                                                                                                                                                                              
module "signalfx-detectors-integration_gcp-cloud-run" {                                                                                                                                                                                                                                                             
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/integration_gcp-cloud-run"                                                                                                                                                                                                                
                                                                                                                                                                                                                                                                                                                    
  environment    = var.environment                                                                                                                                                                                                                                                                                  
  gcp_project_id = var.project_id                                                                                                                                                                                                                                                                                   
  notifications  = local.notifications                                                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                                                                                    
  # We keep default filtering policy here, we just want to append additional filter to it                                                                                                                                                                                                                           
  filtering_append = true                                                                                                                                                                                                                                                                                           
  # We define the additional filter
  filtering_custom = "filter('service_name', '*service-name*')"                                                                                                                                                                                                                                                     
  # We can configure the thresholds of the probes                                                                                                                                                                                                                                      
  error_rate_5xx_threshold_critical = 10                                                                                                                                                                                                                                                           
  error_rate_5xx_threshold_major    = 80                                                                                                                                                                                                                                                           
}                                                                                                                                                                                                                                                                                                                   
```


## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Splunk Observability integrations](https://docs.splunk.com/Observability/gdi/get-data-in/integrations.html)
* [Stackdriver metrics for Memorystore for Redis](https://cloud.google.com/monitoring/api/metrics_gcp#gcp-run)
* [Splunk Observability metrics](https://docs.splunk.com/observability/en/gdi/get-data-in/connect/gcp/gcp.html)
