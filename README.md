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
  ocean_cluster_name                       = "test"
  aks_region                               = "eastus"
  controller_cluster_id                    = "test-123124"
  aks_cluster_name                         = "test-cluster"
  aks_infrastructure_resource_group_name   = "MC_TestResourceGroup_test-cluster_eastus"
  aks_resource_group_name                  = "TestResourceGroup"
  autoscaler_is_enabled                    = true
  autoscaler_resource_limits_max_vcpu      = 750
  autoscaler_resource_limits_max_memory_gib= 1500
  autoscaler_max_scale_down_percentage     = 30
  autoscaler_headroom_automatic_is_enabled = true
  autoscaler_headroom_automatic_percentage = 5
  health_grace_period                      = 600
  max_pods_per_node                        = 30
  enable_node_public_ip                    = true
  os_disk_size_gb                          = 30
  os_disk_type                             = "Managed"
  os_type                                  = "Linux"
  node_min_count                           = 1
  node_max_count                           = 100
  spot_percentage                          = 50
  fallback_to_ondemand                     = true
  availability_zones                       = [1, 2, 3]
  tags                                     = { "tagKey": "env", "tagValue": "staging" }
  labels                                   = { "key": "env","value": "test"}
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

## Modules

No modules.


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ocean_cluster_name"></a> [ocean\_cluster\_name](#input\_ocean\_cluster\_name) | The Ocean cluster. | `string` | `null` | yes |
| <a name="input_aks_region"></a> [aks\_region](#input\_aks\_region) | The cluster's region | `string` | `null` | yes |
| <a name="input_controller_cluster_id"></a> [controller\_cluster\_id](#input\_controller\_cluster\_id) | Enter a unique Ocean cluster identifier. Cannot be updated. | `string` | `null` | yes |
| <a name="input_aks_cluster_name"></a> [aks\_cluster\_name](#input\_aks\_cluster\_name) | The name of the AKS Cluster | `string` | `null` | yes |
| <a name="input_aks_infrastructure_resource_group_name"></a> [aks\_infrastructure\_resource\_group\_name](#input\_aks\_infrastructure\_resource\_group\_name) | The name of the cluster's infrastructure resource group. | `string` | `null` | yes |
| <a name="input_aks_resource_group_name"></a> [aks\_resource\_group\_name](#input\_aks\_resource\_group\_name) | The name of the cluster's resource group. | `string` | `null` | yes |
| <a name="input_autoscaler_is_enabled"></a> [autoscaler\_is\_enabled](#input\_autoscaler\_is\_enabled) | Enable the Ocean Kubernetes Autoscaler. | `bool` | `true` | yes |
| <a name="input_autoscaler_resource_limits_max_vcpu"></a> [autoscaler\_resource\_limits\_max\_vcpu](#input\_autoscaler\_resource\_limits\_max\_vcpu) | The maximum cpu in vCpu units that can be allocated to the cluster. | `number` | `null` | no |
| <a name="input_autoscaler_resource_limits_max_memory_gib"></a> [autoscaler\_resource\_limits\_max\_memory\_gib](#input\_autoscaler\_resource\_limits\_max\_memory\_gib) | The maximum memory in GiB units that can be allocated to the cluster. | `number` | `null` | no |
| <a name="input_autoscaler_max_scale_down_percentage"></a> [autoscaler\_max\_scale\_down\_percentage](#input\_autoscaler\_max\_scale\_down\_percentage) | The maximum percentage allowed to scale down in a single scaling action. | `number` | `null` | no |
| <a name="input_autoscaler_headroom_automatic_percentage"></a> [autoscaler\_headroom\_automatic\_percentage](#input\_autoscaler\_headroom\_automatic\_percentage) | Optionally set a number between 0-100 to control the percentage of total cluster resources dedicated to headroom. | `number` | `null` | no |
| <a name="input_health_grace_period"></a> [health\_grace\_period](#input\_health\_grace\_period) | The amount of time to wait, in seconds, from the moment the instance has launched until monitoring of its health checks begins. | `number` | `600` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | An Array holding Availability Zones, this configures the availability zones the Ocean may launch instances in per VNG. | `list(string)` | `null` | no |
| <a name="input_max_pods_per_node"></a> [max\_pods\_per\_node](#input\_max\_pods\_per\_node) | he maximum number of pods per node in the node pools. | `number` | `null` | no |
| <a name="input_enable_node_public_ip"></a> [enable\_node\_public\_ip](#input\_enable\_node\_public\_ip) | Enable node public IP. | `bool` | `null` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | The size of the OS disk in GB. | `number` | `null` | no |
| <a name="input_os_disk_type"></a> [os\_disk\_type](#input\_os\_disk\_type) | The type of the OS disk. | `string` | `null` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | The OS type of the OS disk. | `string` | `null` | no |
| <a name="input_node_min_count"></a> [node\_min\_count](#input\_node\_min\_count) | Minimum node count limit. | `number` | `null` | no |
| <a name="input_node_max_count"></a> [node\_max\_count](#input\_node\_max\_count) | Maximum node count limit. | `number` | `null` | no |
| <a name="input_spot_percentage"></a> [spot\_percentage](#input\_spot\_percentage) | Percentage of spot VMs to maintain. | `number` | `100` | no |
| <a name="input_fallback_to_ondemand"></a> [fallback_to_ondemand](#input\_fallback_to_ondemand) | If no spot instance markets are available, enable Ocean to launch on-demand instances instead. | `bool` | `true` | no |
| <a name="input_taints"></a> [taints](#input\_taints) | Add taints to a virtual node group. | `list(map(string))` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A maximum of 10 unique key-value pairs for VM tags in the virtual node group. | ` map(string)` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | An array of labels to add to the virtual node group.Only custom user labels are allowed, and not Kubernetes built-in labels or Spot internal labels. | ` map(string)` | `null` | no |
| <a name="input_scheduling_shutdown_hours_time_windows"></a> [scheduling\_shutdown\_hours\_time\_windows](#input\_scheduling\_shutdown\_hours\_time\_windows) | The times that the shutdown hours will apply. | ` list(string)` | `null` | no |
| <a name="input_scheduling_shutdown_hours_is_enabled"></a> [scheduling\_shutdown\_hours\_is\_enabled](#input\_scheduling\_shutdown\_hours\_is\_enabled) | Flag to enable or disable the shutdown hours mechanism. When False, the mechanism is deactivated, and the cluster remains in its current state. | `bool` | `null` | no |
| <a name="input_vmsizes_filters_min_vcpu"></a> [vmsizes\_filters\_min\_vcpu](#input\_vmsizes\_filters\_min\_vcpu) | Minimum number of vcpus available. | `number` | `null` | no |
| <a name="input_vmsizes_filters_max_vcpu"></a> [vmsizes\_filters\_max\_vcpu](#input\_vmsizes\_filters\_max\_vcpu) | Maximum number of vcpus available. | `number` | `null` | no |
| <a name="input_vmsizes_filters_min_memory_gib"></a> [vmsizes\_filters\_min\_memory\_gib](#input\_vmsizes\_filters\_min\_memory\_gib) | Minimum amount of Memory (GiB). | `number` | `null` | no |
| <a name="input_vmsizes_filters_max_memory_gib"></a> [vmsizes\_filters\_max\_memory\_gib](#input\_vmsizes\_filters\_max\_memory\_gib) | Maximum amount of Memory (GiB). | `number` | `null` | no |
| <a name="input_vmsizes_filters_architectures"></a> [vmsizes\_filters\_architectures](#input\_vmsizes\_filters\_architectures) | The filtered virtual machine types will support at least one of the architectures from this list. | `list(string)` | `null` | no |
| <a name="input_vmsizes_filters_series"></a> [vmsizes_filters_series](#input\_vmsizes_filters_series) | Vm sizes belonging to a series from the list will be available for scaling | `list(string)` | `null` | no |


## Outputs

| Name | Description |
|------|-------------|

| <a name="output_ocean_id"></a> [ocean\_id](#output\_ocean\_id) | The Ocean cluster ID |
<!-- END_TF_DOCS -->

## License

Code is licensed under the [Apache License 2.0](LICENSE).
