// spotinst/[NAME]

variable "spotinst_token" {
  type        = string
  description = "Spot Personal Access token"
}
variable "spotinst_account" {
  type        = string
  description = "Spot account ID"
}
variable "ocean_cluster_name" {
  type        = string
  description = "The Ocean cluster."
}
variable "aks_region" {
  type        = string
  description = "The cluster's region."
}
variable "controller_cluster_id" {
  type        = string
  description = "Enter a unique Ocean cluster identifier. Cannot be updated."
}
variable "aks_cluster_name" {
  type        = string
  description = "The name of the AKS Cluster."
}
variable "aks_infrastructure_resource_group_name" {
  type        = string
  description = "The name of the cluster's infrastructure resource group."
}
variable "aks_resource_group_name" {
  type        = string
  description = "The name of the cluster's resource group."
}
variable "autoscaler_is_enabled" {
  type        = bool
  default     = true
  description = "Enable the Ocean Kubernetes Autoscaler."
}
variable "autoscaler_resource_limits_max_vcpu" {
  type        = number
  default     = null
  description = "The maximum cpu in vCpu units that can be allocated to the cluster."
}
variable "autoscaler_resource_limits_max_memory_gib" {
  type        = number
  default     = null
  description = "The maximum memory in GiB units that can be allocated to the cluster."
}
variable "autoscaler_max_scale_down_percentage" {
  type        = number
  default     = null
  description = "The maximum percentage allowed to scale down in a single scaling action."
}
variable "autoscaler_headroom_automatic_is_enabled" {
  type        = bool
  default     = false
  description = "Enable automatic headroom. When set to True, Ocean configures and optimizes headroom automatically."
}
variable "autoscaler_headroom_automatic_percentage" {
  type        = number
  default     = null
  description = "Optionally set a number between 0-100 to control the percentage of total cluster resources dedicated to headroom."
}
variable "health_grace_period" {
  type        = number
  default     = 600
  description = "The amount of time to wait, in seconds, from the moment the instance has launched until monitoring of its health checks begins."
}
variable "availability_zones" {
  type        = list(string)
  description = "An Array holding Availability Zones, this configures the availability zones the Ocean may launch instances in per VNG."
}
variable "max_pods_per_node" {
  type        = number
  default     = null
  description = "The maximum number of pods per node in an AKS cluster."
}
variable "enable_node_public_ip" {
  type        = bool
  default     = null
  description = "enable node public IP."
}
variable "os_disk_size_gb" {
  type        = number
  default     = null
  description = "The size of the OS disk in GB."
}
variable "os_disk_type" {
  type        = string
  default     = null
  description = "The type of the OS disk."
}
variable "os_type" {
  type        = string
  default     = null
  description = "The os type of the os disk."
}
variable "os_sku" {
  type        = string
  default     = null
  description = "The OS SKU of the OS type. Must correlate with the os type."
}
variable "kubernetes_version" {
  type        = string
  default     = null
  description = "The desired Kubernetes version of the launched nodes. In case the value is null, the Kubernetes version of the control plane is used."
}
variable "pod_subnet_ids" {
  type        = list(string)
  default     = null
  description = "The IDs of subnets in an existing VNet into which to assign pods in the cluster (requires azure network-plugin)."
}
variable "vnet_subnet_ids" {
  type        = list(string)
  default     = null
  description = "The IDs of subnets in an existing VNet into which to assign nodes in the cluster (requires azure network-plugin)."
}
variable "node_min_count" {
  type        = number
  default     = null
  description = "Minimum node count limit."
}
variable "node_max_count" {
  type        = number
  default     = null
  description = "Maximum node count limit."
}
variable "spot_percentage" {
  type        = number
  default     = 100
  description = "Percentage of spot VMs to maintain."
}
variable "fallback_to_ondemand" {
  type        = bool
  default     = true
  description = "If no spot instance markets are available, enable Ocean to launch on-demand instances instead."
}
variable "taints" {
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  default     = null
  description = "Add taints to a virtual node group."
}
variable "tags" {
  type        = map(string)
  default     = null
  description = "A maximum of 10 unique key-value pairs for VM tags in the virtual node group."
}
variable "labels" {
  type        = map(string)
  default     = null
  description = "An Array holding Availability Zones, this configures the availability zones the Ocean may launch instances in per VNG."
}
variable "vmsizes_filters_min_vcpu" {
  type        = number
  default     = null
  description = "Minimum number of vcpus available."
}
variable "vmsizes_filters_max_vcpu" {
  type        = number
  default     = null
  description = "Maximum number of vcpus available."
}
variable "vmsizes_filters_min_memory_gib" {
  type        = number
  default     = null
  description = "Minimum amount of Memory (GiB)."
}
variable "vmsizes_filters_max_memory_gib" {
  type        = number
  default     = null
  description = "Maximum amount of Memory (GiB)."
}
variable "vmsizes_filters_architectures" {
  type        = list(string)
  default     = null
  description = "The filtered vm sizes will support at least one of the architectures from this list. x86_64 includes both intel64 and amd64."
}
variable "vmsizes_filters_series" {
  type        = list(string)
  default     = null
  description = "Vm sizes belonging to a series from the list will be available for scaling"
}
variable "vmsizes_filters_exclude_series" {
  type        = list(string)
  default     = null
  description = "Vm sizes belonging to a series from the list will not be available for scaling."
}
variable "vmsizes_filters_accelerated_networking" {
  type        = string
  default     = null
  description = "In case acceleratedNetworking is set to Enabled, accelerated networking applies only to the VM that enables it."
}
variable "vmsizes_filters_disk_performance" {
  type        = string
  default     = null
  description = "The filtered vm sizes will support at least one of the classes from this list."
}
variable "vmsizes_filters_min_gpu" {
  type        = number
  default     = null
  description = "Minimum number of GPUs available."
}
variable "vmsizes_filters_max_gpu" {
  type        = number
  default     = null
  description = "Maximum number of GPUs available."
}
variable "vmsizes_filters_min_nics" {
  type        = number
  default     = null
  description = "Minimum number of network interfaces."
}
variable "vmsizes_filters_min_disk" {
  type        = number
  default     = null
  description = "Minimum number of data disks available."
}
variable "vmsizes_filters_vm_types" {
  type        = list(string)
  default     = null
  description = "The filtered vm types will belong to one of the vm types from this list."
}
variable "vmsizes_filters_gpu_types" {
  type        = list(string)
  default     = null
  description = "The filtered gpu types will belong to one of the gpu types from this list. Supported GPU Types: `nvidia-tesla-v100`, `amd-radeon-instinct-mi25`, `nvidia-a10`, `nvidia-tesla-a100`, `nvidia-tesla-k80`, `nvidia-tesla-m60`, `nvidia-tesla-p100`, `nvidia-tesla-p40`, `nvidia-tesla-t4`, `nvidia-tesla-h100`."
}
variable "autoscale_headrooms_cpu_per_unit" {
  type        = number
  default     = null
  description = "Configure the number of CPUs to allocate the headroom. CPUs are denoted in millicores, where 1000 millicores = 1 vCPU."
}
variable "autoscale_headrooms_memory_per_unit" {
  type        = number
  default     = null
  description = "onfigure the amount of memory (MiB) to allocate the headroom."
}
variable "autoscale_headrooms_gpu_per_unit" {
  type        = number
  default     = null
  description = "Amont of GPU to allocate for headroom unit."
}
variable "autoscale_headrooms_num_of_units" {
  type        = number
  default     = null
  description = "The number of units to retain as headroom, where each unit has the defined headroom CPU and memory."
}
variable "shutdown_hours" {
  type = object({
    is_enabled   = bool
    time_windows = list(string)
  })
  default     = null
  description = "shutdown_hours object"
}
variable "suspension_hours" {
  type = object({
    is_enabled   = bool
    time_windows = list(string)
  })
  default     = null
  description = "suspension_hours object"
}

