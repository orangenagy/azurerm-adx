locals {
  keyvault_name = "${substr(local.resource_name, 0, 19)}${random_string.random.result}"
}

resource "random_string" "random" {
  length  = 4
  special = false
}

resource "azurerm_key_vault" "adxtest" {
  name                = local.keyvault_name
  location            = azurerm_resource_group.adxtest.location
  resource_group_name = azurerm_resource_group.adxtest.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  soft_delete_enabled      = true
  purge_protection_enabled = true
}

resource "azurerm_key_vault_access_policy" "cluster" {
  key_vault_id = azurerm_key_vault.adxtest.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_kusto_cluster.adxtest.identity.0.principal_id

  key_permissions = ["get", "unwrapkey", "wrapkey"]
}

resource "azurerm_key_vault_access_policy" "client" {
  key_vault_id = azurerm_key_vault.adxtest.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = ["get", "list", "create", "delete", "recover"]
}

resource "azurerm_key_vault_key" "adxtest" {
  name         = local.keyvault_name
  key_vault_id = azurerm_key_vault.adxtest.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  depends_on = [
    azurerm_key_vault_access_policy.client,
    azurerm_key_vault_access_policy.cluster,
  ]
}
