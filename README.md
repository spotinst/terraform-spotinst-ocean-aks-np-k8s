# [NAME] Terraform Module

Short description of the module.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Examples](#examples)
- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules)
- [Resources](#resources)
- [Inputs](#inputs)
- [Outputs](#outputs)
- [Documentation](#documentation)
- [Getting Help](#getting-help)
- [Community](#community)
- [Contributing](#contributing)
- [License](#license)

## Usage

```hcl
module "[NAME]" {
  source = "spotinst/[NAME]/spotinst"

  ...
}
```

## Examples

```hcl
### Create Azure Ocean on spot console ###
module "ocean-aks-np" {
  source = "../.."
  # Credentials.
  spotinst_token                          = var.spotinst_token
  spotinst_account                        = var.spotinst_account

  # Configuration
  ocean_cluster_name                       = "oceanClusterName"
  aks_region                               = "eastus"
  controller_cluster_id                    = "controllerId"
  aks_cluster_name                         = "aksClusterName"
  aks_infrastructure_resource_group_name   = "aksInfrastructureResourceGroupName"
  aks_resource_group_name                  = "resourceGroup"
  autoscaler_is_enabled                    = true
  autoscaler_resource_limits_max_vcpu      = 121
  autoscaler_resource_limits_max_memory_gib= 120
  autoscaler_max_scale_down_percentage     = 10
  autoscaler_headroom_automatic_is_enabled = true
  autoscaler_headroom_automatic_percentage  = 10
  health_grace_period                      = 300
  max_pods_per_node                        = 110
  enable_node_public_ip                    = false
  os_disk_size_gb                          = 128
  os_disk_type                             = "Managed"
  os_type                                  = "Linux"
  node_min_count                           = 10
  node_max_count                           = 100
  spot_percentage                          = 100
  fallback_to_ondemand                     = true
  availability_zones                       = [1, 2,]
  tags                                     = { "key1": "value1", "key2": "value2" }
  labels                                   = { "labelkey1": "labelvalue1","labelkey2": "labelvalue2"}
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Documentation

If you're new to [Spot](https://spot.io/) and want to get started, please checkout our [Getting Started](https://docs.spot.io/connect-your-cloud-provider/) guide, available on the [Spot Documentation](https://docs.spot.io/) website.

## Getting Help

We use GitHub issues for tracking bugs and feature requests. Please use these community resources for getting help:

- Ask a question on [Stack Overflow](https://stackoverflow.com/) and tag it with [terraform-spotinst](https://stackoverflow.com/questions/tagged/terraform-spotinst/).
- Join our [Spot](https://spot.io/) community on [Slack](http://slack.spot.io/).
- Open an issue.

## Community

- [Slack](http://slack.spot.io/)
- [Twitter](https://twitter.com/spot_hq/)

## Contributing

Please see the [contribution guidelines](.github/CONTRIBUTING.md).

## License

Code is licensed under the [Apache License 2.0](LICENSE).
