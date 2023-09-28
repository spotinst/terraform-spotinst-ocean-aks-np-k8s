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

  min_count = var.node_min_count
  max_count = var.node_max_count

  spot_percentage      = var.spot_percentage
  fallback_to_ondemand = var.fallback_to_ondemand

  filters {
    min_vcpu = var.vmsizes_filters_min_vcpu
    max_vcpu = var.vmsizes_filters_max_vcpu
    min_memory_gib = var.vmsizes_filters_min_memory_gib
    max_memory_gib = var.vmsizes_filters_max_memory_gib
    architectures = var.vmsizes_filters_architectures
    series = var.vmsizes_filters_series
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
}

