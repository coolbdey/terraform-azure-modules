terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.16.0"
    }
  }
}
