// spotinst/[NAME]

variable "spotinst_token" {
  type        = string
  description = "Spot Personal Access token"
}

variable "spotinst_account" {
  type        = string
  description = "Spot account ID"
}
variable "name" {
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
variable "autoscale_is_enabled" {
  type        = string
  default     = true
  description = "Enable the Ocean Kubernetes Autoscaler."
}
variable "max_vcpu" {
  type        = number
  description = "The maximum cpu in vCpu units that can be allocated to the cluster."
}
variable "max_memory_gib" {
  type        = number
  description = "The maximum memory in GiB units that can be allocated to the cluster."
}
variable "max_scale_down_percentage" {
  type        = number
  description = "The maximum percentage allowed to scale down in a single scaling action."
}
variable "is_enabled" {
  type        = bool
  default     = true
  description = "Enable automatic headroom. When set to True, Ocean configures and optimizes headroom automatically."
}
variable "percentage" {
  type        = number
  description = "Optionally set a number between 0-100 to control the percentage of total cluster resources dedicated to headroom. Relevant when isEnabled=true."
}
variable "grace_period" {
  type        = number
  default     = 600
  description = "Optionally set a number between 0-100 to control the percentage of total cluster resources dedicated to headroom. Relevant when isEnabled=true."
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
variable "min_count" {
  type        = number
  description = "Minimum node count limit."
}
variable "max_count" {
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
