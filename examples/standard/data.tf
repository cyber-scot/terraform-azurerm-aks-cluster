data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = "rg-${var.short}-${var.loc}-${var.env}-mgmt"
}

data "azurerm_key_vault" "kv" {
  name                = "kv-${var.short}-${var.loc}-${var.env}-mgmt-01"
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_key_vault_secret" "svp_id" {
  key_vault_id = data.azurerm_key_vault.kv.id
  name         = "SpokeSvpClientId"
}

data "azurerm_key_vault_secret" "svp_secret" {
  key_vault_id = data.azurerm_key_vault.kv.id
  name         = "SpokeSvpClientSecret"
}
