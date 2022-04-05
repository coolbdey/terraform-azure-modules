terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    mssql = {
      source  = "betr-io/mssql"
      version = "0.2.4"
    }
  }
}
