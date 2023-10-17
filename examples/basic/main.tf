module "ocean-aks-np" {
  source = "../.."
  # Credentials.
  spotinst_token                          = "your-token"
  spotinst_account                        = "your-account"

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
  autoscaler_headroom_automatic_percentage = 5
  health_grace_period                      = 600
  max_pods_per_node                        = 30
  enable_node_public_ip                    = true
  os_disk_size_gb                          = 32
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
  availability_zones                       = ["1", "2", "3"]
  tags                                     = { "tagKey": "env", "tagValue": "staging" }
  labels                                   = { "key": "env","value": "test"}
  taints                                   = [{"key":"taintKey","value":"taintValue", "effect" : "NoSchedule"}]
  vmsizes_filters_min_vcpu                 = 4
  vmsizes_filters_max_vcpu                 = 96
  vmsizes_filters_min_memory_gib           = 14.0
  vmsizes_filters_max_memory_gib           = 900.0
  vmsizes_filters_series                   = ["NC","NV"]
  vmsizes_filters_exclude_series           = ["HB","HC"]
  vmsizes_filters_architectures            = ["X86_64", "INTEL64", "ARM64","AMD64"]
  vmsizes_filters_accelerated_networking   = "Disabled"
  vmsizes_filters_disk_performance         = "Standard"
  vmsizes_filters_min_gpu                  = 4.0
  vmsizes_filters_max_gpu                  = 8.0
  vmsizes_filters_min_nics                 = 1
  vmsizes_filters_vm_types                 = ["generalPurpose", "GPU"]
  vmsizes_filters_min_data                 = 1
  shutdown_hours                           = { is_enabled = false,
                                               time_windows = ["Fri:15:30-Sat:13:30", "Sun:15:30-Mon:13:30"] }
}

