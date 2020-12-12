resource "azurerm_network_security_group" "adxtest" {
  name                = local.resource_name
  location            = azurerm_resource_group.adxtest.location
  resource_group_name = azurerm_resource_group.adxtest.name
}

resource "azurerm_subnet_network_security_group_association" "adxtest" {
  subnet_id                 = azurerm_subnet.adx1.id
  network_security_group_id = azurerm_network_security_group.adxtest.id
}

resource "azurerm_network_security_rule" "adx_management" {
  name                         = "${local.resource_name}-adx-management"
  resource_group_name          = azurerm_resource_group.adxtest.name
  network_security_group_name  = azurerm_network_security_group.adxtest.name
  protocol                     = "Tcp"
  priority                     = 100
  direction                    = "Inbound"
  access                       = "Allow"
  source_port_range            = "*"
  source_address_prefix        = "AzureDataExplorerManagement"
  destination_port_range       = "443"
  destination_address_prefixes = azurerm_subnet.adx1.address_prefixes
}

resource "azurerm_network_security_rule" "adx_health_monitoring" {
  name                         = "${local.resource_name}-adx-health_monitoring"
  resource_group_name          = azurerm_resource_group.adxtest.name
  network_security_group_name  = azurerm_network_security_group.adxtest.name
  protocol                     = "Tcp"
  priority                     = 101
  direction                    = "Inbound"
  access                       = "Allow"
  source_port_range            = "*"
  source_address_prefixes      = ["23.97.212.5/32"]
  destination_port_range       = "443"
  destination_address_prefixes = azurerm_subnet.adx1.address_prefixes
}

resource "azurerm_network_security_rule" "adx_internal" {
  name                         = "${local.resource_name}-adx-internal"
  resource_group_name          = azurerm_resource_group.adxtest.name
  network_security_group_name  = azurerm_network_security_group.adxtest.name
  protocol                     = "Tcp"
  priority                     = 102
  direction                    = "Inbound"
  access                       = "Allow"
  source_port_range            = "*"
  source_address_prefixes      = azurerm_subnet.adx1.address_prefixes
  destination_port_range       = "*"
  destination_address_prefixes = azurerm_subnet.adx1.address_prefixes
}

resource "azurerm_network_security_rule" "adx_azure_lb_inbound" {
  name                         = "${local.resource_name}-adx-internal"
  resource_group_name          = azurerm_resource_group.adxtest.name
  network_security_group_name  = azurerm_network_security_group.adxtest.name
  protocol                     = "Tcp"
  priority                     = 103
  direction                    = "Inbound"
  access                       = "Allow"
  source_port_range            = "*"
  source_address_prefix        = "AzureLoadBalancer"
  destination_port_ranges      = ["80", "443"]
  destination_address_prefixes = azurerm_subnet.adx1.address_prefixes
}