## Update Policy - update_policy ##
variable "should_roll" {
  type        = bool
  default     = false
  description = "Should the cluster be rolled for configuration updates"
}
## roll_config ##
variable "conditioned_roll" {
  type        = bool
  default     = false
  description = "Default: false. Spot will perform a cluster Roll in accordance with a relevant modification of the cluster’s settings. When set to true , only specific changes in the cluster’s configuration will trigger a cluster roll (such as availability_zones, max_pods_per_node, enable_node_public_ip, os_disk_size_gb, os_disk_type, os_sku, kubernetes_version, vnet_subnet_ids, pod_subnet_ids, labels, taints, tags)."
}
variable "respect_pdb" {
  type        = bool
  default     = true
  description = "Default: true. During the roll, if the parameter is set to true we honor PDB during the nodes replacement."
}
variable "batch_size_percentage" {
  type        = number
  default     = null
  description = "Value as a percent to set the size of a batch in a roll. Valid values are 0-100. In case of null as value, the default value in the backend will be 20%."
}
variable "vng_ids" {
  type        = list(string)
  default     = null
  description = "List of virtual node group identifiers to be rolled. Each identifier is a string. vngIds can be null, and cannot be used together with nodeNames and nodePoolNames."
}
variable "batch_min_healthy_percentage" {
  type        = number
  default     = 50
  description = "Default: 50. Indicates the threshold of minimum healthy nodes in single batch. If the amount of healthy nodes in single batch is under the threshold, the roll will fail. If exists, the parameter value will be in range of 1-100. In case of null as value, the default value in the backend will be 50%. Value of param should represent the number in percentage (%) of the batch."
}
variable "comment" {
  type        = string
  default     = null
  description = "Add a comment description for the roll. The comment is limited to 256 chars and optional."
}
variable "node_pool_names" {
  type        = list(string)
  default     = null
  description = "List of node pools to be rolled. Each node pool name is a string. nodePoolNames can be null, and cannot be used together with nodeNames and vngIds."
}
variable "respect_restrict_scale_down" {
  type        = bool
  default     = false
  description = "Default: false. During the roll, if the parameter is set to true we honor Restrict Scale Down label during the nodes replacement."
}
variable "node_names" {
  type        = list(string)
  default     = null
  description = "List of node names to be rolled. Each identifier is a string. nodeNames can be null, and cannot be used together with nodePoolNames and vngIds."
}
variable "linux_os_config" {
  type = object({
    vm_max_map_count = optional(number,null)
  })
  default = null
  description = "Custom Linux OS configuration"
}

