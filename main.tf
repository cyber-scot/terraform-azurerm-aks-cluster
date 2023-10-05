resource "azurerm_kubernetes_cluster" "cluster" {
  for_each                            = {for cluster in var.clusters : cluster.name => cluster}
  name                                = lower(each.value.name)
  kubernetes_version                  = each.value.kubernetes_version
  location                            = each.value.location
  resource_group_name                 = each.value.rg_name
  dns_prefix                          = each.value.dns_prefix
  sku_tier                            = title(each.value.sku_tier)
  private_cluster_enabled             = each.value.private_cluster_enabled
  tags                                = each.value.tags
  http_application_routing_enabled    = each.value.http_application_routing_enabled
  azure_policy_enabled                = each.value.azure_policy_enabled
  role_based_access_control_enabled   = each.value.role_based_access_control_enabled
  open_service_mesh_enabled           = each.value.open_service_mesh_enabled
  private_dns_zone_id                 = each.value.private_dns_zone_id
  private_cluster_public_fqdn_enabled = each.value.private_cluster_public_fqdn_enabled
  custom_ca_trust_certificates_base64 = each.value.custom_ca_trust_certificates_base64
  disk_encryption_set_id              = each.value.disk_encryption_set_id
  edge_zone                           = each.value.edge_zone
  image_cleaner_enabled               = each.value.image_cleaner_enabled
  image_cleaner_interval_hours        = each.value.image_cleaner_interval_hours
  local_account_disabled              = each.value.local_account_disabled
  node_os_channel_upgrade             = each.value.node_os_channel_upgrade
  node_resource_group                 = each.value.node_resource_group
  oidc_issuer_enabled                 = each.value.oidc_issuer_enabled
  dns_prefix_private_cluster          = each.value.dns_prefix_private_cluster
  automatic_channel_upgrade           = each.value.automatic_channel_upgrade
  workload_identity_enabled           = each.value.workload_identity_enabled

  dynamic "linux_profile" {
    for_each = each.value.linux_profile != null ? [each.value.linux_profile] : []
    content {
      admin_username = linux_profile.value.admin_username

      dynamic "ssh_key" {
        for_each = linux_profile.value.ssh_key != null ? [linux_profile.value.ssh_key] : []
        content {
          key_data = ssh_key.value.ssh_key
        }
      }
    }
  }

  dynamic "default_node_pool" {
    for_each = each.value.default_node_pool != null ? [each.value.default_node_pool] : []
    content {
      enable_auto_scaling                 = default_node_pool.value.enable_auto_scaling
      max_count                           = default_node_pool.value.agents_max_count
      min_count                           = default_node_pool.value.agents_min_count
      type                                = default_node_pool.value.agents_type
      capacity_reservation_group_id       = default_node_pool.value.capacity_reservation_group_id
      orchestrator_version                = default_node_pool.value.orchestrator_version
      custom_ca_trust_enabled             = default_node_pool.value.custom_ca_trust_enabled
      enable_host_encryption              = default_node_pool.value.enable_host_encryption
      host_group_id                       = default_node_pool.value.host_group_id
      name                                = default_node_pool.value.pool_name
      vm_size                             = default_node_pool.value.vm_size
      os_disk_size_gb                     = default_node_pool.value.os_disk_size_gb
      vnet_subnet_id                      = default_node_pool.value.subnet_id
      enable_node_public_ip               = default_node_pool.value.enable_node_public_ip
      zones                               = default_node_pool.value.availability_zones
      node_count                          = default_node_pool.value.count
      fips_enabled                        = default_node_pool.value.fips_enabled
      kubelet_disk_type                   = default_node_pool.value.kubelet_disk_type
      max_pods                            = default_node_pool.value.max_pods
      message_of_the_day                  = default_node_pool.value.message_of_the_day
      node_public_ip_prefix_id            = default_node_pool.value.node_public_ip_prefix_id
      node_labels                         = default_node_pool.value.node_labels
      node_taints                         = tolist(default_node_pool.value.node_taints)
      only_critical_addons_enabled        = default_node_pool.value.only_critical_addons_enabled
      os_sku                              = default_node_pool.value.os_sku
      pod_subnet_id                       = default_node_pool.value.pod_subnet_id
      proximity_placement_group_id        = default_node_pool.value.proximity_placement_group_id
      scale_down_mode                     = default_node_pool.value.scale_down_mode
      snapshot_id                         = default_node_pool.value.snapshot_id
      temporary_name_for_rotation         = default_node_pool.value.temporary_name_for_rotation
      tags                                = default_node_pool.value.tags
      ultra_ssd_enabled                   = default_node_pool.value.ultra_ssd_enabled

        dynamic "linux_os_config" {
    for_each = default_node_pool.value.linux_os_config != null ? [default_node_pool.value.linux_os_config] : []
    content {
      swap_file_size_mb             = linux_os_config.value.swap_file_size_mb
      transparent_huge_page_defrag  = linux_os_config.value.transparent_huge_page_defrag
      transparent_huge_page_enabled = linux_os_config.value.transparent_huge_page_enabled

      dynamic "sysctl_config" {
        for_each = linux_os_config.value.sysctl_config != null ? [linux_os_config.value.sysctl_config] : []
        content {
          fs_aio_max_nr                      = sysctl_config.value.fs_aio_max_nr
          fs_file_max                        = sysctl_config.value.fs_file_max
          fs_inotify_max_user_watches        = sysctl_config.value.fs_inotify_max_user_watches
          fs_nr_open                         = sysctl_config.value.fs_nr_open
          kernel_threads_max                 = sysctl_config.value.kernel_threads_max
          net_core_netdev_max_backlog        = sysctl_config.value.net_core_netdev_max_backlog
          net_core_optmem_max                = sysctl_config.value.net_core_optmem_max
          net_core_rmem_default              = sysctl_config.value.net_core_rmem_default
          net_core_rmem_max                  = sysctl_config.value.net_core_rmem_max
          net_core_somaxconn                 = sysctl_config.value.net_core_somaxconn
          net_core_wmem_default              = sysctl_config.value.net_core_wmem_default
          net_core_wmem_max                  = sysctl_config.value.net_core_wmem_max
          net_ipv4_ip_local_port_range_max   = sysctl_config.value.net_ipv4_ip_local_port_range_max
          net_ipv4_ip_local_port_range_min   = sysctl_config.value.net_ipv4_ip_local_port_range_min
          net_ipv4_neigh_default_gc_thresh1  = sysctl_config.value.net_ipv4_neigh_default_gc_thresh1
          net_ipv4_neigh_default_gc_thresh2  = sysctl_config.value.net_ipv4_neigh_default_gc_thresh2
          net_ipv4_neigh_default_gc_thresh3  = sysctl_config.value.net_ipv4_neigh_default_gc_thresh3
          net_ipv4_tcp_fin_timeout           = sysctl_config.value.net_ipv4_tcp_fin_timeout
          net_ipv4_tcp_keepalive_intvl       = sysctl_config.value.net_ipv4_tcp_keepalive_intvl
          net_ipv4_tcp_keepalive_probes      = sysctl_config.value.net_ipv4_tcp_keepalive_probes
          net_ipv4_tcp_keepalive_time        = sysctl_config.value.net_ipv4_tcp_keepalive_time
          net_ipv4_tcp_max_syn_backlog       = sysctl_config.value.net_ipv4_tcp_max_syn_backlog
          net_ipv4_tcp_max_tw_buckets        = sysctl_config.value.net_ipv4_tcp_max_tw_buckets
          net_ipv4_tcp_tw_reuse              = sysctl_config.value.net_ipv4_tcp_tw_reuse
          net_netfilter_nf_conntrack_buckets = sysctl_config.value.net_netfilter_nf_conntrack_buckets
          net_netfilter_nf_conntrack_max     = sysctl_config.value.net_netfilter_nf_conntrack_max
          vm_max_map_count                   = sysctl_config.value.vm_max_map_count
          vm_swappiness                      = sysctl_config.value.vm_swappiness
          vm_vfs_cache_pressure              = sysctl_config.value.vm_vfs_cache_pressure
        }
      }
    }
  }

      dynamic "kubelet_config" {
        for_each = each.value.kubelet_config != null ? [each.value.kubelet_config] : []
        content {
          allowed_unsafe_sysctls    = kubelet_config.value.allowed_unsafe_sysctls
          container_log_max_line    = kubelet_config.value.container_log_max_line
          container_log_max_size_mb = kubelet_config.value.container_log_max_size_mb
          cpu_cfs_quota_enabled     = kubelet_config.value.cpu_cfs_quota_enabled
          cpu_cfs_quota_period      = kubelet_config.value.cpu_cfs_quota_period
          cpu_manager_policy        = kubelet_config.value.cpu_manager_policy
          image_gc_high_threshold   = kubelet_config.value.image_gc_high_threshold
          image_gc_low_threshold    = kubelet_config.value.image_gc_low_threshold
          pod_max_pid               = kubelet_config.value.pod_max_pid
          topology_manager_policy   = kubelet_config.value.topology_manager_policy
        }
      }
    }
  }

  dynamic "maintenance_window" {
    for_each = each.value.maintenance_window != null ? [each.value.maintenance_window] : []
    content {
      dynamic "allowed" {
        for_each = maintenance_window.value.allowed != null ? [maintenance_window.value.allowed] : []
        content {
          day   = allowed.value.day
          hours = allowed.value.hours
        }
      }

      dynamic "not_allowed" {
        for_each = maintenance_window.value.not_allowed != null ? [maintenance_window.value.not_allowed] : []
        content {
          start = not_allowed.value.start
          end   = not_allowed.value.end
        }
      }
    }
  }

  dynamic "maintenance_window_auto_upgrade" {
    for_each = each.value.maintenance_window_auto_upgrade != null ? [each.value.maintenance_window_auto_upgrade] : []
    content {
      frequency   = maintenance_window_auto_upgrade.value.frequency
      interval    = maintenance_window_auto_upgrade.value.interval
      duration    = maintenance_window_auto_upgrade.value.duration
      day_of_week = maintenance_window_auto_upgrade.value.day_of_week
      week_index  = maintenance_window_auto_upgrade.value.week_index
      start_time  = maintenance_window_auto_upgrade.value.start_time
      utc_offset  = maintenance_window_auto_upgrade.value.utc_offset
      start_date  = maintenance_window_auto_upgrade.value.start_date

      dynamic "not_allowed" {
        for_each = maintenance_window_auto_upgrade.value.not_allowed != null ? [maintenance_window_auto_upgrade.value.not_allowed] : []
        content {
          start = not_allowed.value.start
          end   = not_allowed.value.end
        }
      }
    }
  }

  dynamic "maintenance_window_node_os" {
    for_each = each.value.maintenance_window_node_os != null ? [each.value.maintenance_window_node_os] : []
    content {
      frequency   = maintenance_window_node_os.value.frequency
      interval    = maintenance_window_node_os.value.interval
      duration    = maintenance_window_node_os.value.duration
      day_of_week = maintenance_window_node_os.value.day_of_week
      week_index  = maintenance_window_node_os.value.week_index
      start_time  = maintenance_window_node_os.value.start_time
      utc_offset  = maintenance_window_node_os.value.utc_offset
      start_date  = maintenance_window_node_os.value.start_date

      dynamic "not_allowed" {
        for_each = maintenance_window_node_os.value.not_allowed != null ? [maintenance_window_node_os.value.not_allowed] : []
        content {
          start = not_allowed.value.start
          end   = not_allowed.value.end
        }
      }
    }
  }


  dynamic "service_principal" {
    for_each = each.value.service_principal != null ? [each.value.service_principal] : []
    content {
      client_id     = service_principal.value.client_id
      client_secret = service_principal.value.client_secret
    }
  }


  dynamic "identity" {
    for_each = try(length(each.value.identity_ids) > 0 && each.value.identity_type == "SystemAssigned", false) ? [
      each.value.identity_type
    ] : []
    content {
      type = each.value.identity_type
    }
  }

  dynamic "identity" {
    for_each = try(length(each.value.identity_ids), 0) > 0 || each.value.identity_type == "SystemAssigned, UserAssigned" ? [
      each.value.identity_type
    ] : []
    content {
      type         = each.value.identity_type
      identity_ids = try(each.value.identity_ids, [])
    }
  }

  dynamic "identity" {
    for_each = try(length(each.value.identity_ids), 0) > 0 || each.value.identity_type == "SystemAssigned, UserAssigned" ? [
      each.value.identity_type
    ] : []
    content {
      type         = each.value.identity_type
      identity_ids = length(try(each.value.identity_ids, [])) > 0 ? each.value.identity_ids : []
    }
  }

  dynamic "oms_agent" {
    for_each = each.value.oms_agent != null ? [each.value.oms_agent] : []
    content {
      log_analytics_workspace_id = each.value.log_analytics_workspace_id
    }
  }

  dynamic "storage_profile" {
    for_each = each.value.storage_profile != null ? [each.value.storage_profile] : []
    content {
      blob_driver_enabled         = storage_profile.value.blob_driver_enabled
      disk_driver_enabled         = storage_profile.value.disk_driver_enabled
      disk_driver_version         = storage_profile.value.disk_driver_version
      file_driver_enabled         = storage_profile.value.file_driver_enabled
      snapshot_controller_enabled = storage_profile.value.snapshot_controller_enabled
    }
  }

  dynamic "network_profile" {
    for_each = each.value.network_profile != null ? [each.value.network_profile] : []
    content {
      network_plugin     = network_profile.value.network_plugin
      network_policy     = network_profile.value.network_policy
      dns_service_ip     = network_profile.value.dns_service_ip
      outbound_type      = network_profile.value.outbound_type
      pod_cidr           = network_profile.value.pod_cidr
      service_cidr       = network_profile.value.service_cidr
    }
  }

  dynamic "aci_connector_linux" {
    for_each = each.value.aci_connector_linux != null ? [each.value.aci_connector_linux] : []
    content {
      subnet_name = aci_connector_linux.value.subnet_name
    }
  }

  dynamic "api_server_access_profile" {
    for_each = each.value.api_server_access_profile != null ? [each.value.api_server_access_profile] : []
    content {
      authorized_ip_ranges     = api_server_access_profile.value.authorized_ip_ranges
      subnet_id                = api_server_access_profile.value.subnet_id
      vnet_integration_enabled = api_server_access_profile.value.vnet_integration_enabled
    }
  }

  dynamic "auto_scaler_profile" {
    for_each = each.value.auto_scaler_profile != null ? [each.value.auto_scaler_profile] : []
    content {
      balance_similar_node_groups      = auto_scaler_profile.value.balance_similar_node_groups
      expander                         = auto_scaler_profile.value.expander
      max_graceful_termination_sec     = auto_scaler_profile.value.max_graceful_termination_sec
      max_node_provisioning_time       = auto_scaler_profile.value.max_node_provisioning_time
      max_unready_nodes                = auto_scaler_profile.value.max_unready_nodes
      max_unready_percentage           = auto_scaler_profile.value.max_unready_percentage
      new_pod_scale_up_delay           = auto_scaler_profile.value.new_pod_scale_up_delay
      scale_down_delay_after_add       = auto_scaler_profile.value.scale_down_delay_after_add
      scale_down_delay_after_delete    = auto_scaler_profile.value.scale_down_delay_after_delete
      scale_down_delay_after_failure   = auto_scaler_profile.value.scale_down_delay_after_failure
      scan_interval                    = auto_scaler_profile.value.scan_interval
      scale_down_unneeded              = auto_scaler_profile.value.scale_down_unneeded
      scale_down_unready               = auto_scaler_profile.value.scale_down_unready
      scale_down_utilization_threshold = auto_scaler_profile.value.scale_down_utilization_threshold
      empty_bulk_delete_max            = auto_scaler_profile.value.empty_bulk_delete_max
      skip_nodes_with_local_storage    = auto_scaler_profile.value.skip_nodes_with_local_storage
      skip_nodes_with_system_pods      = auto_scaler_profile.value.skip_nodes_with_system_pods
    }
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = each.value.azure_active_directory_role_based_access_control != null ? [
      each.value.azure_active_directory_role_based_access_control
    ] : []
    content {
      managed                = azure_active_directory_role_based_access_control.value.managed
      tenant_id              = azure_active_directory_role_based_access_control.value.tenant_id
      admin_group_object_ids = azure_active_directory_role_based_access_control.value.admin_group_object_ids
      client_app_id          = azure_active_directory_role_based_access_control.value.client_app_id
      server_app_id          = azure_active_directory_role_based_access_control.value.server_app_id
      server_app_secret      = azure_active_directory_role_based_access_control.value.server_app_secret
      azure_rbac_enabled     = azure_active_directory_role_based_access_control.value.azure_rbac_enabled
    }
  }

  dynamic "confidential_computing" {
    for_each = each.value.confidential_computing != null ? [each.value.confidential_computing] : []
    content {
      sgx_quote_helper_enabled = confidential_computing.value.sgx_quote_helper_enabled
    }
  }

  dynamic "windows_profile" {
    for_each = each.value.windows_profile != null ? [each.value.windows_profile] : []
    content {
      admin_username = windows_profile.value.admin_username
      admin_password = windows_profile.value.admin_password
      license        = windows_profile.value.license

      dynamic "gmsa" {
        for_each = windows_profile.value.gmsa != null ? [windows_profile.value.gmsa] : []
        content {
          dns_server  = gmsa.value.dns_server
          root_domain = gmsa.value.root_domain
        }
      }
    }
  }



    dynamic "http_proxy_config" {
      for_each = each.value.http_proxy_config != null ? [each.value.http_proxy_config] : []
      content {
        http_proxy     = http_proxy_config.value.http_proxy
        https_proxy    = http_proxy_config.value.https_proxy
        trusted_ca     = http_proxy_config.value.trusted_ca
      }
    }


    dynamic "ingress_application_gateway" {
      for_each = each.value.ingress_application_gateway != null ? [each.value.ingress_application_gateway] : []
      content {
        gateway_id   = ingress_application_gateway.value.gateway_id
        gateway_name = ingress_application_gateway.value.gateway_name
        subnet_cidr  = ingress_application_gateway.value.subnet_cidr
        subnet_id    = ingress_application_gateway.value.subnet_id
      }
    }

    dynamic "key_management_service" {
      for_each = each.value.key_management_service != null ? [each.value.key_management_service] : []
      content {
        key_vault_network_access = key_management_service.value.key_vault_network_access
        key_vault_key_id         = key_management_service.value.key_vault_key_id
      }
    }

    dynamic "key_vault_secrets_provider" {
      for_each = each.value.key_vault_secrets_provider != null ? [each.value.key_vault_secrets_provider] : []
      content {
        secret_rotation_enabled  = key_vault_secrets_provider.value.secret_rotation_enabled
        secret_rotation_interval = key_vault_secrets_provider.value.secret_rotation_interval
      }
    }

    dynamic "kubelet_identity" {
      for_each = each.value.kubelet_identity != null ? [each.value.kubelet_identity] : []
      content {
        user_assigned_identity_id = kubelet_identity.value.user_assigned_identity_id
      }
    }



    dynamic "service_mesh_profile" {
      for_each = each.value.service_mesh_profile != null ? [each.value.service_mesh_profile] : []
      content {
        mode                             = service_mesh_profile.value.mode
        internal_ingress_gateway_enabled = service_mesh_profile.value.internal_ingress_gateway_enabled
        external_ingress_gateway_enabled = service_mesh_profile.value.external_ingress_gateway_enabled
      }
    }

    dynamic "microsoft_defender" {
      for_each = each.value.microsoft_defender != null ? [each.value.microsoft_defender] : []
      content {
        log_analytics_workspace_id = microsoft_defender.value.log_analytics_workspace_id
      }
    }

    dynamic "monitor_metrics" {
      for_each = each.value.monitor_metrics != null ? [each.value.monitor_metrics] : []
      content {
        annotations_allowed = monitor_metrics.value.annotations_allowed
        labels_allowed      = monitor_metrics.value.labels_allowed
      }
  }
}
