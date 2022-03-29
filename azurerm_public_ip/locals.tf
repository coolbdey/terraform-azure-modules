locals {
  sku               = var.sku_tier == "Global" ? "Standard" : var.sku
  zone              = local.sku != "Standard" ? null : var.zone
  allocation_method = var.ip_version == "IPv6" ? "Static" : var.allocation_method
}