# Spot Ocean aks np k8s Terraform Module

Spotinst Terraform Module to integrate existing k8s with Ocean

## Prerequisites

Installation of the Ocean controller is required by this resource. You can accomplish this by using the [spotinst/ocean-controller](https://registry.terraform.io/modules/spotinst/ocean-controller/spotinst) module. The kubernetes provider will need to be initilaized before calling the ocean-controller module as follows:

```hcl
provider "spotinst" {
  token   = "redacted"
  account = "redacted"
}

module "ocean-aks-np" {
  source  = "spotinst/ocean-aks-np-k8s/spotinst"
  ...
}
##################
## Option 1 to initialize kubernetes provider ##
provider "kubernetes" {
  config_path = "~/.kube/config"
}
##################

module "ocean-controller" {
  source = "spotinst/ocean-controller/spotinst"

  # Credentials.
  spotinst_token   = "redacted"
  spotinst_account = "redacted"

  # Configuration.
  cluster_identifier = "cluster name"
}
```

~> You must configure the same `cluster_identifier` both for the Ocean controller and for the `spotinst_ocean_aks_np` resource. The `ocean-aks-np` module will use the cluster name as the identifier. Ensure this is also used in the controller config

## Usage

```hcl
### Create Azure Ocean on spot console ###
module "ocean-aks-np" {
  source = "spotinst/ocean-aks-np-k8s/spotinst"
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
  autoscaler_resource_limits_max_vcpu      = 20000
  autoscaler_resource_limits_max_memory_gib= 100000
  autoscaler_max_scale_down_percentage     = 10
  autoscaler_headroom_automatic_is_enabled = true
  autoscaler_headroom_automatic_percentage = 5
  health_grace_period                      = 600
  max_pods_per_node                        = 110
  enable_node_public_ip                    = false
  os_disk_size_gb                          = 128
  os_disk_type                             = "Managed"
  os_type                                  = "Linux"
  node_min_count                           = 0
  node_max_count                           = 1000
  spot_percentage                          = 100
  fallback_to_ondemand                     = true
  availability_zones                       = [1, 2,]
  tags                                     = { "key1": "value1", "key2": "value2" }
  labels                                   = { "labelkey1": "labelvalue1","labelkey2": "labelvalue2"}
}
```

## Providers

| Name | Version |
|------|---------|
| spotinst/spotinst | >= 1.102.0 |

## Modules
* `ocean-aks-np-k8s` - Creates Ocean Cluster [Doc](https://registry.terraform.io/modules/spotinst/ocean-aks-np-k8s/spotinst/latest)
* `ocean-controller` - Create and installs Spot Ocean controller pod [Doc](https://registry.terraform.io/modules/spotinst/ocean-controller/spotinst/latest)
* `ocean-aws-k8s-vng` - (Optional) Add custom virtual node groups [Doc](https://registry.terraform.io/modules/spotinst/ocean-aks-np-k8s-vng/spotinst/latest)

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
