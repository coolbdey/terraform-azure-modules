locals {
  sku               = var.sku_tier == "Global" ? "Standard" : var.sku
  zones             = local.sku != "Standard" ? null : var.zones
  allocation_method = var.ip_version == "IPv6" ? "Static" : var.allocation_method
}