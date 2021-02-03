provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "tfacc"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}
