resource "azurerm_virtual_network" "adxnetwork" {
  name                = "adxnetwork"
  location            = azurerm_resource_group.adxtest.location
  resource_group_name = azurerm_resource_group.adxtest.name
  address_space       = ["10.1.0.0/16"]


  subnet {
    name           = "adx1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "adx2"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "adx3"
    address_prefix = "10.0.3.0/24"
  }
}
