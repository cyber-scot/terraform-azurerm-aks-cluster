variable "clusters" {
  description = "A list of clusters to create"
  type = list(object({
    name                                = string
    kubernetes_version                  = string
    location                            = string
    rg_name                             = string
    dns_prefix                          = string
    sku_tier                            = string
    private_cluster_enabled             = bool
    tags                                = map(string)
    http_application_routing_enabled    = optional(bool)
    azure_policy_enabled                = optional(bool)
    role_based_access_control_enabled   = optional(bool)
    open_service_mesh_enabled           = optional(bool)
    private_dns_zone_id                 = optional(string)
    private_cluster_public_fqdn_enabled = optional(bool)
    custom_ca_trust_certificates_base64 = optional(string)
    disk_encryption_set_id              = optional(string)
    edge_zone                           = optional(string)
    image_cleaner_enabled               = optional(bool)
    image_cleaner_interval_hours        = optional(number)
    local_account_disabled              = optional(bool)
    node_os_channel_upgrade             = optional(string)
    node_resource_group                 = optional(string)
    oidc_issuer_enabled                 = optional(bool)
    linux_profile = optional(object({
      admin_username = string
      ssh_key = list(object({
        key_data = string
      }))
    }))
    default_node_pool = optional(object({
      enable_auto_scaling  = bool
      max_count            = number
      min_count            = number
      type                 = string
      orchestrator_version = string
      // ... (other attributes as needed)
    }))
    service_principal = optional(object({
      client_id     = string
      client_secret = string
    }))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    oms_agent = optional(object({
      log_analytics_workspace_id = string
    }))
    network_profile = optional(object({
      network_plugin     = string
      network_policy     = string
      dns_service_ip     = string
      docker_bridge_cidr = string
      outbound_type      = string
      pod_cidr           = string
      service_cidr       = string
    }))
    aci_connector_linux = optional(object({
      enabled     = bool
      subnet_name = string
    }))
    automatic_channel_upgrade = optional(object({
      channel = string
    }))
    api_server_access_profile = optional(object({
      authorized_ip_ranges = list(string)
    }))
    auto_scaler_profile = optional(object({
      balance_similar_node_groups = bool
      // ... (additional attributes as needed)
    }))
    azure_active_directory_role_based_access_control = optional(object({
      azure_admin_group_object_ids = list(string)
      // ... (additional attributes as needed)
    }))
    confidential_computing = optional(object({
      enabled                  = bool
      sgx_quote_helper_enabled = bool
    }))
    http_proxy_config = optional(object({
      http_proxy     = string
      https_proxy    = string
      trusted_ca     = string
      exception_list = list(string)
    }))
    ingress_application_gateway = optional(object({
      enabled   = bool
      subnet_id = string
      // ... (additional attributes as needed)
    }))
    key_management_service = optional(object({
      enabled          = bool
      key_vault_id     = string
      key_vault_key_id = string
    }))
    key_vault_secrets_provider = optional(object({
      enabled      = bool
      key_vault_id = string
    }))
    kubelet_identity = optional(object({
      user_assigned_identity_id = string
    }))
    maintenance_window = optional(object({
      day    = string
      hour   = string
      minute = string
    }))
    maintenance_window_auto_upgrade = optional(object({
      day    = string
      hour   = string
      minute = string
    }))
    maintenance_window_node_os = optional(object({
      day    = string
      hour   = string
      minute = string
    }))
    microsoft_defender = optional(object({
      enabled                    = bool
      log_analytics_workspace_id = string
    }))
    monitor_metrics = optional(object({
      enabled = bool
      // ... (additional attributes as needed)
    }))
  }))
  default = []
}
