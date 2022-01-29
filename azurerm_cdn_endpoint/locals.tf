locals {
  origin_host            = var.origin_host != null ? var.origin_host : "${var.sa_name}.core.windows.net"
  is_compression_enabled = length(var.content_types_to_compress) == 0 ? false : var.is_compression_enabled
}
