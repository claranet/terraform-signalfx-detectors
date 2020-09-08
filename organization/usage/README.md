## Notes

Could be used with related [dashboards](https://github.com/claranet/terraform-signalfx-dashboards/tree/master/organization/usage).

```hcl
module "signalfx-dashboards-organization-usage" {
  source = "github.com/claranet/terraform-signalfx-dashboards.git//organization/usage?ref=usage"

  default_org_name = "MyFavoriteOrg" # optional but recommended
}

module "signalfx-detectors-organization-usage" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//organization/usage?ref=usage"

  notifications = ["Email,billing@mycorp.net"]
}

```

