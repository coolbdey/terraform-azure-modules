locals {
  zones             = var.sku != "Standard" ? null : var.zones
}