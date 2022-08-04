
module "resource_group" {
  source = "./modules/resourcegroup"
  resource_group_name     = var.resource_group_name
  location = var.location
}
module "vnet" {
  source = "./modules/vnet"
  vnet_address_space = var.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  vnetname = var.vnetname
   depends_on = [
    module.resource_group]
}
module "subnet" {
  source = "./modules/subnet"
  subnetname                 = var.subnetname
  resource_group_name  = var.resource_group_name
  vnetname = var.vnetname
  location            = var.location
  subnet_address = var.subnet_address
  depends_on = [module.vnet,module.resource_group]
    }   

module "nsg" {
  source = "./modules/nsg"
  subnetname                 = var.subnetname
  vnetname = var.vnetname
  resource_group_name   = var.resource_group_name
  security_group_name   = var.security_group_name
  location = var.location
  sr                       = var.sr
  priority                   = var.priority
  depends_on = [module.subnet,module.resource_group]
  }
# module "vm-image"{
#   source = "./modules/vm-image"
#   name = var.name
#   depends_on = [module.resource_group]
# }  

# module "loadbalancer"{
#   source = "./modules/lb"
#   lbname                = var.lbname
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   bepool             = var.bepool
#   subnetname         = var.subnetname
#   vnetname            = var.vnetname
#   subnet_address = var.subnet_address
#   pip                 = var.pip
#   depends_on = [
#     module.subnet
#   ]
# }

module "vm"{
  source = "./modules/vm"
  vmname                = var.vmname
  subnetname                 = var.subnetname
  machine_type       =var.machine_type
  vnetname            = var.vnetname
 # VMIP           = var.VMIP
#   #lbname                = var.lbname
  packer_resource_group_name  = var.packer_resource_group_name
# #   bepool             = var.bepool
  location            = var.location
  resource_group_name = var.resource_group_name
  nic                  =var.nic
  packer_image_name = var.packer_image_name
  depends_on = [module.nsg,module.resource_group]

  }
