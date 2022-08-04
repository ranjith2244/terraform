resource "azurerm_virtual_network" "vnet" {
  name                = var.vnetname
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space            = var.vnet_address_space
}