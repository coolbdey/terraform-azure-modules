locals {
  zones             = local.sku != "Standard" ? null : var.zones
  allocation_method = var.ip_version == "IPv6" ? "Static" : var.allocation_method
}