resource "azurerm_kubernetes_cluster" "clust" {
  for_each              = { for cluster in var.clusters : cluster.name => cluster }
  // ... (your existing code)

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
  location            = ""
  name                = ""
  resource_group_name = ""
}
