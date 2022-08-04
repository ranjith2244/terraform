data "azurerm_subnet" "subnet" {
  name                 = var.subnetname
  virtual_network_name = var.vnetname
  resource_group_name  = var.resource_group_name
}
data "azurerm_resource_group" "packerrg" {
  name                = var.packer_resource_group_name
}
data "azurerm_virtual_network" "vnet"{
  name = var.vnetname
  resource_group_name = var.resource_group_name
}

data "azurerm_image" "image" {
  name                = var.packer_image_name
  resource_group_name = data.azurerm_resource_group.packerrg.name
}

data "azurerm_lb_backend_address_pool" "bepool" {
  name = var.bepool
  loadbalancer_id = data.azurerm_lb.loadbalancer.id
}

data "azurerm_lb" "loadbalancer" {
  name = var.lbname
  resource_group_name = var.resource_group_name
}
resource "azurerm_windows_virtual_machine_scale_set" "vmss" {
  name                = var.vmssname
  location            = var.location
  sku                 = "Standard_DS1_v2"
  instances           = 1
  resource_group_name = var.resource_group_name
  //upgrade_policy_mode = "Manual"
  admin_password      = "password@123"
  admin_username      = "username"
  source_image_id = data.azurerm_image.image.id
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
  network_interface {
    name    = var.nic
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = data.azurerm_subnet.subnet.id
      load_balancer_backend_address_pool_ids = [data.azurerm_lb_backend_address_pool.bepool.id]
    }
  }
  # sku {
  #   name     = "Standard_DS1_v2"
  #   tier     = "Standard"
  #   capacity = 2
  # }
}


