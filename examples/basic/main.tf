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
  autoscaler_headroom_automatic_is_enabled = true
  autoscaler_headroom_automatic_percentage = 5
  health_grace_period                      = 600
  linux_os_config                          = {
    vm_max_map_count                       = 65531}
  max_pods_per_node                        = 30
  enable_node_public_ip                    = true
  os_disk_size_gb                          = 32
  os_disk_type                             = "Managed"
  os_type                                  = "Linux"
  os_sku                                   = "Ubuntu"
  kubernetes_version                       = "1.30"
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
  vmsizes_filters_min_vcpu                 = 2
  vmsizes_filters_max_vcpu                 = 128
  vmsizes_filters_min_memory_gib           = 8
  vmsizes_filters_max_memory_gib           = 128
  vmsizes_filters_series                   = ["D v3", "Dds_v4", "Dsv2", "A", "A v2","Ncas T4 v3","Ncs v2"]
  vmsizes_filters_exclude_series           = ["E v3","Esv3", "Eas_v5"]
  vmsizes_filters_architectures            = ["X86_64"]
  vmsizes_filters_accelerated_networking   = "Enabled"
  vmsizes_filters_disk_performance         = "Premium"
  vmsizes_filters_min_gpu                  = 1
  vmsizes_filters_max_gpu                  = 8
  vmsizes_filters_min_nics                 = 1
  vmsizes_filters_vm_types                 = ["generalPurpose","GPU"]
  vmsizes_filters_min_disk                 = 1
  vmsizes_filters_gpu_types                = ["nvidia-tesla-p100","nvidia-tesla-t4"]
  shutdown_hours                           = { is_enabled = false,
                                               time_windows = ["Fri:15:30-Sat:13:30", "Sun:15:30-Mon:13:30"] }
  should_roll                              = false
  batch_size_percentage                    = 25
  data_integration_id                      = "di-abcd123"
  suspension_hours                         = { is_enabled = false,
                                               time_windows = ["Fri:15:30-Sun:13:30", "Sun:15:30-Mon:13:30"] }

    vng_template_scheduling = [{
      vng_template_shutdown_hours = [{
        is_enabled = true
        time_windows = ["Sat:15:30-Sun:13:30", "Sun:15:30-Mon:08:30"]
      }]
    }]

  # Scheduling tasks parameters block (clusterRoll)
   tasks = [
    {
      is_enabled = true
      cron_expression = "0 1 * * *"
      task_type = "autoUpgradeVersion"
      parameters_upgrade_config = [{
          apply_roll = true
          scope_version = "patch"
          roll_parameters = [{
            batch_min_healthy_percentage = 80
            batch_size_percentage = 20
            comment = "Scheduled upgrade roll"
            respect_pdb = true
            respect_restrict_scale_down = true
        }]
      }]
    },
{
      is_enabled = true
      cron_expression = "0 5 * * *"
      task_type = "clusterRoll"
      parameters_cluster_roll = [{
            batch_min_healthy_percentage = 50
            batch_size_percentage = 30
            comment = "Scheduled cluster roll"
            respect_pdb = true
            respect_restrict_scale_down = true
      }]
    }
  ]
}