###################
# scheduling task  #
variable "tasks" {
  type = list(object({
    is_enabled      = bool
    cron_expression = string
    task_type       = string
    parameters_cluster_roll = optional(set(object({
      batch_min_healthy_percentage = optional(number,null)
      batch_size_percentage = optional(number,null)
      comment = optional(string,null)
      respect_pdb = optional(bool,null)
      respect_restrict_scale_down = optional(bool,null)
      vng_ids = optional(list(string),null)
    })), []),
    parameters_upgrade_config = optional(set(object({
      apply_roll = optional(bool,null)
      scope_version = optional(string,null)
      roll_parameters = optional(set(object({
        batch_min_healthy_percentage = optional(number,null)
        batch_size_percentage = optional(number,null)
        comment = optional(string,null)
        respect_pdb = optional(bool,null)
        respect_restrict_scale_down = optional(bool,null)
      })), []),
    })), [])
  }))
  default     = null
  description = "tasks object"
}
##################

# Logging
variable "data_integration_id" {
  type        = string
  default     = null
  description = "The identifier of The Azure Blob data integration to export the logs to."
}

#vng template scheduling
 variable "vng_template_scheduling" {
  type = list(object({
    vng_template_shutdown_hours= optional(set(object({
        is_enabled   = optional(bool,null)
        time_windows = optional(list(string),null)
    })), [])
 }))
  default     = null
  description = "vng template scheduling object"
}
