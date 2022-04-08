locals {
  enable_partitioning = local.sku == "Premium" ? true : false
}