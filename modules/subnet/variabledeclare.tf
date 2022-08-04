variable "subnetname" {
 type        = string
 description = "1st Subnet Name"
}
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
variable "subnet_address" {
type = list(string)
description = "subnet address"
}