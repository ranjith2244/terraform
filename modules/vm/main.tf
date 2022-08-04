
data "azurerm_subnet" "subnet" {
  name                 = var.subnetname
  virtual_network_name = var.vnetname
  resource_group_name  = var.resource_group_name
}
# data "azurerm_resource_group" "packerrg" {
#   name                = var.packer_resource_group_name
# }
data "azurerm_virtual_network" "vnet"{
  name = var.vnetname
  resource_group_name = var.resource_group_name
}
data "azurerm_image" "myimage" {
  name                = "myPackerImage1"
  resource_group_name = "myPackerGroup"
}

# data "azurerm_lb_backend_address_pool" "bepool" {
#   name = var.bepool
#   loadbalancer_id = data.azurerm_lb.loadbalancer.id
# }

# data "azurerm_lb" "loadbalancer" {
#   name = var.lbname
#   resource_group_name = var.resource_group_name
# }

resource "azurerm_network_interface" "network_interface_public" {
    count            = "${var.machine_type == "public" ? 1 : 0}"  
    name    = var.nic
    location = var.location
    resource_group_name = var.resource_group_name
    
    
    ip_configuration {
      name      = "internal"
      subnet_id = data.azurerm_subnet.subnet.id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = azurerm_public_ip.VMIP[0].id
    }
  }
resource "azurerm_network_interface" "network_interface_private" {
    count            = "${var.machine_type == "private" ? 1 : 0}"  
    name    = var.nic
    location = var.location
    resource_group_name = var.resource_group_name
    
    
    ip_configuration {
      name      = "internal"
      subnet_id = data.azurerm_subnet.subnet.id
      private_ip_address_allocation = "Dynamic"
          
    }
  }
resource "azurerm_public_ip" "VMIP" {
  count            = "${var.machine_type == "public" ? 1 : 0}"
  name                = "VMIP"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
}
resource "azurerm_windows_virtual_machine" "vm_public" {
  count            = "${var.machine_type == "public" ? 1 : 0}"   
  name                = var.vmname
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "password@123"
  source_image_id = data.azurerm_image.myimage.id
   network_interface_ids =  [azurerm_network_interface.network_interface_public[0].id] 
  

   os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  
}
resource "azurerm_windows_virtual_machine" "vm_private" {
  count            = "${var.machine_type == "private" ? 1 : 0}"  
  name                = var.vmname
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "password@123"
  source_image_id = data.azurerm_image.myimage.id
   network_interface_ids =  [azurerm_network_interface.network_interface_private[0].id] 

   os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  
}
# resource "azurerm_network_interface_backend_address_pool_association" "example" {
#   network_interface_id    = azurerm_network_interface.network_interface.id
#   ip_configuration_name   = "internal"
#   backend_address_pool_id = data.azurerm_lb_backend_address_pool.bepool.id
# }
