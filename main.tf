provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "adxtest" {
  name     = "adxtest"
  location = "West Europe"
}
