provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

locals {
  resource_name = var.resource_base_name
}

resource "azurerm_resource_group" "adxtest" {
  name     = local.resource_name
  location = "UK South"
}
