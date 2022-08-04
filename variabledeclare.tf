variable "subnetname" {
 type        = string
 description = "1st Subnet Name"
}
variable "vnetname" {
 type        = string
 description = "Virtual Network Name"
}
# variable "VMIP" {
#  type        = string
#  description = "VMIP"
# }
variable "location" {
 type        = string
 description = "Location"
}
variable "machine_type" {
 type        = string
 description = "machine_type"
 }
variable "resource_group_name" {
 type        = string
 description = "Resource Group Name"
}

variable "vmname" {
 type        = string
 description = "vm"

}
variable "packer_resource_group_name" {
 type        = string
 description = "image Resource Group Name"
}
variable "packer_image_name" {
 type        = string
 description = "image  Name"
}
# variable "pip" {
#  type        = string
#  description = "public ip"
# }
variable "subnet_address" {
type = list(string)
description = "subnet address"
}
# variable "bepool" {
#  type        = string
#  description = "BackEndAddressPool"
# }
variable "nic" {
 type        = string
 description = "nic"
}
# variable "lbname" {
#  type        = string
#  description = "Load Balancer name"
# }

variable "name" {
 type        = string
 description = "Name"
}
variable "vnet_address_space" {
type = list(string)
description = "vnet address space"
}
variable "security_group_name" {
 type        = string
 description = "NSG name"
}
variable "priority" {
 type        = number
 description = "Rule priority"
}
variable "sr" {
 type        = string
 description = "security rule name"
}
