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
  autoscaler_headroom_automatic_is_enabled = true
  autoscaler_max_scale_down_percentage     = 30
  autoscaler_headroom_automatic_percentage = 5
  health_grace_period                      = 600
  max_pods_per_node                        = 30
  enable_node_public_ip                    = true
  os_disk_size_gb                          = 30
  os_disk_type                             = "Managed"
  os_type                                  = "Linux"
  os_sku                                   = "Ubuntu"
  kubernetes_version                       = "1.26"
  pod_subnet_ids                           = ["/subscriptions/123456-1234-1234-1234-123456789/resourceGroups/ExampleResourceGroup/providers/Microsoft.Network/virtualNetworks/ExampleVirtualNetwork/subnets/default"]
  vnet_subnet_ids                          = ["/subscriptions/123456-1234-1234-1234-123456789/resourceGroups/ExampleResourceGroup/providers/Microsoft.Network/virtualNetworks/ExampleVirtualNetwork/subnets/default"]
  node_min_count                           = 1
  node_max_count                           = 100
  spot_percentage                          = 50
  fallback_to_ondemand                     = true
  autoscale_headrooms_cpu_per_unit         = 6
  autoscale_headrooms_memory_per_unit      = 10
  autoscale_headrooms_gpu_per_unit         = 4
  autoscale_headrooms_num_of_units         = 10
  availability_zones                       = [1, 2, 3]
  tags                                     = { "tagKey": "env", "tagValue": "staging" }
  labels                                   = { "key": "env","value": "test"}
  shutdown_hours                           = { is_enabled = false 
                                               time_windows = ["Fri:15:30-Sat:13:30", "Sun:15:30-Mon:13:30"] }
  taints                                   = [{"key":"taintKey","value":"taintValue", "effect" : "NoSchedule"}]
  vmsizes_filters_min_vcpu                 = 2
  vmsizes_filters_max_vcpu                 = 16
  vmsizes_filters_min_memory_gib           = 10
  vmsizes_filters_max_memory_gib           = 18
  vmsizes_filters_series                   = ["D v3", "Dds_v4", "Dsv2"]
  vmsizes_filters_architectures            = ["X86_64"]
  should_roll                              = true
  conditioned_roll                         = false
  batch_size_percentage                    = 25
  batch_min_healthy_percentage             = 100
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

