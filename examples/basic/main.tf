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
  autoscaler_resource_limits_max_vcpu      = 20000
  autoscaler_resource_limits_max_memory_gib= 100000
  autoscaler_max_scale_down_percentage     = 10
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
  scheduling_shutdown_hours_time_windows   = ["Sat:08:00-Sun:08:00"]
  scheduling_shutdown_hours_is_enabled     = true
  vmsizes_filters_min_vcpu=2
  vmsizes_filters_max_vcpu=16
  vmsizes_filters_min_memory_gib=10
  vmsizes_filters_max_memory_gib=18
  vmsizes_filters_series=["D v3"]
  vmsizes_filters_architectures=["X86_64"]
}

