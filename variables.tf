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
  description = "Add a name for the Ocean cluster"
}
variable "aks_region" {
  type        = string
  description = "Required on cluster.aks object."
}
variable "controller_cluster_id" {
  type        = string
  description = "Enter a unique Ocean cluster identifier. Cannot be updated."
}
variable "aks_cluster_name" {
  type        = string
  description = "Required on cluster.aks object"
}
variable "aks_infrastructure_resource_group_name" {
  type        = string
  description = "Required on cluster.aks object."
}
variable "aks_resource_group_name" {
  type        = string
  description = "Required on cluster.aks object."
}
variable "autoscaler_is_enabled" {
  type        = bool
  default     = true
  description = "Enable the Ocean Kubernetes Autoscaler."
}
variable "autoscaler_resource_limits_max_vcpu" {
  type        = number
  description = "The maximum cpu in vCpu units that can be allocated to the cluster."
}
variable "autoscaler_resource_limits_max_memory_gib" {
  type        = number
  description = "The maximum memory in GiB units that can be allocated to the cluster."
}
variable "autoscaler_max_scale_down_percentage" {
  type        = number
  description = "The maximum percentage allowed to scale down in a single scaling action."
}

variable "autoscaler_headroom_automatic_percentage" {
  type        = number
  description = "Optionally set a number between 0-100 to control the percentage of total cluster resources dedicated to headroom. Relevant when isEnabled=true."
}
variable "health_grace_period" {
  type        = number
  default     = 600
  description = "he amount of time to wait, in seconds, from the moment the instance has launched until monitoring of its health checks begins."
}
variable "availability_zones" {
  type        = list(string)
  description = "An Array holding Availability Zones, this configures the availability zones the Ocean may launch instances in per VNG."
}
variable "max_pods_per_node" {
  type        = number
  description = "The maximum number of pods per node in an AKS cluster."
}
variable "enable_node_public_ip" {
  type        = bool
  description = "enable node public IP."
}
variable "os_disk_size_gb" {
  type        = number
  description = "The size of the OS disk in GB."
}
variable "os_disk_type" {
  type        = string
  description = "The type of the OS disk."
}
variable "os_type" {
  type        = string
  description = "The os type of the os disk."
}
variable "node_min_count" {
  type        = number
  description = "Minimum node count limit."
}
variable "node_max_count" {
  type        = number
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
  description = "taints / toleration"
}
variable "tags" {
  type        = map(string)
  default     = null
  description = "Tags to be added to resources"
}
variable "labels" {
  type        = map(string)
  default     = null
  description = "An array of labels to add to the virtual node group.Only custom user labels are allowed, and not Kubernetes built-in labels or Spot internal labels."
}
variable "scheduling_shutdown_hours_time_windows" {
  type        = list(string)
  description = "The times that the shutdown hours will apply."
}
variable "scheduling_shutdown_hours_is_enabled" {
  type        = bool
  description = "Flag to enable or disable the shutdown hours mechanism. When False, the mechanism is deactivated, and the cluster remains in its current state."
}
variable "vmsizes_filters_min_vcpu" {
  type        = number
  description = "Minimum number of vcpus available."
}
variable "vmsizes_filters_max_vcpu" {
  type        = number
  description = "Maximum number of vcpus available."
}
variable "vmsizes_filters_min_memory_gib" {
  type        = number
  description = "Minimum amount of Memory (GiB)."
}
variable "vmsizes_filters_max_memory_gib" {
  type        = number
  description = "Maximum amount of Memory (GiB)."
}
variable "vmsizes_filters_architectures" {
  type        = list(string)
  description = "The filtered virtual machine types will support at least one of the architectures from this list."
}
variable "vmsizes_filters_series" {
  type        = list(string)
  description = "Vm sizes belonging to a series from the list will be available for scaling"
}
