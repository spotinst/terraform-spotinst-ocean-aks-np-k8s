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
    autoscale_is_enabled      = var.is_autoscale_enabled

    resource_limits {
      max_vcpu       = var.resource_limits_max_vcpu
      max_memory_gib = var.resource_limits_max_memory_gib
    }

    autoscale_down {
      max_scale_down_percentage = var.autoscale_max_scale_down_percentage
    }

    autoscale_headroom {

      automatic {
        is_enabled = var.is_automatic_autoscaler_headroom_enabled
        percentage = var.autoscale_headroom_automatic_percentage
      }

    }

  }

  health {
    grace_period = var.health_grace_period
  }
  availability_zones = var.availability_zones
  max_pods_per_node     = var.max_pods_per_node
  enable_node_public_ip = var.enable_node_public_ip
  os_disk_size_gb       = var.os_disk_size_gb
  os_disk_type         = var.os_disk_type
  os_type             = var.os_type

  min_count = var.node_min_count
  max_count = var.node_max_count

  spot_percentage      = var.spot_percentage
  fallback_to_ondemand = var.fallback_to_ondemand
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

