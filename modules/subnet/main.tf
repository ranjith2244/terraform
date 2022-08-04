resource "azurerm_subnet" "subnet" {
  name                 = var.subnetname
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnetname
  address_prefixes     = var.subnet_address
}