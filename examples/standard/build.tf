module "rg" {
  source = "cyber-scot/rg/azurerm"

  name     = "rg-${var.short}-${var.loc}-${var.env}-01"
  location = local.location
  tags     = local.tags
}

module "network" {
  source = "cyber-scot/network/azurerm"

  rg_name  = module.rg.rg_name
  location = module.rg.rg_location
  tags     = module.rg.rg_tags

  vnet_name          = "vnet-${var.short}-${var.loc}-${var.env}-01"
  vnet_location      = module.rg.rg_location
  vnet_address_space = ["10.0.0.0/16"]

  subnets = {
    "sn1-${module.network.vnet_name}" = {
      prefix            = "10.0.0.0/24",
      service_endpoints = ["Microsoft.Storage"]
    }
  }
}

module "aks_cluster" {
  source = "../../" # Adjust this path to point to your module

  clusters = [
    {
      name                    = "aks-${var.short}-${var.loc}-${var.env}-01"
      rg_name                 = module.rg.rg_name
      location                = module.rg.rg_location
      tags                    = module.rg.rg_tags
      kubernetes_version      = "1.20.7"
      dns_prefix              = "exampledns"
      sku_tier                = "Free"
      private_cluster_enabled = false
      identity_type           = "SystemAssigned"
      default_node_pool = {
        enable_auto_scaling = true
        agents_max_count    = 5
        agents_min_count    = 1
        agents_type         = "VirtualMachineScaleSets"
        pool_name           = "default"
        vm_size             = "Standard_DS2_v2"
        os_disk_size_gb     = 30
        subnet_id           = module.network.subnets_ids["sn1-${module.network.vnet_name}"]
        count               = 1
      }
      network_profile = {
        network_plugin = "kubenet"
        network_policy = "calico"
        dns_service_ip = "10.0.0.10"
        outbound_type  = "loadBalancer"
        pod_cidr       = "10.244.0.0/16"
        service_cidr   = "10.1.0.0/16"
      }
      service_principal = {
        client_id     = data.azurerm_key_vault_secret.svp_id.value
        client_secret = data.azurerm_key_vault_secret.svp_secret.value
      }
    }
  ]
}

