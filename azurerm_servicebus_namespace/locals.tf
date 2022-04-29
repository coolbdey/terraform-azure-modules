locals {
  enable_partitioning = var.sku == "Premium" ? true : false
}