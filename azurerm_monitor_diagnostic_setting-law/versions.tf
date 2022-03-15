terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"

      configuration_aliases = [azurerm.secure, azurerm.management]
    }
  }
}
