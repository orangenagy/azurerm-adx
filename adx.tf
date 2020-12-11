resource "azurerm_kusto_cluster" "adxtest" {
  name                = "riteshtestadx"
  location            = azurerm_resource_group.adxtest.location
  resource_group_name = azurerm_resource_group.adxtest.name

  sku {
    name     = "Standard_D13_v2"
    capacity = 2
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_kusto_cluster_customer_managed_key" "adxtest" {
  cluster_id   = azurerm_kusto_cluster.adxtest.id
  key_vault_id = azurerm_key_vault.adxtest.id
  key_name     = azurerm_key_vault_key.adxtest.name
  key_version  = azurerm_key_vault_key.adxtest.version
}
