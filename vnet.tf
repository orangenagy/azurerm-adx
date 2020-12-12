resource "azurerm_virtual_network" "adxtest" {
  name                = local.resource_name
  location            = azurerm_resource_group.adxtest.location
  resource_group_name = azurerm_resource_group.adxtest.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "adx1" {
  name                 = "${local.resource_name}-1"
  resource_group_name  = azurerm_resource_group.adxtest.name
  virtual_network_name = azurerm_virtual_network.adxtest.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_subnet" "adx2" {
  name                 = "${local.resource_name}-2"
  resource_group_name  = azurerm_resource_group.adxtest.name
  virtual_network_name = azurerm_virtual_network.adxtest.name
  address_prefixes     = ["10.1.2.0/24"]
}

resource "azurerm_subnet" "adx3" {
  name                 = "${local.resource_name}-3"
  resource_group_name  = azurerm_resource_group.adxtest.name
  virtual_network_name = azurerm_virtual_network.adxtest.name
  address_prefixes     = ["10.1.3.0/24"]
}

resource "azurerm_public_ip" "adx_data_management_endpoint" {
  name                = "${local.resource_name}-data-management-endpoint"
  location            = azurerm_resource_group.adxtest.location
  resource_group_name = azurerm_resource_group.adxtest.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "adx_engine_endpoint" {
  name                = "${local.resource_name}-engine-endpoint"
  location            = azurerm_resource_group.adxtest.location
  resource_group_name = azurerm_resource_group.adxtest.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
