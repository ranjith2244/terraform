variable "vnetname" {
 type        = string
 description = "Virtual Network Name"
}
variable "location" {
 type        = string
 description = "Location"
}
variable "resource_group_name" {
 type        = string
 description = "Resource Group Name"
}
variable "vnet_address_space" {
type = list(string)
description = "vnet address space"
}