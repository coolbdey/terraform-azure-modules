locals {
  file_copy_enabled      = var.sku == "Standard" ? var.file_copy_enabled : false
  ip_connect_enabled     = var.sku == "Standard" ? var.ip_connect_enabled : false
  scale_units            = var.sku == "Standard" ? var.scale_units : 2
  shareable_link_enabled = var.sku == "Standard" ? var.shareable_link_enabled : false
  tunneling_enabled      = var.sku == "Standard" ? var.tunneling_enabled : false
}