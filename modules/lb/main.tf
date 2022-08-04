# provider "azurerm" {
#   features {}
#   subscription_id = "de7365e2-8329-48fc-8273-4ab1574e6b4b"
#   //skip_provider_registration = "true"
# }
data "azurerm_subnet" "subnet" {
  name                 = var.subnetname
  virtual_network_name = var.vnetname
  resource_group_name  = var.resource_group_name
}

resource "azurerm_public_ip" "pip" {
  name                         = var.pip
  location                     = var.location
  resource_group_name          = var.resource_group_name
  //public_ip_address_allocation = "static"
  allocation_method = "Static"
  sku = "Standard"
}

resource "azurerm_lb" "loadbalancer" {
  name                = var.lbname
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.pip.id
  }
  sku = "Standard"
  depends_on = [
    azurerm_public_ip.pip 
  ]
}
resource "azurerm_lb_backend_address_pool" "bepool" {
  loadbalancer_id     = azurerm_lb.loadbalancer.id
  name                = var.bepool
  depends_on = [
    azurerm_lb.loadbalancer
  ]
}

resource "azurerm_lb_probe" "lbprobe" {
  //resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.loadbalancer.id
  name                = "lb-probe"
  port                = 80
  protocol = "Http"
  request_path = "/"

  depends_on = [
    azurerm_lb.loadbalancer
  ]
}

resource "azurerm_lb_rule" "lbnatrule" {
  //resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "RuleA"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 5000
  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.bepool.id]
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = azurerm_lb_probe.lbprobe.id
}