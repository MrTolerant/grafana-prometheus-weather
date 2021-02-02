provider "azurerm" {
  version = ">=2.0.0"
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

resource "azurerm_resource_group" "weather" {
  name     = "weather"
  location = "northcentralus"
}