| Name                                                                                                                              | Description                                                                                                                                         | Type                 | Default | Required |
|-----------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|---------|:--------:|
| <a name="input_ocean_cluster_name"></a> [ocean\_cluster\_name](#input\_ocean\_cluster\_name)                                      | The Ocean cluster.                                                                                                                                  | `string`             | `null`  |   yes    |
| <a name="input_aks_region"></a> [aks\_region](#input\_aks\_region)                                                                | The cluster's region                                                                                                                                | `string`             | `null`  |   yes    |
| <a name="input_controller_cluster_id"></a> [controller\_cluster\_id](#input\_controller\_cluster\_id)                             | Enter a unique Ocean cluster identifier. Cannot be updated.                                                                                         | `string`             | `null`  |   yes    |
| <a name="input_aks_cluster_name"></a> [aks\_cluster\_name](#input\_aks\_cluster\_name)                                            | The name of the AKS Cluster                                                                                                                         | `string`             | `null`  |   yes    |
| <a name="input_aks_infrastructure_resource_group_name"></a> [aks\_infrastructure\_resource\_group\_name](#input\_aks\_infrastructure\_resource\_group\_name) | The name of the cluster's infrastructure resource group.                                                                                            | `string`             | `null`  |   yes    |
| <a name="input_aks_resource_group_name"></a> [aks\_resource\_group\_name](#input\_aks\_resource\_group\_name)                     | The name of the cluster's resource group.                                                                                                           | `string`             | `null`  |   yes    |
| <a name="input_autoscaler_is_enabled"></a> [autoscaler\_is\_enabled](#input\_autoscaler\_is\_enabled)                             | Enable the Ocean Kubernetes Autoscaler.                                                                                                             | `bool`               | `true`  |   yes    |
| <a name="input_autoscaler_resource_limits_max_vcpu"></a> [autoscaler\_resource\_limits\_max\_vcpu](#input\_autoscaler\_resource\_limits\_max\_vcpu) | The maximum cpu in vCpu units that can be allocated to the cluster.                                                                                 | `number`             | `null`  |    no    |
| <a name="input_autoscaler_resource_limits_max_memory_gib"></a> [autoscaler\_resource\_limits\_max\_memory\_gib](#input\_autoscaler\_resource\_limits\_max\_memory\_gib) | The maximum memory in GiB units that can be allocated to the cluster.                                                                               | `number`             | `null`  |    no    |
| <a name="input_autoscaler_max_scale_down_percentage"></a> [autoscaler\_max\_scale\_down\_percentage](#input\_autoscaler\_max\_scale\_down\_percentage) | The maximum percentage allowed to scale down in a single scaling action.                                                                            | `number`             | `null`  |    no    |
| <a name="input_autoscaler_headroom_automatic_is_enabled"></a> [autoscaler\_headroom\_automatic\_is\_enabled](#input\_autoscaler\_headroom\_automatic\_is\_enabled) | Enable automatic headroom. When set to True, Ocean configures and optimizes headroom automatically.                                    | `bool`               | `false` |    no    |
| <a name="input_autoscaler_headroom_automatic_percentage"></a> [autoscaler\_headroom\_automatic\_percentage](#input\_autoscaler\_headroom\_automatic\_percentage) | Optionally set a number between 0-100 to control the percentage of total cluster resources dedicated to headroom.                                   | `number`             | `null`  |    no    |
| <a name="input_health_grace_period"></a> [health\_grace\_period](#input\_health\_grace\_period)                                   | The amount of time to wait, in seconds, from the moment the instance has launched until monitoring of its health checks begins.                     | `number`             | `600`   |    no    |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones)                                        | An Array holding Availability Zones, this configures the availability zones the Ocean may launch instances in per VNG.                              | `list(string)`       | `null`  |   yes    |
| <a name="input_max_pods_per_node"></a> [max\_pods\_per\_node](#input\_max\_pods\_per\_node)                                       | he maximum number of pods per node in the node pools.                                                                                               | `number`             | `null`  |    no    |
| <a name="input_enable_node_public_ip"></a> [enable\_node\_public\_ip](#input\_enable\_node\_public\_ip)                           | Enable node public IP.                                                                                                                              | `bool`               | `null`  |    no    |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb)                                             | The size of the OS disk in GB.                                                                                                                      | `number`             | `null`  |    no    |
| <a name="input_os_disk_type"></a> [os\_disk\_type](#input\_os\_disk\_type)                                                        | The type of the OS disk.                                                                                                                            | `string`             | `null`  |    no    |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type)                                                                         | The OS type of the OS disk.                                                                                                                         | `string`             | `null`  |    no    |
| <a name="input_os_sku"></a> [os\_sku](#input\_os\_type)                                                                           | The OS SKU of the OS type. Must correlate with the os type.                                                                                         | `string`             | `null`  |    no    |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_os\_type)                                                   | The desired Kubernetes version of the launched nodes. In case the value is null, the Kubernetes version of the control plane is used.               | `string`             | `null`  |    no    |
| <a name="input_pod_subnet_ids"></a> [pod\_subnet\_ids](#input\_os\_type)                                                          | The IDs of subnets in an existing VNet into which to assign pods in the cluster (requires azure network-plugin).                                    | `list(string)`       | `null`  |    no    |
| <a name="input_vnet_subnet_ids"></a> [vnet\_subnet\_ids](#input\_os\_type)                                                        | The IDs of subnets in an existing VNet into which to assign nodes in the cluster (requires azure network-plugin).                                   | `list(string)`       | `null`  |    no    |
| <a name="input_node_min_count"></a> [node\_min\_count](#input\_node\_min\_count)                                                  | Minimum node count limit.                                                                                                                           | `number`             | `null`  |    no    |
| <a name="input_node_max_count"></a> [node\_max\_count](#input\_node\_max\_count)                                                  | Maximum node count limit.                                                                                                                           | `number`             | `null`  |    no    |
| <a name="input_spot_percentage"></a> [spot\_percentage](#input\_spot\_percentage)                                                 | Percentage of spot VMs to maintain.                                                                                                                 | `number`             | `100`   |    no    |
| <a name="input_fallback_to_ondemand"></a> [fallback_to_ondemand](#input\_fallback_to_ondemand)                                    | If no spot instance markets are available, enable Ocean to launch on-demand instances instead.                                                      | `bool`               | `true`  |    no    |
| <a name="input_taints"></a> [taints](#input\_taints)                                                                              | Add taints to a virtual node group.                                                                                                                 | `list(map(string))`  | `null`  |    no    |
| <a name="input_tags"></a> [tags](#input\_tags)                                                                                    | A maximum of 10 unique key-value pairs for VM tags in the virtual node group.                                                                       | ` map(string)`       | `null`  |    no    |
| <a name="input_labels"></a> [labels](#input\_labels)                                                                              | An array of labels to add to the virtual node group.Only custom user labels are allowed, and not Kubernetes built-in labels or Spot internal labels. | ` map(string)`       | `null`  |    no    |
| <a name="input_scheduling_shutdown_hours_time_windows"></a> [scheduling\_shutdown\_hours\_time\_windows](#input\_scheduling\_shutdown\_hours\_time\_windows) | The times that the shutdown hours will apply.                                                                                                       | ` list(string)`      | `null`  |    no    |
| <a name="input_scheduling_shutdown_hours_is_enabled"></a> [scheduling\_shutdown\_hours\_is\_enabled](#input\_scheduling\_shutdown\_hours\_is\_enabled) | Flag to enable or disable the shutdown hours mechanism. When False, the mechanism is deactivated, and the cluster remains in its current state.     | `bool`               | `null`  |    no    |
| <a name="input_shutdown_hours"></a> [shutdown\_hours](#input\_shutdown\_hours)                                                    | shutdown_hours object.                                                                                                                              | `object`             | `null`  |    no    |
| <a name="input_vmsizes_filters_min_vcpu"></a> [vmsizes\_filters\_min\_vcpu](#input\_vmsizes\_filters\_min\_vcpu)                  | Minimum number of vcpus available.                                                                                                                  | `number`             | `null`  |    no    |
| <a name="input_vmsizes_filters_max_vcpu"></a> [vmsizes\_filters\_max\_vcpu](#input\_vmsizes\_filters\_max\_vcpu)                  | Maximum number of vcpus available.                                                                                                                  | `number`             | `null`  |    no    |
| <a name="input_vmsizes_filters_min_memory_gib"></a> [vmsizes\_filters\_min\_memory\_gib](#input\_vmsizes\_filters\_min\_memory\_gib) | Minimum amount of Memory (GiB).                                                                                                                     | `number`             | `null`  |    no    |
| <a name="input_vmsizes_filters_max_memory_gib"></a> [vmsizes\_filters\_max\_memory\_gib](#input\_vmsizes\_filters\_max\_memory\_gib) | Maximum amount of Memory (GiB).                                                                                                                     | `number`             | `null`  |    no    |
| <a name="input_vmsizes_filters_architectures"></a> [vmsizes\_filters\_architectures](#input\_vmsizes\_filters\_architectures)     | The filtered virtual machine types will support at least one of the architectures from this list.                                                   | `list(string)`       | `null`  |    no    |
| <a name="input_vmsizes_filters_series"></a> [vmsizes_filters_series](#input\_vmsizes_filters_series)                              | Vm sizes belonging to a series from the list will be available for scaling.                                                                         | `list(string)`       | `null`  |    no    |
| <a name="input_vmsizes_filters_exclude_series"></a> [vmsizes_filters_exclude_series](#input\_vmsizes_filters_exclude_series)      | Vm sizes belonging to a series from the list will not be available for scaling.                                                                     | `list(string)`       | `null`  |    no    |
| <a name="input_vmsizes_filters_accelerated_networking"></a> [vmsizes_filters_accelereated_networking](#input\_vmsizes_filters_accelerated_netwoking) | In case acceleratedNetworking is set to Enabled, accelerated networking applies only to the VM that enables it.                                     | `string`             | `null`  |    no    |
| <a name="input_vmsizes_filters_disk_performance"></a> [vmsizes_filters_disk_performance](#input\_vmsizes_filters_disk_performance) | The filtered vm sizes will support at least one of the classes from this list.                                                                      | `string`             | `null`  |    no    |
| <a name="input_vmsizes_filters_min_gpu"></a> [vmsizes_filters_min_gpu](#input\_vmsizes_filters_min_gpu)                           | Minimum number of GPUs available.                                                                                                                   | `number`             | `null`  |    no    |
| <a name="input_vmsizes_filters_max_gpu"></a> [vmsizes_filters_max_gpu](#input\_vmsizes_filters_max_gpu)                           | Maximum number of GPUs available.                                                                                                                   | `number`             | `null`  |    no    |
| <a name="input_vmsizes_filters_min_nics"></a> [vmsizes_filters_min_nics](#input\_vmsizes_filters_min_nics)                        | Minimum number of network interfaces.                                                                                                               | `number`             | `null`  |    no    |
| <a name="input_vmsizes_filters_min_disk"></a> [vmsizes_filters_min_disk](#input\_vmsizes_filters_min_data)                        | Minimum number of data disks available.                                                                                                             | `number`             | `null`  |    no    |
| <a name="input_vmsizes_filters_vm_types"></a> [vmsizes_filters_vm_types](#input\_vmsizes_filters_vm_types)                        | The filtered vm types will belong to one of the vm types from this list.                                                                            | `list(string)`       | `null`  |    no    |
| <a name="input_vmsizes_filters_gpu_types"></a> [vmsizes_filters_gpu_types](#input\_vmsizes_filters_gpu_types)                     | The filtered gpu types will belong to one of the gpu types from this list.                                                                          | `list(string)`       | `null`  |    no    |
| <a name="input_autoscale_headrooms_num_of_units"></a> [autoscale\_headrooms\_num\_of\_units](#input\_autoscale\_headrooms\_num\_of\_units) | The number of units to retain as headroom, where each unit has the defined headroom CPU, memory.                                                    | `number`             | `null`  |    no    |
| <a name="input_autoscale_headrooms_cpu_per_unit"></a> [autoscale\_headrooms\_cpu\_per\_unit](#input\_autoscale\_headrooms\_cpu\_per\_unit) | Configure the number of CPUs to allocate for each headroom unit. CPUs are denoted in millicores, where 1000 millicores = 1 vCPU.                    | `number`             | `null`  |    no    |
| <a name="input_autoscale_headrooms_gpu_per_unit"></a> [autoscale\_headrooms\_gpu\_per\_unit](#input\_autoscale\_headrooms\_gpu\_per\_unit) | Amont of GPU to allocate for headroom unit.                                                                                                         | `number`             | `null`  |    no    |
| <a name="input_autoscale_headrooms_memory_per_unit"></a> [autoscale\_headrooms\_memory\_per\_unit](#input\_autoscale\_headrooms\_memory\_per\_unit) | Configure the amount of memory (MiB) to allocate the headroom                                                                                       | `number`             | `null`  |    no    |
| <a name="input_should_roll"></a> [should\_roll](#input\_should\_roll)                                                             | If set to true along with the cluster update, roll will be triggered.| `bool`               | `false` |    no    |
| <a name="input_conditioned_roll"></a> [conditioned\_roll](#input\_conditioned\_roll)                                              | Default: false. Spot will perform a cluster Roll in accordance with a relevant modification of the cluster’s settings. When set to true , only specific changes in the cluster’s configuration will trigger a cluster roll (such as availability_zones, max_pods_per_node, enable_node_public_ip, os_disk_size_gb, os_disk_type, os_sku, kubernetes_version, vnet_subnet_ids, pod_subnet_ids, labels, taints and tags).| `bool`               | `null` |    no    |
| <a name="input_respect_pdb"></a> [respect\_pdb](#input\_respect\_pdb)                                                             | During the roll, if the parameter is set to true we honor PDB during the nodes replacement| `bool`               | `true` |    no    |
| <a name="input_batch_size_percentage"></a> [batch\_size\_percentage](#input\_batch\_size\_percentage)                             | Value as a percent to set the size of a batch in a roll. Valid values are 0-100. In case of null as value, the default value in the backend will be 20%.| `number`             | `20` |    no    |
| <a name="input_vng_ids"></a> [vng\_ids](#input\_vng\_ids)                                                                         | List of virtual node group identifiers to be rolled. Each identifier is a string. vngIds can be null, and cannot be used together with nodeNames and nodePoolNames.| `list(string)`       | `null` |    no    |
| <a name="input_batch_min_healthy_percentage"></a> [batch\_min\_healthy\_percentage](#input\_batch\_min\_healthy\_percentage)      | Default: 50. Indicates the threshold of minimum healthy nodes in single batch. If the amount of healthy nodes in single batch is under the threshold, the roll will fail. If exists, the parameter value will be in range of 1-100. In case of null as value, the default value in the backend will be 50%. Value of param should represent the number in percentage (%) of the batch. | `number`             | `null` |    no    |
| <a name="input_comment"></a> [comment](#input\_comment)                                                                           | Add a comment description for the roll. The comment is limited to 256 chars and optional. | `string`             | `null` |    no    |
| <a name="input_node_pool_names"></a> [node\_pool\_names](#input\_node\_pool\_names)                                               | List of node pools to be rolled. Each node pool name is a string. nodePoolNames can be null, and cannot be used together with nodeNames and vngIds.| `list(string)`       | `null` |    no    |
| <a name="input_respect_restrict_scale_down"></a> [respect\_restrict\_scale\_down](#input\_respect\_restrict\_scale\_down)         | During the roll, if the parameter is set to true we honor Restrict Scale Down label during the nodes replacement.| `bool`               | `false` |    no    |
| <a name="input_node_names"></a> [node\_names](#input\_node\_names)                                                                | List of node names to be rolled. Each identifier is a string. nodeNames can be null, and cannot be used together with nodePoolNames and vngIds. | `list(string)`       | `null` |    no    |


## Outputs

| Name | Description |
|------|-------------|

| <a name="output_ocean_id"></a> [ocean\_id](#output\_ocean\_id) | The Ocean cluster ID |
<!-- END_TF_DOCS -->

## License

Code is licensed under the [Apache License 2.0](LICENSE).
