variable "subnetname" {
 type        = string
 description = "1st Subnet Name"
}
variable "vnetname" {
 type        = string
 description = "Virtual Network Name"
 }
# variable "bepool" {
#  type        = string
#  description = "BackEndAddressPool"
# }
variable "nic" {
 type        = string
 description = "nic"
}
variable "machine_type" {
 type        = string
 description = "machine_type"
 }
# variable "lbname" {
#  type        = string
#  description = "Load Balancer name"
# }
variable "location" {
 type        = string
 description = "Location"
}
variable "resource_group_name" {
 type        = string
 description = "Resource Group Name"
}
variable "packer_resource_group_name" {
 type        = string
 description = "image Resource Group Name"
}
variable "packer_image_name" {
 type        = string
 description = "image  Name"
}
# variable "vnet_address_space" {
# type = list(string)
# description = "vnet address space"
# }
# variable "subnet_address" {
# type = list(string)
# description = "subnet address"
# }
# variable "priority" {
#  type        = number
#  description = "Rule priority"
# }
variable "vmname" {
 type        = string
 description = "vm"
}
# variable "VMIP" {
#  type        = string
#  description = "vm ip"
# }
