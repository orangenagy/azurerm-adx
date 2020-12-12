resource "azurerm_kusto_cluster" "adxtest" {
  name                = var.resource_base_name
  location            = azurerm_resource_group.adxtest.location
  resource_group_name = azurerm_resource_group.adxtest.name

  sku {
    name     = "Standard_D13_v2"
    capacity = 2
  }

  virtual_network_configuration {
    subnet_id                    = azurerm_subnet.adx1.id
    engine_public_ip_id          = azurerm_public_ip.adx_engine_endpoint.id
    data_management_public_ip_id = azurerm_public_ip.adx_data_management_endpoint.id
  }

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_network_security_rule.adx_management,
    azurerm_network_security_rule.adx_health_monitoring,
    azurerm_network_security_rule.adx_internal,
    azurerm_network_security_rule.adx_azure_lb_inbound,
  ]
}

resource "azurerm_kusto_cluster_customer_managed_key" "adxtest" {
  count        = var.use_encryption_on_adx ? 1 : 0
  cluster_id   = azurerm_kusto_cluster.adxtest.id
  key_vault_id = azurerm_key_vault.adxtest.id
  key_name     = azurerm_key_vault_key.adxtest.name
  key_version  = azurerm_key_vault_key.adxtest.version
}
