provider "spotinst" {
  //  version = "~> 0.11"
  # Credentials should be fetched from ENV VARS injected by Jenkins
  token = var.spotinst_token
  account = var.spotinst_account
}
resource "spotinst_ocean_aks_np" "v2" {
  name                                   = var.ocean_cluster_name
  aks_region                             = var.aks_region
  controller_cluster_id                  = var.controller_cluster_id
  aks_cluster_name                       = var.aks_cluster_name
  aks_infrastructure_resource_group_name = var.aks_infrastructure_resource_group_name
  aks_resource_group_name                = var.aks_resource_group_name

  autoscaler {
    autoscale_is_enabled      = var.autoscaler_is_enabled

    resource_limits {
      max_vcpu       = var.autoscaler_resource_limits_max_vcpu
      max_memory_gib = var.autoscaler_resource_limits_max_memory_gib
    }

    autoscale_down {
      max_scale_down_percentage = var.autoscaler_max_scale_down_percentage
    }

    autoscale_headroom {

      automatic {
        is_enabled = var.autoscaler_headroom_automatic_is_enabled
        percentage = var.autoscaler_headroom_automatic_percentage
      }

    }

  }
  # Scheduling ##
  scheduling {
    dynamic "shutdown_hours" {
      for_each = var.shutdown_hours != null ? [var.shutdown_hours] : []
      content {
        is_enabled   = shutdown_hours.value.is_enabled
        time_windows = shutdown_hours.value.time_windows
      }
    }
    dynamic "tasks" {
      for_each = var.tasks != null ? var.tasks : []
      content {
        cron_expression = tasks.value.cron_expression
        is_enabled      = tasks.value.is_enabled
        task_type       = tasks.value.task_type
        parameters {
          dynamic "parameters_cluster_roll" {
            for_each = tasks.value.parameters_cluster_roll
            content {
              batch_min_healthy_percentage = parameters_cluster_roll.value.batch_min_healthy_percentage
              batch_size_percentage        = parameters_cluster_roll.value.batch_size_percentage
              comment                      = parameters_cluster_roll.value.comment
              respect_pdb                  = parameters_cluster_roll.value.respect_pdb
              respect_restrict_scale_down  = parameters_cluster_roll.value.respect_restrict_scale_down
              vng_ids                      = parameters_cluster_roll.value.vng_ids
            }
          }
        }

      }
    }
  }

  health {
    grace_period = var.health_grace_period
  }
  availability_zones    = var.availability_zones
  max_pods_per_node     = var.max_pods_per_node
  enable_node_public_ip = var.enable_node_public_ip
  os_disk_size_gb       = var.os_disk_size_gb
  os_disk_type          = var.os_disk_type
  os_type               = var.os_type
  os_sku                = var.os_sku
  kubernetes_version    = var.kubernetes_version
  pod_subnet_ids        = var.pod_subnet_ids
  vnet_subnet_ids       = var.vnet_subnet_ids
  dynamic "linux_os_config" {
    for_each = var.linux_os_config != null ? [var.linux_os_config] : []
    content {
      sysctls {
        vm_max_map_count = linux_os_config.value.vm_max_map_count
      }
    }
  }
  min_count = var.node_min_count
  max_count = var.node_max_count

  spot_percentage      = var.spot_percentage
  fallback_to_ondemand = var.fallback_to_ondemand

  filters {
    min_vcpu                = var.vmsizes_filters_min_vcpu
    max_vcpu                = var.vmsizes_filters_max_vcpu
    min_memory_gib          = var.vmsizes_filters_min_memory_gib
    max_memory_gib          = var.vmsizes_filters_max_memory_gib
    architectures           = var.vmsizes_filters_architectures
    series                  = var.vmsizes_filters_series
    exclude_series          = var.vmsizes_filters_exclude_series
    accelerated_networking  = var.vmsizes_filters_accelerated_networking
    disk_performance        = var.vmsizes_filters_disk_performance
    min_gpu                 = var.vmsizes_filters_min_gpu
    max_gpu                 = var.vmsizes_filters_max_gpu
    min_nics                = var.vmsizes_filters_min_nics
    vm_types                = var.vmsizes_filters_vm_types
    min_disk                = var.vmsizes_filters_min_disk
    gpu_types               = var.vmsizes_filters_gpu_types
  }
  headrooms {
    cpu_per_unit    = var.autoscale_headrooms_cpu_per_unit
    memory_per_unit = var.autoscale_headrooms_memory_per_unit
    gpu_per_unit    = var.autoscale_headrooms_gpu_per_unit
    num_of_units    = var.autoscale_headrooms_num_of_units
  }

  tags=var.tags
  labels=var.labels

  dynamic "taints" {
    for_each = var.taints == null ? [] : var.taints
    content {
      key    = taints.value["key"]
      value  = taints.value["value"]
      effect = taints.value["effect"]
    }
  }

  update_policy {
    should_roll                     = var.should_roll
    conditioned_roll                = var.conditioned_roll
    roll_config {
      respect_pdb                   = var.respect_pdb
      batch_size_percentage         = var.batch_size_percentage
      vng_ids                       = var.vng_ids
      batch_min_healthy_percentage  = var.batch_min_healthy_percentage
      comment                       = var.comment
      node_pool_names               = var.node_pool_names
      respect_restrict_scale_down   = var.respect_restrict_scale_down
      node_names                    = var.node_names

    }
  }
}

