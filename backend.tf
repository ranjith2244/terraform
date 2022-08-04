terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.11.0"
    }
  }
 backend "azurerm" {
    resource_group_name="terraform-rg"
    storage_account_name="testacct22444"
    container_name="tfstate"
    key="key.tfstate"
 }
}
