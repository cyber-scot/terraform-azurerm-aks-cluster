resource "azurerm_kubernetes_cluster" "cluster" {
  for_each              = { for cluster in var.clusters : cluster.name => cluster }
  name                    = lower(each.value.name)
  kubernetes_version      = each.value.kubernetes_version
  location                = each.value.location
  resource_group_name     = each.value.rg_name
  dns_prefix              = each.value.dns_prefix
  sku_tier                = title(each.value.sku_tier)
  private_cluster_enabled = each.value.private_cluster_enabled
  tags                    = each.value.tags
  http_application_routing_enabled  = each.value.http_application_routing_enabled
  azure_policy_enabled              = each.value.azure_policy_enabled
  role_based_access_control_enabled = each.value.role_based_access_control_enabled
  open_service_mesh_enabled = each.value.open_service_mesh_enabled
  private_dns_zone_id = each.value.private_dns_zone_id
  private_cluster_public_fqdn_enabled = each.value.private_cluster_public_fqdn_enabled
  custom_ca_trust_certificates_base64 = each.value.custom_ca_trust_certificates_base64
  disk_encryption_set_id = each.value.disk_encryption_set_id
  edge_zone = each.value.edge_zone
  image_cleaner_enabled = each.value.image_cleaner_enabled
  image_cleaner_interval_hours = each.value.image_cleaner_interval_hours
  local_account_disabled = each.value.local_account_disabled
  node_os_channel_upgrade = each.value.node_os_channel_upgrade
  node_resource_group = each.value.node_resource_group
  oidc_issuer_enabled = each.value.oidc_issuer_enabled


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
    for_each = each.value.default_node_pool == false ? [each.value.default_node_pool] : []
    content {
      enable_auto_scaling   = default_node_pool.value.enable_auto_scaling
      max_count             = default_node_pool.value.agents_max_count
      min_count             = default_node_pool.value.agents_min_count
      type                  = default_node_pool.value.agents_type
      capacity_reservation_group_id = default_node_pool.value.capacity_reservation_group_id
      orchestrator_version  = default_node_pool.value.orchestrator_version
      custom_ca_trust_enabled = default_node_pool.value.custom_ca_trust_enabled
      custom_ca_trust_certificated_base64 = tolist(default_node_pool.value.custom_ca_trust_certificates_base64)
      enable_host_encryption = default_node_pool.value.enable_host_encryption
      host_group_id = default_node_pool.value.host_group_id
      name                  = default_node_pool.value.pool_name
      vm_size               = default_node_pool.value.vm_size
      os_disk_size_gb       = default_node_pool.value.os_disk_size_gb
      vnet_subnet_id        = default_node_pool.value.subnet_id
      enable_node_public_ip = default_node_pool.value.enable_node_public_ip
      zones                 = default_node_pool.value.availability_zones
      node_count            = default_node_pool.value.count
      fips_enabled          = default_node_pool.value.fips_enabled
      kubelet_disk_type     = default_node_pool.value.kubelet_disk_type
      max_pods              = default_node_pool.value.max_pods
      message_of_the_day    = default_node_pool.value.message_of_the_day
      node_public_ip_prefix_id = default_node_pool.value.node_public_ip_prefix_id
      node_labels = default_node_pool.value.node_labels
      node_taints = tolist(default_node_pool.value.node_taints)
      only_critical_addons_enabled = default_node_pool.value.only_critical_addons_enabled
      os_sku = default_node_pool.value.os_sku
      pod_subnet_id = default_node_pool.value.pod_subnet_id
      proximity_placement_group_id = default_node_pool.value.proximity_placement_group_id
      scale_down_mode = default_node_pool.value.scale_down_mode
      snapshot_id = default_node_pool.value.snapshot_id
      temporary_name_for_rotation = default_node_pool.value.temporary_name_for_rotation
      tags = default_node_pool.value.tags
      ultra_ssd_enabled = default_node_pool.value.ultra_ssd_enabled

      upgrade_settings {
        max_surge = ""
      }

      kubelet_config {

      }

      linux_os_config {

      }

      node_network_profile {

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
    for_each = try(length(each.value.identity_ids) > 0 && each.value.identity_type == "SystemAssigned", false) ? [each.value.identity_type] : []
    content {
      type = each.value.identity_type
    }
  }

  dynamic "identity" {
    for_each = try(length(each.value.identity_ids), 0) > 0 || each.value.identity_type == "SystemAssigned, UserAssigned" ? [each.value.identity_type] : []
    content {
      type         = each.value.identity_type
      identity_ids = try(each.value.identity_ids, [])
    }
  }

  dynamic "identity" {
    for_each = try(length(each.value.identity_ids), 0) > 0 || each.value.identity_type == "SystemAssigned, UserAssigned" ? [each.value.identity_type] : []
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

  dynamic "network_profile" {
    for_each = each.value.network_profile != null ? [each.value.network_profile] : []
    content {
    network_plugin     = network_profile.value.network_plugin
    network_policy     = network_profile.value.network_policy
    dns_service_ip     = network_profile.value.dns_service_ip
    docker_bridge_cidr = network_profile.value.docker_bridge_cidr
    outbound_type      = network_profile.value.outbound_type
    pod_cidr           = network_profile.value.pod_cidr
    service_cidr       = network_profile.value.service_cidr
    }
  }

    dynamic "aci_connector_linux" {
    for_each = each.value.aci_connector_linux != null ? [each.value.aci_connector_linux] : []
    content {
      enabled     = aci_connector_linux.value.enabled
      subnet_name = aci_connector_linux.value.subnet_name
    }
  }

  dynamic "automatic_channel_upgrade" {
    for_each = each.value.automatic_channel_upgrade != null ? [each.value.automatic_channel_upgrade] : []
    content {
      channel = automatic_channel_upgrade.value.channel
    }
  }

  dynamic "api_server_access_profile" {
    for_each = each.value.api_server_access_profile != null ? [each.value.api_server_access_profile] : []
    content {
      authorized_ip_ranges = api_server_access_profile.value.authorized_ip_ranges
    }
  }

  dynamic "auto_scaler_profile" {
    for_each = each.value.auto_scaler_profile != null ? [each.value.auto_scaler_profile] : []
    content {
      balance_similar_node_groups      = auto_scaler_profile.value.balance_similar_node_groups
      // ... (additional attributes as needed)
    }
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = each.value.azure_active_directory_role_based_access_control != null ? [each.value.azure_active_directory_role_based_access_control] : []
    content {
      azure_admin_group_object_ids = azure_active_directory_role_based_access_control.value.azure_admin_group_object_ids
      // ... (additional attributes as needed)
    }
  }


  dynamic "confidential_computing" {
    for_each = each.value.confidential_computing != null ? [each.value.confidential_computing] : []
    content {
      enabled = confidential_computing.value.enabled
      sgx_quote_helper_enabled = confidential_computing.value.sgx_quote_helper_enabled
    }
  }


  dynamic "http_proxy_config" {
    for_each = each.value.http_proxy_config != null ? [each.value.http_proxy_config] : []
    content {
      http_proxy           = http_proxy_config.value.http_proxy
      https_proxy          = http_proxy_config.value.https_proxy
      trusted_ca          = http_proxy_config.value.trusted_ca
      exception_list      = http_proxy_config.value.exception_list
    }
  }


  dynamic "ingress_application_gateway" {
    for_each = each.value.ingress_application_gateway != null ? [each.value.ingress_application_gateway] : []
    content {
      enabled                = ingress_application_gateway.value.enabled
      subnet_id              = ingress_application_gateway.value.subnet_id
      // ... (additional attributes as needed)
    }
  }

  dynamic "key_management_service" {
    for_each = each.value.key_management_service != null ? [each.value.key_management_service] : []
    content {
      enabled     = key_management_service.value.enabled
      key_vault_id = key_management_service.value.key_vault_id
      // ... (additional attributes as needed)
      key_vault_key_id = key_management_service.value.key_vault_key_id
    }
  }

  dynamic "key_vault_secrets_provider" {
    for_each = each.value.key_vault_secrets_provider != null ? [each.value.key_vault_secrets_provider] : []
    content {
      enabled     = key_vault_secrets_provider.value.enabled
      key_vault_id = key_vault_secrets_provider.value.key_vault_id
      // ... (additional attributes as needed)
    }
  }

  dynamic "kubelet_identity" {
    for_each = each.value.kubelet_identity != null ? [each.value.kubelet_identity] : []
    content {
      user_assigned_identity_id = kubelet_identity.value.user_assigned_identity_id
    }
  }

  dynamic "maintenance_window" {
    for_each = each.value.maintenance_window != null ? [each.value.maintenance_window] : []
    content {
      day      = maintenance_window.value.day
      hour     = maintenance_window.value.hour
      minute   = maintenance_window.value.minute
    }
  }

  dynamic "maintenance_window_auto_upgrade" {
    for_each = each.value.maintenance_window_auto_upgrade != null ? [each.value.maintenance_window_auto_upgrade] : []
    content {
      day      = maintenance_window_auto_upgrade.value.day
      hour     = maintenance_window_auto_upgrade.value.hour
      minute   = maintenance_window_auto_upgrade.value.minute
    }
  }

  dynamic "maintenance_window_node_os" {
    for_each = each.value.maintenance_window_node_os != null ? [each.value.maintenance_window_node_os] : []
    content {
      day      = maintenance_window_node_os.value.day
      hour     = maintenance_window_node_os.value.hour
      minute   = maintenance_window_node_os.value.minute
    }
  }

  dynamic "microsoft_defender" {
    for_each = each.value.microsoft_defender != null ? [each.value.microsoft_defender] : []
    content {
      enabled = microsoft_defender.value.enabled
      log_analytics_workspace_id = microsoft_defender.value.log_analytics_workspace_id
    }
  }

  dynamic "monitor_metrics" {
    for_each = each.value.monitor_metrics != null ? [each.value.monitor_metrics] : []
    content {
      enabled = monitor_metrics.value.enabled
      // ... (additional attributes as needed)
    }
  }



  timeouts {
    create = "20m"
  }
}
