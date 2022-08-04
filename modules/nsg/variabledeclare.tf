variable "location" {
 type        = string
 description = "Location"
}
variable "security_group_name" {
 type        = string
 description = "NSG name"
}
variable "sr" {
 type        = string
 description = "security rule name"
}
variable "resource_group_name" {
 type        = string
 description = "Resource Group Name"
}
variable "priority" {
 type        = number
 description = "Rule priority"
}
variable "subnetname" {
 type        = string
 description = "1st Subnet Name"
}
variable "vnetname" {
 type        = string
 description = "Virtual Network Name"
}