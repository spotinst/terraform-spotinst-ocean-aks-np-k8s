module "ocean-aks-np" {
  source = "../.."
  # Credentials.
  spotinst_token   = var.spotinst_token
  spotinst_account = var.spotinst_account
  # Configuration
  name                                   = "clusterName"
  aks_region                             = "region"
  controller_cluster_id                  = "controllerId"
  aks_cluster_name                       = "nodePoolName"
  aks_infrastructure_resource_group_name = "aksInfrastructureResourceGroupName"
  aks_resource_group_name                = "resourceGroup"
  autoscale_is_enabled      = true
  max_vcpu       = 121
  max_memory_gib = 120
  max_scale_down_percentage = 10
  is_enabled = true
  percentage = 10
  grace_period = 300
  max_pods_per_node     = 110
  enable_node_public_ip = false
  os_disk_size_gb       = 128
  os_disk_type         = "Managed"
  os_type             = "Linux"
  min_count = 10
  max_count = 100
  spot_percentage      = 100
  fallback_to_ondemand = true

  availability_zones = [
    1,
    2,
  ]
  tags={ "key1": "value1", "key2": "value2" }
  labels={ "labelkey1": "labelvalue1","labelkey2": "labelvalue2"}
}

